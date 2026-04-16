package Ex.dto.manual;


public class CampusCapacityDTO {

    private String nomCampus;
    private Integer nombreSalles;
    private Integer nombreBatiments;

    public CampusCapacityDTO(String nomCampus, Integer nombreSalles, Integer nombreBatiments) {
        this.nomCampus = nomCampus;
        this.nombreSalles = nombreSalles;
        this.nombreBatiments = nombreBatiments;
    }

    public String getNomCampus() { return nomCampus; }
    public Integer getNombreSalles() { return nombreSalles; }
    public Integer getNombreBatiments() { return nombreBatiments; }
}