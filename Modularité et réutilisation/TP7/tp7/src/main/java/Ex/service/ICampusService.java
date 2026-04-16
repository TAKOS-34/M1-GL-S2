package Ex.service;

import java.util.List;
import java.util.Optional;

import Ex.modele.Campus;


public interface ICampusService {
	
	Campus createCampus(Campus campus) ;

	void deleteCampus(String id);

	Optional<Campus> campusParId(String nomC);
	
	void campusParVille(String ville) ;
	
	List<Campus> findAll();
	
	List<Campus> avecLesBatiments();
	
	Optional<Campus> campusAvecLesBatiments(Campus campus);

}