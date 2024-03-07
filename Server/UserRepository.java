package com.example.social.media;

import org.springframework.data.repository.CrudRepository;

public interface UserRepository extends CrudRepository<User, Long> {
    User findByUserid(String userid);
    //userid가 이미 데이터베이스에 존재하는지
    boolean existsByUserid(String userid);
}