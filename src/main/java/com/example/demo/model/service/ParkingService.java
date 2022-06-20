package com.example.demo.model.service;

import com.example.demo.model.entity.Parking;

import java.util.ArrayList;
import java.util.List;

public interface ParkingService {

    public void save(Parking parking);

    public void delete(int parkingId);

    public ArrayList<Parking> searchByStreetNameOrPrice(String name, double price);

    public List<Parking> getAll();

    public Parking getById(int parkingId);

    public void changeCapacity(int parkingId, int capacity);

    public ArrayList<Parking> findByOrderByPrice();

    public ArrayList<Parking> findByOrderByStreetName();
}
