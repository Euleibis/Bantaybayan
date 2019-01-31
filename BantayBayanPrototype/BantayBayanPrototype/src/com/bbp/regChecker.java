package com.bbp;

public class regChecker {
	public void printSample() {
		System.out.println("gumagana tol");
	}
	
	
	/** This method returns true if the given String is blank or empty 
	 * 
	 * @param text String to be checked
	 * @return true if text is blank; false otherwise
	 */
	public boolean isBlank(String text) {
		if(text == "") {
			return true;
		}
		else {
			return false;
		}
	}
	
	/** This method returns true if the given String contains white spaces 
	 * 
	 * @param text String to be checked
	 * @return true if text has it has any white spaces; false otherwise
	 */
	public boolean hasWhiteSpaces(String text) {
		String regex = "(.)*(\\s)(.)*";
		
		if(text.matches(regex)) {
			return true;
		}
		else {
			return false;
		}
	}
	
	/** This method returns true if the given String contains consecutive white spaces 
	 * 
	 * @param text String to be checked
	 * @return true if text contains consecutive white spaces; false otherwise
	 */
	public boolean hasMultipleWhiteSpaces(String text) {
		String regex = "\\A([\\s])*\\Z";
		
		if(text.matches(regex)) {
			return true;
		}
		else {
			return false;
		}
	}
	
	/** This method returns true if the given String follows the given length
	 * 
	 * @param text String to be checked
	 * @return true if length of String matches given length; false otherwise
	 */
	public boolean hasMaxCharacters(String text, int length) {
		if (text.length() <= length) {
			return true;
		}
		else {
			return false;
		}
	}
	
	/** This method returns true if the given String follows the given length
	 * 
	 * @param text String to be checked
	 * @return true if length of String matches given length; false otherwise
	 */
	public boolean hasMinCharacters(String text, int lenght) {
		if (text.length() >= lenght) {
			return true;
		}
		else {
			return false;
		}
	}
	
	
	/** This method returns true if the password and confirm password values match.
	 *  
	 * @param text1 value of password field
	 * @param text2 value of confirm password field
	 * @return true if the Strings are equal; false otherwise
	 */
	 
	public boolean isEqual(String text1, String text2) {
		if (text1.equals(text2)) {
			return true;
		}
		else {
			return false;
		}
	}
	
	/** This method returns true if the password has at least 1 number
	 *  
	 * @param password value of password field
	 * @return true if password has a number, false otherwise
	 */
	
	public boolean hasNumber(String password) {
		String regex = "(.)*(\\d)(.)*";
		
		if (password.matches(regex)) {
			return true;
		}
		else {
			return false;
		}
	}
	
	/** This method returns true if the format of the email address is correct
	 *  
	 * @param email value of email field
	 * @return true if email is valid, false otherwise
	 */
	 
	public boolean isValidEmail(String email) {
		String regex = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
				
		if(email.matches(regex)) {
			return true;
		}
		else {
			return false;
		}
	}
}


