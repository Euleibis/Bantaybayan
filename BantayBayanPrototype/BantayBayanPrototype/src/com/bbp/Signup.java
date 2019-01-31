package com.bbp;
import java.sql.*;
import java.util.Random;
public class Signup
{
	int nextMax;
	/**
	 * see if the email you input is already in the database or not
	 * @return check
	 * @throws SQLException
	 */
	String sql;
	String sqlurl = "jdbc:mysql://localhost:3306/bbp";
	String sqluser = "root";
	String sqlpass = "33sqltestpass33";
	public boolean isEmailCheck(String text1)
	{
		boolean status = false;
		try{
			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
			Connection con = DriverManager.getConnection(sqlurl, sqluser, sqlpass);
			
			PreparedStatement ps=con.prepareStatement("select * from Accounts where Email=?");
			ps.setString(1, text1);
			ResultSet rs=ps.executeQuery();
			status=rs.next();
			
		}catch(Exception e){}
		return status;
	}
	public int addAccount(String text1, String text2, String text3) throws SQLException
	{
		int status=0;
		try
		{
			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
			Connection con = DriverManager.getConnection(sqlurl, sqluser, sqlpass);
			PreparedStatement ps = con.prepareStatement("insert into Accounts values (?,?,?)");
			ps.setString(1, text1);
			ps.setString(2, text2);
			ps.setString(3, text3);
			status=ps.executeUpdate();
		}
		catch(Exception e)
		{
			
		}
		return status;
	}
	public int addAccountDistrict(String text1, String text2, String text3)
	{
		int status=0;
		try
		{
			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
			Connection con = DriverManager.getConnection(sqlurl, sqluser, sqlpass);
			PreparedStatement ps = con.prepareStatement("inset into Accounts values (?,?,?,?)");
			ps.setString(1, text1);
			ps.setString(2, text2);
			ps.setString(3, text3);
			ps.setString(4, "true");
		}
		catch(Exception e)
		{
			
		}
		return status;
	}
	public String generateAccount() 
	{
		{
			String account = null;
			int nextNumber = 0;
			try
			{
				DriverManager.registerDriver(new com.mysql.jdbc.Driver());
				Connection con = DriverManager.getConnection(sqlurl, sqluser, sqlpass);
				Statement st = con.createStatement();
				ResultSet rs = st.executeQuery("select count(username) From tblAccounts Where accountType = 'D'");
				while (rs.next())
				{
					nextNumber = rs.getInt(1);
				}
				nextNumber++;
				if (nextNumber < 10)
				{
					account = "District000" + String.valueOf(nextNumber);
				}
				else if (nextNumber < 100)
				{
					account = "District00" + String.valueOf(nextNumber);
				}
				else if (nextNumber < 1000)
				{
					account = "District0" + String.valueOf(nextNumber);
				}
				else
				{
					account = "District" + String.valueOf(nextNumber);
				}
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			return account;
		}
	}
	public String generateCharacter(int a)
	{
		String character = null;
		if (a == 1)
		{
			character = "a";
		}
		if (a == 2)
		{
			character = "b";
		}
		if (a == 3)
		{
			character = "c";
		}
		if (a == 4)
		{
			character = "d";
		}
		if (a == 5)
		{
			character = "e";
		}
		if (a == 6)
		{
			character = "f";
		}
		if (a == 7)
		{
			character = "g";
		}
		if (a == 8)
		{
			character = "h";
		}
		if (a == 9)
		{
			character = "i";
		}
		if (a == 10)
		{
			character = "j";
		}
		if (a == 11)
		{
			character = "k";
		}		
		if (a == 12)
		{
			character = "l";
		}
		if (a == 13)
		{
			character = "m";
		}
		if (a == 14)
		{
			character = "n";
		}
		if (a == 15)
		{
			character = "o";
		}
		if (a == 16)
		{
			character = "p";
		}
		if (a == 17)
		{
			character = "q";
		}
		if (a == 18)
		{
			character = "r";
		}
		if (a == 19)
		{
			character = "s";
		}
		if (a == 20)
		{
			character = "t";
		}
		if (a == 21)
		{
			character = "u";
		}
		if (a == 22)
		{
			character = "v";
		}
		if (a == 23)
		{
			character = "w";
		}
		if (a == 24)
		{
			character = "x";
		}
		if (a == 25)
		{
			character = "y";
		}
		if (a == 26)
		{
			character = "z";
		}
		if (a == 27)
		{
			character = "1";
		}
		if (a == 28)
		{
			character = "2";
		}
		if (a == 29)
		{
			character = "3";
		}
		if (a == 30)
		{
			character = "4";
		}
		if (a == 31)
		{
			character = "5";
		}
		if (a == 32)
		{
			character = "6";
		}
		if (a == 33)
		{
			character = "7";
		}
		if (a == 34)
		{
			character = "8";
		}
		if (a == 35)
		{
			character = "9";
		}
		if (a == 36)
		{
			character = "0";
		}
		return character;
	}
	public String generatePassword()
	{
		int a, b, c, d, e, f, g, h;
		String aa, ba, ca, da, ea, fa, ga, ha;
		String password = null;
		Random random = new Random();
		a = random.nextInt(36) + 1;
		b = random.nextInt(36) + 1;
		c = random.nextInt(36) + 1;
		d = random.nextInt(36) + 1;
		e = random.nextInt(36) + 1;
		f = random.nextInt(36) + 1;
		g = random.nextInt(36) + 1;
		h = random.nextInt(36) + 1;
		Signup s = new Signup();
		aa = s.generateCharacter(a);
		ba = s.generateCharacter(b);
		ca = s.generateCharacter(c);
		da = s.generateCharacter(d);
		ea = s.generateCharacter(e);
		fa = s.generateCharacter(f);
		ga = s.generateCharacter(g);
		ha = s.generateCharacter(h);
		password = aa + ba + ca + da + ea + fa + ga + ha;
		return password;
	}
}
