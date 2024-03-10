package com.example.social.music;

public class MusicDTO {

    private String title;
    private String artist;
    private String albumUrl;
    private String filePath;
    private String tempo; // 노래의 속도 (느림, 중간, 빠름)

    public MusicDTO() {
    }

    public MusicDTO(String title, String artist, String albumUrl, String filePath, String tempo) {
        this.title = title;
        this.artist = artist;
        this.albumUrl = albumUrl;
        this.filePath = filePath;
        this.tempo = tempo;
    }

    // Getter 및 Setter 메서드
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

    public void setAlbumUrl(String albumUrl) {
        this.albumUrl = albumUrl;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getTempo() {
        return tempo;
    }

    public void setTempo(String tempo) {
        this.tempo = tempo;
    }
}


