package Ex.erreurs;
/* utilisation de concert avec GlobalExceptionHandler de type @ControllerAdvice */

public class CampusNotFoundException extends RuntimeException {
   
	private static final long serialVersionUID = 1L;

	public CampusNotFoundException(String message) {
        super(message);
    }
}