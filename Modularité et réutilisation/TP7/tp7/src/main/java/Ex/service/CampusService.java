package Ex.service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import Ex.domain.CampusRepository;
import Ex.modele.Campus;
import jakarta.transaction.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.stream.StreamSupport;

@Service
@Primary
public class CampusService implements ICampusService {

	private final CampusRepository cr;

    @Autowired
    public CampusService(CampusRepository cr) {
        this.cr = cr;
    }

    public List<Campus> findAll() {
        return cr.findAll();
    }
    
    public void campusParVille(String ville)
	{  Iterable<Campus> e = cr.findByVille(ville);
	  System.out.println("La liste des campus de "+ville);
      if (StreamSupport.stream(e.spliterator(), false).count() != 0) { 
   	   for (Campus c : e)
          { System.out.println(c.toString());}
      } else System.out.println("pas de campus connu sur "+ville);
	} 
       
    public Optional<Campus> campusParId(String id) {
        return cr.findById(id);
    }  
    
    @Transactional
    public Campus createCampus(Campus campus) {
        return cr.save(campus);
    }
    @Transactional
    public Campus updateCampus(String id, Campus updatedCampus) {
    	return cr.findById(id)
                .map(campus -> {
                    campus.setVille(updatedCampus.getVille());
                    campus.setBatiments(updatedCampus.getBatiments());
                    return cr.save(campus);
                })
                .orElseThrow(() -> new RuntimeException("Campus not found with nomC: " + id));
    }
    @Transactional
    public void deleteCampus(String id) {
        cr.deleteById(id);
    }

    public List<Campus> avecLesBatiments()
    {return cr.findAllWithBatiments();}
    
    public Optional<Campus> campusAvecLesBatiments(Campus campus)
    {return cr.findByCampusWithAllBatiments(campus);}
    
    
}