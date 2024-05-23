package com.example.springjwt.repository;

import com.example.springjwt.entitiy.ExerciseData;
import com.example.springjwt.entitiy.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ExerciseDataRepository extends JpaRepository<ExerciseData, Long> {

    //사람이 여러명인 경우 그 사용자만의 데이터를 찾기위해 리스트형으로 만들어서 반환한다.
    List<ExerciseData> findByUsername(String username);
}
