package Ex.domain;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import Ex.modele.*;

@Repository
public interface SalleRepository extends JpaRepository<Salle, String> {

	// SQL Query (native query )	
@Query(			value = "SELECT * FROM salle ORDER BY batiment", nativeQuery = true)
List<Salle> findAllOrderByBatiment();

//JPQL Query (with one parameter)	
@Query("SELECT s FROM Salle s WHERE s.etage = :et")
List<Salle> findByEtage(@Param("et") String et);

//JPQL Query (with one parameter)	
@Query("SELECT s FROM Salle s WHERE s.typeS = :ty")
List<Salle> findByType(@Param("ty") TypeSalle ty);


//JPQL Query (with two parameters)	
@Query("SELECT s FROM Salle s WHERE s.etage = :et and s.batiment= :bt")
List<Salle> findByEtageAndBatiment(@Param("et") String et, @Param("bt") Batiment bt);

//SQL Join with Batiment
@Query(value = "SELECT s.*, b.* from salle s, batiment b "
		  + " where s.batiment = b.codeB "
		  , nativeQuery = true)
		List<Map<String, Object>> findSalleByBatiment();

List<Salle> findByBatiment(Batiment batiment);

List<Salle> findByBatiment_CodeB(String codeB);

Optional<Salle> findByNumS(String numS);

@Query("SELECT s, b, c FROM Salle s JOIN s.batiment b JOIN b.campus c")
List<Object[]> sallesEtBatimentsEtCampus();

//List<Salle> findByCapaciteOrEtage(int capacite, String etage);
//List<Salle> findByCapaciteAndEtage(int capacite, String etage);
//List<Salle> findByCapaciteBetween(int min, int max);

@Query("SELECT s FROM Salle s WHERE s.capacite > :cap")
List<Salle> findGrandesSalles(@Param("cap") int cap);

@Query("SELECT s FROM Salle s WHERE (:typeS IS NULL OR s.typeS = :typeS) "
		+ "AND (:accessible IS NULL OR s.acces = :accessible)"
		+ "    AND (:capaciteMin IS NULL OR s.capacite >= :capaciteMin)"
		+ "     AND (:capaciteMax IS NULL OR s.capacite <= :capaciteMax)"
		+ " AND (:etage IS NULL OR s.etage = :etage)"
		+ " AND (:batiment IS NULL OR s.batiment = :batiment)")
List<Salle> searchSalles(
        @Param("typeS") TypeSalle typeS,
        @Param("accessible") String accessible,
        @Param("capaciteMin") Integer capaciteMin,
        @Param("capaciteMax") Integer capaciteMax,
        @Param("etage") Integer etage,
        @Param("batiment") Batiment batiment
    );



}
