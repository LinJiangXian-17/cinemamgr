package com.lanqiao.service;

import com.lanqiao.entity.CinemaUsers;

public interface ICinemaUsersService {
    /**
     * 用户注册
     * @param user
     * @return
     */
    public int insertUser(CinemaUsers user);

    /**
     * 用户登录
     * @param user
     * @return
     */
    public CinemaUsers selectByAccountAndPwd(CinemaUsers user);
}
