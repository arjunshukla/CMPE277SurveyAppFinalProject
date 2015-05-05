package myvote;

public class ErrorFields {
	private String field;
    private String message;
    
    public String getField() {
		return field;
	}

	public String getMessage() {
		return message;
	}

 
    public ErrorFields(String field, String message) {
        this.field = field;
        this.message = message;
    }
 
}