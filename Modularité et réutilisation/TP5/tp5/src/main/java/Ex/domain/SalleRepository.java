package Ex.domain;
import Ex.modele.Salle;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;

public interface SalleRepository extends JpaRepository<Salle, String> {
    @Query("SELECT s FROM Salle s")
    List<Salle> findAllCustom();

    @Query("SELECT s FROM Salle s WHERE s.batiment.codeB = 'triolet_b36'")
    List<Salle> findAllSalleInBat36();

    @Query("SELECT s FROM Salle s WHERE s.batiment.codeB = :codeBatiment")
    List<Salle> findAllSalleByBat(@Param("codeBatiment") String codeBatiment);

    @Query("SELECT s FROM Salle s " +
            "JOIN Batiment b ON s.batiment.codeB = b.codeB " +
            "JOIN Campus c ON b.campus.nomC = :nomCampus")
    List<Salle> findAllSalleByCampus(@Param("nomCampus") String nomCampus);

    @Query("SELECT COUNT(*) AS nbSalle, b.codeB FROM Salle s " +
            "JOIN Batiment b ON s.batiment.codeB = b.codeB " +
            "GROUP BY b.codeB")
    List<Object[]> nbSalleByBat();

    @Query("SELECT COUNT(*) AS nbSalle, s.typeS FROM Salle s " +
            "GROUP BY s.typeS")
    List<Object[]> nbSalleByType();
}
