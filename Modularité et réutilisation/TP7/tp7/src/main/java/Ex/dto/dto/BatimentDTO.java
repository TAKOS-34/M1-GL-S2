package Ex.dto.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

public class BatimentDTO {
	 	@JsonProperty("codeB")
	    private String codeB;

	    @JsonProperty("anneeC")
	    private int anneeC;

	    public String getCodeB() {
	        return codeB;
	    }
	   
	    public int getAnneeC() {
	        return anneeC;
	    }
	    
	    public void setCodeB(String codeB) {
	        this.codeB = codeB;
	    }
	    
	    public void setAnneeC(int anneeC) {
	        this.anneeC = anneeC;
	    }
	    
}