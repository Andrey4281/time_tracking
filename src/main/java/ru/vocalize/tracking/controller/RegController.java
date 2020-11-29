package ru.vocalize.tracking.controller;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import ru.vocalize.tracking.model.Status;
import ru.vocalize.tracking.model.User;
import ru.vocalize.tracking.service.UserService;

@Controller
public class RegController {

    private UserService userService;
    private BCryptPasswordEncoder passwordEncoder;

    public RegController(UserService userService, BCryptPasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/reg")
    public String regPage(@RequestParam(required = false) String error,
                          Model model) {
        String errorMessage = null;
        if (error != null) {
            errorMessage = "Пользователь с данным именем уже существует";
        }
        model.addAttribute("errorMessage", errorMessage);
        return "reg";
    }

    @PostMapping("/reg/create")
    public String createUser(@ModelAttribute User user) {
        if (!userService.findByUsername(user.getUsername()).isEmpty()) {
            return "redirect:/reg?error=true";
        }
        Status status = new Status();
        status.setId(1);
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setStatus(status);
        userService.save(user);
        return "redirect:/login";
    }
}