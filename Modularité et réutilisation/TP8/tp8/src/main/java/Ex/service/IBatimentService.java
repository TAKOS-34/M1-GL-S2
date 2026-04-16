package Ex.service;

import java.util.List;
import java.util.Optional;

import Ex.modele.Batiment;
import Ex.modele.Campus;


public interface IBatimentService {

	List<Batiment> batimentsParCampus(Campus campus) ;
	
	List<Batiment> findAll();
	
	Optional<Batiment> batimentParCodeB(String id);
	
	List<Batiment> batimentsParCampusEtSalles(Campus campus);

}