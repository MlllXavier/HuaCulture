package com.good_ghost.hua_culture.service;

import com.good_ghost.hua_culture.entity.User;
import com.good_ghost.hua_culture.mapper.UserMapper;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.xml.crypto.Data;
import java.util.Date;
import java.util.List;

@Service("userService")
public class UserServiceImpl implements UserService {

    @Resource
    private UserMapper userMapper;

    @Override
    public List<User> getAll() {
        return userMapper.getAll();
    }

    @Override
    public User getById(int id) {
        return userMapper.getById(id);
    }

    @Override
    public void addUser(HttpServletRequest request) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        User user = new User();
        user.setUsername(Integer.parseInt(username));
        user.setPassword(password);
        user.setName("-");
        user.setPhoto("static/profile0.jpg");
        user.setIntro("该用户没有留下自我简介");
        user.setClasses("");
        user.setLike_num(0);
        user.setComment_num(0);
        user.set_verifiable(false);
        user.setTime(new Date(System.currentTimeMillis()));
        userMapper.saveUser(user);
    }
}
