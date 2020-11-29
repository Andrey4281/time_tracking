package ru.vocalize.tracking.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import ru.vocalize.tracking.service.UserService;

@Controller
public class IndexController {

    private UserService userService;

    public IndexController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping({"/", "/index"})
    public String indexPage(Model model) {
        model.addAttribute("user", userService.getCurrentUser());
        return "index";
    }
}

