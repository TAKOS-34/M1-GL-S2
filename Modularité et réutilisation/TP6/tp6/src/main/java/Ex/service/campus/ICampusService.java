package Ex.service.campus;
import Ex.modele.Campus;
import Ex.modele.TypeSalle;

import java.util.List;
import java.util.Optional;

public interface ICampusService {
    Campus createCampus(Campus campus);
    Campus modifieInformations(String nomC, Campus updatedCampus);
    void deleteCampus(String id);
    List<Campus> listeCampus();
    Optional<Campus> campusParId(String nomC);
    void campusParVille(String ville);
    int chercherSalle(String campus, int places, TypeSalle typeSalle, String pmr);
}
