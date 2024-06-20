# Bit-Music

## 언어 선택

[English](README_EN.md) | [한국어](README_KR.md)

<br><br>

### Logo
<div align="center">
  
  | WEB | APP |
  |:---:|:---:|
  | <img src="https://github.com/LouiIII3/Workout-Beats-Project/assets/119919129/7f998cac-bc8e-4b8d-ad32-07286d3539694" width="200px" height="200px"> | <img src="https://github.com/LouiIII3/web_node.js/assets/119919129/cd06c3ed-bdb6-4c9f-9595-c83ff39909f5" width="200px" height="200px"> |
</div>



<br><br>

## Project Introduction and Objectives

- **Diverse Music Selection**: Provides various music genres and tempos tailored to users' diverse tastes and workout types.
  
- **Hands-free User Experience**: Addresses the inconvenience of using hands to play desired songs during workouts.

- **Customized Music for Workouts**: Offers the ability for users to adjust music to fit their workout environment.

- **Real-time Streaming**: Enables users to stream music in real-time.



<br><br>

## Overall Logic
<div align="center">
  <img style="width:60%; display:block; margin:0 auto;" src="https://github.com/LouiIII3/Running_Music-Project/assets/119919129/19deb815-01e8-46f6-a7b2-4208948fa046"/>
</div>


<br><br>



## UI Design

| UI V1 | UI V2 | Description |
|---|------|---|
| <img src="https://github.com/LouiIII3/Social_media_project/assets/119919129/7b419e28-3d95-4497-ab24-b5ffbf898d54" width="1400px" height="200px"> | <img src="https://github.com/LouiIII3/Temperature_Humidity-Visualization_Project/assets/119919129/a8aa7d5a-0ede-4dfe-b91a-884d6a9845cb" width="1400px" height="200px"> | Developed the website using Bootstrap. The navigation bar includes sections for Main, Create Account, Login, and Music. |
| <img src="https://github.com/LouiIII3/Social_media_project/assets/119919129/7f635c2f-b551-49ff-b368-519ea24577eb" width="1400px" height="200px"> | <img src="https://github.com/LouiIII3/Temperature_Humidity-Visualization_Project/assets/119919129/792d2fac-7bdb-4638-95bf-200691de9dac" width="1400px" height="200px"> | The registration form includes fields for ID, email verification and sending, verification code, password, and nickname. |
| <img src="https://github.com/LouiIII3/Social_media_project/assets/119919129/4c7b1b12-176a-432e-b73f-0101e8a16f5d" width="400px" height="200px"> | <img src="https://github.com/LouiIII3/Temperature_Humidity-Visualization_Project/assets/119919129/c43c7f40-2d2c-418a-951e-356680998787" width="400px" height="200px"> | The login page includes fields for ID and password input, password reset, and registration options. (Facebook login option not yet implemented.) |
| <img src="https://github.com/LouiIII3/Social_media_project/assets/119919129/0315797a-0a04-438d-83bc-2e409a0a5f57" width="400px" height="200px"> | <img src="https://github.com/LouiIII3/Temperature_Humidity-Visualization_Project/assets/119919129/31cee02d-ed3f-4033-8164-e07bc6569c5d" width="400px" height="200px"> | Provides a window for listening to music (admin access only).<br>Displays the artist and details of the selected track. Users can easily listen to the track through the track bar and navigate using the next and previous buttons. Users can click the button to listen to the desired song. The logout button allows for safe logout, and users can manually enter and send their heart rate. |
| <img src="https://github.com/LouiIII3/Running_Music-Project/assets/119919129/e3dde5f8-669d-4d6b-a130-4790e025a7c1" width="400px" height="200px"> | <img src="https://github.com/LouiIII3/Temperature_Humidity-Visualization_Project/assets/119919129/a6467631-03c0-4a23-823a-42065cd0e5cd" width="400px" height="200px"> | UI showing the user's exercise information by watching the user exercise video. The bottom of the page includes a section for generating a QR code. |



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

#### 2. Direct Login and Registration Implementation in V1 Version

- Decided to implement the login and registration functions directly without relying on frameworks like Spring Security. This is to gain a deeper understanding of the basic concepts and working principles.
- By directly exploring various security and authentication technologies, we aim to broaden our understanding of different technologies and advance our technical stack.

#### 3. Deep Learning Environment Setup According to Model API (2024-02-11)

- Set up a deep learning environment according to the Model API to enhance exercise data analysis and prediction capabilities. This allows users to receive more sophisticated and customized exercise plans.

#### <s>4. Camera Heart Rate Measurement (2024-02-11)</s>

- <s>Removed due to difficulty in obtaining accurate data when the face is not visible.</s>

#### 5. Email Verification Feature Added (2024-04-16)

- Added a feature to verify the user's email address to enhance security. Email verification helps confirm the user's identity and protect access to the account.

#### 6. Exercise Data Storage Feature Added (2024-05-02)

- Added a feature to store users' exercise data, allowing them to record and track their workouts.

#### 7. QR Code-based Exercise Data Transfer Feature Added (2024-05-13)

- Added a feature to easily transfer exercise data between users using QR codes. This allows users to easily share and compare workout results.

#### 8. HTTPS Usage (2024-05-19)

- Enhanced security by using HTTPS (HTTP Secure) for data transmission. HTTPS encrypts the data being transmitted, preventing man-in-the-middle attacks and eavesdropping on the network.

#### 9. Load Balancer Usage (2024-05-25)

- Handled HTTPS traffic using Amazon Web Services (AWS) Load Balancer. The AWS Load Balancer manages SSL/TLS certificates and safely distributes traffic, improving both the availability and security of the application.

#### <s>10. IPv6 Usage (2024-05-31)</s>

- <s>Upgraded the network infrastructure to be future-oriented by adopting IPv6.</s> (Reverted to IPv4 due to issues with SSH connectivity.)

<br><br>

## Issues Encountered

- Failed to directly retrieve data from the database.
- Database modifications.
- iOS app beta connection on April 2, 2024.
- April 3-5, 2024 <br>
  Encountered malware attacks on the Spring Boot file and contacted AWS for resolution.
- April 10, 2024 <br>
  Decision to use Spring Security in the Spring Boot project.
- May 15, 2024 <br>
  Tensorflow module working correctly locally but having issues after server deployment.
