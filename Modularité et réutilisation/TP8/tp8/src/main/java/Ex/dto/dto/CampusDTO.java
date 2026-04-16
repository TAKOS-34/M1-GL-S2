package Ex.dto.dto;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

public class CampusDTO {
	 	@JsonProperty("nomCampus")
	    private String nomC;

	    @JsonProperty("ville")
	    private String ville;
	    
	    @JsonProperty("batiments")
	    private List<BatimentDTO> batiments; 

	    public String getNomC() {
	        return nomC;
	    }
	   
	    public String getVille() {
	        return ville;
	    }
	    
	    public void setNomC(String nomC) {
	        this.nomC = nomC;
	    }
	    
	    public void setVille(String ville) {
	        this.ville = ville;
	    }
	    
	    public List<BatimentDTO> getBatiments() {
	        return batiments;
	    }
	    
	    public void setBatiments(List<BatimentDTO> batiments) {
	        this.batiments = batiments;
	    }
	    
}