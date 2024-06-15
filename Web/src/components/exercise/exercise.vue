<template>
  <div style="position: relative">
    <div style="position: fixed; left: 0; top: 0">
      <video ref="videoElement" autoplay style="
          transform: scaleX(-1);
          width: 1656px;
          height: 1250px;
          z-index: 100;
        "></video>
      <canvas ref="canvas" width="640" height="480" style="
          position: fixed;
          top: 0;
          left: 0;
          transform: scaleX(-1);
          width: 1656px;
          height: 1250px;
          z-index: 100;
        "></canvas>
    </div>

    <v-container>
      <v-alert v-model="showAlert" color="red" style="
          font-size: 30px;
          font-weight: bold;
          border-radius: 60px;
          border: 2px solid white;
          z-index: 999;
        " prominent>
        다음 운동 시작까지 5초 남았습니다.
      </v-alert>
    </v-container>

    <div class="text-center">
      <v-progress-circular :model-value="percentage" :rotate="360" :size="170" :width="30" color="blue"
        style="position: absolute; top: -70px; right: 65px; z-index: 100">
        <template v-slot:default> {{ percentage }} % </template>
      </v-progress-circular>
    </div>

    <div style="
        position: fixed;
        font-size: 100px;
        font-weight: bold;
        left: 50px;
        top: 0px;
        z-index: 1000;
      ">
      {{ this.big_count }} / {{ this.big_count1 }}
    </div>

    <div>
      <v-btn @click="toggleLoop" style="
          z-index: 102;
          color: white;
          position: fixed;
          bottom: 10px;
          right: 100px;
          border: 3px solid red;
          border-radius: 30px;
        ">
        {{ looping ? "운동종료" : "운동시작" }}
      </v-btn>
    </div>

    <div style="
        position: fixed;
        right: 60px;
        top: 210px;
        width: 175px;
        height: 650px;
        background-color: #d3d3d3;
        border-radius: 30px;
        color: black; /* 텍스트 색상을 검정색으로 설정 */
      ">
      <div>
        <ul>
          <template v-for="group in saveAllData">
            <li v-for="(data, index) in group" :key="index">
              <div v-if="index === 0">{{ getExerciseName(data.id) }}</div>
              {{ data.weight }}kg / {{ data.count }}회
            </li>
          </template>
        </ul>
      </div>
    </div>
    <div id="restOverlay"
      style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: black; z-index: 2000;">
      <div class="container" style="display: flex; height: 100%;">
        <!-- Left section for image -->
        <div class="left-panel" style="width: 65%; height: 100%;">
          <img v-if="selectedImg" :src="selectedImg" alt="Random Image"
            style="width: 100%; height: 100%; z-index: 3000;">
        </div>
        <!-- Right section for rest time and sets -->
        <div class="right-panel" style="width: 35%; height: 100%; display: flex; flex-direction: column;">
          <!-- Top section for rest time -->
          <div class="top-section"
            style="height: 30%; display: flex; justify-content: center; align-items: center; font-size: 2em; color: white;">
            <div id="header" style="width: 100%; text-align: center;">
              휴식시간: <span id="restTime">{{ show_rest_time }}초</span>
            </div>
          </div>
          <!-- Bottom section for sets -->
          <div class="bottom-section" style="height: 70%; overflow-y: auto;">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
            <div v-for="(data, dataIndex) in saveAllData" :key="dataIndex">
              <div v-for="(set, setIndex) in data" :key="setIndex" class="circle-container"
                style="display: flex; align-items: center; margin: 10px 0;">
                <label style="margin-left: 50px;">
                  <template v-if="set.id === 1">
                    Arm - {{ setIndex + 1 }}번째 세트
                  </template>
                  <template v-else-if="set.id === 2">
                    Shoulder - {{ setIndex + 1 }}번째 세트
                  </template>
                  <template v-else-if="set.id === 3">
                    Lunge - {{ setIndex + 1 }}번째 세트
                  </template>
                </label>
                <i :class="['fas', 'fa-circle', { 'completed': set.completed, 'incomplete': !set.completed }]"
                  style="margin-left: 350px;"></i>

              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

  </div>
  <QrCode ref="QrComponent" />
</template>

<script>
import * as tf from "@tensorflow/tfjs";
import * as poseDetection from "@tensorflow-models/pose-detection";
import { v4 as uuidv4 } from "uuid";
import { right_arm_curl, shoulder_press_v, lunge_v } from "./exercise_lib.js";

