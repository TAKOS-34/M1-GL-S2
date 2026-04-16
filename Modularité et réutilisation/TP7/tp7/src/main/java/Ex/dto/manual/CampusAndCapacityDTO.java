package Ex.dto.manual;

public class CampusAndCapacityDTO {

    private String nomCampus;
    private Integer nombreBatiments;
    private Integer nombreSalles;
    private String ville;

    public CampusAndCapacityDTO(String nomCampus,
                                 Integer nombreBatiments,
                                 Integer nombreSalles,
                                 String ville) {
        this.nomCampus = nomCampus;
        this.nombreBatiments = nombreBatiments;
        this.nombreSalles = nombreSalles;
        this.ville = ville;
    }

    public String getNomCampus() { return nomCampus; }
    public Integer getNombreBatiments() { return nombreBatiments; }
    public Integer getNombreSalles() { return nombreSalles; }
    public String getVille() { return ville; }
}