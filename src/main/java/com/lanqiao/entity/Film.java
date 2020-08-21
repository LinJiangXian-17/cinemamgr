package com.lanqiao.entity;

import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class Film {
    private Integer filmId;
    private String filmName;
    private String summary;
    private String type;
    private String hit;
    private String upComing;
    @DateTimeFormat(pattern="yyyy-MM-dd")//页面写入数据库时格式化
    @JSONField(format="yyyy-MM-dd")//数据库导出页面时json格式化
    private Date time;

    private String showtime;
    private Double score;
    private Integer wish;
    private String cover;

    public Film() {
    }

    public Film(Integer filmId, String filmName, String summary, String type, String hit, String upComing, Date time, Double score, Integer wish, String cover) {
        this.filmId = filmId;
        this.filmName = filmName;
        this.summary = summary;
        this.type = type;
        this.hit = hit;
        this.upComing = upComing;
        this.time = time;
        this.score = score;
        this.wish = wish;
        this.cover = cover;
    }

    public Integer getFilmId() {
        return filmId;
    }

    public void setFilmId(Integer filmId) {
        this.filmId = filmId;
    }

    public String getFilmName() {
        return filmName;
    }

    public void setFilmName(String filmName) {
        this.filmName = filmName;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getHit() {
        return hit;
    }

    public void setHit(String hit) {
        this.hit = hit;
    }

    public String getUpComing() {
        return upComing;
    }

    public void setUpComing(String upComing) {
        this.upComing = upComing;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public String getShowtime() {
        return showtime;
    }

    public void setShowtime(String showtime) {
        this.showtime = showtime;
    }

    public Double getScore() {
        return score;
    }

    public void setScore(Double score) {
        this.score = score;
    }

    public Integer getWish() {
        return wish;
    }

    public void setWish(Integer wish) {
        this.wish = wish;
    }

    public String getCover() {
        return cover;
    }

    public void setCover(String cover) {
        this.cover = cover;
    }

    @Override
    public String toString() {
        return "Film{" +
                "filmId=" + filmId +
                ", filmName='" + filmName + '\'' +
                ", summary='" + summary + '\'' +
                ", type='" + type + '\'' +
                ", hit='" + hit + '\'' +
                ", upComing='" + upComing + '\'' +
                ", time=" + time +
                ", score=" + score +
                ", wish=" + wish +
                ", cover='" + cover + '\'' +
                '}';
    }
}
