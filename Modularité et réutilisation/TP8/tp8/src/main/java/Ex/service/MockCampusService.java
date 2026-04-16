package Ex.service;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import Ex.modele.Campus;
import jakarta.annotation.PostConstruct;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

@Service
//@Primary
public class MockCampusService implements ICampusService {

    private final Map<String, Campus> storage = new ConcurrentHashMap<>();
    
    @PostConstruct
    public void init() {
        storage.put("Triolet", new Campus("Triolet", "Montpellier"));
        storage.put("Balard", new Campus("Balard", "Montpellier"));
    }

    @Override
    public List<Campus> findAll() {
        return new ArrayList<>(storage.values());
    }

    @Override
    public void campusParVille(String ville) {
        System.out.println("La liste des campus de " + ville);
        boolean found = false;

        for (Campus c : storage.values()) {
            if (c.getVille().equalsIgnoreCase(ville)) {
                System.out.println(c);
                found = true;
            }
        }

        if (!found) {
            System.out.println("pas de campus connu sur " + ville);
        }
    }

    @Override
    public Optional<Campus> campusParId(String id) {
        return Optional.ofNullable(storage.get(id));
    }

    @Override
    public Campus createCampus(Campus campus) {
        storage.put(campus.getNomC(), campus);
        return campus;
    }

    @Override
    public void deleteCampus(String id) {
        storage.remove(id);
    }
    	
    public List<Campus> avecLesBatiments()
    {return new ArrayList<>(storage.values());}

	@Override
	public Optional<Campus> campusAvecLesBatiments(Campus campus) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateCampus(String ville, String nomC) {
		// TODO Auto-generated method stub
		
	}

    @Override
    public void testAutoInvocation(String ville, String nomC) {

    }

}