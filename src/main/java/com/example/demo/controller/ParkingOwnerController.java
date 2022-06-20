package com.example.demo.controller;

import com.example.demo.model.entity.Parking;
import com.example.demo.model.entity.ParkingInformation;
import com.example.demo.model.entity.User;
import com.example.demo.model.enums.ParkingStatus;
import com.example.demo.model.enums.VerificationStatus;
import com.example.demo.model.service.ParkingInformationService;
import com.example.demo.model.service.ParkingService;
import com.example.demo.model.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

@Controller
@RequestMapping("/parkingOwner")
public class ParkingOwnerController {
    @Autowired
    UserService userService;
    @Autowired
    ParkingInformationService parkingInformationService;
    @Autowired
    ParkingService parkingService;

    @GetMapping("/")
    public String parkingOwnerMainPage(@SessionAttribute("userId") int userId , Model model, HttpServletRequest request) {
        User user = userService.getById(userId);
        model.addAttribute("parkingList", user.getParkingList());
        return "parkingOwnerIndex";
    }

    @GetMapping("/parkingInfo")
    public String showInfo(Model model, HttpServletRequest request) {
        int parkingId = 0;
        if (request.getParameter("parkingId") == null) {
            parkingId = (int) request.getSession().getAttribute("parkingId");
        } else {
            parkingId = Integer.parseInt(request.getParameter("parkingId"));
        }
        request.getSession().setAttribute("parkingId", parkingId);
        model.addAttribute("parkingInfoList",
                parkingInformationService.getParkingInformationsByParkingId(parkingId));
        Calendar cal = Calendar.getInstance();
        Map<String, Integer> months = cal.getDisplayNames(Calendar.MONTH, Calendar.LONG, Locale.ENGLISH);
        model.addAttribute("months", months);
        model.addAttribute("parkingStatus", ParkingStatus.values());
        String sort = request.getParameter("sort");
        if (sort != null) {
            switch (sort) {
                case "month": {
                    model.addAttribute("parkingInfoList", parkingInformationService.
                            getInfoByMonthAndParkingId(Integer.parseInt(request.getParameter("month")), parkingId));
                    Map<String, Integer> info = new HashMap<>();
                    model.addAttribute("month", Integer.parseInt(request.getParameter("month")));
                    model.addAttribute("info", info);
                    break;
                }
                case "parkingStatus": {
                    model.addAttribute("parkingInfoList",
                            parkingInformationService.getParkingInformationsByParkingStatusAndParkingId
                                    (ParkingStatus.valueOf(request.getParameter("parkingStatus")), parkingId));
                    break;
                }
            }
        }
        return "parkingInfo";
    }

    @GetMapping("/getPDF")
    public ModelAndView getPDF(@RequestParam("month") int month, HttpServletRequest request, HttpServletResponse response, Model model) {
        List<ParkingInformation> parkingInformationList = parkingInformationService.
                getInfoByMonthAndParkingId(Integer.parseInt(request.getParameter("month")), (Integer) request.getSession().getAttribute("parkingId"));
        return new ModelAndView("createPDF", "modelObject", parkingInformationList);
    }

    @GetMapping("/createParking")
    public String showRegisteredParking(Model model){
        model.addAttribute("parking", new Parking());
        return "/registeredParking";
    }
    @PostMapping("/registeredParking")
    public String registerParking(@ModelAttribute("parking") Parking parking, @SessionAttribute("userId") int userId){
        parking.setVerificationStatus(VerificationStatus.EXPECTATION);
        User user = userService.getById(userId);
        parking.setUser(user);
        parkingService.save(parking);
        return "redirect:/parkingOwner/";
    }

    @GetMapping("/updateParking")
    public String createParking(Model model,@RequestParam("parkingId") int parkingId){
        Parking parking = parkingService.getById(parkingId);
        model.addAttribute("parking",parking);
        return "/registeredParking";
    }

    @GetMapping("/Earnings")
    public String getInfoAboutEarnings(@SessionAttribute("parkingId") int parkingId, Model model){
        Calendar cal = Calendar.getInstance();
        Map<String, Integer> months = cal.getDisplayNames(Calendar.MONTH, Calendar.LONG, Locale.ENGLISH);
        Map<String, Integer> earningsForEachMonth = new HashMap<>();
        for (Map.Entry<String,Integer> month: months.entrySet()) {
            earningsForEachMonth.put(month.getKey(),parkingInformationService.countEarnings(month.getValue(),parkingId));
        }
        int [] years = {2022,2021,2019};
        model.addAttribute("years", years);
        model.addAttribute("earnings", earningsForEachMonth);
        return "earnings";
    }
}

