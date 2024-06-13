# Workout-Beats

## 언어 선택

[English](README_EN.md) | [한국어](README_KR.md)

<br><br>


### Logo
<div align="center">
  
  | WEB | APP |
  |:---:|:---:|
  | <img src="https://github.com/LouiIII3/Workout-Beats-Project/assets/119919129/7f998cac-bc8e-4b8d-ad32-07286d3539694" width="200px" height="200px"> | <img src="https://github.com/LouiIII3/web_node.js/assets/119919129/cd06c3ed-bdb6-4c9f-9595-c83ff39909f5" width="200px" height="200px"> |
</div>


## Language Selection


[English](README_EN.md) | [한국어](README_KR.md)

<br><br>

## Project Introduction and Objectives

- **Diverse Music Selection**: Provides various music genres and tempos tailored to users' diverse tastes and workout types.
  
- **Hands-free User Experience**: Addresses the inconvenience of using hands to play desired songs during workouts.

- **Customized Music for Workouts**: Offers the ability for users to adjust music to fit their workout environment.

- **Real-time Streaming**: Enables users to stream music in real-time.

- **Correct Exercise Postures**: Provides features to ensure users perform exercises correctly. 


<br><br>

## Overall Logic
<div align="center">
  <img style="width:60%; display:block; margin:0 auto;" src="https://github.com/LouiIII3/Running_Music-Project/assets/119919129/19deb815-01e8-46f6-a7b2-4208948fa046"/>
</div>


<br><br>



## UI Design

| Image | Description |
|---|---|
| <img src="https://github.com/LouiIII3/Social_media_project/assets/119919129/7b419e28-3d95-4497-ab24-b5ffbf898d54" width="1400px" height="200px"> | Developed the website using Bootstrap. The navigation bar includes Main, Create Account, Login, and Music sections. |
| <img src="https://github.com/LouiIII3/Social_media_project/assets/119919129/7f635c2f-b551-49ff-b368-519ea24577eb" width="1400px" height="200px"> | The sign-up form includes fields for ID, email verification and dispatch, authentication code verification, password, and nickname. |
| <img src="https://github.com/LouiIII3/Social_media_project/assets/119919129/4c7b1b12-176a-432e-b73f-0101e8a16f5d" width="400px" height="200px"> | The login page includes fields for ID and password, as well as options for password reset and account registration. (Facebook login option is not yet implemented.) |
| <img src="https://github.com/LouiIII3/Social_media_project/assets/119919129/0315797a-0a04-438d-83bc-2e409a0a5f57" width="400px" height="200px"> | Provides a window for listening to music (accessible only to administrators). <br>Provides detailed information about the selected song and artist. Users can easily listen to songs, navigate using next and previous buttons, and click the respective button to listen to desired songs. Users can log out securely and manually input heart rates for transmission. |
| <img src="https://github.com/LouiIII3/Running_Music-Project/assets/119919129/e3dde5f8-669d-4d6b-a130-4790e025a7c1" width="400px" height="200px"> | Displays exercise data while watching exercise videos. Includes a section for generating QR codes at the bottom of the page. |



<br><br>

## Usage

- Integrating Vue in Spring Boot:

    To neatly organize the Vue project, create a `vue` folder inside your Spring Boot project as follows:

    ```sh
    mkdir vue
    ```

    Running this command will create the `vue` folder. Now navigate to the created folder to configure the Vue project:

    ```sh
    cd vue
    ```

    To create the Vue project, run the following command:

    ```sh
    vue init webpack vue-front
    ```

    This will create the Vue project.

<br>

- Installing the Tensorflow module:

  To install the Tensorflow module, use the following command:

  ```sh
  pip install tensorflow

<br><br>

## Additional Features

#### 1. Token Implementation

- Token-based registration enhances authentication and security, facilitates stateless architecture, separates infrastructure components, improves user experience, and enables consistent authentication across applications.

#### 2. Direct Login and Registration Feature Implementation in V1 Version

- Decided to implement login and registration features directly without relying on frameworks like Spring Security. This decision was made to deepen understanding of basic concepts and operational principles.
- By directly exploring various security and authentication technologies, we aim to broaden understanding of different technologies and advance our technology stack.

#### 3. Email Verification Feature Added (2024-04-16)

- Added functionality to verify user email addresses to enhance security. Email verification helps verify user identities and protect access to accounts.

#### 4. Exercise Data Storage Feature Added (2024-05-02)

- Added functionality to store user exercise data, allowing users to record and track their workouts.

#### 5. Exercise Data Collection Feature Added Using Tensorflow (2024-05-10)

- Added functionality to collect and analyze user exercise data using Tensorflow. This feature will help learn and improve user exercise patterns.

#### 6. Exercise Data Transfer Feature Added Using QR Codes (2024-05-13)

- Added functionality to easily transfer exercise data between users using QR codes. This allows users to easily share and compare workout results.


<br><br>

## Issues Encountered During Development

- Failed to directly retrieve data from the database.
- Database modification.
- App beta (iOS) connection on April 2, 2024.
- April 3-5, 2024: <br>
  Identified malware attacks on the Spring Boot files and contacted AWS for assistance.
- April 10, 2024: <br>
  Decision to use Spring Security in the Spring Boot project.
- May 15, 2024: <br>
  Issue arose with Tensorflow module not functioning correctly after deployment on the server.

