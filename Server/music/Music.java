package com.example.social.music;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class Music {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String title;
    private String artist;
    private String albumUrl;
    private String filePath;
    private String tempo; // 노래의 속도 (느림, 중간, 빠름)

    public Music() {
    }

    public Music(String title, String artist, String albumUrl, String filePath, String tempo) {
        this.title = title;
        this.artist = artist;
        this.albumUrl = albumUrl;
        this.filePath = filePath;
        this.tempo = tempo;
    }

    // Getter 및 Setter 메서드
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getArtist() {
        return artist;
    }

    public void setArtist(String artist) {
        this.artist = artist;
    }

    public String getAlbumUrl() {
        return albumUrl;
    }


    public String getFilePath() {
        return filePath;
    }


    public String getTempo() {
        return tempo;
    }

}
