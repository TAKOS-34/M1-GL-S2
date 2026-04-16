package Ex.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import Ex.dto.manual.CampusCapacityDTO;
import Ex.service.ICampusCapacityService;


@RestController
public class CampusCapacityRestController {
	
	@Autowired
	private ICampusCapacityService iccs;

	// exemple http://localhost:8889/campus/Triolet/Nbsalles
	  @GetMapping("/campus/{nomC}/Nbsalles")
	  public Integer nombreSalles(@PathVariable String nomC) {
	  return iccs.nombreSalles(nomC);
	    }
	  
	  @GetMapping("/campus/{nomC}/Nbbatiments")
	    public Integer nombreBatiments(@PathVariable String nomC) {
	        return iccs.nombreBatiments(nomC);
	    }
	  
	  @GetMapping("/campus/{nomC}/capacite")
	  public CampusCapacityDTO capacite(@PathVariable String nomC) {

	      Integer nbSalles = iccs.nombreSalles(nomC);
	      Integer nbBatiments = iccs.nombreBatiments(nomC);

	      return new CampusCapacityDTO(nomC, nbSalles, nbBatiments);
	  }
	  
	}

