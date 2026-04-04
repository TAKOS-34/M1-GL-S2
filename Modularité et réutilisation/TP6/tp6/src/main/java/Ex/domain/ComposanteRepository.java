package Ex.domain;
import org.springframework.data.jpa.repository.JpaRepository;
import Ex.modele.Composante;

public interface ComposanteRepository extends JpaRepository<Composante, String> {}