package com.lanqiao.service.impl;

import com.lanqiao.entity.CinemaUsers;
import com.lanqiao.mapper.CinemaUsersMapper;
import com.lanqiao.service.ICinemaUsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("cinemaUsersService")
public class CinemaUsersServiceImpl implements ICinemaUsersService {

    @Autowired
    CinemaUsersMapper cinemaUsersMapper;

    /**
     * 用户注册
     * @param user
     * @return
     */
    @Override
    public int insertUser(CinemaUsers user) {
        return this.cinemaUsersMapper.insertUser(user);
    }

    /**
     * 用户登录
     * @param user
     * @return
     */
    @Override
    public CinemaUsers selectByAccountAndPwd(CinemaUsers user) {
        return this.cinemaUsersMapper.selectByAccountAndPwd(user);
    }
}
