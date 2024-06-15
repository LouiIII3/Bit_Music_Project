//각도 계산 함수
export function angleBetweenVectors(x1, x2, x3) {
  function dotProduct(v1, v2) {
    return v1[0] * v2[0] + v1[1] * v2[1];
  }

  function vectorMagnitude(v) {
    return Math.sqrt(v[0] * v[0] + v[1] * v[1]);
  }

  let v1 = [x2[0] - x1[0], x2[1] - x1[1]];
  let v2 = [x3[0] - x2[0], x3[1] - x2[1]];

  let dot = dotProduct(v1, v2);
  let mag1 = vectorMagnitude(v1);
  let mag2 = vectorMagnitude(v2);

  let cosTheta = dot / (mag1 * mag2);

  let theta = Math.acos(cosTheta);
  let angleInDegrees = theta * (180 / Math.PI);

  return 180 - angleInDegrees;
}

//오른쪽 암컬 함수
export function right_arm_curl(keypoints, ctx, right_arm_curl_info, ID) {
  if (ID === 1) {
    const calculateAngle = (keypoints, ctx, indices) => {
      const x1 = [keypoints[indices[0]].x, keypoints[indices[0]].y];
      const x2 = [keypoints[indices[1]].x, keypoints[indices[1]].y];
      const x3 = [keypoints[indices[2]].x, keypoints[indices[2]].y];

      const angle = angleBetweenVectors(x1, x2, x3);
      ctx.font = "20px Arial";
      ctx.fillStyle = "white";
      ctx.fillText(
        `${angle.toFixed(2)}°`,
        keypoints[indices[1]].x,
        keypoints[indices[1]].y - 10
      );

      return angle;
    };

    const rightarmcurl = [6, 8, 10];

    if (
      keypoints[rightarmcurl[0]] &&
      keypoints[rightarmcurl[1]] &&
      keypoints[rightarmcurl[2]]
    ) {
      const angle_rightarm = calculateAngle(keypoints, ctx, rightarmcurl);

      // 각도 비교
      if (angle_rightarm >= 160 && right_arm_curl_info.arm_curl_right_down_vue === 0) {
        right_arm_curl_info.arm_curl_right_down_vue++;
      }

      if (angle_rightarm <= 40 && right_arm_curl_info.arm_curl_right_down_vue >= 1) {
        right_arm_curl_info.arm_curl_right_up_vue++;
      }

      if (right_arm_curl_info.arm_curl_right_down_vue === 1 && right_arm_curl_info.arm_curl_right_up_vue === 1) {
        right_arm_curl_info.right_arm_curl_check++;
        right_arm_curl_info.arm_curl_right_down_vue = 0;
        right_arm_curl_info.arm_curl_right_up_vue = 0;
        right_arm_curl_info.arm_per++;
      }
    }
  }
}

// 왼쪽 암 컬 함수
export function left_arm_curl(keypoints, ctx, left_arm_curl_info) {
  const calculateAngle = (keypoints, ctx, indices) => {
    const x1 = [keypoints[indices[0]].x, keypoints[indices[0]].y];
    const x2 = [keypoints[indices[1]].x, keypoints[indices[1]].y];
    const x3 = [keypoints[indices[2]].x, keypoints[indices[2]].y];

    const angle = angleBetweenVectors(x1, x2, x3);
    ctx.font = "20px Arial";
    ctx.fillStyle = "white";
    ctx.fillText(
      `${angle.toFixed(2)}°`,
      keypoints[indices[1]].x,
      keypoints[indices[1]].y - 10
    );

    return angle;
  };

  const leftarmcurl = [5, 7, 9];

  if (
    keypoints[leftarmcurl[0]] &&
    keypoints[leftarmcurl[1]] &&
    keypoints[leftarmcurl[2]]
  ) {
    const angle_leftarm = calculateAngle(keypoints, ctx, leftarmcurl);

    // 각도 비교
    if (angle_leftarm >= 160 && left_arm_curl_info.arm_curl_left_down_vue === 0) {
      left_arm_curl_info.arm_curl_left_down_vue++;
    }

    if (angle_leftarm <= 40 && left_arm_curl_info.arm_curl_left_down_vue >= 1) {
      left_arm_curl_info.arm_curl_left_up_vue++;
    }

    if (left_arm_curl_info.arm_curl_left_down_vue === 1 && left_arm_curl_info.arm_curl_left_up_vue === 1) {
      left_arm_curl_info.left_arm_curl_check++;
      left_arm_curl_info.arm_curl_left_down_vue = 0;
      left_arm_curl_info.arm_curl_left_up_vue = 0;
    }
  }
}

