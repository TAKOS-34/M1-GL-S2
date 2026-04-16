package Ex.service;

import java.util.List;

import Ex.modele.Batiment;
import Ex.modele.Salle;


public interface ISalleService {
	
	List<Salle> sallesParBatiment(Batiment batB) ;
	
	List<Salle> findAll();
	
	void findAllAndMore();
	

}