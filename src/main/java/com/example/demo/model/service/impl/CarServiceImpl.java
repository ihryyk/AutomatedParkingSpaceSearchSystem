package com.example.demo.model.service.impl;


import com.example.demo.model.entity.Car;
import com.example.demo.model.repository.CarRepository;
import com.example.demo.model.service.CarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
@Service
public class CarServiceImpl implements CarService {
    @Autowired
    CarRepository carRepository;

    public void save(Car car){
        carRepository.save(car);
    }

    public void delete(int carId){
        carRepository.deleteById(carId);
    }

    public ArrayList<Car> getCarsByUser_Id(int userId){
        return carRepository.getCarsByUser_Id(userId);
    }
    public Car getCarByNumber(String number){
       return carRepository.getCarByNumber(number);
    }

}
