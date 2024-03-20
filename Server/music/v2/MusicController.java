package com.example.springjwt.controller;

import com.example.springjwt.dto.MusicDTO;
import com.example.springjwt.entitiy.Music;
import com.example.springjwt.service.JoinService;
import com.example.springjwt.service.MusicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@RestController
public class MusicController {

    @Autowired
    private MusicService musicService;

    @Autowired
    private JoinService joinService;

    @GetMapping("/music")
    public ResponseEntity<?> getMusicByHeartRate(@RequestParam int heartRate) {
        // 사용자 인증
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("User not authenticated");
        }

        // 사용자 정보 가져오기
        String username = authentication.getName();

        //심박수 저장
        musicService.updateHeartRate(username, heartRate);

        // 사용자의 심박수를 기반으로 음악 가져오기
        MusicDTO musicDTO = musicService.getMusicByHeartRate(heartRate);
        if (musicDTO == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("No music found for this heart rate");
        }

        return ResponseEntity.ok(musicDTO);
    }

    @GetMapping("/next")
    public ResponseEntity<?> playNextSong() {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("User not authenticated");
        }

            // 사용자 정보 가져오기
            String username = authentication.getName();

            // 사용자의 심박수 가져오기
            int heartRate = joinService.getHeartRate(username);

            // 다음 노래 재생하기
            Music nextSong = musicService.getNextSongByHeartRate(heartRate);

            if (nextSong == null) {
                return ResponseEntity.notFound().build();
            }

            MusicDTO musicDTO = convertToDTO(nextSong);
            return ResponseEntity.ok(musicDTO);
    }


    @GetMapping("/previous")
    public ResponseEntity<?> playPreviousSong(@RequestHeader("Authorization") String token) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("User not authenticated");
        }

            // 사용자 정보 가져오기
            String username = authentication.getName();

            // 사용자의 심박수 가져오기
            int heartRate = joinService.getHeartRate(username);

            // 이전 노래 재생하기
            Music previousSong = musicService.getPreviousSongByHeartRate(heartRate);

            if (previousSong == null) {
                return ResponseEntity.notFound().build();
            }

            MusicDTO musicDTO = convertToDTO(previousSong);
            return ResponseEntity.ok(musicDTO);
        }


    @GetMapping("/all")
    public ResponseEntity<?> getAllMusic(@RequestHeader("Authorization") String token) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("User not authenticated");
        }

            List<Music> allMusic = musicService.getAllMusic();
            List<MusicDTO> allMusicDTO = allMusic.stream()
                    .map(this::convertToDTO)
                    .collect(Collectors.toList());

            return ResponseEntity.ok(allMusicDTO);
        }














    //전부가져오기 위한 메소드- 다음혹은 이전노래의
    private MusicDTO convertToDTO(Music music) {
        return new MusicDTO(
                music.getId(),
                music.getTitle(),
                music.getArtist(),
                music.getAlbumUrl(),
                music.getFilePath(),
                music.getTempo()
        );
    }
}
