package Ex.service.campus;
import Ex.domain.CampusRepository;
import Ex.modele.Campus;
import Ex.modele.TypeSalle;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.StreamSupport;

@Service
public class CampusService implements ICampusService {

    @Autowired
    private CampusRepository cr;

    public List<Campus> listeCampus() {
        return cr.findAll();
    }

    public Optional<Campus> campusParId(String nomC) {
        return cr.findById(nomC);
    }

    public void campusParVille(String ville) {
        Iterable<Campus> e = cr.findByVille(ville);
        System.out.println("La liste des campus de " + ville);

        if (StreamSupport.stream(e.spliterator(), false).count() != 0) {
            for (Campus c : e) {
                System.out.println(c.toString());
            }
        } else {
            System.out.println("pas de campus connu sur " + ville);
        }
    }

    @Transactional
    public Campus createCampus(Campus campus) {
        return cr.save(campus);
    }

    @Transactional
    public Campus modifieInformations(String nomC, Campus updatedCampus) {
        return cr.findById(nomC)
                .map(campus -> {
                    campus.setVille(updatedCampus.getVille());
                    campus.setBatiments(updatedCampus.getBatiments());
                    return cr.save(campus);
                })
                .orElseThrow(() -> new EntityNotFoundException("Not found: " + nomC));
    }

    @Override
    public void deleteCampus(String id) {
        cr.deleteById(id);
    }

    @Override
    public int chercherSalle(String campus, int places, TypeSalle typeSalle, String pmr) {
        return cr.chercherSalle(campus, places, typeSalle, pmr);
    }
}
