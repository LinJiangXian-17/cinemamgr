package com.lanqiao.entity;

public class Figure {

    private Integer figureId;
    private Double figurePrice;
    private String figureName;
    private String figureImg;

    public Figure() {
    }

    public Figure(Integer figureId, Double figurePrice, String figureName, String figureImg) {
        this.figureId = figureId;
        this.figurePrice = figurePrice;
        this.figureName = figureName;
        this.figureImg = figureImg;
    }

    public Integer getFigureId() {
        return figureId;
    }

    public void setFigureId(Integer figureId) {
        this.figureId = figureId;
    }

    public Double getFigurePrice() {
        return figurePrice;
    }

    public void setFigurePrice(Double figurePrice) {
        this.figurePrice = figurePrice;
    }

    public String getFigureName() {
        return figureName;
    }

    public void setFigureName(String figureName) {
        this.figureName = figureName;
    }

    public String getFigureImg() {
        return figureImg;
    }

    public void setFigureImg(String figureImg) {
        this.figureImg = figureImg;
    }

    @Override
    public String toString() {
        return "Figure{" +
                "figureId=" + figureId +
                ", figurePrice=" + figurePrice +
                ", figureName='" + figureName + '\'' +
                ", figureImg='" + figureImg + '\'' +
                '}';
    }
}