//숄더프레스 함수
export function shoulder_press_v(keypoints, ctx, shoulder_press_info, ID) {
  if (ID === 2) {
    const calculateAngle = (keypoints, ctx, indices) => {
      const x1 = [keypoints[indices[0]].x, keypoints[indices[0]].y];
      const x2 = [keypoints[indices[1]].x, keypoints[indices[1]].y];
      const x3 = [keypoints[indices[2]].x, keypoints[indices[2]].y];

      const angle = angleBetweenVectors(x1, x2, x3);
      ctx.font = "20px Arial";
      ctx.fillStyle = "white";
      ctx.fillText(
        `${angle.toFixed(2)}°`,
        keypoints[indices[1]].x,
        keypoints[indices[1]].y - 10
      );

      return angle;
    };

    // 오른팔 팔꿈치 각도
    const rightarm = [6, 8, 10];
    // 오른쪽 겨드랑이 각도
    const rightarmpit = [8, 6, 12];
    // 왼쪽 팔꿈치 각도
    const leftarm = [5, 7, 9];
    // 왼쪽 겨드랑이 각도
    const leftarmpit = [7, 5, 11];

    if (
      keypoints[rightarm[0]] && keypoints[rightarm[1]] && keypoints[rightarm[2]] &&
      keypoints[rightarmpit[0]] && keypoints[rightarmpit[1]] && keypoints[rightarmpit[2]] &&
      keypoints[leftarm[0]] && keypoints[leftarm[1]] && keypoints[leftarm[2]] &&
      keypoints[leftarmpit[0]] && keypoints[leftarmpit[1]] && keypoints[leftarmpit[2]]
    ) {
      const angle_rightarm = calculateAngle(keypoints, ctx, rightarm);
      const angle_rightarmpit = calculateAngle(keypoints, ctx, rightarmpit);
      const angle_leftarm = calculateAngle(keypoints, ctx, leftarm);
      const angle_leftarmpit = calculateAngle(keypoints, ctx, leftarmpit);

      // 각도 비교
      //팔 필때
      //오른쪽 각도 체크
      if (angle_rightarm >= 140 && angle_rightarm <= 150 &&
        angle_rightarmpit >= 150 && angle_rightarmpit <= 170 && shoulder_press_info.shoulder_press_right_up_vue === 0) {
        shoulder_press_info.shoulder_press_right_up_vue = 1;
      }
      //왼쪽 각도 체크
      if (angle_leftarm >= 140 && angle_leftarm <= 150 &&
        angle_leftarmpit >= 150 && angle_leftarmpit <= 170 && shoulder_press_info.shoulder_press_left_up_vue === 0) {
        shoulder_press_info.shoulder_press_left_up_vue = 1;
      }

      //팔 접을때
      //오른쪽 각도 체크
      if (angle_rightarm >= 70 && angle_rightarm <= 85 &&
        angle_rightarmpit >= 90 && angle_rightarmpit <= 100 && shoulder_press_info.shoulder_press_right_up_vue === 1) {
        shoulder_press_info.shoulder_press_right_down_vue = 1;
      }
      //왼쪽 각도 체크
      if (angle_leftarm >= 70 && angle_leftarm <= 85 &&
        angle_leftarmpit >= 90 && angle_leftarmpit <= 100 && shoulder_press_info.shoulder_press_left_up_vue === 1) {
        shoulder_press_info.shoulder_press_left_down_vue = 1;
      }

      if (shoulder_press_info.shoulder_press_right_up_vue === 1 && shoulder_press_info.shoulder_press_left_up_vue === 1
        && shoulder_press_info.shoulder_press_right_down_vue === 1 && shoulder_press_info.shoulder_press_left_down_vue === 1) {
        shoulder_press_info.shoulder_press_count++;
        shoulder_press_info.shoulder_press_right_up_vue = 0;
        shoulder_press_info.shoulder_press_left_up_vue = 0;
        shoulder_press_info.shoulder_press_right_down_vue = 0;
        shoulder_press_info.shoulder_press_left_down_vue = 0;
        shoulder_press_info.shoulder_per++;
      }
    }
  }
}

