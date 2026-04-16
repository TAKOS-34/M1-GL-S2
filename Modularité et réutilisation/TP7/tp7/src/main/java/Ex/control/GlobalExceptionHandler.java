package Ex.control;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import Ex.erreurs.CampusNotFoundException;

/* interception erreurs provenant des controllers */
/* centralisation de la gestion des erreurs */

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(CampusNotFoundException.class)
    public String handleCampusNotFound(CampusNotFoundException ex, Model model) {

        model.addAttribute("message", ex.getMessage());
        return "errors/campus_errors";
    }
}