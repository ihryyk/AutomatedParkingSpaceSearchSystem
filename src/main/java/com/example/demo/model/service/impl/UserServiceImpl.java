package com.example.demo.model.service.impl;


import com.example.demo.model.entity.User;
import com.example.demo.model.repository.UserRepository;
import com.example.demo.model.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class UserServiceImpl implements UserService {
    @Autowired
    UserRepository userRepository;

    @Override
    public void save(User user) {
        userRepository.save(user);
    }

    @Override
    public void delete(int userId) {
        userRepository.deleteById(userId);
    }

    @Override
    public void block(int userId) {
        User user = userRepository.findById(userId).orElseThrow(RuntimeException::new);
        user.setBlock(true);
        userRepository.save(user);
    }

    @Override
    public void unblock(int userId) {
        User user = userRepository.findById(userId).orElseThrow(RuntimeException::new);
        user.setBlock(false);
        userRepository.save(user);
    }

    @Override
    public List<User> getAll() {
        return userRepository.findAll();
    }

    @Override
    public User loggedUser(String emailAddress, String userPassword){
      return userRepository.findByEmailAddressAndPassword(emailAddress, userPassword);
    }

    @Override
    public User getById(int id){
        return userRepository.getById(id);
    }
}
