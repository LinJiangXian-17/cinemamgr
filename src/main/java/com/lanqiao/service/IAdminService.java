package com.lanqiao.service;

import com.lanqiao.entity.Admin;

public interface IAdminService {

    /**
     * 登录校验
     * @param admin
     * @return
     */
    public Admin selectForLogin(Admin admin);
}
