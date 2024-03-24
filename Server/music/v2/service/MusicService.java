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
    private int currentSongIndex = 0;

    public MusicDTO getMusicByHeartRate(String username, int newHeartRate) {
        UserEntity user = userRepository.findByUsername(username);

        if (user != null) {
            // 클라이언트가 전송한 새로운 심박수를 업데이트
            user.setHeartRate(newHeartRate);
            userRepository.save(user);

            String tempo = convertHeartRateToTempo(newHeartRate);
            List<Music> musicList = musicRepository.findByTempo(tempo);

            int currentSongIndex;
            switch (tempo) {
                case "slow":
                    currentSongIndex = user.getSlowSongIndex();
                    break;
                case "normal":
                    currentSongIndex = user.getNormalSongIndex();
                    break;
                case "fast":
                    currentSongIndex = user.getFastSongIndex();
                    break;
                default:
                    currentSongIndex = -1;
            }

            if (!musicList.isEmpty() && currentSongIndex >= 0 && currentSongIndex < musicList.size()) {
                Music music = musicList.get(currentSongIndex);

                // 여기에서 음악 정보만을 포함한 MusicDTO를 생성하여 반환합니다.
                return convertToMusicDTO(music);
            }
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


    // 다음 노래를 심박수를 기반으로 가져오는 메서드
    public Music getNextSongByHeartRate(String username, int heartRate) {
        UserEntity user = userRepository.findByUsername(username);
        if (user != null) {
            String tempo = convertHeartRateToTempo(heartRate);
            List<Music> musicList = musicRepository.findByTempo(tempo);

            int currentSongIndex;
            switch (tempo) {
                case "slow":
                    currentSongIndex = user.getSlowSongIndex();
                    break;
                case "normal":
                    currentSongIndex = user.getNormalSongIndex();
                    break;
                case "fast":
                    currentSongIndex = user.getFastSongIndex();
                    break;
                default:
                    currentSongIndex = -1;
            }

            if (currentSongIndex < musicList.size()) {


                // 다음 노래가 마지막 노래가 아닌 경우에만 인덱스를 증가시킴
                if (currentSongIndex < musicList.size() - 1) {
                    currentSongIndex++;

                } else {
                    // 마지막 노래일 경우, 인덱스를 초기화
                    currentSongIndex = 0;
                }

                Music nextSong = musicList.get(currentSongIndex);

                // 인덱스 업데이트
                switch (tempo) {
                    case "slow":
                        user.setSlowSongIndex(currentSongIndex);
                        break;
                    case "normal":
                        user.setNormalSongIndex(currentSongIndex);
                        break;
                    case "fast":
                        user.setFastSongIndex(currentSongIndex);
                        break;
                }

                userRepository.save(user);
                return nextSong;
            }
        }
        return null;
    }

    public Music getPreviousSongByHeartRate(String username, int heartRate) {
        UserEntity user = userRepository.findByUsername(username);
        if (user != null) {
            String tempo = convertHeartRateToTempo(heartRate);
            List<Music> musicList = musicRepository.findByTempo(tempo);

            int currentSongIndex;
            switch (tempo) {
                case "slow":
                    currentSongIndex = user.getSlowSongIndex();
                    break;
                case "normal":
                    currentSongIndex = user.getNormalSongIndex();
                    break;
                case "fast":
                    currentSongIndex = user.getFastSongIndex();
                    break;
                default:
                    currentSongIndex = -1;
            }

            // 이전 노래가 첫 번째 노래가 아닌 경우에만 인덱스를 감소시킴
            if (currentSongIndex > 0) {
                currentSongIndex--;
            } else {
                // 첫 번째 노래일 경우, 인덱스를 마지막 노래로 초기화
                currentSongIndex = musicList.size() - 1;
            }

            if (currentSongIndex >= 0 && currentSongIndex < musicList.size()) {
                // 인덱스 업데이트
                switch (tempo) {
                    case "slow":
                        user.setSlowSongIndex(currentSongIndex);
                        break;
                    case "normal":
                        user.setNormalSongIndex(currentSongIndex);
                        break;
                    case "fast":
                        user.setFastSongIndex(currentSongIndex);
                        break;
                }

                userRepository.save(user);
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