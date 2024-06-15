<template>
  <v-dialog v-model="stepper_dialog" max-width="500">
    <v-stepper :items="['', '', '']">
      <template v-slot:item.1>
        <v-card title="운동 설정" flat> 운동 설정을 눌러 루틴을 생성 </v-card>
      </template>

      <template v-slot:item.2>
        <v-card title="운동 시작" flat> 운동시작 버튼으로 운동을 진행 </v-card>
      </template>

      <template v-slot:item.3>
        <v-card title="운동 종료" flat>
          운동종료 버튼으로 운동을 종료한 후 <br />QR코드를 촬영하여
          스마트폰으로 확인
        </v-card>
      </template>
    </v-stepper>
  </v-dialog>

  <!-- <v-snackbar
    :timeout="2000"
    color="deep-purple-accent-4"
    elevation="24"
    location="center"
  >
    <template v-slot:activator="{ props }">
      <v-btn v-bind="props" style="position: absolute; right: 100px"
        >open</v-btn
      >
    </template>
    다음 운동까지 10초 남았습니다.
  </v-snackbar> -->



  <div>
    <v-card style="z-index: 300">
      <v-layout row>
        <v-navigation-drawer
          v-model="drawer"
          :rail="rail"
          permanent
          location="right"
          @click="rail = false"
        >
          <v-list-item prepend-icon="mdi-account-multiple" title="minki">
            <template v-slot:append>
              <!-- <v-btn href="https://www.sch.ac.kr" target="_blank"
                >로그아웃</v-btn
              > -->
              <v-btn
                icon="mdi-chevron-right"
                variant="text"
                @click.stop="rail = !rail"
              ></v-btn>
            </template>
          </v-list-item>
          <v-divider></v-divider>
          <v-list density="compact" nav>
            <v-list-item
              @click="showSlideGroup(1)"
              prepend-icon="mdi-dumbbell"
              title="운동 설정"
              value="1"
              @click.stop="rail = !rail"
            ></v-list-item>
            <v-list-item
              @click="showSlideGroup(2)"
              prepend-icon="mdi-dumbbell"
              title="내 루틴"
              value="2"
              @click.stop="rail = !rail"
            ></v-list-item>
            <v-list-item
              @click="showSlideGroup(3)"
              prepend-icon="mdi-dumbbell"
              title="초기화"
              value="3"
              @click.stop="rail = !rail"
            ></v-list-item>
          </v-list>
        </v-navigation-drawer>
      </v-layout>
    </v-card>

    <div>
      <v-dialog v-model="end_dialog" max-width="1000" persistent>
        <v-card>
          <v-card-title>
            <span class="headline">종료된 루틴</span>
            <div>운동 시간 : {{ total_time[0].totalTime }}초</div>
          </v-card-title>
          <v-card-text>
            <div>
              <ul>
                <li v-for="(data, index) in localdata" :key="index">
                  {{ this.totalTime }}
                  <ul>
                    <li v-for="(set, setIndex) in data" :key="setIndex">
                      {{ setIndex + 1 }}번째 세트: {{ set.weight }}kg /
                      {{ set.count }}회
                    </li>
                  </ul>
                </li>
              </ul>
            </div>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn
              color="primary"
              text
              @click="this.$refs.QrComponent.openDialog()"
              >QRcode</v-btn
            >
            <v-btn color="primary" text @click="end_dialog = false"
              >Close</v-btn
            >
          </v-card-actions>
        </v-card>
      </v-dialog>
    </div>

    <div class="text-center pa-4">
      <v-dialog v-model="dialog" max-width="1000" persistent>
        <template v-slot:activator="{ props: activatorProps }">
          <v-btn
            v-bind="activatorProps"
            style="position: fixed; right: 0; height: 0px"
          ></v-btn>
        </template>
        <v-card style="width: 1000px; height: 550px; border-radius: 20px">
          <v-row justify="center">
            <v-col
              cols="12"
              class="text-left"
              style="margin-top: 30px; margin-left: 170px"
            >
              <v-text-field
                v-model="routine"
                label="루틴 이름"
                placeholder="Ex) 오늘의 루틴 1"
                variant="outlined"
                style="max-width: 300px"
              ></v-text-field>
            </v-col>
          </v-row>
          <v-row align="center" justify="center" style="margin-top: -80px">
            <v-col cols="10">
              <v-hover v-slot="{ isHovering, props }">
                <v-btn
                  class="button-margin"
                  large
                  @click="
                    handleButtonClick(1);
                    openDialog();
                  "
                  v-bind="props"
                  style="
                    width: 250px;
                    height: 350px;
                    padding: 0;
                    border-radius: 40px;
                    background-color: #495057;
                  "
                >
                  <v-img :src="cards[0].imageSrc" width="300px"></v-img>
                  <v-expand-transition>
                    <div
                      v-if="isHovering"
                      class="d-flex transition-fast-in-fast-out bg-red-darken-2 v-card--reveal text-h2"
                      style="height: 100%; border-radius: 40px"
                    >
                      Arm Curl
                    </div>
                  </v-expand-transition>
                </v-btn>
              </v-hover>

              <v-hover v-slot="{ isHovering, props }">
                <v-btn
                  class="button-margin"
                  large
                  @click="
                    handleButtonClick(2);
                    openDialog();
                  "
                  v-bind="props"
                  style="
                    width: 250px;
                    height: 350px;
                    padding: 0;
                    border-radius: 40px;
                    background-color: #495057;
                  "
                >
                  <v-img :src="cards[1].imageSrc" width="250px"></v-img>
                  <v-expand-transition>
                    <div
                      v-if="isHovering"
                      class="d-flex transition-fast-in-fast-out bg-red-darken-2 v-card--reveal text-h2"
                      style="height: 100%; border-radius: 40px"
                    >
                      Shoulder<br />
                      Press
                    </div>
                  </v-expand-transition>
                </v-btn>
              </v-hover>

              <v-hover v-slot="{ isHovering, props }">
                <v-btn
                  class="button-margin"
                  large
                  @click="
                    handleButtonClick(3);
                    openDialog();
                  "
                  v-bind="props"
                  style="
                    width: 250px;
                    height: 350px;
                    padding: 0;
                    border-radius: 40px;
                    background-color: #495057;
                  "
                >
                  <v-img :src="cards[2].imageSrc" width="250px"></v-img>
                  <v-expand-transition>
                    <div
                      v-if="isHovering"
                      class="d-flex transition-fast-in-fast-out bg-indigo-darken-2 v-card--reveal text-h2"
                      style="height: 100%; border-radius: 40px"
                    >
                      Lunge
                    </div>
                  </v-expand-transition>
                </v-btn>
              </v-hover>
            </v-col>
          </v-row>

          <template v-slot:actions>
            <v-spacer></v-spacer>
            <v-btn @click="time_dialog = true"> 시간 설정 </v-btn>
            <v-btn
              @click="
                dialog = false;
                Routine_localStorage();
              "
            >
              완료
            </v-btn>
          </template>
        </v-card>
      </v-dialog>
    </div>

    <v-dialog v-model="time_dialog" max-width="500">
      <v-card>
        <v-card-title class="d-flex justify-space-between text-center">
          <!-- <span>Title 1</span>
        <span>Title 2</span> -->
        </v-card-title>
        <v-card-text>
          <v-row>
            <v-col cols="6">
              <v-tooltip location="right">
                <template v-slot:activator="{ props }">
                  <v-icon
                    v-bind="props"
                    icon="mdi-help-circle-outline"
                  ></v-icon>
                </template>
                루틴 진행 중 운동이 진행되지 않으면 실패 지점으로 인식하는
                시간입니다
              </v-tooltip>
              <v-select
                v-model="selectedOption1"
                :items="options1"
                label="운동 수행시간 설정"
                variant="underlined"
                style="margin-top: 10px"
              ></v-select>
            </v-col>
            <v-col cols="6">
              <v-tooltip location="right">
                <template v-slot:activator="{ props }">
                  <v-icon
                    v-bind="props"
                    icon="mdi-help-circle-outline"
                  ></v-icon>
                </template>
                루틴 진행 중 세트 중간 휴식 시간 설정입니다
              </v-tooltip>
              <v-select
                v-model="selectedOption2"
                :items="options2"
                label="휴식 시간 설정"
                variant="underlined"
                style="margin-top: 10px"
              ></v-select>
            </v-col>
          </v-row>
        </v-card-text>
        <v-divider></v-divider>
        <v-card-actions>
          <v-btn color="primary" @click="Time_localStorage">저장</v-btn>
          <v-btn text @click="time_dialog = false">취소</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>

    <v-dialog v-model="dialog_2" max-width="600">
      <v-card>
        <v-card-title class="d-flex justify-space-between">
          <span v-if="selectedCardId">{{
            cards[selectedCardId - 1].name
          }}</span>
          <div>
            <v-btn icon @click="addSet">
              <v-icon>mdi-plus</v-icon>
            </v-btn>
            <v-btn icon @click="removeSet(sets.length - 1)">
              <v-icon>mdi-delete</v-icon>
            </v-btn>
          </div>
        </v-card-title>
        <v-card-text>
          <div v-for="(set, index) in sets" :key="index">
            <v-row align="center">
              <v-col cols="2">
                <span>{{ index + 1 }}세트</span>
              </v-col>
              <v-col cols="2">
                <v-text-field
                  v-model="set.weight"
                  label="무게"
                  placeholder="KG"
                  variant="plain"
                ></v-text-field>
              </v-col>
              <v-col cols="2">
                <v-text-field
                  v-model="set.count"
                  label="횟수"
                  placeholder="회"
                  variant="plain"
                ></v-text-field>
              </v-col>
            </v-row>
          </div>
        </v-card-text>
        <v-divider></v-divider>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
            color="primary"
            text="저장"
            variant="tonal"
            @click="saveDataAndCloseDialog"
          ></v-btn>
          <v-btn text="취소" variant="plain" @click="closeDialog"></v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>

    <!-- <div class="text-center">
      <v-progress-circular
        :model-value="value"
        :rotate="360"
        :size="170"
        :width="30"
        color="blue"
        style="position: absolute; top: -70px; right: 65px; z-index: 100"
      >
        <template v-slot:default> {{ value }} % </template>
      </v-progress-circular>
    </div> -->

    <QrCode ref="QrComponent" />

    <!-- <div v-if="ExerciseVisible">
      <exercise></exercise>
    </div> -->

    <!-- 웹캠 화면 부분 -->
    <div style="z-index: 100">
      <div style="position: absolute; left: 0; top: 0">
        <video
          ref="videoElement"
          autoplay
          style="
            transform: scaleX(-1);
            width: 640px;
            height: 480px;
            z-index: 100;
          "
        ></video>
        <canvas
          ref="canvas"
          width="640"
          height="480"
          style="
            position: absolute;
            top: 0;
            left: 0;
            transform: scaleX(-1);
            width: 640px;
            height: 480px;
            z-index: 100;
          "
        ></canvas>
      </div>
    </div>
  </div>

  <Exercise ref="exerciseComponent" />
