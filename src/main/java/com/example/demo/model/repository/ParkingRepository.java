package com.example.demo.model.repository;

import com.example.demo.model.entity.Parking;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import javax.transaction.Transactional;
import java.util.ArrayList;

public interface ParkingRepository extends JpaRepository<Parking, Integer> {

    public ArrayList<Parking> getParkingByStreetName(String nameStreet);

    public ArrayList<Parking> searchByStreetNameOrPrice(String name, double price);

    @Transactional
    @Modifying(clearAutomatically = true)
    @Query(value = "update Parking p set p.freePlaces = p.freePlaces +(:freePlaces) where p.id=:parkingId")
    public void changeFreePlaces(@Param("parkingId") int parkingId, @Param("freePlaces") int capacity);

    public ArrayList<Parking> findByOrderByPrice();

    public ArrayList<Parking> findByOrderByStreetName();
}
