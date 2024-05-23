package com.example.social.music;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MusicService {

    @Autowired
    private MusicRepository musicRepository;

    private List<Music> musicList;
    private int currentSongIndex = -1;

    public Music getMusicByHeartRate(int heartRate) {
        String tempo = convertHeartRateToTempo(heartRate);
        List<Music> musicList = musicRepository.findByTempo(tempo);
        if (!musicList.isEmpty()) {
            this.musicList = musicList;
            this.currentSongIndex = 0;
            return musicList.get(0);
        }
        return null;
    }

    public Music getNextSong() {
        if (this.musicList == null || this.musicList.isEmpty()) {
            return null;
        }
        if (this.currentSongIndex < this.musicList.size() - 1) {
            this.currentSongIndex++;
        } else {
            this.currentSongIndex = 0; // 처음으로 돌아감
        }
        return this.musicList.get(currentSongIndex);
    }

    public Music getPreviousSong() {
        if (this.musicList == null || this.musicList.isEmpty()) {
            return null;
        }
        if (this.currentSongIndex > 0) {
            this.currentSongIndex--;
        } else {
            this.currentSongIndex = this.musicList.size() - 1; // 마지막으로 이동
        }
        return this.musicList.get(currentSongIndex);
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
}








