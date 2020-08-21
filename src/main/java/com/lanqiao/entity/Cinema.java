package com.lanqiao.entity;

public class Cinema {

    private Integer cinemaId;
    private String name;
    private String address;
    private String description;
    private String tel;
    private String pic;

    public Cinema() {
    }

    public Cinema(Integer cinemaId, String name, String address, String description, String tel, String pic) {
        this.cinemaId = cinemaId;
        this.name = name;
        this.address = address;
        this.description = description;
        this.tel = tel;
        this.pic = pic;
    }

    public Integer getCinemaId() {
        return cinemaId;
    }

    public void setCinemaId(Integer cinemaId) {
        this.cinemaId = cinemaId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getPic() {
        return pic;
    }

    public void setPic(String pic) {
        this.pic = pic;
    }

    @Override
    public String toString() {
        return "Cinema{" +
                "cinemaId=" + cinemaId +
                ", name='" + name + '\'' +
                ", address='" + address + '\'' +
                ", description='" + description + '\'' +
                ", tel='" + tel + '\'' +
                ", pic='" + pic + '\'' +
                '}';
    }
}
