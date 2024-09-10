# 졸업작품 - 웹 부분 ver1.0

- Human pose estimation (movenet) 기술을 이용한 각도 기반 운동 프로그램
- 사용 프레임워크 -> Vue & Vuetify

---

## 디렉토리 형식

```
src
  ├── App.vue
  ├── components
  │   ├── main.vue
  │   ├── qr_code.vue
  │   ├── photo
  │       └── arm_curl_pic.png
  │       └── shoulder_press_pic.png
  │       └── lunge_pic.png
  │   └── exercise
  │       └── exercise.vue
  │       └── exercise_lib.js
  │       └── restimg
  │           └── 1.img
  │           └── ...

```

---

## 설치 모듈들

### vue & vuetify install

```
npm init vue
TypeScript를 사용하기에 Yes로 두고 나머진 No로 설정
생성된 본인이 설정한 이름의 디렉토리에 들어가서 npm install

vuetify
https://v15.vuetifyjs.com/ko/getting-started/quick-start/

```

### npm

```
npm install @tensorflow-models/pose-detection @tensorflow/tfjs vue-web-cam
npm install uuid
npm install vue-qrcode

```
