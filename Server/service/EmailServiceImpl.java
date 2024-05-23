package com.example.springjwt.service;

import java.util.*;
import java.util.concurrent.TimeUnit; // TimeUnit 추가


import com.example.springjwt.repository.EmailRepository;
import com.example.springjwt.repository.UserRepository;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class EmailServiceImpl implements EmailRepository {

    @Autowired
    JavaMailSender emailSender;

    // 인증코드의 유효시간을 설정
    private static final long VERIFICATION_CODE_EXPIRATION_MINUTES = 1;

    // 이메일 인증 여부를 저장하는 맵
    private Map<String, Boolean> emailVerificationStatus = new HashMap<>();

    // 이메일 주소와 인증 코드를 저장하기 위한 Map
    private Map<String, VerificationCodeInfo> emailCodeMap = new HashMap<>(); // VerificationCodeInfo 추가

    @Autowired
    private UserRepository userRepository;

    // 이메일 주소와 인증 코드를 저장하는 내부 클래스
    private static class VerificationCodeInfo {
        private final String code;
        private final long expirationTimeMillis;

        public VerificationCodeInfo(String code, long expirationTimeMillis) {
            this.code = code;
            this.expirationTimeMillis = expirationTimeMillis;
        }

        public String getCode() {
            return code;
        }

        public boolean isExpired() {
            return System.currentTimeMillis() > expirationTimeMillis;
        }
    }


    private MimeMessage createMessage(String to) throws Exception {
        String ePw = createKey(); // 새로운 인증 코드 생성
        System.out.println("보내는 대상 : " + to);
        System.out.println("인증 번호 : " + ePw);
        MimeMessage message = emailSender.createMimeMessage();

        message.addRecipients(MimeMessage.RecipientType.TO, to);// 보내는 대상
        message.setSubject("BitMusic 회원가입 이메일 인증");// 제목

        String msgg = "";
        msgg += "<div style='margin:100px;'>";
        msgg += "<h1> 이메일 내용 입니다. </h1>";
        message.setText(msgg, "utf-8", "html");// 내용
        message.setFrom(new InternetAddress("이메일 주소", "보내는 사람"));// 보내는 사람

        // 이메일 주소와 해당 인증 코드를 맵에 저장
        emailCodeMap.put(to, new VerificationCodeInfo(ePw, System.currentTimeMillis() + TimeUnit.MINUTES.toMillis(VERIFICATION_CODE_EXPIRATION_MINUTES)));

        return message;
    }

    public static String createKey() {
        StringBuilder key = new StringBuilder();
        Random rnd = new Random();

        //인증코드 8자리로 구현 할것
            }
        }

        return key.toString();
    }

    //동기화를 하여 데이터를 안섞이게 synchronized 추가
    @Override
    public synchronized String sendSimpleMessage(String to) throws Exception {
        MimeMessage message = createMessage(to);
        try {
            emailSender.send(message);
        } catch (MailException es) {
            es.printStackTrace();
            throw new IllegalArgumentException();
        }
        return emailCodeMap.get(to).getCode(); // 인증 코드 반환
    }

    public boolean verifyCode(String email, String code) {
        // emailCodeMap에서 해당 이메일의 인증 코드 가져오기
        VerificationCodeInfo codeInfo = emailCodeMap.get(email);
        if (codeInfo != null && !codeInfo.isExpired() && codeInfo.getCode().equals(code)) {
            // 인증 코드가 일치하고 유효하면 해당 이메일을 인증된 상태로 변경
            emailVerificationStatus.put(email, true);
            return true;
        } else {
            return false;
        }
    }



    // 이메일을 인증된 이메일로 표시
    public void markEmailAsVerified(String email) {
        emailVerificationStatus.put(email, true);
    }

    // 이메일이 이미 인증되었는지 확인
    public boolean isEmailVerified(String email) {

        return emailVerificationStatus.getOrDefault(email, false);
    }

    // 이미 가입된 이메일인지 확인
    //public boolean isEmailAlreadyExists(String email) {
   //     return registeredEmails.containsKey(email);
   // }

    // 이미 가입된 이메일인지 확인하는 메서드
    public boolean isEmailAlreadyExists(String email) {
        return userRepository.existsByEmail(email);
    }

}
