package com.lanqiao.entity;

public class Actor {

    private Integer actorId;
    private String actorName;
    private String description;
    private String actorImg;

    public Actor() {
    }

    public Actor(Integer actorId, String actorName, String description, String actorImg) {
        this.actorId = actorId;
        this.actorName = actorName;
        this.description = description;
        this.actorImg = actorImg;
    }

    public Integer getActorId() {
        return actorId;
    }

    public void setActorId(Integer actorId) {
        this.actorId = actorId;
    }

    public String getActorName() {
        return actorName;
    }

    public void setActorName(String actorName) {
        this.actorName = actorName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getActorImg() {
        return actorImg;
    }

    public void setActorImg(String actorImg) {
        this.actorImg = actorImg;
    }

    @Override
    public String toString() {
        return "Actor{" +
                "actorId=" + actorId +
                ", actorName='" + actorName + '\'' +
                ", description='" + description + '\'' +
                ", actorImg='" + actorImg + '\'' +
                '}';
    }
}
