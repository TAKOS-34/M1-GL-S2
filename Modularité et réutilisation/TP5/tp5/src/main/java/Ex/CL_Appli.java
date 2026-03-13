package Ex;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import jakarta.transaction.Transactional;
import Ex.domain.* ;
import Ex.modele.* ;

@Transactional 
@SpringBootApplication
public class CL_Appli implements CommandLineRunner {
		 @Autowired
		 private BatimentRepository br;
		 @Autowired
		 private CampusRepository cr;
		 @Autowired
		 private SalleRepository sr;

		public static void main(String[] args) {
			SpringApplication.run(CL_Appli.class, args);
		}
		
	public void run(String... args) throws Exception {
		tsLesBatiments();
		campusParVille("Montpellier");
		List<String> codes = new ArrayList<>();
		codes.add("triolet_b36");
		codes.add("triolet_b16");
		certainsBatiments(codes);
		toutesLesSalles();
		sallesBat36();
		sallesParBatiment("triolet_b36");
		sallesParCampus("Triolet");
		statsParBatiment();
		statsParType();

		Campus campus = new Campus();
		campus.setNomC("FDE Nimes");
		campus.setVille("Nimes");
		cr.saveAndFlush(campus);

		Batiment bat = new Batiment();
		bat.setCodeB("bt1 nimes");
		bat.setAnneeC(2024);

		bat.setCampus(cr.getReferenceById("FDE Nimes"));
		br.saveAndFlush(bat);

		Salle s1 = new Salle();
		s1.setNumSalle("N01");
		s1.setCapacite(40);
		s1.setTypeS(TypeSalle.td);
		s1.setAccessibilite("oui");
		s1.setEtage("RDC");
		s1.setBatiment(br.getReferenceById("bt1 nimes"));

		Salle s2 = new Salle();
		s2.setNumSalle("N02");
		s2.setCapacite(120);
		s2.setTypeS(TypeSalle.amphi);
		s2.setAccessibilite("non");
		s2.setEtage("1");
		s2.setBatiment(br.getReferenceById("bt1 nimes"));

		sr.save(s1);
		sr.save(s2);
		sr.flush();

		toutesLesSalles();
		tousLesCampus();
	   }
	
	public void tsLesBatiments()
	{  Iterable<Batiment> e = br.findAll();
	  System.out.println("La liste des batiments");
      if (e != null) { 
   	   for (Batiment b : e)
          { System.out.println(b.getCodeB()+"\t "+b.getAnneeC()+"\t "+b.getCampus().getNomC());}
      } else System.out.println("nada");
	} 
	
	public void campusParVille(String ville)
	{  Iterable<Campus> e = cr.findByVille(ville);
	  System.out.println("La liste des campus de "+ville);
      if (e != null) { 
   	   for (Campus c : e)
          { System.out.println(c.toString());}
      } else System.out.println("nada");
	} 
	
	public void certainsBatiments(List<String> codes)
	{  Iterable<Batiment> e = br.findByIds(codes);
	  System.out.println("La liste de certains batiments");
      if (e != null) { 
   	   for (Batiment b : e)
          { System.out.println(b.getCodeB()+"\t "+b.getAnneeC()+"\t "+b.getCampus().getNomC());}
      } else System.out.println("nada");
	}

	public void toutesLesSalles() {
		List<Salle> salles = sr.findAllCustom();
		System.out.println("Liste de toutes les salles :");
		salles.forEach(s -> System.out.println(s.getNumSalle()));
	}

	public void sallesBat36() {
		List<Salle> salles = sr.findAllSalleInBat36();
		System.out.println("Salles du bâtiment B36 :");
		salles.forEach(s -> System.out.println(s.getNumSalle()));
	}

	public void sallesParBatiment(String codeBatiment) {
		List<Salle> salles = sr.findAllSalleByBat(codeBatiment);
		System.out.println("Salles du bâtiment " + codeBatiment + " :");
		salles.forEach(s -> System.out.println(s.getNumSalle()));
	}

	public void sallesParCampus(String nomCampus) {
		List<Salle> salles = sr.findAllSalleByCampus(nomCampus);
		System.out.println("Salles du campus " + nomCampus + " :");
		salles.forEach(s -> System.out.println(s.getNumSalle() + " (Bât: " + s.getBatiment().getCodeB() + ")"));
	}

	public void statsParBatiment() {
		List<Object[]> stats = sr.nbSalleByBat();
		System.out.println("Nombre de salles par bâtiment :");
		for (Object[] row : stats) {
			System.out.println("Bâtiment : " + row[1] + " -> " + row[0] + " salles");
		}
	}

	public void statsParType() {
		List<Object[]> stats = sr.nbSalleByType();
		System.out.println("Répartition des salles par type :");
		for (Object[] row : stats) {
			System.out.println("Type : " + row[1] + " -> " + row[0] + " salles");
		}
	}

	public void tousLesCampus() {
		List<Campus> salles = cr.findAll();
		System.out.println("Liste de toutes les campus :");
		salles.forEach(s -> System.out.println(s.getNomC()));
	}
}
