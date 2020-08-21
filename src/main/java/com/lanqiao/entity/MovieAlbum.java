package com.lanqiao.entity;

public class MovieAlbum {

    private Integer id;
    private String imgUrl;
    private Integer filmId;

    public MovieAlbum() {
    }

    public MovieAlbum(Integer id, String imgUrl, Integer filmId) {
        this.id = id;
        this.imgUrl = imgUrl;
        this.filmId = filmId;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public Integer getFilmId() {
        return filmId;
    }

    public void setFilmId(Integer filmId) {
        this.filmId = filmId;
    }

    @Override
    public String toString() {
        return "MovieAlbum{" +
                "id=" + id +
                ", imgUrl='" + imgUrl + '\'' +
                ", filmId=" + filmId +
                '}';
    }
}
