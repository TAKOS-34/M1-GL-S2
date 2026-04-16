package Ex.modele;

import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.*;


@Entity
public class Composante {
	
	@Id
	private String acronyme;
	
	private String nom;
	private String responsable;
	
	@ManyToMany(fetch = FetchType.LAZY) 
	@JoinTable( name = "exploite",
     joinColumns = @JoinColumn( name = "team" ),
     inverseJoinColumns = @JoinColumn( name = "building" ))
	private List<Batiment> batiments = new ArrayList<Batiment>();
	
	
	public Composante() {
	}
	
	public Composante(String acronyme, String nom, String responsable) {
		super();
		this.acronyme = acronyme;
		this.nom = nom;
		this.responsable = responsable;
	}
	
	
	public String getAcronyme() {
		return acronyme;
	}
	public void setAcronyme(String acronyme) {
		this.acronyme = acronyme;
	}
	public String getNom() {
		return nom;
	}
	public void setNom(String nom) {
		this.nom = nom;
	}
	public String getResponsable() {
		return responsable;
	}
	public void setResponsable(String responsable) {
		this.responsable = responsable;
	}	

	public List<Batiment> getBatiments() {
		return batiments;
	}

	
	public boolean addBatiment(Batiment batiment) {
		if(batiment!=null) {
			if(this.batiments == null)
				this.batiments = new ArrayList<Batiment>();
			if(!batiments.contains(batiment))
				return batiments.add(batiment);;
			
		}
		return false;
	}
	
	public boolean deleteBatiment(Batiment batiment)  {
		if(batiment!=null && this.batiments != null)
			return batiments.remove(batiment);
		return false;
	}

	@Override
	public String toString() {
		return "Composante [acronyme=" + acronyme + ", nom=" + nom + ", responsable=" + responsable + ", batiments="
				+ batiments + "]";
	}


}