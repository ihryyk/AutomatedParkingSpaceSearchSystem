package com.example.demo.model.entity;


import com.example.demo.model.enums.ParkingStatus;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.sql.Timestamp;

import static javax.persistence.CascadeType.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "parking_information")
public class ParkingInformation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "information_id")
    private int id;
    @ManyToOne(cascade = {MERGE, REFRESH, DETACH})
    @JoinColumn(name = "car_id")
    private Car car;
    @ManyToOne(cascade = {MERGE, REFRESH, DETACH})
    @JoinColumn(name = "parking_id")
    private Parking parking;
    @Column(name = "parking_time_start")
    private Timestamp startTime;
    @Column(name = "parking_time_end")
    private Timestamp endTime;
    @ManyToOne(cascade =  {MERGE, REFRESH, DETACH})
    @JoinColumn(name = "abonnement_id")
    private Abonnement abonnement;
    @Column(name = "price")
    private double price;
    @Enumerated(EnumType.STRING)
    @Column(name = "parking_status")
    private ParkingStatus parkingStatus;
}
