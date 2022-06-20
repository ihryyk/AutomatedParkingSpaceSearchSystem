package com.example.demo.model.service.impl;


import com.example.demo.model.entity.ParkingInformation;
import com.example.demo.model.enums.ParkingStatus;
import com.example.demo.model.repository.AbonnementRepository;
import com.example.demo.model.repository.ParkingInformationRepository;
import com.example.demo.model.repository.ParkingRepository;
import com.example.demo.model.service.ParkingInformationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

@Service
public class ParkingInformationServiceImpl implements ParkingInformationService {
    @Autowired
    ParkingInformationRepository parkingInformationRepository;

    @Autowired
    AbonnementRepository abonnementRepository;

    @Autowired
    ParkingRepository parkingRepository;
    @Override
    public void create(ParkingInformation parkingInformation) {
        parkingInformationRepository.save(parkingInformation);
    }

//    @Override
//    public void cancel(int parkingInformationId) {
//        ParkingInformation parkingInformation = parkingInformationRepository.findById(parkingInformationId).orElseThrow(RuntimeException::new);
//        parkingInformation.setParkingStatus(ParkingStatus.CANCELED);
//        parkingInformationRepository.save(parkingInformation);
//    }
//
//    @Override
//    public void finish(int parkingInformationId) {
//        ParkingInformation parkingInformation = parkingInformationRepository.findById(parkingInformationId).orElseThrow(RuntimeException::new);
//        parkingInformation.setParkingStatus(ParkingStatus.FINISHED);
//        parkingInformationRepository.save(parkingInformation);
//    }

    @Override
    public ArrayList<ParkingInformation> getParkingInformationsByCarId(int carId) {
        return parkingInformationRepository.getParkingInformationsByCarId(carId);
    }

    @Override
    public ArrayList<ParkingInformation> getParkingInformationsByParkingId(int parkingId) {
        return parkingInformationRepository.getParkingInformationsByParkingId(parkingId);
    }



    @Override
    public void changeParkingStatus (ParkingStatus parkingStatus, int parkingInformId){
      ParkingInformation parkingInformation = parkingInformationRepository.findById(parkingInformId).orElseThrow(RuntimeException::new);
      parkingInformation.setParkingStatus(parkingStatus);
      parkingInformationRepository.save(parkingInformation);
      if (parkingStatus == ParkingStatus.CANCELED || parkingStatus == ParkingStatus.FINISHED){
          parkingRepository.changeFreePlaces(parkingInformation.getParking().getId(),1);
      }else {
          parkingRepository.changeFreePlaces(parkingInformation.getParking().getId(),-1);
      }
    }
    @Override
    public ArrayList<ParkingInformation> getParkingInformationsByCarUserIdAndParkingStatus(int userId, ParkingStatus parkingStatus){
        return parkingInformationRepository.getParkingInformationsByCarUserIdAndParkingStatus(userId,parkingStatus);
    }

    @Override
    public void saveParkingInform(ParkingInformation parkingInformation){
        parkingInformationRepository.save(parkingInformation);
    }

    @Override
    public ParkingInformation getById(int Id){
      return parkingInformationRepository.getById(Id);
    }
    @Override
    public void parkingStatusChanger(int parkingInformId, ParkingStatus parkingStatus) {
        ParkingInformation parkingInformation = parkingInformationRepository.getById(parkingInformId);
        long minutes=0;
        if (parkingStatus==ParkingStatus.ACTIVE) {
            LocalDateTime start = parkingInformation.getStartTime().toLocalDateTime();
            LocalDateTime now = LocalDateTime.now().withSecond(0).withNano(0);
            minutes = ChronoUnit.MINUTES.between(now, start);
        }else if (parkingStatus==ParkingStatus.FINISHED){
            LocalDateTime end = parkingInformation.getEndTime().toLocalDateTime();
            LocalDateTime now = LocalDateTime.now().withSecond(0).withNano(0);
            minutes = ChronoUnit.MINUTES.between(now, end);
        }
        ScheduledExecutorService scheduledExecutorService = Executors.newSingleThreadScheduledExecutor();
        scheduledExecutorService.schedule(new CloserTask(parkingInformId, parkingStatus), minutes, TimeUnit.MINUTES);
        }

    /**
     * Starts a thread the counts the time before ending the application
     */

    private static class CloserTask implements Runnable {

        @Autowired
        ParkingInformationService parkingInformationService ;
        int id;
        ParkingStatus parkingStatus;

        public CloserTask(int id, ParkingStatus parkingStatus) {
            this.id = id;
            this.parkingStatus = parkingStatus;
        }

        @Override
        public void run() {
            System.out.println("start");
            ParkingInformation parkingInformation = parkingInformationService.getById(id);

            if (parkingInformation.getParkingStatus() != ParkingStatus.CANCELED) {
                parkingInformationService.changeParkingStatus(parkingStatus,id);
            }
        }
    }

    public ArrayList<ParkingInformation> getParkingInformationsByParkingStatusAndParkingId(ParkingStatus parkingStatus, int parkingId){
        return parkingInformationRepository.getParkingInformationsByParkingStatusAndParkingId( parkingStatus, parkingId);
    }

    @Override
    public ArrayList<ParkingInformation> getInfoByMonthAndParkingId(int month, int parkingId){
        return parkingInformationRepository.getInfoByMonthAndParkingId(month,parkingId);
    }

    public int  countVisitors( int month, int parkingId){
        return parkingInformationRepository.countVisitors(month,parkingId);
    }
    public int  countEarnings(int month, int parkingId){
        if (parkingInformationRepository.countVisitors(month,parkingId)>0){
            return parkingInformationRepository.countEarnings(month,parkingId);
        }else{
           return 0;
        }
    }
}
