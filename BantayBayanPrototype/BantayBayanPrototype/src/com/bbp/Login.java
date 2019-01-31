package com.bbp;
import java.sql.*;

public class Login {
	public boolean isLoginValidate(String text1, String text2)
	{
		boolean isValid = false;
		
		String sqlurl = "jdbc:mysql://localhost:3306/bbp";
		String sqluser = "root";
		String sqlpass = "33sqltestpass33";
		
		String pUsername = null;
		String pPassword = null;
		try
		{
			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
			Connection con = DriverManager.getConnection(sqlurl, sqluser, sqlpass);
			
			PreparedStatement ps = con.prepareStatement("select * from tblAccounts where username=? and password=?");
			ps.setString(1, text1);
			ps.setString(2, text2);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				pUsername = rs.getString("username");
				pPassword = rs.getString("password");
			}
			
			if (pUsername == null || pUsername == ""  || pPassword == null || pPassword == "" ){
				isValid = false;
			}
			else {
				isValid = true;
			}
			
			
			
			System.out.println(pUsername);
			System.out.println(pPassword);
			System.out.println(text1);
			System.out.println(text2);
			System.out.println("done");
			
		}
		catch(SQLException sqle)
		{
			sqle.printStackTrace();
			System.out.println("Catched an sql exception.");
			isValid = false;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("Catched an exception.");
			isValid = false;
		}
		System.out.println(isValid);
		return isValid;
	}
}