</template>

<script>
import Exercise from "./exercise/exercise.vue";

import QrCode from "./qr_code.vue";

import arm_curl_pic from "./photo/arm_curl_pic.png";
import shoulder_press_pic from "./photo/shoulder_press_pic.png";
import lunge_pic from "./photo/lunge_pic.png";

export default {
  components: {
    Exercise,
    QrCode,
  },

  data() {
    return {
      looping: false,
      sets: [{ weight: "", count: "", completed: false }],

      drawer: true,
      rail: true,
      showSlide: false,
      showSlide_2: false,
      model: null,
      selectedCardName: null,
      selectedCardId: null,

      selectedExercise: null,

      dialog: false,
      dialog_2: false,
      time_dialog: false,
      end_dialog: false,

      QrVisible: true,

      ExerciseVisible: true,

      routine: null,

      stepper_dialog: true,

      showAlert: false,

      localdata: [],

      total_time: [],

      time_set: [0,0],
      selectedOption1: "30초",
      selectedOption2: "60초",
      options1: ["10초","20초", "30초", "40초", "60초"],
      options2: ["30초", "60초", "90초", "120초"],

      cards: [
        {
          id: 1,
          imageSrc: arm_curl_pic,
          name: "이두컬",
          eng_name: "arm_curl",
          sets: [{ id: 1, weight: "", count: "", completed: false }],
        },
        {
          id: 2,
          imageSrc: shoulder_press_pic,
          eng_name: "shoulder_press",
          name: "숄더 프레스",
          sets: [{ id: 2, weight: "", count: "", completed: false }],
        },
        {
          id: 3,
          imageSrc: lunge_pic,
          name: "런지",
          eng_name: "lunge",
          sets: [{ id: 3, weight: "", count: "", completed: false }],
        },
      ],
    };
  },

  methods: {
    openDialog() {
      this.dialog_2 = true;
    },
    showSlideGroup(value) {
      if (value === 1) {
        this.dialog = true;
      }
      if (value === 2) {
        let storedData = localStorage.getItem("allData");
        this.localdata = JSON.parse(storedData);
        this.total_time = JSON.parse(localStorage.getItem("exercise_data"));
        console.log(this.total_time);
        this.end_dialog = true;
      }
      if (value === 3) {
        localStorage.clear();
      }
    },
    async handleButtonClick(value) {
      this.selectedCardId = value;
      console.log(this.selectedCardId);
      console.log(this.cards[this.selectedCardId - 1].name);
      this.sets = JSON.parse(JSON.stringify(this.cards[value - 1].sets));
    },

    testMethod(value) {
      console.log(value);
    },

    cancelSelection() {
      this.showSlide = false;
    },
    completeSelection() {
      this.showSlide = false;
      this.showSlide_2 = true;
    },
    toggle(card) {
      this.selectedCardName = card.name;
    },
    addSet() {
      if (this.sets.length < 5) {
        this.sets.push({ weight: "", count: "", completed: false });
      }
    },
    removeSet(index) {
      if (this.sets.length > 1) {
        this.sets.splice(index, 1);
      }
    },

    saveDataAndCloseDialog() {
      if (this.selectedCardId !== null) {
        // weight와 count를 정수로 변환
        this.sets.forEach((set) => {
          set.weight = parseInt(set.weight, 10);
          set.count = parseInt(set.count, 10);
        });

        this.cards[this.selectedCardId - 1].sets = JSON.parse(
          JSON.stringify(this.sets)
        );
        localStorage.setItem(
          `${this.cards[this.selectedCardId - 1].eng_name}_sets`,
          JSON.stringify(this.sets)
        );
      }

      const arm_curl_local_load_s = localStorage.getItem("arm_curl_sets");
      const shoulder_press_local_load_s = localStorage.getItem(
        "shoulder_press_sets"
      );
      const lunge_local_load_s = localStorage.getItem("lunge_sets");

      const arm_curl_local_load = JSON.parse(arm_curl_local_load_s);
      const shoulder_press_local_load = JSON.parse(shoulder_press_local_load_s);
      const lunge_local_load = JSON.parse(lunge_local_load_s);

      // weight와 count를 정수로 변환
      if (arm_curl_local_load) {
        arm_curl_local_load.forEach((set) => {
          set.id = 1;
          set.weight = parseInt(set.weight, 10);
          set.count = parseInt(set.count, 10);
        });
      }

      if (shoulder_press_local_load) {
        shoulder_press_local_load.forEach((set) => {
          set.id = 2;
          set.weight = parseInt(set.weight, 10);
          set.count = parseInt(set.count, 10);
        });
      }

      if (lunge_local_load) {
        lunge_local_load.forEach((set) => {
          set.id = 3;
          set.weight = parseInt(set.weight, 10);
          set.count = parseInt(set.count, 10);
        });
      }

      if (this.selectedCardId === 1) {
        this.$refs.exerciseComponent.setLocalLoadData(arm_curl_local_load);
        this.dialog_2 = false;
      } else if (this.selectedCardId === 2) {
        this.$refs.exerciseComponent.setLocalLoadData(
          shoulder_press_local_load
        );
        this.dialog_2 = false;
      } else if (this.selectedCardId === 3) {
        this.$refs.exerciseComponent.setLocalLoadData(lunge_local_load);
        this.dialog_2 = false;
      }
    },

    closeDialog() {
      this.dialog_2 = false;
    },
    Routine_localStorage() {
      localStorage.setItem("routine_name", this.routine);
    },
    Time_localStorage() {
      this.time_set = [
        parseInt(this.selectedOption1.replace("초", ""), 10),
        parseInt(this.selectedOption2.replace("초", ""), 10)
      ];
      this.time_dialog = false;
      localStorage.setItem("Time_set", JSON.stringify(this.time_set));

    },
    // nextStep() {
    //   if (this.step < 3) {
    //     this.step++;
    //   }
    // },
    // Alert_Click() {
    //   this.showAlert = true;
    //   setTimeout(() => {
    //     this.showAlert = false;
    //   }, 5000);
    // },
    setupCamera() {
      const video = this.$refs.videoElement;
      navigator.mediaDevices
        .getUserMedia({ video: true })
        .then((stream) => {
          video.srcObject = stream;
        })
        .catch((error) => {
          console.error("웹캠 설정에 실패했습니다:", error);
        });
    },

  },
};
</script>

<style>
#videoElement,
#canvas {
  width: 640px;
  height: 480px;
}

body {
  background-color: black;
}

.text-body-2 {
  margin-bottom: 10px;
}

.main-container {
  width: 100px;
  height: 300px;
  overflow-x: auto;
}

.sub-container {
  width: 100px;
  height: 200px;
  border-radius: 20px;
  border: 2px solid blue;
}

.content {
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  font-size: 24px;
}

.button-margin {
  margin-right: 20px;
}

.transparent-btn {
  background-color: transparent;
  color: inherit;
  border: none;
}

.arm-curl {
  position: absolute;
  top: 0;
  left: 0;
  z-index: 9999;
}

.v-card--reveal {
  align-items: center;
  left: 0;
  justify-content: center;
  opacity: 0.8;
  position: absolute;
  width: 100%;
  font-weight: 500;
  font-family: "NanumSquareNeo-Variant";
}
</style>