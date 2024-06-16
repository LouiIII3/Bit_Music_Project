# BIT_MUSIC
## 언어 선택

[English](README_EN.md) | [한국어](README_KR.md)

<br><br>


### 로고
<div align="center">
  
  | WEB | APP |
  |:---:|:---:|
  | <img src="https://github.com/LouiIII3/Workout-Beats-Project/assets/119919129/7f998cac-bc8e-4b8d-ad32-07286d3539694" width="200px" height="200px"> | <img src="https://github.com/LouiIII3/web_node.js/assets/119919129/cd06c3ed-bdb6-4c9f-9595-c83ff39909f5" width="200px" height="200px"> |
</div>




<br><br>

## 프로젝트 소개 및 목적

- **다양한 음악 선택**: 사용자의 다양한 취향과 운동 유형을 고려하여 다양한 음악 장르와 템포를 제공합니다.
  
- **손을 사용하지 않는 사용자 경험**: 운동 중 원하는 곡을 재생하기 위해 손을 사용하는 불편함을 해결합니다.

- **운동에 맞는 음악 사용자 정의**: 사용자가 운동 환경에 맞게 음악을 조절할 수 있는 기능을 제공합니다.

- **실시간 스트리밍**: 사용자가 음악을 실시간으로 스트리밍할 수 있도록 합니다.


<br><br>

## 전체 로직
<div align="center">
  <img style="width:60%; display:block; margin:0 auto;" src="https://github.com/LouiIII3/Running_Music-Project/assets/119919129/19deb815-01e8-46f6-a7b2-4208948fa046"/>
</div>


<br><br>



## UI 디자인

| UI V1 | UI V2 | 설명 |
|---|------|---|
| <img src="https://github.com/LouiIII3/Social_media_project/assets/119919129/7b419e28-3d95-4497-ab24-b5ffbf898d54" width="1400px" height="200px"> | <img src="https://github.com/LouiIII3/Temperature_Humidity-Visualization_Project/assets/119919129/a8aa7d5a-0ede-4dfe-b91a-884d6a9845cb" width="1400px" height="200px"> | 부트스트랩을 사용하여 웹사이트를 개발했습니다. 네비게이션 바에는 Main, Create Account, Login, Music 섹션이 포함되어 있습니다. |
| <img src="https://github.com/LouiIII3/Social_media_project/assets/119919129/7f635c2f-b551-49ff-b368-519ea24577eb" width="1400px" height="200px"> | <img src="https://github.com/LouiIII3/Temperature_Humidity-Visualization_Project/assets/119919129/792d2fac-7bdb-4638-95bf-200691de9dac" width="1400px" height="200px"> | 회원가입 양식에는 ID, 이메일 확인 및 발송, 인증코드 확인, 패스워드, 닉네임 등의 필드가 포함되어 있습니다. |
| <img src="https://github.com/LouiIII3/Social_media_project/assets/119919129/4c7b1b12-176a-432e-b73f-0101e8a16f5d" width="400px" height="200px"> | <img src="https://github.com/LouiIII3/Temperature_Humidity-Visualization_Project/assets/119919129/c43c7f40-2d2c-418a-951e-356680998787" width="400px" height="200px"> | 로그인 페이지에는 ID 및 패스워드 입력란과 비밀번호 재설정 및 회원가입 옵션이 포함되어 있습니다. (Facebook 로그인 옵션은 아직 구현되지 않았습니다.) |
| <img src="https://github.com/LouiIII3/Social_media_project/assets/119919129/0315797a-0a04-438d-83bc-2e409a0a5f57" width="400px" height="200px"> | <img src="https://github.com/LouiIII3/Temperature_Humidity-Visualization_Project/assets/119919129/31cee02d-ed3f-4033-8164-e07bc6569c5d" width="400px" height="200px"> | 음악 감상을 위한 창을 제공합니다 (관리자만 접근 가능).<br> 선택한 곡의 아티스트와 상세 정보를 제공합니다. 사용자는 곡 바를 통해 쉽게 곡을 듣고, 다음과 이전 버튼을 사용하여 탐색할 수 있습니다. 사용자는 원하는 곡을 듣기 위해 해당 버튼을 클릭할 수 있습니다. 로그아웃 버튼을 통해 안전하게 로그아웃하고, 사용자는 수동으로 심박수를 입력하여 전송할 수 있습니다. |
| <img src="https://github.com/LouiIII3/Running_Music-Project/assets/119919129/e3dde5f8-669d-4d6b-a130-4790e025a7c1" width="400px" height="200px"> | <img src="https://github.com/LouiIII3/Temperature_Humidity-Visualization_Project/assets/119919129/a6467631-03c0-4a23-823a-42065cd0e5cd" width="400px" height="200px"> | 사용자가 운동을 하는 영상을 보고 사용자의 운동 정보를 보여주는 UI입니다. 페이지 하단에는 QR 코드를 생성하는 부분이 포함되어 있습니다. |



