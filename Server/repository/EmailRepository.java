package com.example.springjwt.repository;

public interface EmailRepository {
    String sendSimpleMessage(String to)throws Exception;
}