import QrCode from "../qr_code.vue";

import a from "./restimg/1.jpg";
import b from "./restimg/2.jpg";
import c from "./restimg/3.jpg";
import d from "./restimg/4.jpg";
import e from "./restimg/5.jpg";
import f from "./restimg/6.jpg";

var photos = [
  a, b, c, d, e, f,
];


export default {
  components: {
    QrCode,
  },
  computed: {
    totalExerciseCount() {
      let totalCount = 0;
      this.saveAllData.forEach((group) => {
        group.forEach((data) => {
          totalCount += data.count;
        });
      });
      return totalCount;
    },
    percentage() {
      return Math.round(((this.arm_per + this.shoulder_per + this.lunge_per) / this.totalExerciseCount) * 100);
    },
  },

  data() {
    return {
      looping: false,

      saveAllData: [],
      show_rest_time: 0,

      // arm curl
      right_arm_curl_count: 0,
      arm_curl_right_down_vue: 0,
      arm_curl_right_up_vue: 0,
      arm_curl_left_down_vue: 0,
      arm_curl_left_up_vue: 0,
      left_arm_curl_count: 0,

      // shoulder press
      shoulder_press_count: 0,
      shoulder_press_right_up_vue: 0,
      shoulder_press_right_down_vue: 0,
      shoulder_press_left_up_vue: 0,
      shoulder_press_left_down_vue: 0,

      // lunge
      lunge_right_count: 0,
      lunge_left_count: 0,
      lunge_right_down_vue: 0,
      lunge_right_up_vue: 0,
      lunge_left_down_vue: 0,
      lunge_left_up_vue: 0,
      lunge_count_vue: 0,

      startTime: null,
      endTime: null,
      elapsedTime: null,

      arm_curl_local_load: null,
      shoulder_press_local_load: null,
      lunge_local_load: null,

      arm_curl_countValues: null,
      arm_curl_weightValues: null,
      shoulder_press_countValues: null,
      shoulder_press_weightValues: null,
      lunge_countValues: null,
      lunge_weightValues: null,

      allData: null,
      currentId: null,

      big_count: 0,
      big_count1: 0,

      LC: 0,
      LCT: 0,

      lunge_check: false,
      shoulder_check: false,
      arm_check: false,

      cnt: 0,

      fail_time: 0,
      rest_time: 0,

      local_time: [],

      showAlert: false,
      progress_count: 0,

      arm_per: 0,
      shoulder_per: 0,
      lunge_per: 0,

      exercises: [
        {
          startDate: "2999-01-01T01:00:00Z",
          endDate: "2999-01-01T01:00:00Z",
          totalTime: null,
          routineName: "test_routine_1",
          exerciseRecordModel: [],
        },
      ],

      photos: photos,
      selectedImg: null,
    };
  },
  mounted() {
    this.setupCamera();
  },
  methods: {
    randomPhoto(imgs) {
      console.log(imgs[Math.floor(Math.random() * photos.length)]);
      return imgs[Math.floor(Math.random() * photos.length)];
    },
    async detectPose() {
      await tf.setBackend("webgl");

      const video = this.$refs.videoElement;
      const canvas = this.$refs.canvas;
      const ctx = canvas.getContext("2d");

      const detectorConfig = {
        modelType: poseDetection.movenet.modelType.SINGLEPOSE_THUNDER,
      };
      const model = await poseDetection.createDetector(
        poseDetection.SupportedModels.MoveNet,
        detectorConfig
      );

      const linePairs = [
        [5, 6],
        [11, 12],
        [5, 7],
        [7, 9],
        [6, 8],
        [8, 10],
        [5, 11],
        [6, 12],
        [11, 13],
        [13, 15],
        [12, 14],
        [14, 16],
      ];

      const redKeyPointsIndices = [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16];

      this.local_time = JSON.parse(localStorage.getItem("Time_set"));
      console.log(this.local_time);

      const processPose = async (i, j) => {
        if (
          !this.looping ||
          i >= this.saveAllData.length ||
          j >= this.saveAllData[i].length
        ) {
          return;
        }

        this.big_count_1();
        this.big_count1 = this.saveAllData[i][j].count;

        this.currentId = this.saveAllData[i][j].id;
        const poses = await model.estimatePoses(video);
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        ctx.drawImage(video, 0, 0, canvas.width, canvas.height);

        poses.forEach(({ keypoints }) => {
          keypoints.forEach((keypoint, idx) => {
            if (
              keypoint &&
              keypoint.score > 0.5 &&
              redKeyPointsIndices.includes(idx)
            ) {
              ctx.beginPath();
              ctx.arc(keypoint.x, keypoint.y, 3, 0, 2 * Math.PI);
              ctx.fillStyle = "blue";
              ctx.fill();
            }
          });

          linePairs.forEach((pair) => {
            const [startIdx, endIdx] = pair;
            const start = keypoints[startIdx];
            const end = keypoints[endIdx];
            if (start && end && start.score > 0.5 && end.score > 0.5) {
              ctx.beginPath();
              ctx.moveTo(start.x, start.y);
              ctx.lineTo(end.x, end.y);
              ctx.strokeStyle = "yellow";
              ctx.stroke();
            }
          });

          if (this.currentId === 1) {
            if (this.arm_check === false) {
              this.LC = this.right_arm_curl_count;
              this.LCT = Date.now();
              this.arm_check = true;
            }
            const rightArmCounters = {
              arm_curl_right_down_vue: this.arm_curl_right_down_vue,
              arm_curl_right_up_vue: this.arm_curl_right_up_vue,
              right_arm_curl_check: this.right_arm_curl_count,
              arm_per: this.arm_per
            };
            right_arm_curl(keypoints, ctx, rightArmCounters, 1);
            this.arm_curl_right_down_vue =
              rightArmCounters.arm_curl_right_down_vue;
            this.arm_curl_right_up_vue = rightArmCounters.arm_curl_right_up_vue;
            this.right_arm_curl_count = rightArmCounters.right_arm_curl_check;
            this.arm_per = rightArmCounters.arm_per;

            // If the count changes, reset the timer
            if (this.right_arm_curl_count !== this.LC) {
              this.LC = this.right_arm_curl_count;
              this.LCT = Date.now();
            }

            // Calculate the elapsed time
            const elapsedTime = Math.floor((Date.now() - this.LCT) / 1000);
            console.log(`Last arm curl change was ${elapsedTime} seconds ago.`);


            if (this.local_time[0] - elapsedTime <= 5) {
              this.showAlert = true;
              setTimeout(() => {
                this.showAlert = false;
              }, 2000);
            }
            // If the count has not changed for 10 seconds, move to the next exercise
            if (elapsedTime >= this.local_time[0]) {
              this.right_arm_curl_count = 0;
              this.saveAllData[i][j].completed = false;
              this.arm_check = false;
              j++;
            } else if (
              this.right_arm_curl_count === this.saveAllData[i][j].count
            ) {
              this.right_arm_curl_count = 0;
              this.saveAllData[i][j].completed = true;
              this.arm_check = false;
              j++;
            }
          } else if (this.currentId === 2) {
            if (this.shoulder_check === false) {
              this.LC = this.shoulder_press_count;
              this.LCT = Date.now();
              this.shoulder_check = true;
            }

            const shoulderPressCounters = {
              shoulder_press_count: this.shoulder_press_count,
              shoulder_press_right_up_vue: this.shoulder_press_right_up_vue,
              shoulder_press_right_down_vue: this.shoulder_press_right_down_vue,
              shoulder_press_left_up_vue: this.shoulder_press_left_up_vue,
              shoulder_press_left_down_vue: this.shoulder_press_left_down_vue,
              shoulder_per: this.shoulder_per
            };
            shoulder_press_v(keypoints, ctx, shoulderPressCounters, 2);
            this.shoulder_press_right_up_vue =
              shoulderPressCounters.shoulder_press_right_up_vue;
            this.shoulder_press_right_down_vue =
              shoulderPressCounters.shoulder_press_right_down_vue;
            this.shoulder_press_left_up_vue =
              shoulderPressCounters.shoulder_press_left_up_vue;
            this.shoulder_press_left_down_vue =
              shoulderPressCounters.shoulder_press_left_down_vue;
            this.shoulder_press_count =
              shoulderPressCounters.shoulder_press_count;
            this.shoulder_per = shoulderPressCounters.shoulder_per;
            // If the count changes, reset the timer
            if (this.shoulder_press_count !== this.LC) {
              this.LC = this.shoulder_press_count;
              this.LCT = Date.now();
            }

            // Calculate the elapsed time
            const elapsedTime = Math.floor((Date.now() - this.LCT) / 1000);
            console.log(
              `Last shoulder press change was ${elapsedTime} seconds ago.`
            );

            if (this.local_time[0] - elapsedTime <= 5) {
              this.showAlert = true;
              setTimeout(() => {
                this.showAlert = false;
              }, 2000);
            }
            // If the count has not changed for 10 seconds, move to the next exercise
            if (elapsedTime >= this.local_time[0]) {
              this.shoulder_press_count = 0;
              this.saveAllData[i][j].completed = false;
              this.shoulder_check = false;
              j++;
            } else if (
              this.shoulder_press_count === this.saveAllData[i][j].count
            ) {
              this.shoulder_press_count = 0;
              this.saveAllData[i][j].completed = true;
              this.shoulder_check = false;
              j++;
            }
          } else if (this.currentId === 3) {
            if (this.lunge_check === false) {
              this.LC = this.lunge_count_vue;
              this.LCT = Date.now();
              this.lunge_check = true;
            }

            const lungeCounters = {
              lunge_right_count: this.lunge_right_count,
              lunge_right_down_vue: this.lunge_right_down_vue,
              lunge_right_up_vue: this.lunge_right_up_vue,
              lunge_left_count: this.lunge_left_count,
              lunge_left_down_vue: this.lunge_left_down_vue,
              lunge_left_up_vue: this.lunge_left_up_vue,
              lunge_count_vue: this.lunge_count_vue,
              lunge_per: this.lunge_per
            };
            lunge_v(keypoints, ctx, lungeCounters, 3);
            this.lunge_right_count = lungeCounters.lunge_right_count;
            this.lunge_right_down_vue = lungeCounters.lunge_right_down_vue;
            this.lunge_right_up_vue = lungeCounters.lunge_right_up_vue;
            this.lunge_left_count = lungeCounters.lunge_left_count;
            this.lunge_left_down_vue = lungeCounters.lunge_left_down_vue;
            this.lunge_left_up_vue = lungeCounters.lunge_left_up_vue;
            this.lunge_count_vue = lungeCounters.lunge_count_vue;
            this.lunge_per = lungeCounters.lunge_per;

            if (this.lunge_count_vue !== this.LC) {
              this.LC = this.lunge_count_vue;
              this.LCT = Date.now();
            }

            const elapsedTime = Math.floor((Date.now() - this.LCT) / 1000);
            console.log(`Last lunge change was ${elapsedTime} seconds ago.`);


            if (this.local_time[0] - elapsedTime <= 5) {
              this.showAlert = true;
              setTimeout(() => {
                this.showAlert = false;
              }, 2000);
            }
            if (elapsedTime >= this.local_time[0]) {
              this.lunge_count_vue = 0;
              this.saveAllData[i][j].completed = false;
              this.lunge_check = false;
              j++;
            } else if (this.lunge_count_vue === this.saveAllData[i][j].count) {
              this.lunge_count_vue = 0;
              this.saveAllData[i][j].completed = true;
              this.lunge_check = false;
              j++;
            }
          } else {
            console.log("ID error");
          }
        });

        // 다음 운동을 처리
        if (j < this.saveAllData[i].length) {
          await new Promise((resolve) => requestAnimationFrame(resolve));
          processPose(i, j); // 재귀적으로 호출하여 다음 루프 처리
        } else if (i < this.saveAllData.length) {
          if (i === this.saveAllData.length - 1) {
            // 운동 종료 시간 설정
            this.endTime = new Date().toISOString().split(".")[0] + "Z";
            // 운동 시간 계산
            this.elapsedTime = Math.floor(
              new Date(this.endTime) - new Date(this.startTime)
            );
            // 운동 기록에 운동 시간 저장
            this.exercises[0].totalTime = this.elapsedTime / 1000;
            // 운동 기록에 시작 및 종료 시간 저장
            this.exercises[0].startDate = this.startTime;
            this.exercises[0].endDate = this.endTime;

            // 데이터를 정리하여 id 별로 그룹화
            let exerciseData = {};

            for (let i = 0; i < this.saveAllData.length; i++) {
              for (let j = 0; j < this.saveAllData[i].length; j++) {
                let exercise = this.saveAllData[i][j];
                if (!exerciseData[exercise.id]) {
                  exerciseData[exercise.id] = {
                    name: "",
                    muscles: [],
                    equipment: "",
                    sets: 0,
                    counts: [],
                    weights: [],
                    completeds: [],
                  };
                }

                // 필요한 정보 할당
                exerciseData[exercise.id].sets = this.saveAllData[i].length; // sets
                exerciseData[exercise.id].counts.push(exercise.count);
                exerciseData[exercise.id].weights.push(exercise.weight);
                exerciseData[exercise.id].completeds.push(exercise.completed);

                // 운동 이름 및 근육 부위 설정
                if (exercise.id === 1) {
                  exerciseData[exercise.id].name = "이두컬";
                  exerciseData[exercise.id].muscles = ["이두"];
                  exerciseData[exercise.id].equipment = "덤벨";
                } else if (exercise.id === 2) {
                  exerciseData[exercise.id].name = "숄더프레스";
                  exerciseData[exercise.id].muscles = ["어깨"];
                  exerciseData[exercise.id].equipment = "덤벨";
                } else if (exercise.id === 3) {
                  exerciseData[exercise.id].name = "런지";
                  exerciseData[exercise.id].muscles = ["하체"];
                  exerciseData[exercise.id].equipment = "덤벨";
                }
              }
            }

            // addExerciseRecord 호출
            for (let id in exerciseData) {
              let data = exerciseData[id];
              this.addExerciseRecord(
                data.name,
                data.muscles,
                data.equipment,
                data.sets,
                data.counts,
                data.weights,
                data.completeds
              );
            }

            this.exercises[0].routineName = localStorage.getItem("routine_name");
            localStorage.setItem("exercise_data", JSON.stringify(this.exercises));

            this.$refs.QrComponent.openDialog();
          } else {
            j = 0;
            i++;
            this.selectedImg = this.randomPhoto(this.photos);
            document.getElementById("restOverlay").style.display = "block";

            // 휴식 중에 무언가 실행
            for (let t = this.local_time[1]; t > 0; t--) {
              this.show_rest_time = t;
              await new Promise((resolve) => setTimeout(resolve, 1000));
            }
            // 이미지 숨기기
            document.getElementById("restOverlay").style.display = "none";

            await new Promise((resolve) => requestAnimationFrame(resolve));
            processPose(i, j); // 재귀적으로 호출하여 다음 루프 처리
          }
        }
      };

      // 초기 호출
      processPose(0, 0);
    },

    async setupCamera() {
      const video = this.$refs.videoElement;
      const stream = await navigator.mediaDevices.getUserMedia({ video: true });
      video.srcObject = stream;
    },

    async toggleLoop() {
      this.looping = !this.looping;
      if (this.looping) {
        // 운동 시작 시간 설정
        this.startTime = new Date().toISOString().split(".")[0] + "Z";

        // 자세 감지 시작
        this.detectPose();
      }
    },
    addExerciseRecord(name, part, tool, set, count, kg, doneCount) {
      const record = {
        id: uuidv4(),
        exerciseName: name,
        part: part,
        tool: tool,
        set: set,
        count: count,
        kg: kg,
        done: doneCount,
      };

      this.exercises[0].exerciseRecordModel.push(record);
    },

    setLocalLoadData(data) {
      let storedData = localStorage.getItem("allData") || "[]";

      let allData = JSON.parse(storedData);

      if (data.sets && Array.isArray(data.sets)) {
        // sets 배열 순회하며 각 set의 weight와 count를 정수로 변환
        data.sets.forEach((set) => {
          set.weight = parseInt(set.weight);
          set.count = parseInt(set.count);
        });
      }

      allData.push(data);

      localStorage.setItem("allData", JSON.stringify(allData));

      // 각 운동 데이터를 Vue 컴포넌트의 데이터에 할당
      this.saveAllData = allData;

    },
    getExerciseName(id) {
      switch (id) {
        case 1:
          return "Arm Curl";
        case 2:
          return "Shoulder Press";
        case 3:
          return "Lunge";
        default:
          return "what the?";
      }
    },
    big_count_1() {
      if (this.currentId === 1) {
        this.big_count = this.right_arm_curl_count;
      } else if (this.currentId === 2) {
        this.big_count = this.shoulder_press_count;
      }
      if (this.currentId === 3) {
        this.big_count = this.lunge_count_vue;
      }
    },
  },
};
</script>

<style>
.circle-container {
  display: flex;
  align-items: center;
  font-size: 1.5em;
  margin-left: 5px;
  /* 여백 설정 */
}

.fa-circle {
  font-size: 2em;
}

.completed {
  color: green;
}

.incomplete {
  color: red;
}
</style>