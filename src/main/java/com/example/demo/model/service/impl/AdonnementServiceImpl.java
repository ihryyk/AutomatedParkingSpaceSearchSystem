package com.example.demo.model.service.impl;


import com.example.demo.model.entity.Abonnement;
import com.example.demo.model.entity.User;
import com.example.demo.model.repository.AbonnementRepository;
import com.example.demo.model.repository.UserRepository;
import com.example.demo.model.service.AbonnementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

@Service
public class AdonnementServiceImpl implements AbonnementService {
    @Autowired
    AbonnementRepository abonnementRepository;

    @Autowired
    UserRepository userRepository;

    @Override
    public void save(Abonnement abonnement) {
        abonnementRepository.save(abonnement);
    }

    @Override
    public void delete(int abonnementId) {
        abonnementRepository.deleteById(abonnementId);
    }

    @Override
    @Transactional
    public void addToUser(int abonnementId, int userId) {
        User user = userRepository.findById(userId).orElseThrow(RuntimeException::new);
        Abonnement abonnement = abonnementRepository.findById(abonnementId).orElseThrow(RuntimeException::new);
        abonnement.getUsers().add(user);
        user.getAbonnements().add(abonnement);
        userRepository.save(user);
    }

    @Override
    public List<Abonnement> getByUserId(User user) {
        return abonnementRepository.findAllByUsers(user);
    }
    @Override
    public List<Abonnement> getAll() {
        return abonnementRepository.findAll();
    }
    @Override
    public Abonnement getAbonnementByName(String name) {
        return abonnementRepository.getAbonnementByName(name);
    }
    @Override
    public ArrayList<Abonnement> getAbonnementsByAmount(int amount){
        return abonnementRepository.getAbonnementsByAmount(amount);
    }
    @Override
    public ArrayList<Abonnement> getAbonnementsByPrice(double price){
        return  abonnementRepository.getAbonnementsByPrice(price);
    }
    @Override
    public ArrayList<Abonnement> getAbonnementsByDiscount(int discount){
        return abonnementRepository.getAbonnementsByDiscount(discount);
    }
}
