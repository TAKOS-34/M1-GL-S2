package Ex;

import Ex.service.campus.CampusService;
import Ex.service.salle.SalleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import jakarta.transaction.Transactional;
import Ex.modele.* ;

import java.util.List;

@Transactional 
@SpringBootApplication
public class CL_Appli implements CommandLineRunner {
		 @Autowired
		 private CampusService cs;

		 @Autowired
		 private SalleService sc;

		public static void main(String[] args) {
			SpringApplication.run(CL_Appli.class, args);
		}
		
	public void run(String... args) throws Exception {
		System.out.println(cs.chercherSalle("Montpellier", 40, TypeSalle.td, "oui"));

		List<Salle> salles = sc.chercherSalle("Triolet", 80);
		for (Salle s : salles) {
			System.out.println(s.getNumSalle());
		}
	}
}
