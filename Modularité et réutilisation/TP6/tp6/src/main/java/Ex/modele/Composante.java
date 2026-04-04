package Ex.modele;
import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Composante {

    @Id
    private String acronyme;

    private String nom;
    private String responsable;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "exploite", joinColumns = @JoinColumn(name = "team"), inverseJoinColumns = @JoinColumn(name = "building"))
    private List<Batiment> batiments = new ArrayList<>();

    public Composante() {}

    public Composante(String acronyme, String nom, String responsable) {
        this.acronyme = acronyme;
        this.nom = nom;
        this.responsable = responsable;
    }

    public String getAcronyme() {
        return acronyme;
    }

    public String getNom() {
        return nom;
    }

    public String getResponsable() {
        return responsable;
    }

    public List<Batiment> getBatiments() {
        return batiments;
    }
}
