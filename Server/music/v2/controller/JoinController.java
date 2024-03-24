package com.example.springjwt.controller;

import com.example.springjwt.dto.JoinDTO;
import com.example.springjwt.service.JoinService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;


@RestController
@ResponseBody
public class JoinController {

    private final JoinService joinService;

    public JoinController(JoinService joinService) {

        this.joinService = joinService;
    }

    //@PostMapping("/join")
    //public String joinProcess(JoinDTO joinDTO) {

    //    joinService.joinProcess(joinDTO);

     //   return "로그인 되었습니다";


    //회원가입 되었습니다.
    //@PostMapping("/join")
    //public String joinProcess(@RequestBody JoinDTO joinDTO) {
    //    joinService.joinProcess(joinDTO);
    //    return "회원가입 되었습니다";
    //}


    //
    @PostMapping("/join")
    public ResponseEntity<String> joinProcess(@RequestBody JoinDTO joinDTO) {
        String resultMessage = joinService.joinProcess(joinDTO);
        return ResponseEntity.ok(resultMessage);
    }
    
}
