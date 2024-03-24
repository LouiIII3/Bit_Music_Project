package com.example.springjwt.repository;

import com.example.springjwt.entitiy.Music;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MusicRepository extends JpaRepository<Music, Long> {
    List<Music> findByTempo(String tempo);
}
