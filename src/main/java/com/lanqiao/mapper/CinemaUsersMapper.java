package com.lanqiao.mapper;

import com.lanqiao.entity.CinemaUsers;
import org.springframework.stereotype.Repository;

@Repository
public interface CinemaUsersMapper {

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
