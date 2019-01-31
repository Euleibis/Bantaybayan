package com.bbp;

import java.sql.*;
import java.text.DecimalFormat;

public class Rating 
{
	String sqlurl = "jdbc:mysql://localhost:3306/bbp";
	String sqluser = "root";
	String sqlpass = "33sqltestpass33";
	public double getAverageRatings(String district)
	{
		Rating r = new Rating();
		int maxNumber = r.getMaxRating(district);
		int[] ratings = r.getRatings(district, maxNumber);
		double rating = 0;
		double sum = 0;
		for(int i : ratings)
		{
			sum += i;
		}
		rating = sum/maxNumber;
		DecimalFormat format = new DecimalFormat("##.0");
		rating = Double.parseDouble(format.format(rating));
		return rating;
	}
	public int getMaxRating(String district)
	{
		int maxNumber = 0;
		
		try
		{
			
			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
			Connection con = DriverManager.getConnection(sqlurl, sqluser, sqlpass);
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("Select rating from tblConcerns Where district = '" + district + "' AND rating!=0;");
			while (rs.next())
			{
				maxNumber += 1;
			}
			System.out.println(maxNumber);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return maxNumber;
	}
	public int[] getRatings(String district, int maxNumber)
	{
		int[] rating = new int[maxNumber];
		try 
		{

			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
			Connection con = DriverManager.getConnection(sqlurl, sqluser, sqlpass);
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("Select * from tblConcerns Where district = '" + district + "' AND rating!=0;");
			while (rs.next())
			{
				rating[rs.getRow() - 1] = rs.getInt("rating");
				System.out.println(rating[rs.getRow() - 1]);
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return rating;
	}
}
