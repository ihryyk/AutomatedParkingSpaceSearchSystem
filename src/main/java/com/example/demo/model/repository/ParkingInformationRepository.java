package com.example.demo.model.repository;

import com.example.demo.model.entity.ParkingInformation;
import com.example.demo.model.enums.ParkingStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import javax.transaction.Transactional;
import java.util.ArrayList;

public interface ParkingInformationRepository extends JpaRepository<ParkingInformation, Integer> {

    public ArrayList<ParkingInformation> getParkingInformationsByCarId(int carId);

    public ArrayList<ParkingInformation> getParkingInformationsByParkingId(int parkingId);

    public ArrayList<ParkingInformation> getParkingInformationsByCarUserIdAndParkingStatus(int userId, ParkingStatus parkingStatus);

    public ArrayList<ParkingInformation> getParkingInformationsByParkingStatusAndParkingId(ParkingStatus parkingStatus, int parkingId);

    @Transactional
    @Modifying(clearAutomatically = true)
    @Query("from ParkingInformation where  MONTH(startTime) =:month and parking.id=:parkingId ")
    public ArrayList<ParkingInformation> getInfoByMonthAndParkingId(@Param("month") int month, @Param("parkingId") int parkingId);


    @Transactional
    @Query(value = "select count(id) from ParkingInformation  where  MONTH(startTime) =:month and parking.id=:parkingId")
    public int countVisitors(@Param("month") int month, @Param("parkingId") int parkingId);


    @Transactional
    @Query(value = "select sum (price) from ParkingInformation where  MONTH(startTime) =:month and parking.id=:parkingId")
    public int countEarnings(@Param("month") int month, @Param("parkingId") int parkingId);


}
