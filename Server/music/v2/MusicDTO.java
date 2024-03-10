package com.example.springjwt.dto;

import com.example.springjwt.entitiy.Music;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MusicDTO {
    private Long id;
    private String title;
    private String artist;
    private String albumUrl;
    private String filePath;
    private String tempo;

    public MusicDTO() {}


    //전부 다 가져가기 위한 메소드
    public MusicDTO(Long id, String title, String artist, String albumUrl, String filePath, String tempo) {
        this.id = id;
        this.title = title;
        this.artist = artist;
        this.albumUrl = albumUrl;
        this.filePath = filePath;
        this.tempo = tempo;
    }

}