//런지 함수
export function lunge_v(keypoints, ctx, lunge_info, ID) {
  if (ID === 3) {
    const calculateAngle = (keypoints, ctx, indices) => {
      const x1 = [keypoints[indices[0]].x, keypoints[indices[0]].y];
      const x2 = [keypoints[indices[1]].x, keypoints[indices[1]].y];
      const x3 = [keypoints[indices[2]].x, keypoints[indices[2]].y];

      const angle = angleBetweenVectors(x1, x2, x3);
      ctx.font = "20px Arial";
      ctx.fillStyle = "white";
      ctx.fillText(
        `${angle.toFixed(2)}°`,
        keypoints[indices[1]].x,
        keypoints[indices[1]].y - 10
      );

      return angle;
    };

    // 오른팔 무릎 각도
    const rightleg = [12, 14, 16];
    // 오른쪽 힙인지 각도
    const righthip = [6, 12, 14];
    // 왼쪽 무릎 각도
    const leftleg = [11, 13, 15];
    // 왼쪽 힙인지 각도
    const lefthip = [5, 11, 13];

    if (keypoints[rightleg[0]] && keypoints[rightleg[1]] && keypoints[rightleg[2]] &&
      keypoints[righthip[0]] && keypoints[righthip[1]] && keypoints[righthip[2]] &&
      keypoints[leftleg[0]] && keypoints[leftleg[1]] && keypoints[leftleg[2]] &&
      keypoints[lefthip[0]] && keypoints[lefthip[1]] && keypoints[lefthip[2]]) {
      const angle_rightleg = calculateAngle(keypoints, ctx, rightleg);
      const angle_righthip = calculateAngle(keypoints, ctx, righthip);
      const angle_leftleg = calculateAngle(keypoints, ctx, leftleg);
      const angle_lefthip = calculateAngle(keypoints, ctx, lefthip);

      // // 각도 비교 
      // // 기본 상태 
      // //오른쪽 다리 앞으로 런지 시 (오른 무릎 90~100, 왼 무릅 90 ~ 110, 오른 힙인지 90~100, 왼 힙인지 170~180 )
      // //왼 다리 앞으로 런지 시 (오른 무릎 90~110, 왼 무릅 90 ~ 100, 오른 힙인지 170~180, 왼 힙인지 90~100 )
      // // 다 피었을 때 (힙인지 135~ 165, 무릎 155 ~ 180)

      // 오른 다리 앞으로
      if (angle_rightleg >= 85 && angle_rightleg <= 105 && angle_leftleg >= 85 && angle_leftleg <= 110
        && angle_righthip >= 90 && angle_righthip <= 120 && angle_lefthip >= 160 && angle_lefthip <= 180) {
        lunge_info.lunge_right_down_vue = 1;
      }

      //왼 다리 앞으로
      if (angle_rightleg >= 85 && angle_rightleg <= 110 && angle_leftleg >= 85 && angle_leftleg <= 105
        && angle_righthip >= 160 && angle_righthip <= 180 && angle_lefthip >= 90 && angle_lefthip <= 120) {
        lunge_info.lunge_left_down_vue = 1;
      }

      // 디폴트 다 핀 상태
      if (angle_rightleg >= 140 && angle_rightleg <= 180 && angle_leftleg >= 140 && angle_leftleg <= 180
        && angle_righthip >= 135 && angle_righthip <= 165 && angle_lefthip >= 135 && angle_lefthip <= 165) {
        if (lunge_info.lunge_left_down_vue === 1) {
          lunge_info.lunge_left_up_vue = 1;
        }
        else if (lunge_info.lunge_right_down_vue === 1) {
          lunge_info.lunge_right_up_vue = 1;
        }
      }

      // 오른쪽 전체 체크
      if (lunge_info.lunge_right_down_vue === 1 && lunge_info.lunge_right_up_vue === 1) {
        lunge_info.lunge_right_count = 1;
        lunge_info.lunge_right_down_vue = 0;
        lunge_info.lunge_right_up_vue = 0;
      }
      //왼쪽 전체 체크
      if (lunge_info.lunge_left_down_vue === 1 && lunge_info.lunge_left_up_vue === 1) {
        lunge_info.lunge_left_count = 1;
        lunge_info.lunge_left_down_vue = 0;
        lunge_info.lunge_left_up_vue = 0;
      }

      if(lunge_info.lunge_right_count === 1 && lunge_info.lunge_left_count === 1){
        lunge_info.lunge_count_vue++;
        lunge_info.lunge_right_count = 0;
        lunge_info.lunge_left_count = 0;
        lunge_info.lunge_per++;
      }
    }
  }
}