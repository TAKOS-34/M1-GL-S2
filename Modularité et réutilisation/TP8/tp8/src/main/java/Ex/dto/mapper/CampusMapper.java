package Ex.dto.mapper;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

import Ex.dto.dto.*;
import Ex.modele.*;

@Component
// si pb config plusieurs beans par type : @Scope("singleton")
public class CampusMapper implements ICampusMapper {
	
	 @Override
	    public BatimentDTO batimentToBatimentDTO(Batiment batiment) {
	        if ( batiment == null ) {
	            return null;       }
	        BatimentDTO btSlimDto = new BatimentDTO();
	        btSlimDto.setCodeB( batiment.getCodeB());
	        btSlimDto.setAnneeC( batiment.getAnneeC() );    
	        return btSlimDto;
	    }
	
	
	 protected List<BatimentDTO> bTListToBTDTOList(List<Batiment> bts) {
        if ( bts == null ) {
            return null;
        }
        List<BatimentDTO> bts_dto = new ArrayList<BatimentDTO>();
        for ( Batiment batiment : bts ) {
        	bts_dto.add( batimentToBatimentDTO( batiment ) );
        }
        return bts_dto;
    }

    @Override
    public CampusDTO campusToCampusDTO(Campus campus) {
        if ( campus == null ) {
            return null;       }
        CampusDTO campusSlimDto = new CampusDTO();
        campusSlimDto.setNomC( campus.getNomC());
        campusSlimDto.setVille( campus.getVille() );
        campusSlimDto.setBatiments( bTListToBTDTOList(campus.getBatiments()) );
        return campusSlimDto;
    }

    
}