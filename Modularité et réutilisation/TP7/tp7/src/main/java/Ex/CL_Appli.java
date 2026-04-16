package Ex;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import Ex.domain.BatimentRepository;
import Ex.domain.CampusRepository;
import Ex.domain.SalleRepository;
import Ex.modele.Batiment;
import Ex.modele.Campus;
import Ex.modele.Salle;
import Ex.modele.TypeSalle;
import Ex.service.CampusService;
import Ex.service.ICampusCapacityService;
import Ex.service.ICampusService;
import Ex.service.ISalleService;

@SpringBootApplication
public class CL_Appli implements CommandLineRunner {

		 @Autowired
		 private ICampusService cs;
		 @Autowired
		 private CampusRepository cr;
		 @Autowired
		 private BatimentRepository br;
		 @Autowired
		 private SalleRepository sr;
		 
		 @Autowired
		 private ICampusCapacityService capcps;
		 
		 @Autowired
		 private ISalleService ss;
		 
		public static void main(String[] args) {
			SpringApplication.run(CL_Appli.class, args);
		}
		
	public void run(String... args) throws Exception {

	
	Batiment triolet_b36 = br.getReferenceById("triolet_b36");
	
	List<Salle> salles = sr.searchSalles(
		    TypeSalle.amphi,
		    "oui",
		    100,
		    250,
		    null,   // pas de filtre sur etage
		    triolet_b36
		);
	for (Salle s : salles) {System.out.println(s.getNumS());}
	
/*	List<Campus> lesCampus = cs.findAll();
	for (Campus cps : lesCampus)
	{
		System.out.println(cps.getNomC()+" "+capcps.nombreBatiments(cps.getNomC())+".."+capcps.nombreSalles(cps.getNomC())); 
	} */
	
	} 
	
	
}
