package com.example.demo.model.repository;


import com.example.demo.model.entity.Abonnement;
import com.example.demo.model.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.ArrayList;

public interface AbonnementRepository extends JpaRepository<Abonnement, Integer> {
    public ArrayList<Abonnement> findAllByUsers(User user);

    public Abonnement getAbonnementByName(String name);

    public ArrayList<Abonnement> getAbonnementsByAmount(int amount);

    public ArrayList<Abonnement> getAbonnementsByPrice(double price);

    public ArrayList<Abonnement> getAbonnementsByDiscount(int discount);
}
