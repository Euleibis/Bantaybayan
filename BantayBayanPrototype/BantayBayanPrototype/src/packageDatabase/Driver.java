package packageDatabase;

import java.sql.*;

public class Driver {

	public static void main(String[] args) {
		
		try{
			// 1. Get a connection to database
			Connection myConn = DriverManager.getConnection("jdbc:mysql://localhost:3306/demoschema", "root", "33sqltestpass33");
			// 2. Create a statement
			Statement myStmt = myConn.createStatement();
			// 3. Execute SQL Query
			String sql = "INSERT INTO testtable " +
				" (StudentLastName, StudentFirstName, StudentNum)" +
				" VALUES ('Brown', 'David', '55')";
				
			myStmt.executeUpdate(sql);
			
			System.out.println("Insert Complete.");
			}
		catch (Exception exc){
			exc.printStackTrace();
		}

	}

}



/*

//****INSERTING
// 1. Get a connection to database
	Connection myConn = DriverManager.getConnection(url, user, password);
	
	// 2. Create a statement
	Statement myStmt = myConn.createStatement();
	
	// 3. Execute SQL Query
	String sql = "INSERT INTO testTable " +
		" (StudentLastName, StudentFirstName, StudentNum)" +
		" VALUES ('Brown', 'David', '4'"
		
	myStmt.executeUpdate(sql);
	
	System.out.println("Insert Complete.");



//*****UPDATING
 // 1. get a connection to database
Connection myConn = DriverManager.getConnection(url, user, password);

// 2. Create a statement
Statement myStmt = myConn.createStatement();

// 3. Execute SQL Query
String sql = "UPDATE employees " + 
	"SET email='demo@luv2code.com'" +
	"WHERE id=9;"


//******SHOWING
// 1. Get a connection to database
Connection myConn = DriverManager.getConnection("jdbc:mysql://localhost:3306/demoschema", "root", "33sqltestpass33");
// 2. Create a statement
Statement myStmt = myConn.createStatement();
// 3. Execute SQL Query

ResultSet myRs = myStmt.executeQuery("SELECT * FROM testTable");
// 4. Process the result set
while (myRs.next()) {
	System.out.println(myRs.getString("StudentLastName") + ", " + myRs.getString("StudentFirstName"));


*/
