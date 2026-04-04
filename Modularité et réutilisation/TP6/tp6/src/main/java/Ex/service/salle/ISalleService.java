package Ex.service.salle;
import Ex.modele.Salle;
import java.util.List;

public interface ISalleService {
    List<Salle> chercherSalle(String campus, int places);
}
