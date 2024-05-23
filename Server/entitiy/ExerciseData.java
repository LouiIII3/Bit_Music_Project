package com.example.springjwt.entitiy;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalTime;

@Entity
@Data
public class ExerciseData {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", referencedColumnName = "id")
    private UserEntity user;
    private String username;

    private LocalDate exerciseDate;
    private LocalTime exerciseTime;
    private int exerciseCount;
    private String exerciseName;

    @Override
    public String toString() {
        return "ExerciseData{" +
                "user=" + username +
                ", exerciseCount=" + exerciseCount +
                ", exerciseTime='" + exerciseTime + '\'' +
                ", exerciseDate='" + exerciseDate + '\'' +
                ", exerciseName='" + exerciseName + '\'' +
                '}';
    }
}
