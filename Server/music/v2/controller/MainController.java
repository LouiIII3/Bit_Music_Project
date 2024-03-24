package com.example.springjwt.controller;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Collection;
import java.util.Iterator;


@Controller
@RequestMapping("/web")
//@ResponseBody
public class MainController {

    @GetMapping("/")
    public String mainP() {

        return "login";
    }

    @GetMapping("/account")
    public String account(Model model) {
        return "account";
    }

    @GetMapping("/main")
    public String newPage(Model model) {
        return "new"; //
    }

    @GetMapping("/login")
    public String login(Model model) {
        return "login";
    }


    @GetMapping("/music")
    public String music3(Model model) {
        return "music";
    }

}
