package Ex.domain;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import Ex.modele.Campus;


@Repository
public interface CampusRepository extends JpaRepository<Campus, String> {
	
	List<Campus> findByVille(String ville);
	
	@Query("SELECT c.nomC, bts.codeB, sls.numS FROM Campus c "
			+ "JOIN c.batiments bts join bts.salles sls")	
	List<String[]> campusEtCodeBEtNumS();
	
	@Query("SELECT c.nomC, count(bts.codeB) cpt_bat FROM Campus c "
			+ "JOIN c.batiments bts group by c.nomC")	
	List<String[]> campusEtComptageBats();
	
	@Query("SELECT DISTINCT c FROM Campus c JOIN FETCH c.batiments")
	List<Campus> findAllWithBatiments();

	@Query("SELECT DISTINCT c FROM Campus c JOIN FETCH c.batiments WHERE c = :campus")
	Optional<Campus> findByCampusWithAllBatiments(@Param("campus") Campus campus);
	
}
