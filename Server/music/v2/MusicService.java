package com.example.springjwt.service;


import com.example.springjwt.dto.MusicDTO;
import com.example.springjwt.entitiy.Music;
import com.example.springjwt.entitiy.UserEntity;
import com.example.springjwt.repository.MusicRepository;
import com.example.springjwt.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MusicService {

    @Autowired
    private MusicRepository musicRepository;

    @Autowired
    private UserRepository userRepository;

    private List<Music> musicList;
    private int currentSongIndex = -1;

    public MusicDTO getMusicByHeartRate(int heartRate) {
        String tempo = convertHeartRateToTempo(heartRate);
        List<Music> musicList = musicRepository.findByTempo(tempo);
        if (!musicList.isEmpty()) {
            Music music = musicList.get(0); // 첫 번째 음악을 가져옴
            return convertToMusicDTO(music); // Music를 MusicDTO로 변환하여 반환
        }
        return null;
    }


    public void updateHeartRate(String username, int heartRate) {
        UserEntity user = userRepository.findByUsername(username);
        if (user != null) {
            user.setHeartRate(heartRate);
            userRepository.save(user);
        }
    }

    public int getHeartRate(String username) {
        UserEntity user = userRepository.findByUsername(username);
        if (user != null) {
            return user.getHeartRate();
        }
        return 0;
    }


    // 다음 노래를 심박수를 기반으로 가져오는 메서드
    public Music getNextSongByHeartRate(int heartRate) {
        String tempo = convertHeartRateToTempo(heartRate);
        List<Music> musicList = musicRepository.findByTempo(tempo);
        if (!musicList.isEmpty()) {
            if (currentSongIndex + 1 < musicList.size()) {
                currentSongIndex++; // 다음 노래의 인덱스로 업데이트
                return musicList.get(currentSongIndex); // 다음 노래 반환
            } else {
                // 마지막 노래일 경우, 첫 번째 노래를 반환
                currentSongIndex = 0;
                return musicList.get(0);
            }
        }
        return null;
    }

    // 이전 노래를 심박수를 기반으로 가져오는 메서드
    public Music getPreviousSongByHeartRate(int heartRate) {
        String tempo = convertHeartRateToTempo(heartRate);
        List<Music> musicList = musicRepository.findByTempo(tempo);
        if (!musicList.isEmpty()) {
            if (currentSongIndex - 1 >= 0) {
                currentSongIndex--; // 이전 노래의 인덱스로 업데이트
                return musicList.get(currentSongIndex); // 이전 노래 반환
            } else {
                // 첫 번째 노래일 경우, 마지막 노래를 반환
                currentSongIndex = musicList.size() - 1;
                return musicList.get(currentSongIndex);
            }
        }
        return null;
    }


    private String convertHeartRateToTempo(int heartRate) {
        if (heartRate >= 60 && heartRate <= 90) {
            return "slow";
        } else if (heartRate > 90 && heartRate <= 110) {
            return "normal";
        } else {
            return "fast";
        }
    }

    public List<Music> getAllMusic() {
        return musicRepository.findAll();
    }

    private MusicDTO convertToMusicDTO(Music music) {
        MusicDTO musicDTO = new MusicDTO();
        musicDTO.setId(music.getId());
        musicDTO.setTitle(music.getTitle());
        musicDTO.setArtist(music.getArtist());
        musicDTO.setAlbumUrl(music.getAlbumUrl());
        musicDTO.setFilePath(music.getFilePath());
        musicDTO.setTempo(music.getTempo());
        return musicDTO;
    }
}