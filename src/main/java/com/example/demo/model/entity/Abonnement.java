package com.example.demo.model.entity;



import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.sql.Date;
import java.util.HashSet;
import java.util.Set;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "abonnement")
public class Abonnement {

    @Column(name = "name")
    private String name;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_abonnement")
    private int id;
    @Column(name = "discount")
    private int discount;
    @Column(name = "amount")
    private int amount;
    @Column(name = "end_date")
    private Date endDate;
    @Column(name = "start_date")
    private Date startDate;
    @Column(name="price")
    private double price;
    @ManyToMany
    @JoinTable(name = "user_abonnement", joinColumns = {@JoinColumn(name = "abonnement_id")},
            inverseJoinColumns = {@JoinColumn(name = "user_id")})
    private Set<User> users = new HashSet<>();


}
