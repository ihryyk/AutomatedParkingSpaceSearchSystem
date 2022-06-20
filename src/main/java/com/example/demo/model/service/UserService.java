package com.example.demo.model.service;

import com.example.demo.model.entity.User;

import java.util.List;

public interface UserService {

    public void save(User user);

    public void delete(int userId);

    public void block(int userId);

    public void unblock(int userId);

    public List<User> getAll();

    public User loggedUser(String emailAddress, String userPassword);

    public User getById(int id);
}
