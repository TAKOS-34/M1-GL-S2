package Ex.modele;

import java.util.ArrayList;
import java.util.List;


import jakarta.persistence.*;

@Entity
public class Batiment {
	
	@Id
	private String codeB;
	
	private int anneeC;
	
	@ManyToOne
	@JoinColumn(name="campus")
	private Campus campus;
	
	@OneToMany(fetch = FetchType.LAZY,mappedBy="batiment", cascade = CascadeType.REMOVE)
	private List<Salle> salles = new ArrayList<Salle>();
	
	@ManyToMany(fetch = FetchType.LAZY, mappedBy="batiments")
	private List<Composante> composantes = new ArrayList<Composante>();
	
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
	
	
	
	public List<Composante> getComposantes() {
		return composantes;
	}
	
	public List<Salle> getSalles() {
		return salles;
	}
	
	public boolean addComposante(Composante composante) {
		if(composante!=null) {
			if(this.composantes == null)
				this.composantes = new ArrayList<Composante>();
			if(!composantes.contains(composante))
				return composantes.add(composante);
			
		}
		return false;
	}
	
	public boolean deleteComposante(Composante composante)  {
		if(composante!=null && this.composantes != null)
			return composantes.remove(composante);
		return false;
	}

	public boolean addSalle(Salle salle) {
		if(salle!=null) {
			if(this.salles == null)
				this.salles = new ArrayList<Salle>();
			if(!salles.contains(salle))
				return salles.add(salle);
			
		}
		return false;
	}
	
	public boolean deleteSalle(Salle salle)  {
		if(salle!=null && this.salles != null)
			return salles.remove(salle);
		return false;
	}
	@Override
	public String toString() {
		return "Batiment [codeB=" + codeB  + ", anneeC=" + anneeC + "]";
	}

	
}
