package com.example.demo.model.service.impl;


import com.example.demo.model.entity.Parking;
import com.example.demo.model.repository.ParkingRepository;
import com.example.demo.model.service.ParkingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ParkingServiceImpl implements ParkingService {
    @Autowired
    ParkingRepository parkingRepository;

    @Override
    public void save(Parking parking) {
        parkingRepository.save(parking);
    }

    @Override
    public void delete(int parkingId) {
        parkingRepository.deleteById(parkingId);
    }

    @Override
    public ArrayList<Parking> searchByStreetNameOrPrice(String name, double price) {
        return parkingRepository.searchByStreetNameOrPrice(name, price);
    }

    @Override
    public List<Parking> getAll() {
        return parkingRepository.findAll();
    }

    @Override
    public Parking getById(int parkingId) {
        return parkingRepository.getById(parkingId);
    }

    @Override
    public void changeCapacity(int parkingId, int capacity) {
        parkingRepository.changeFreePlaces(parkingId ,capacity);
    }
    @Override
    public ArrayList<Parking> findByOrderByPrice(){
        return parkingRepository.findByOrderByPrice();
    }

    @Override
    public ArrayList<Parking> findByOrderByStreetName(){
        return  parkingRepository.findByOrderByStreetName();
    }


}
