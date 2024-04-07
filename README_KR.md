# Workout-Beates

<div align="center">
  <img style="width:60%; display:block; margin:0 auto;" src="https://github.com/LouiIII3/Workout-Beats-Project/assets/119919129/7f998cac-bc8e-4b8d-ad32-07286d353969"/>
</div>

<h2>언어 선택</h2> 

[English](README_EN.md) | [한국어](README_KR.md)


  <h2>제작 이유및 설명</h2>
  
  - <b>다양한 장르와 템포의 음악을 제공하여 사용자의 다양한 음악 취향과 운동 유형에 맞게 제작됩니다.
    
  - <b>Workout Beats는 사용자가 운동 환경에 맞게 음악을 조절할 수 있는 기능을 제공합니다.
    
  - <b>Workout Beats는 사용자가 실시간으로 음악을 스트리밍할 수 있도록 합니다. 이를 위해서는 실시간 데이터 전송 및 처리, 버퍼링, 오디오 품질 관리 등의 기술이 필요합니다. (이는 사용자 경험을 향상시키는 데 도움이 될것입니다.)
<br>

<h2>UI(design)</h2>

  - 부트스트랩을 사용하여 웹사이트를 만들었습니다.
  - 네비게이션 바에는 Main, Create Account, Login, Music이 포함되어 있습니다.
<div align="center">
  <img width="70%" src="https://github.com/LouiIII3/Social_media_project/assets/119919129/7b419e28-3d95-4497-ab24-b5ffbf898d54"/>
</div>
<br>
<br>
  - 회원가입 창은 ID, 이메일 확인 및 발송, 인증코드 확인, 패스워드, 닉네임 등의 양식으로 이루어져 있습니다.
<div align="center">
  <img width="70%" src="https://github.com/LouiIII3/Social_media_project/assets/119919129/7f635c2f-b551-49ff-b368-519ea24577eb"/>
</div>
<br>
<br>
  - 로그인 창에는 ID와 패스워드 입력란이 있으며, 비밀번호를 잊은 경우와 회원가입할 수 있는 버튼도 포함되어 있습니다. (현재 페이스북 연결 옵션은 서버와에 구현하지 않았습니다.)
<div align="center">
  <img width="40%" src="https://github.com/LouiIII3/Social_media_project/assets/119919129/4c7b1b12-176a-432e-b73f-0101e8a16f5d"/>
</div>

<br>
<br>
  - 음악 감상을 할 수 있는 창을 제공합니다. <br>
선택한 노래의 가수와 노래에 대한 정보를 제공합니다. 사용자는 노래 바를 통해 쉽게 노래를 들을 수 있으며, 다음이나 이전 버튼을 통해 이동할 수 있습니다. 노래를 듣고 싶은 경우에는 해당 버튼을 클릭하여 들을 수 있습니다.
또한, 로그아웃 버튼을 통해 안전하게 로그아웃 할 수 있으며, 사용자는 직접 심박수를 입력하여 전송할 수도 있습니다.
<div align="center">
  <img width="40%" src="https://github.com/LouiIII3/Social_media_project/assets/119919129/0315797a-0a04-438d-83bc-2e409a0a5f57"/>
</div>

<br>
<br>
  - 로그인 상태와 로그인하지 않은 상태일 때의 화면
<div align="center">
  <img width="40%" src="https://github.com/LouiIII3/Social_media_project/assets/119919129/ed0d4e6b-1177-415b-af3b-d23518a2d27c"/>
  <img width="40%" src="https://github.com/LouiIII3/Social_media_project/assets/119919129/4101b585-e050-40ba-9a86-7bcca458bbb5"/>
</div>



  <h2>추가된 부분</h2>
1. 토큰 구현
  
  - 토큰 구현의 이유: 
토큰 기반의 등록은 인증 및 보안을 강화하고 상태 없는 아키텍처를 용이하게 하며, 인프라 구성 요소를 분리하고 사용자 경험을 개선하며, 응용 프로그램 간에 일관된 인증을 가능하게 합니다.

1-2. 직접 로그인 및 가입 기능 구현

   - 로그인 및 가입 기능을 직접 구현한 이유:
   나는 Spring Security와 같은 프레임워크에 의존하지 않고 로그인 및 가입 기능을 직접 구현하기로 결정했다. 이는 기본 개념과 작동 원리에 대한 이해를 깊이 있게 하기 위해서이다.

   - 다양한 보안 및 인증 기술을 직접 탐구함으로써, 다양한 기술에 대한 이해를 넓히고, 기술 스택에 대한 발전을 위 도움이 될 것으로 기대했다.

<h2>문제</h2>

- <s>데이터를 데이터베이스에 직접 가져오는 데 실패했습니다.</s>
- <s>데이터베이스 수정</s>
- <s>2024년 4월 2일 앱 베타(ios) 연결</s>
- <s>2024년 4월 3일 - 4월 5일 현재 스프링 부트 파일에 멀웨어 공격이 있었고 이에 대해 AWS에 문의 중입니다........</s>
