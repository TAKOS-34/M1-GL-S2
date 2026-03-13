package Ex.modele;
import jakarta.persistence.*;

@Entity
public class Salle {
    @Id
    private String numSalle;

    private int capacite;
    private TypeSalle typeS;
    private String accessibilite;
    private String etage;

    @ManyToOne
    @JoinColumn(name="batiment")
    private Batiment batiment;

    public Salle() {}

    public Salle(String numSalle, int capacite, TypeSalle typeS, String accessibilite, String etage, Batiment batiment) {
        this.numSalle = numSalle;
        this.capacite = capacite;
        this.typeS = typeS;
        this.accessibilite = accessibilite;
        this.etage = etage;
        this.batiment = batiment;
    }

    public String getNumSalle() {
        return numSalle;
    }

    public int getCapacite() {
        return capacite;
    }

    public TypeSalle getTypeS() {
        return typeS;
    }

    public String getAccessibilite() {
        return accessibilite;
    }

    public String getEtage() {
        return etage;
    }

    public Batiment getBatiment() {
        return batiment;
    }

    @Override
    public String toString() {
        return "";
    }
}
