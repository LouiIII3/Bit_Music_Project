package com.example.springjwt.controller;

import com.example.springjwt.entitiy.ExerciseData;
import com.example.springjwt.repository.ExerciseDataRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("exercise")
public class ExerciseDataController {

    @Autowired
    private ExerciseDataRepository exerciseDataRepository;


    @GetMapping("/user-data")
    public ResponseEntity<?> getUserExerciseData() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("User not authenticated");
        }

        String username = authentication.getName();
        List<ExerciseData> exerciseDataList = exerciseDataRepository.findByUsername(username);
        if (exerciseDataList.isEmpty()) {
            System.out.println("No exercise data found for user: " + username);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            System.out.println("Exercise data found for user: " + username);
            return new ResponseEntity<>(exerciseDataList, HttpStatus.OK);
        }
    }



    //html 파일에서 데이터 받기
    @PostMapping("/sub-data")
    public ResponseEntity<String> submitExerciseData(@RequestBody ExerciseData exerciseData) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("User not authenticated");
        }
        // 데이터베이스에 데이터 저장
        exerciseDataRepository.save(exerciseData);

        // 응답으로 클라이언트에게 성공 여부를 전송
        return ResponseEntity.noContent().build();
    }
}
