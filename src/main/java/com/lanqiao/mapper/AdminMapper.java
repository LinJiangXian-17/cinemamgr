package com.lanqiao.mapper;

import com.lanqiao.entity.Admin;
import org.springframework.stereotype.Repository;

@Repository
public interface AdminMapper {

    /**
     * 登录校验
     * @param admin
     * @return
     */
    public Admin selectForLogin(Admin admin);
}
