package Ex.service.salle;

import Ex.domain.SalleRepository;
import Ex.modele.Salle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class SalleService implements ISalleService {

    @Autowired
    private SalleRepository sr;

    @Override
    public List<Salle> chercherSalle(String campus, int places) {
        return sr.chercherSalle(campus, places);
    }
}
