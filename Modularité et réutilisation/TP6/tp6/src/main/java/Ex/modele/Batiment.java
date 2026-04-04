package Ex.modele;
import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Batiment {
	
	@Id
	private String codeB;
	
	private int anneeC;
	
	@ManyToOne
	@JoinColumn(name="campus")
	private Campus campus;

	@OneToMany(fetch = FetchType.LAZY, mappedBy="batiment", cascade = CascadeType.REMOVE)
	private List<Salle> salles = new ArrayList<>();

	@ManyToMany(fetch = FetchType.LAZY, mappedBy="batiments")
	private List<Composante> composantes = new ArrayList<>();
	
	public Batiment() {} 
	
	public Batiment(String codeB, int anneeC, Campus campus) {
		super();
		this.codeB = codeB;
		this.anneeC = anneeC;
		this.campus = campus;
	}

	public String getCodeB() {
		return codeB;
	}

	public void setCodeB(String codeB) {
		this.codeB = codeB;
	}

	public int getAnneeC() {
		return anneeC;
	}

	public void setAnneeC(int anneeC) {
		this.anneeC = anneeC;
	}

	public Campus getCampus() {
		return campus;
	}

	public void setCampus(Campus campus) {
		this.campus = campus;
	}
	
	@Override
	public String toString() {
		return "Batiment [codeB=" + codeB  + ", anneeC=" + anneeC + "]";
	}
	
}
