package com.example.springjwt.service;

import com.example.springjwt.dto.LoginDTO;
import com.example.springjwt.jwt.JWTUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.AuthenticationException;
import org.springframework.stereotype.Service;

@Service
public class LoginService {

    // Inner class representing the login response payload
    public static class LoginResponse {
        private String token;

        // Constructor
        public LoginResponse(String token) {
            this.token = token;
        }

}}
