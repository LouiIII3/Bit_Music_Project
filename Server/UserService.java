package com.example.social.media;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDate;



@Service("customUserService")
public class UserService {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;


    //회원가입 양식
    public User registerUser(String id, String password, LocalDate birthdate, String nickname, String profilePictureUrl) {
        User newUser = new User(); // 새로운 사용자 생성

        // 새로운 사용자에 정보 설정
        newUser.setUserid(id);
        newUser.setPassword(passwordEncoder.encode(password));
        newUser.setBirthdate(birthdate);
        newUser.setNickname(nickname);
        newUser.setProfilePictureUrl(profilePictureUrl);

        return userRepository.save(newUser); // 새로운 사용자 저장 후 반환
    }

    public boolean isUseridExists(String userid) {
        return userRepository.existsByUserid(userid);
    }

    //로그인 기능
    public User findUserByUsernameAndPassword(String userid, String password) {
        User user = userRepository.findByUserid(userid);
        if (user != null && passwordEncoder.matches(password, user.getPassword())) {
            return user;
        }
        return null;
    }


    //비번 수정
    public boolean updatePassword(String userid, String currentPassword, String newPassword) {
        User user = userRepository.findByUserid(userid);

        if (user != null && passwordEncoder.matches(currentPassword, user.getPassword())) {
            user.setPassword(passwordEncoder.encode(newPassword));
            userRepository.save(user);
            return true;
        }

        return false;
    }

    public User findUserByUsername(String userid) {
        return userRepository.findByUserid(userid);
    }

}