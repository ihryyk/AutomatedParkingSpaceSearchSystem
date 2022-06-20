package com.example.demo.model.service;

import com.example.demo.model.entity.ParkingInformation;
import com.example.demo.model.enums.ParkingStatus;

import java.util.ArrayList;

public interface ParkingInformationService {
    public void create(ParkingInformation parkingInformation);

    public ParkingInformation getById(int Id);

    public ArrayList<ParkingInformation> getParkingInformationsByCarId(int carId);

    public ArrayList<ParkingInformation> getParkingInformationsByParkingId(int parkingId);

    public void changeParkingStatus(ParkingStatus parkingStatus, int parkingInformId);

    public ArrayList<ParkingInformation> getParkingInformationsByCarUserIdAndParkingStatus(int userId, ParkingStatus parkingStatus);

    public void saveParkingInform(ParkingInformation parkingInformation);

    public void parkingStatusChanger(int parkingInformId, ParkingStatus parkingStatus);

    public ArrayList<ParkingInformation> getParkingInformationsByParkingStatusAndParkingId(ParkingStatus parkingStatus, int parkingId);

    public ArrayList<ParkingInformation> getInfoByMonthAndParkingId(int month, int parkingId);

    public int countVisitors(int month, int parkingId);

    public int countEarnings(int month, int parkingId);
}
