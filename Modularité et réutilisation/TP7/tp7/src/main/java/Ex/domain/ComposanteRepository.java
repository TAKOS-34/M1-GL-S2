package Ex.domain;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import Ex.modele.Composante;

@Repository
public interface ComposanteRepository extends JpaRepository<Composante, String>{

}