<br><br>

## 사용 방법

- Spring Boot에서 Vue를 통합하는 방법:

    Vue 프로젝트를 깔끔하게 구성하기 위해 Spring Boot 프로젝트 내에 `vue` 폴더를 아래와 같이 생성합니다.

    ```sh
    mkdir vue
    ```

    이 명령을 실행하면 `vue` 폴더가 생성됩니다. 이제 생성된 폴더로 이동하여 Vue 프로젝트를 설정합니다.

    ```sh
    cd vue
    ```

    Vue 프로젝트를 생성하기 위해 다음 명령어를 실행합니다.

    ```sh
    vue init webpack vue-front
    ```

    이렇게 하면 Vue 프로젝트가 생성됩니다.

<br>

- Tensorflow 모듈 설치 방법:

  Tensorflow 모듈을 설치하려면 다음 명령어를 사용합니다.

  ```sh
  pip install tensorflow
  ```


<br><br>

## 추가 기능

#### 1. 토큰 구현

- 토큰 기반의 등록은 인증과 보안을 강화하고 상태 없는 아키텍처를 용이하게 하며, 인프라 구성 요소를 분리하고 사용자 경험을 개선하며, 응용 프로그램 간에 일관된 인증을 가능하게 합니다.

#### 2. V1 버전에서의 직접 로그인 및 가입 기능 구현

- Spring Security와 같은 프레임워크에 의존하지 않고 로그인 및 가입 기능을 직접 구현하기로 결정했습니다. 이는 기본 개념과 작동 원리에 대한 이해를 깊이 있게 하기 위함입니다.
- 다양한 보안 및 인증 기술을 직접 탐구함으로써, 다양한 기술에 대한 이해를 넓히고, 기술 스택을 발전시키고 싶기 때문입니다.

#### 3. 모델 API에 따른 딥러닝 환경 구축(2024-02-11)

- 모델 API에 따른 딥러닝 환경을 구축하여, 운동 데이터 분석 및 예측 기능을 강화하였습니다. 이를 통해 사용자는 보다 정교하고 맞춤형 운동 계획을 제공받을 수 있습니다.

#### <s>4. 카메라 심박도 측정(2024-02-11)</s>

- <s>얼굴이 나오지 않는경우 정확한 데이터를 얻기 힘들어 제거하였습니다.</s>

#### 5. 이메일 인증 기능 추가(2024-04-16)

- 사용자의 이메일 주소를 인증하는 기능을 추가하여 보안을 강화합니다. 이메일 인증은 사용자의 신원을 확인하고, 계정에 대한 액세스를 보호하는 데 도움이 됩니다.

#### 6. 운동 데이터 저장 기능 추가(2024-05-02)

- 사용자의 운동 데이터를 저장하는 기능을 추가하여 사용자가 운동한 내용을 기록하고 추적할 수 있습니다.

#### 7. QR 코드를 활용한 운동 데이터 전송 기능 추가(2024-05-13)

- QR 코드를 이용하여 사용자간에 운동 데이터를 쉽게 전송할 수 있는 기능을 추가하였습니다. 이를 통해 사용자들은 운동 결과를 더 쉽게 전송하고 비교할 수 있습니다.

#### 8. HTTPS 사용(2024-05-19)

- HTTPS(HTTP Secure)를 사용하여 데이터 전송 시 보안을 강화했습니다. HTTPS는 데이터를 암호화하여 전송하기 때문에 네트워크 상에서 발생할 수 있는 중간자 공격 및 도청을 방지할 수 있습니다.

#### 9. 로드 밸런서 사용(2024-05-25)
- Amazon Web Services(AWS) 로드 밸런서를 사용하여 HTTPS 트래픽을 처리했습니다. AWS 로드 밸런서는 SSL/TLS 인증서를 관리하고 트래픽을 안전하게 분산시켜 애플리케이션의 가용성과 보안을 모두 향상시켰습니다.

#### <s>10. IPv6 사용(2024-05-31)</s>
- <s>IPv6를 도입하여 네트워크 인프라를 미래 지향적으로 업그레이드 하였습니다.</s> (SSH 연결이 안되어 IPV4로 바꾸었습니다.)


<br><br>

## 진행중 생겼던 문제점들

- 데이터를 데이터베이스에 직접 가져오는 데 실패했습니다.
- 데이터베이스 수정
- 2024년 4월 2일 앱 베타(ios) 연결
- 2024년 4월 3일 - 4월 5일 <br>
  현재 스프링 부트 파일에 멀웨어 공격이 있었고 이에 대해 AWS에 문의 하였습니다.
- 2024년 4월 10일 <br>
  Spring Boot 프로젝트에서 Spring Security 사용 결정:
- 2024년 5월 15일 <br>
  Local에서 정상 작동하던 Tensorflow 모듈이 서버에 배포후 작동 하는 문제가 생겼습니다.

