package com.example.springjwt.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class VueController {
    @GetMapping("/")
    public String showVuePage() {
        return "index";
    }
}
