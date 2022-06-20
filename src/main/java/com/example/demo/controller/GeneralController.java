package com.example.demo.controller;

import com.example.demo.model.entity.Parking;
import com.example.demo.model.entity.User;
import com.example.demo.model.enums.UserRole;
import com.example.demo.model.service.AbonnementService;
import com.example.demo.model.service.ParkingService;
import com.example.demo.model.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;
import javax.validation.Valid;
import java.util.List;


@Controller
public class GeneralController {
    @Autowired
    AbonnementService abonnementService;

    @Autowired
    UserService userService;

    @Autowired
    ParkingService parkingService;


    @GetMapping("/")
    public String showIndexPage(Model model, HttpServletRequest request) {
        List<Parking> parkingList = parkingService.getAll();
        User user = null;
        if (request.getSession().getAttribute("userId") != null) {
            user = userService.getById((Integer) request.getSession().getAttribute("userId"));
        }
        model.addAttribute("parkingList", parkingList);
        model.addAttribute("user", user);
        return "index";
    }

    @GetMapping("/registration")
    public String showRegistrationForm(Model model) {
        User user = new User();
        model.addAttribute("user", user);
        return "registration";
    }

    @PostMapping("/registration")
    public String registrationUser( @Valid @ModelAttribute("user") User user, BindingResult bindingResult , @RequestParam("registration") String registration,
                                   HttpServletRequest request, Model model) {
        if (bindingResult.hasErrors()){
            model.addAttribute("popUps", "registration");
            return "registration";
        }

        switch (registration) {
            case ("User"):
                user.setRole(UserRole.USER);
                userService.save(user);
                request.getSession().setAttribute("userId", userService.loggedUser(user.getEmailAddress(), user.getPassword()).getId());
                request.getSession().setAttribute("userRole",UserRole.USER);
                return "redirect:/";
            case ("ParkingOwner"):
                user.setRole(UserRole.OWNER);
                userService.save(user);
                request.getSession().setAttribute("userId", userService.loggedUser(user.getEmailAddress(), user.getPassword()).getId());
                request.getSession().setAttribute("userRole", UserRole.OWNER);
                return "redirect:/parkingOwner/";

        }
        return "redirect:/registration";
    }

    @GetMapping("/login")
    public String showLoginForm(Model model) {
        model.addAttribute("user", new User());
        return "login";
    }


    @PostMapping("/login")
    public String login(@RequestParam("emailAddress") String emailAddress,
                        @RequestParam("password") String password, HttpServletRequest request) {
        User loggedUser = userService.loggedUser(emailAddress, password);
        if (loggedUser == null) {
            return "redirect:/login";
        } else {
            request.getSession().setAttribute("userId", loggedUser.getId());
            request.getSession().setAttribute("userRole", loggedUser.getRole());
            if (loggedUser.getRole() == UserRole.OWNER) {
                return "redirect:/parkingOwner/";
            } else if (loggedUser.getRole() == UserRole.USER) {
                return "redirect:/";
            }
        }
        return "redirect:/";
    }

}
