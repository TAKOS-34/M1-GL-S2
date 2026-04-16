package Ex.domain;

import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import Ex.modele.*;

@Repository
public interface BatimentRepository extends JpaRepository<Batiment, String> {
	// JPQL Query
	@Query("SELECT b FROM Batiment b WHERE b.codeB IN :ids")
	List<Batiment> findByIds(@Param("ids") List<String> ids);
	
	List<Batiment> findByCampus(Campus campus);
	
	Optional<Batiment> findByCodeB(String codeB);
	
	//SQL Join with Campus
	@Query(value = "SELECT c.*, b.* from campus c, batiment b "
	 + " where b.campus = c.nomC "	  , nativeQuery = true)
	List<Map<String, Object>> findBatimentByCampus();
	
	
	@Query("SELECT DISTINCT b FROM Batiment b JOIN FETCH b.salles")
	List<Batiment> findAllWithSalles();
	
	@Query("SELECT DISTINCT b FROM Batiment b JOIN FETCH b.salles WHERE b.campus = :campus")
	List<Batiment> findByCampusWithSalles(@Param("campus") Campus campus);
	
	
	
}