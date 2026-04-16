package Ex.modele;

import jakarta.persistence.*;

@Entity
public class Salle {
	
	@Id
	private String numS;
	
	private int capacite;
	
	@Enumerated(EnumType.STRING)
	private TypeSalle typeS;
	
	
	private String acces;
	private String etage;
	
	@ManyToOne
	@JoinColumn(name="batiment")
	private Batiment batiment;

	public Salle() {	
	}
	
	public Salle(String numS, int capacite, TypeSalle typeS, String acces, String etage, Batiment batiment) {
		super();
		this.numS = numS;
		this.capacite = capacite;
		this.typeS = typeS;
		this.acces = acces;
		this.etage = etage;
		this.batiment = batiment;
	}

	public String getNumS() {
		return numS;
	}

	public void setNumS(String numS) {
		this.numS = numS;
	}

	public int getCapacite() {
		return capacite;
	}

	public void setCapacite(int capacite) {
		this.capacite = capacite;
	}

	public TypeSalle getTypeS() {
		return typeS;
	}


	public void setTypeS(TypeSalle typeS) {
		this.typeS = typeS;
	}

	public String getAcces() {
		return acces;
	}

	public void setAcces(String acces) {
		this.acces = acces;
	}

	public String getEtage() {
		return etage;
	}

	public void setEtage(String etage) {
		this.etage = etage;
	}

	public Batiment getBatiment() {
		return batiment;
	}

	public void setBatiment(Batiment batiment) {
		this.batiment = batiment;
	}
	
	@Override
	public String toString() {
		return "Salle [numS=" + numS + ", capacite=" + capacite + ", typeS=" + typeS + ", acces=" + acces + ", etage="
				+ etage + "]";
	}
	
}
