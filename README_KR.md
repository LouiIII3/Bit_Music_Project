# Workout-Beats

<div align="center">
  <img style="width:60%; display:block; margin:0 auto;" src="https://github.com/LouiIII3/Workout-Beats-Project/assets/119919129/7f998cac-bc8e-4b8d-ad32-07286d353969"/>
</div>

## 언어 선택

[English](README_EN.md) | [한국어](README_KR.md)

## 프로젝트 소개 및 목적

- **다양한 음악 선택**: 사용자의 다양한 취향과 운동 유형을 고려하여 다양한 음악 장르와 템포를 제공합니다.
  
- **손을 사용하지 않는 사용자 경험**: 운동 중 원하는 곡을 재생하기 위해 손을 사용하는 불편함을 해결합니다.

- **운동에 맞는 음악 사용자 정의**: 사용자가 운동 환경에 맞게 음악을 조절할 수 있는 기능을 제공합니다.

- **실시간 스트리밍**: 사용자가 음악을 실시간으로 스트리밍할 수 있도록 합니다. 이를 위해 실시간 데이터 전송, 버퍼링, 오디오 품질 관리 등의 기술이 필요합니다.

## UI 디자인

- 부트스트랩을 사용하여 웹사이트를 개발했습니다.
- 네비게이션 바에는 Main, Create Account, Login, Music 섹션이 포함되어 있습니다.

<div align="center">
  <img width="70%" src="https://github.com/LouiIII3/Social_media_project/assets/119919129/7b419e28-3d95-4497-ab24-b5ffbf898d54"/>
</div>

- 회원가입 양식에는 ID, 이메일 확인 및 발송, 인증코드 확인, 패스워드, 닉네임 등의 필드가 포함되어 있습니다.

<div align="center">
  <img width="70%" src="https://github.com/LouiIII3/Social_media_project/assets/119919129/7f635c2f-b551-49ff-b368-519ea24577eb"/>
</div>

- 로그인 페이지에는 ID 및 패스워드 입력란과 비밀번호 재설정 및 회원가입 옵션이 포함되어 있습니다. (Facebook 로그인 옵션은 아직 구현되지 않았습니다.)

<div align="center">
  <img width="40%" src="https://github.com/LouiIII3/Social_media_project/assets/119919129/4c7b1b12-176a-432e-b73f-0101e8a16f5d"/>
</div>

- 음악 감상을 위한 창을 제공합니다 (관리자만 접근 가능).

<details>
<summary>자세한 내용</summary>

- 선택한 곡의 아티스트와 상세 정보를 제공합니다.
- 사용자는 곡 바를 통해 쉽게 곡을 듣고, 다음과 이전 버튼을 사용하여 탐색할 수 있습니다.
- 사용자는 원하는 곡을 듣기 위해 해당 버튼을 클릭할 수 있습니다.
- 로그아웃 버튼을 통해 안전하게 로그아웃하고, 사용자는 수동으로 심박수를 입력하여 전송할 수 있습니다.
</details>

<div align="center">
  <img width="40%" src="https://github.com/LouiIII3/Social_media_project/assets/119919129/0315797a-0a04-438d-83bc-2e409a0a5f57"/>
</div>

- 로그인 및 로그아웃 상태에 대한 스크린샷입니다.

<div align="center">
  <img width="40%" src="https://github.com/LouiIII3/Social_media_project/assets/119919129/ed0d4e6b-1177-415b-af3b-d23518a2d27c"/>
  <img width="40%" src="https://github.com/LouiIII3/Social_media_project/assets/119919129/4101b585-e050-40ba-9a86-7bcca458bbb5"/>
</div>

## 사용 방법

- Spring Boot에서 Vue를 통합하는 방법:

    Vue 프로젝트를 깔끔하게 구성하기 위해 Spring Boot 프로젝트 내에 `vue` 폴더를 아래와 같이 생성하세요.

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


## 추가 기능

#### 1. 토큰 구현

- 토큰 기반의 등록은 인증과 보안을 강화하고 상태 없는 아키텍처를 용이하게 하며, 인프라 구성 요소를 분리하고 사용자 경험을 개선하며, 응용 프로그램 간에 일관된 인증을 가능하게 합니다.

#### 2. V1 버전에서의 직접 로그인 및 가입 기능 구현

- Spring Security와 같은 프레임워크에 의존하지 않고 로그인 및 가입 기능을 직접 구현하기로 결정했습니다. 이는 기본 개념과 작동 원리에 대한 이해를 깊이 있게 하기 위함입니다.
- 다양한 보안 및 인증 기술을 직접 탐구함으로써, 다양한 기술에 대한 이해를 넓히고, 기술 스택을 발전시키고 싶기 때문입니다.

#### 3. 이메일 인증 기능 추가

- 사용자의 이메일 주소를 인증하는 기능을 추가하여 보안을 강화합니다. 이메일 인증은 사용자의 신원을 확인하고, 계정에 대한 액세스를 보호하는 데 도움이 됩니다.


## 진행중 생겼던 문제점들

- 데이터를 데이터베이스에 직접 가져오는 데 실패했습니다.
- 데이터베이스 수정
- 2024년 4월 2일 앱 베타(ios) 연결
- 2024년 4월 3일 - 4월 5일 <br>
  현재 스프링 부트 파일에 멀웨어 공격이 있었고 이에 대해 AWS에 문의 하였습니다.
- 2024년 4월 10일 <br>
  Spring Boot 프로젝트에서 Spring Security 사용 결정:

