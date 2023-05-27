package com.good_ghost.hua_culture.service;

import com.good_ghost.hua_culture.entity.User;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface UserService {

    List<User> getAll();

    User getById(int id);

    void addUser(HttpServletRequest request);
}
