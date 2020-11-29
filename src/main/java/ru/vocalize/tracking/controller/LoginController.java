package ru.vocalize.tracking.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {

    @GetMapping("/login")
    public String loginPage(@RequestParam(required = false) String error, Model model) {
        String errorMessage = null;
        if (error != null) {
            errorMessage = "Имя пользователя или пароль введены неверно!";
        }
        model.addAttribute("errorMessage", errorMessage);
        return "login";
    }
}