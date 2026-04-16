package Ex.dto.mapper;


import org.mapstruct.Mapper;

import Ex.dto.dto.BatimentDTO;
import Ex.dto.dto.CampusDTO;
import Ex.modele.Batiment;
import Ex.modele.Campus;

@Mapper(
	    componentModel = "spring"
	)
	public interface ICampusMapper {
	   
	    CampusDTO campusToCampusDTO(Campus campus);
	    
	    BatimentDTO batimentToBatimentDTO(Batiment batiment);


	//  Campus campusDTOToCampusPost(CampusDTO campusDto);
	}