package myvote;

import java.util.ArrayList;
import java.util.List;

public class ValidationErrorDTO {
	 
    private List<ErrorFields> fieldErrors = new ArrayList<>();
 
    public ValidationErrorDTO() {
 
    }
 
    public void addFieldError(String path, String message) {
        ErrorFields error = new ErrorFields(path, message);
        fieldErrors.add(error);
    }

	public List<ErrorFields> getFieldErrors() {
		return fieldErrors;
	}
 
}