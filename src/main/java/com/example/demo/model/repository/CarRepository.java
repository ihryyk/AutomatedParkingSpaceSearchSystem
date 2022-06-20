package com.example.demo.model.repository;

import com.example.demo.model.entity.Car;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.ArrayList;

public interface CarRepository extends JpaRepository<Car, Integer> {

    public ArrayList<Car> getCarsByUser_Id(int userId);

    public Car getCarByNumber(String number);

}
