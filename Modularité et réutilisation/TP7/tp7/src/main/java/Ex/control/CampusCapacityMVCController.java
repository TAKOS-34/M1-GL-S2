package Ex.control;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import Ex.service.ICampusCapacityService;

@Controller
@RequestMapping("/campus")
public class CampusCapacityMVCController {

    private final ICampusCapacityService service;

    public CampusCapacityMVCController(ICampusCapacityService service) {
        this.service = service;
    }

    // formulaire de recherche
    @GetMapping("/form")
    public String afficherFormulaire() {
        return "campusForm";
    }

    // traitement edition formulaire (POST)
    @PostMapping("/resultatCapacite")
    public String traiterFormulaire(@RequestParam String nomCampus, Model model) {

        Integer nbSalles = service.nombreSalles(nomCampus);
        Integer nbBatiments = service.nombreBatiments(nomCampus);
        model.addAttribute("nomCampus", nomCampus);
        model.addAttribute("nbSalles", nbSalles);
        model.addAttribute("nbBatiments", nbBatiments); 
        return "resultatCapacity";
    }
}