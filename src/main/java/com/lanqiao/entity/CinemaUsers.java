package com.lanqiao.entity;

public class CinemaUsers {

    private Integer userId;
    private String username;
    private String account;
    private String password;

    public CinemaUsers() {
    }

    public CinemaUsers(Integer userId, String username, String account, String password) {
        this.userId = userId;
        this.username = username;
        this.account = account;
        this.password = password;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "CinemaUsers{" +
                "userId=" + userId +
                ", username='" + username + '\'' +
                ", account='" + account + '\'' +
                ", password='" + password + '\'' +
                '}';
    }
}
