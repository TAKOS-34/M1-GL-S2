package Ex.service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import Ex.modele.Campus;

@Service
public class CampusCapacityService  implements ICampusCapacityService{

	private final CampusService cs;
	private final BatimentService bs;

    @Autowired
    public CampusCapacityService(CampusService cs, BatimentService bs) {
        this.cs = cs;
		this.bs = bs;
    }
     
    private Integer compterSalles(Campus campus) {
        return bs.batimentsParCampusEtSalles(campus).stream()
                .mapToInt(bt -> bt.getSalles().size())
                .sum();
    }
    
    /* gestion de l'incertitude sur le Optional<Campus> ici */
    public Integer nombreSalles(String nomCampus) {
        return cs.campusParId(nomCampus)
                .map(this::compterSalles)
                .orElse(0);
    }
    
    // idem pour la gestion de l'incertitude mais un peu différent que nombreSalles 
	public Integer nombreBatiments(Campus campus) {
		
		if (campus == null) {
	        return 0;
	    }
		else return cs.campusAvecLesBatiments(campus)
	    	        .map(c -> c.getBatiments().size())
	    	        .orElse(0);
	}
	
	
	private Integer compterBatiments(Campus campus) {
        return cs.campusAvecLesBatiments(campus).stream()
                .mapToInt(cs -> cs.getBatiments().size())
                .sum();
    }
	
	
	public Integer nombreBatiments(String nomCampus) {
        return cs.campusParId(nomCampus)
                .map(this::compterBatiments)
                .orElse(0);
    }
	
}