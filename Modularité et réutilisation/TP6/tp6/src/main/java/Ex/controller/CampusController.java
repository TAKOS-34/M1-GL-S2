package Ex.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import Ex.service.campus.ICampusService;

@Controller
public class CampusController {

    @Autowired
    private ICampusService cs;

    public CampusController() {}

    @GetMapping("/listeCampus")
    public String home(@RequestParam(name = "nomC", required = false, defaultValue = "anonyme") String name, Model model) {
        model.addAttribute("nomC", name);
        model.addAttribute("campuses", cs.listeCampus());
        return "campus";
    }
}