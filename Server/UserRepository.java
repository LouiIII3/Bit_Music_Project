package com.example.social.media;

import org.springframework.data.repository.CrudRepository;

public interface UserRepository extends CrudRepository<User, Long> {
    User findByUserid(String userid);
    boolean existsByUserid(String userid);
    
}
