package ru.vocalize.tracking.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import ru.vocalize.tracking.model.Track;
import ru.vocalize.tracking.service.TrackService;
import ru.vocalize.tracking.service.UserService;

import java.util.List;

@Controller
@RequestMapping("/user")
public class TrackController {

    private final TrackService trackService;
    private final UserService userService;

    public TrackController(TrackService trackService, UserService userkService) {
        this.trackService = trackService;
        this.userService = userkService;
    }

    @PostMapping("/came")
    public String came() {
        trackService.cameUser(userService.getCurrentUser());
        return "redirect:/index";
    }

    @PostMapping("/gone")
    public String gone() {
        trackService.goneUser(userService.getCurrentUser());
        return "redirect:/index";
    }

    @GetMapping("/track")
    public ResponseEntity<List<Track>> track() {
        return new ResponseEntity<>(
                trackService.findByUser(userService.getCurrentUser()),
                HttpStatus.OK);

    }
}
