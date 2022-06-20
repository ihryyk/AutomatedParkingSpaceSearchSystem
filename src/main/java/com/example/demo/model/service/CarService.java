package com.example.demo.model.service;

import com.example.demo.model.entity.Car;

import java.util.ArrayList;

public interface CarService {

    public void save(Car car);

    public void delete(int carId);

    public ArrayList<Car> getCarsByUser_Id(int userId);

    public Car getCarByNumber(String number);

}
