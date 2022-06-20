package com.example.demo.model.service;


import com.example.demo.model.entity.Abonnement;
import com.example.demo.model.entity.User;

import java.util.ArrayList;
import java.util.List;

public interface AbonnementService {

    public void save(Abonnement abonnement);

    public void delete(int abonnementId);

    public void addToUser(int abonnementId, int userId);

    public List<Abonnement> getByUserId(User user);

    public List<Abonnement> getAll();

    public Abonnement getAbonnementByName(String name);

    public ArrayList<Abonnement> getAbonnementsByAmount(int amount);

    public ArrayList<Abonnement> getAbonnementsByPrice(double price);

    public ArrayList<Abonnement> getAbonnementsByDiscount(int discount);
}
