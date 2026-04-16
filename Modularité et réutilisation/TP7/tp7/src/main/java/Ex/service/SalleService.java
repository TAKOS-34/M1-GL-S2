package Ex.service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import Ex.domain.SalleRepository;
import Ex.modele.Batiment;
import Ex.modele.Campus;
import Ex.modele.Salle;

import java.util.List;

@Service
public class SalleService implements ISalleService {

	private final SalleRepository sr;

    @Autowired
    public SalleService(SalleRepository sr) {
        this.sr = sr;
    }

    public List<Salle> findAll() {
        return sr.findAll();
    }
    
       
    public List<Salle> sallesParBatiment(Batiment batB) {
        return sr.findByBatiment(batB);
    }

	public void findAllAndMore() {
		List<Object[]> triple = sr.sallesEtBatimentsEtCampus();
		for(Object[] row : triple){
		    Salle salle = (Salle) row[0];
		    Batiment batiment = (Batiment) row[1];
		    Campus campus = (Campus) row[2];
		    System.out.println(salle.getNumS() + " - " 
		    + batiment.getCodeB() + " - " + campus.getNomC());
		}
	}
    
}