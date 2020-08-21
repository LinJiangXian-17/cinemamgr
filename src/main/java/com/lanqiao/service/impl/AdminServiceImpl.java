package com.lanqiao.service.impl;

import com.lanqiao.entity.Admin;
import com.lanqiao.mapper.AdminMapper;
import com.lanqiao.service.IAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("adminService")
public class AdminServiceImpl implements IAdminService {

    @Autowired
    AdminMapper adminMapper;

    @Override
    public Admin selectForLogin(Admin admin) {
        return this.adminMapper.selectForLogin(admin);
    }
}
