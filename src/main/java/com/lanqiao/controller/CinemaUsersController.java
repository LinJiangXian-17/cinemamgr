package com.lanqiao.controller;

import com.lanqiao.entity.CinemaUsers;
import com.lanqiao.mapper.CinemaUsersMapper;
import com.lanqiao.service.ICinemaService;
import com.lanqiao.service.ICinemaUsersService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.awt.peer.PanelPeer;

@Controller
@RequestMapping("/user")
public class CinemaUsersController {

    @Autowired
    ICinemaUsersService cinemaUsersService;

    @RequestMapping("/reg")
    @ResponseBody
    public String registered(CinemaUsers user){

        //账号和密码是必须的
        if (StringUtils.isNotBlank(user.getAccount()) && StringUtils.isNotBlank(user.getPassword())) {
            int i = this.cinemaUsersService.insertUser(user);

            return i > 0 ? "{\"resultCode\": true}" : "{\"resultCode\": false}";

        } else {
            return "{\"resultCode\": false}";
        }
    }

    /**
     * 用户登录
     * @param user
     * @return
     */
    @RequestMapping("/login")
    @ResponseBody
    public CinemaUsers userLogin(CinemaUsers user){
        //账号和密码是必须的
        if (StringUtils.isNotBlank(user.getAccount()) && StringUtils.isNotBlank(user.getPassword())) {

            CinemaUsers cinemaUsers = this.cinemaUsersService.selectByAccountAndPwd(user);

            return cinemaUsers;

        } else {
            return null;
        }
    }
}
