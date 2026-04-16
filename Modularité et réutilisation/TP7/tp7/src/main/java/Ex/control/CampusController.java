package Ex.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import Ex.erreurs.CampusNotFoundException;
import Ex.modele.Campus;
import Ex.service.ICampusService;


@Controller
@RequestMapping("/campus")
public class CampusController {

	@Autowired
	private ICampusService cs;

	public CampusController() {
		System.out.println("les campus ");
	}
	//http://localhost:8889/campus/listeCampus
	@GetMapping("/listeCampus")
	public String homeCampus(Model model) {
		model.addAttribute("campuses",  cs.findAll());
		return "campuses1";
	}
	
	@GetMapping("/listeBasicCampus")
	public String basicCampus(Model model) {
		model.addAttribute("campuses",  cs.findAll());
		return "campuses";
	}
	
	@GetMapping("/{nomC}")
	 public String afficheCampus(@PathVariable String nomC, Model model) {
	        return cs.campusParId(nomC)
	                .map(campus -> {
	                    model.addAttribute("campus", campus);
	                    return "afficheCampus";
	                })
	                .orElse("afficheCampusNotFound");
	    }
	
/* pour tester la centralisation des erreurs via @ControllerAdvice */	
	@GetMapping("/advice/{id}")
    public String getCampusAdvice(@PathVariable String id, Model model) {

        Campus campus = cs.campusParId(id)
                .orElseThrow(() -> new CampusNotFoundException(
                        "Campus avec le nom " + id + " est introuvable"
                ));

        model.addAttribute("campus", campus);
        return "errors/campusDetails";
    }
	
	@GetMapping("/newCampus")
    public String showCreateForm(Model model) {
        model.addAttribute("campus", new Campus());
        return "newCampus";
    }
	
	@PostMapping(value = "/processNewCampus")
	public String createCampus(@ModelAttribute("newCampus") Campus campus) {
	cs.createCampus(campus);
	return "redirect:/campus/listeCampus"; 
	}
	
	@PostMapping("/delete/{nomC}") 
    public String deleteCampus(@PathVariable("nomC") String nomC) { 
        cs.deleteCampus(nomC); 
        return "redirect:/campus/listeCampus"; 
    }
	
}
