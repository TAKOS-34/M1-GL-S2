package Ex.domain;

import java.util.List;

import Ex.modele.TypeSalle;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import Ex.modele.Campus;

@Repository
public interface CampusRepository extends JpaRepository<Ex.modele.Campus, String> {
	
	List<Campus> findByVille(String ville);

	@Query("SELECT c.nomC, bts.codeB, sls.numSalle FROM Campus c " +
			"JOIN c.batiments bts JOIN bts.salles sls")
	List<String[]> campusEtCodeBEtNumSalle();

	@Query("SELECT COUNT(*) FROM Campus c " +
			"JOIN c.batiments b " +
			"JOIN b.salles s " +
			"WHERE c.ville = :campus " +
			"AND s.typeS = :typeSalle " +
			"AND s.accessibilite = :pmr " +
			"AND s.capacite <= :places ")
	int chercherSalle(String campus, int places, TypeSalle typeSalle, String pmr);
}
