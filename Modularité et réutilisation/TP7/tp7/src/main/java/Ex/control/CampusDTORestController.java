package Ex.control;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import Ex.domain.CampusRepository;
import Ex.dto.dto.CampusDTO;
import Ex.dto.mapper.ICampusMapper;


@RestController
@RequestMapping("/sites")
public class CampusDTORestController {

    private ICampusMapper mapstructMapper;

    private CampusRepository cpRepository;

    @Autowired
    public CampusDTORestController(
            ICampusMapper mapstructMapper,
            CampusRepository cpRepository    ) {
        this.mapstructMapper = mapstructMapper;
        this.cpRepository = cpRepository;
    }

    @GetMapping("/{id}")
    public ResponseEntity<CampusDTO> getById(
            @PathVariable(value = "id") String id
    ) {
        return new ResponseEntity<>(
                mapstructMapper.campusToCampusDTO(
                		cpRepository.findById(id).get()
                ),
                HttpStatus.OK
        );
    }
    //par ex : http://localhost:8889/sites/Triolet
}