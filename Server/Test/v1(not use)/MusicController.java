package com.example.social.music;

import com.example.social.media.JwtTokenProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/audio")
public class MusicController {

    @Autowired
    private MusicService musicService;

    @Autowired
    private JwtTokenProvider jwtTokenProvider;

    @GetMapping("/play")
    public ResponseEntity<?> getMusicByHeartRate(@RequestHeader("Authorization") String token,
                                                 @RequestParam("heartRate") int heartRate) {
        try {
            if (!jwtTokenProvider.validateToken(token)) {
                throw new Exception("유효하지 않은 토큰입니다.");
            }

            Music music = musicService.getMusicByHeartRate(heartRate);

            if (music == null) {
                return ResponseEntity.notFound().build();
            }

            MusicDTO musicDTO = convertToDTO(music);
            return ResponseEntity.ok(musicDTO);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(e.getMessage());
        }
    }

    @GetMapping("/next")
    public ResponseEntity<?> playNextSong(@RequestHeader("Authorization") String token) {
        try {
            if (!jwtTokenProvider.validateToken(token)) {
                throw new Exception("유효하지 않은 토큰입니다.");
            }

            Music nextSong = musicService.getNextSong();

            if (nextSong == null) {
                return ResponseEntity.notFound().build();
            }

            MusicDTO musicDTO = convertToDTO(nextSong);
            return ResponseEntity.ok(musicDTO);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(e.getMessage());
        }
    }

    @GetMapping("/previous")
    public ResponseEntity<?> playPreviousSong(@RequestHeader("Authorization") String token) {
        try {
            if (!jwtTokenProvider.validateToken(token)) {
                throw new Exception("유효하지 않은 토큰입니다.");
            }

            Music previousSong = musicService.getPreviousSong();

            if (previousSong == null) {
                return ResponseEntity.notFound().build();
            }

            MusicDTO musicDTO = convertToDTO(previousSong);
            return ResponseEntity.ok(musicDTO);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(e.getMessage());
        }
    }


    @GetMapping("/all")
    public ResponseEntity<?> getAllMusic(@RequestHeader("Authorization") String token) {
        try {
            if (!jwtTokenProvider.validateToken(token)) {
                throw new Exception("유효하지 않은 토큰입니다.");
            }

            List<Music> allMusic = musicService.getAllMusic();
            List<MusicDTO> allMusicDTO = allMusic.stream()
                    .map(this::convertToDTO)
                    .collect(Collectors.toList());

            return ResponseEntity.ok(allMusicDTO);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(e.getMessage());
        }
    }

    // MusicDTO로 변환하는 메서드
    private MusicDTO convertToDTO(Music music) {
        return new MusicDTO(
                music.getTitle(),
                music.getArtist(),
                music.getAlbumUrl(),
                music.getFilePath(),
                music.getTempo()
        );
    }
}




































