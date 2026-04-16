package Ex.service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import Ex.domain.BatimentRepository;
import Ex.modele.Batiment;
import Ex.modele.Campus;

import java.util.List;
import java.util.Optional;

@Service
public class BatimentService implements IBatimentService {

	private final BatimentRepository br;

    @Autowired
    public BatimentService(BatimentRepository br) {
        this.br = br;
    }

    public List<Batiment> findAll() {
        return br.findAll();
    }
       
    public List<Batiment> batimentsParCampus(Campus campus) {
        return br.findByCampus(campus);
    }

	public Optional<Batiment> batimentParCodeB(String id) {
		return br.findByCodeB(id);
	}

	public List<Batiment> batimentsParCampusEtSalles(Campus campus) {
        return br.findByCampusWithSalles(campus);
    }


}