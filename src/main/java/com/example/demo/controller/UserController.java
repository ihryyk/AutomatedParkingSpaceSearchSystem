package com.example.demo.controller;

import com.example.demo.model.entity.*;
import com.example.demo.model.enums.ParkingStatus;
import com.example.demo.model.enums.UserRole;
import com.example.demo.model.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.text.ParseException;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    UserService userService;

    @Autowired
    CarService carService;

    @Autowired
    AbonnementService abonnementService;

    @Autowired
    ParkingInformationService parkingInformationService;

    @Autowired
    ParkingService parkingService;

    @GetMapping("/profile")
    public String showProfilePage(Model model, HttpServletRequest request){
        User user = userService.getById((Integer) request.getSession().getAttribute("userId"));
        model.addAttribute("user",user);
        return "profile";
    }

    @PostMapping("/profile")
    public String updateUser(@ModelAttribute ("user") User user, HttpServletRequest request){
        user.setRole(UserRole.USER);
        userService.save(user);
        return "redirect:/";
    }

    @GetMapping("/profile/userCar")
    public String showUserCar(Model model, HttpServletRequest request){

        model.addAttribute("carList", carService.getCarsByUser_Id((Integer) request.getSession().getAttribute("userId")));
        return "showCar";
    }

    @GetMapping("/profile/addCar")
    public String showAddCarForm(Model model){
        Car car = new Car();
        model.addAttribute("car", car);
        return "addCar";
    }

    @PostMapping("/profile/addCar")
    public String addCar(@ModelAttribute ("car") Car car, HttpServletRequest request){
        User user = userService.getById((Integer) request.getSession().getAttribute("userId"));
        car.setUser(user);
        carService.save(car);
        return "redirect:/user/profile/userCar";
    }

    @GetMapping("/logOut")
    public String logOut(HttpServletRequest request){
        request.getSession().invalidate();
        return "redirect:/";
    }

    @GetMapping("/bookParking")
    public String showBookForm(Model model, HttpServletRequest request, @RequestParam("parkingId")int parkingId){
        model.addAttribute("parkingInformation", new ParkingInformation());
        User user =userService.getById((Integer) request.getSession().getAttribute("userId"));
        model.addAttribute("userAbonnements", abonnementService.getByUserId(user));
        model.addAttribute("userCars", carService.getCarsByUser_Id(user.getId()));
        request.getSession().setAttribute("parkingId", parkingId);
        return "bookParking";
    }


    @GetMapping("/applyParking")
    public String applyBook(@RequestParam("carNumber") String carNumber,
                            @RequestParam("abonnementName") String abonnementName,
                            @RequestParam("startDate") String startDate,
                            @RequestParam("endDate") String endDate,Model model, HttpServletRequest request) throws ParseException {
        ParkingInformation parkingInformation = new ParkingInformation();
        parkingInformation.setEndTime(Timestamp.valueOf(endDate.replace("T", " ") + ":00"));
        parkingInformation.setStartTime(Timestamp.valueOf(startDate.replace("T", " ") + ":00"));
        parkingInformation.setAbonnement(abonnementService.getAbonnementByName(abonnementName));
        parkingInformation.setCar(carService.getCarByNumber(carNumber));
        Parking parking = parkingService.getById((int) request.getSession().getAttribute("parkingId"));

        long parkingHours = ChronoUnit.HOURS.
                between(parkingInformation.getStartTime().toLocalDateTime(),parkingInformation.getEndTime().toLocalDateTime());
        parkingInformation.setParking(parking);
        double discount = parkingInformation.getAbonnement().getDiscount()/100.0;
        double finalPrice = parking.getPrice()*parkingHours*discount;
        parkingInformation.setPrice(finalPrice);
        model.addAttribute("parkingInform", parkingInformation);
        return "applyParking";
    }
    @GetMapping("/history")
    public String history(Model model, HttpServletRequest request){
        User user = userService.getById((Integer) request.getSession().getAttribute("userId"));
        model.addAttribute("parkingInforms",
                parkingInformationService.getParkingInformationsByCarUserIdAndParkingStatus(user.getId(),ParkingStatus.FINISHED));
        return "history";
    }

    @PostMapping("/applyParking")
    public String applyBookParking(@ModelAttribute("parkingInform") ParkingInformation parkingInformation, HttpServletRequest request){
        parkingService.changeCapacity((Integer) request.getSession().getAttribute("parkingId"),-1);
        parkingInformation.setParkingStatus(ParkingStatus.RESERVED);
        parkingInformationService.saveParkingInform(parkingInformation);
        parkingInformationService.parkingStatusChanger(parkingInformation.getId(), ParkingStatus.ACTIVE);
        parkingInformationService.parkingStatusChanger(parkingInformation.getId(), ParkingStatus.FINISHED);
        return "redirect:/";
    }

    @PostMapping("/deleteCar")
    public String deleteCar(@RequestParam("carId") int carId){
        carService.delete(carId);
        return "redirect:/user/profile/userCar";
    }

    @GetMapping("/activeParking")
    public String showActiveParking(Model model, HttpServletRequest request){
        User user = userService.getById((Integer) request.getSession().getAttribute("userId"));
        model.addAttribute("activeParking",
                parkingInformationService.getParkingInformationsByCarUserIdAndParkingStatus(user.getId(),ParkingStatus.RESERVED));
        return "activeParking";
    }

    @PostMapping("/cancelParking")
    public String finishParking(@RequestParam ("parkingInformId") int parkingInfoId){
        parkingInformationService.changeParkingStatus(ParkingStatus.FINISHED,parkingInfoId);
        return "redirect:/user/activeParking";
    }

    @GetMapping("/abonnements")
    public String userAbonnements(Model model, HttpServletRequest request){
        User user = userService.getById((Integer) request.getSession().getAttribute("userId"));
        model.addAttribute("abonnements", abonnementService.getByUserId(user));
        return "userAbonnements";
    }

    @GetMapping("/searchBy")
    public String getParkingByName(Model model,@RequestParam("price") double price,@RequestParam("streetName") String streetName){
        model.addAttribute("parkingList", parkingService.searchByStreetNameOrPrice(streetName,price));
        return "index";
    }

    @GetMapping("/orderBy")
    public String orderParkingBy(Model model,@RequestParam("orderBy") String orderBy){
        if (orderBy.equals("streetName")){
            model.addAttribute("parkingList", parkingService.findByOrderByStreetName());
        }else {
            model.addAttribute("parkingList", parkingService.findByOrderByPrice());
        }
        return "index";
    }

    @GetMapping("/abonnements/allAbonnements")
    public String showAllAbonnements(Model model, HttpServletRequest request){
        User user = userService.getById((Integer) request.getSession().getAttribute("userId"));
        List<Abonnement> abonnements = abonnementService.getAll();
        model.addAttribute("abonnements",checkAbonnement(user,abonnements));
        return "allAbonnements";
    }

    @PostMapping("/buyAbonnements")
    public String addAbonnements(@RequestParam("abonId") int abonId, HttpServletRequest request){
        User user = userService.getById((Integer) request.getSession().getAttribute("userId"));
        abonnementService.addToUser(user.getId(),abonId);
        return "redirect:/user/abonnements";
    }
    @GetMapping("/searchAbonnements")
    public String searchAbonnements (@SessionAttribute("userId") int userId,@RequestParam("searchBy") String search, @RequestParam("parameter") int parameter, Model model){
        List<Abonnement> abonnements = new ArrayList<>();
        User user = userService.getById(userId);
        switch (search){

            case "Amount":
             abonnements = abonnementService.getAbonnementsByAmount(parameter);
                break;
            case "Price":
                abonnements= abonnementService.getAbonnementsByPrice(parameter);
                break;
            case "Discount":
                abonnements=  abonnementService.getAbonnementsByDiscount(parameter);
        }
        model.addAttribute("abonnements",checkAbonnement(user,abonnements));
        return "allAbonnements";
    }

    public Map<Abonnement, Boolean> checkAbonnement(User user, List<Abonnement> allAbonnements){
        List<Abonnement> userAbonnements = abonnementService.getByUserId(user);
        Map<Abonnement,Boolean> markedAbonnements = new HashMap<>();
        for (int i = 0; i < allAbonnements.size(); i++) {
            if (userAbonnements.contains(allAbonnements.get(i))){
                markedAbonnements.put(allAbonnements.get(i),true);
            }else {
                markedAbonnements.put(allAbonnements.get(i),false);
            }
        }
       return markedAbonnements;
    }
}
