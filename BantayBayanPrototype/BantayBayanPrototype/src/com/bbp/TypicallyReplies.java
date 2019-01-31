package com.bbp;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.temporal.ChronoUnit;
import java.time.temporal.Temporal;
public class TypicallyReplies
{	
	String sql;
	String sqlurl = "jdbc:mysql://localhost:3306/bbp";
	String sqluser = "root";
	String sqlpass = "33sqltestpass33";
	public String getFinalTime(String district)
	{
		TypicallyReplies tr = new TypicallyReplies();

		int maxNumber = tr.getMaxTimesofReplies(district);
		long[] time = tr.getTime(district, maxNumber);
		System.out.println("starting for loop. Time is: " + time[0] + "and maxNumber is:" + maxNumber) ;
		long finalTime = 0;
		String stringFinalTime = null;
		
		if(maxNumber == 1) {
			finalTime = time[0];
		}
		else {
			for(int i = 0; i <= maxNumber; i++) {
				
				finalTime = finalTime + (time[i] + time[i]);
				System.out.println(finalTime);
			}
			finalTime = finalTime / maxNumber;
		}
		
		if (finalTime < 60) {
			stringFinalTime = String.valueOf(finalTime) + " second/s";
		}
		else if (finalTime < 3600) {
			stringFinalTime = String.valueOf(finalTime) + " minute/s";
		}
		else if (finalTime < 86400) {
			stringFinalTime = String.valueOf(finalTime) + " hour/s";
		}
		else if (finalTime < 604800) {
			stringFinalTime = String.valueOf(finalTime) + " day/s";
		}
		else {
			stringFinalTime = "no data available";
		}
		System.out.println("string final tiem: " + stringFinalTime);
		return stringFinalTime;
	}
	
	public int[] getConcernIDArray(String district) {
		TypicallyReplies tr = new TypicallyReplies();
		
		int[] concernIDArray = new int[tr.getMaxPost(district)];
		try 
		{
			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
			Connection con = DriverManager.getConnection(sqlurl, sqluser, sqlpass);
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("SELECT concernID from tblConcerns WHERE district='" + district + "' AND replyStatus='Replied';");
			
			int i = 0;
			while (rs.next())
			{
				concernIDArray[i] = rs.getInt("concernID");
				i++;
			}
		}
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		
		return concernIDArray;
	}
	
	public int getMaxPost(String district)
	{
		int maxPost = 0;
		try 
		{
			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
			Connection con = DriverManager.getConnection(sqlurl, sqluser, sqlpass);
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("Select COUNT(concernid) from tblConcerns WHERE district='" + district + "' AND replyStatus='Replied' ;");
			while (rs.next())
			{
				maxPost = rs.getInt("COUNT(concernid)");
			}
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		return maxPost;
	}
	public int getMaxTimesofReplies(String district)
	{
		int maxNumber = 0;
		try
		{
			TypicallyReplies tr = new TypicallyReplies();
			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
			Connection con = DriverManager.getConnection(sqlurl, sqluser, sqlpass);
			Statement st = con.createStatement();
			int maxPost = tr.getMaxPost(district);
			for (int i = 0; i <= maxPost; i++) 
			{
				ResultSet rs = st.executeQuery(
						"SELECT dateCommented FROM tblcomments WHERE tblcomments.title='" + district + "';");
				while (rs.next()) {
					maxNumber = rs.getInt("COUNT(*)");
				} 
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return maxNumber;
	}
	public long[] getTime(String district, int maxNumber)
	{
		Temporal[] t1 = new Temporal[maxNumber];
		
		Instant[] id = new Instant[maxNumber];
		Instant[] id2 = new Instant[maxNumber];
		
		Date[] dateTimeComment = new Date[maxNumber];
		Date[] dateTimePost = new Date[maxNumber];
		
		LocalDate[] dateComment = new LocalDate[maxNumber];
		LocalTime[] timeComment = new LocalTime[maxNumber];
		LocalDate[] datePost = new LocalDate[maxNumber];
		LocalTime[] timePost = new LocalTime[maxNumber];
		LocalDateTime[] ldtComment = new LocalDateTime[maxNumber];
		LocalDateTime[] ldtPost = new LocalDateTime[maxNumber];
		
		String[] joiner1 = new String[maxNumber];
		String joiner2[] = new String[maxNumber];
		
		TypicallyReplies tr = new TypicallyReplies();
		try
		{
			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
			Connection con = DriverManager.getConnection(sqlurl, sqluser, sqlpass);
			Statement st = con.createStatement();
			int maxPost = tr.getMaxPost(district);
			for(int i = 0 ; i <= maxPost; i++)
			{
				System.out.println("MAXPOST AY " + maxPost);
				System.out.println("MAXNumber AY " + maxNumber);
				ResultSet rs = st.executeQuery("SELECT tblconcerns.postdate, tblcomments.dateCommented FROM tblconcerns, tblcomments WHERE tblconcerns.concernID = " + i+1 + " AND tblcomments.title='" + district + "' limit 1");	
				while (rs.next())
				{
					dateComment[i] = rs.getDate(2).toLocalDate();
					timeComment[i] = rs.getTime(2).toLocalTime();
					datePost[i] = rs.getDate(1).toLocalDate();
					timePost[i] = rs.getTime(1).toLocalTime();
					
					ldtComment[i] = LocalDateTime.of(dateComment[i], timeComment[i]);
					ldtPost[i] = LocalDateTime.of(datePost[i], timePost[i]);
				}
			}
		}
		catch (SQLException e) 
		{
			e.printStackTrace();
		}

		SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
		
		
		String sfdtc = null;
		String sfdtp = null;
		
		long[] seconds = new long[maxNumber];
		
		long[] minutes = new long[maxNumber];
				
		long[] hours = new long[maxNumber];
				
		
		long[] time = new long[maxNumber];
		System.out.println("sstart");
		for (int i = 0; i < maxNumber; i++)
		{
			hours[i]= ChronoUnit.SECONDS.between(ldtPost[i], ldtComment[i]);
			System.out.println("final " + i + ": " + minutes[i]);
			
			
			/*
			sfdtc = String.valueOf(dateComment[i]) + " " + String.valueOf(timeComment[i]);
			System.out.println("FINAL DATE TIME COMMENT: " + sfdtc);
			sfdtp = String.valueOf(datePost[i]) + " " + String.valueOf(timePost[i]);
			System.out.println(sfdtp);
			System.out.println("AAAAAAAAAAA");
			time[i] = Long.parseLong(sfdtc) - Long.parseLong(sfdtp);
			System.out.println("WOOOOOOO");
			System.out.println("FINAL TIME: " + time[i]);
			*/
		}
		
		return hours;
	}
	
	/****************************************************************************************************************************************************************************************************************/
	
	public String typical(String district) {
		System.out.println("1get total concerns directed to the district and pass it to an integer");
		// get total concerns directed to the district and pass it to an integer
		int concernIDArrIndex = 0;
		try 
		{
			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
			Connection con = DriverManager.getConnection(sqlurl, sqluser, sqlpass);
			PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM tblConcerns WHERE district=? AND replyStatus='Replied';");
			ps.setString(1, district);
			ResultSet rs = ps.executeQuery();
			int i = 0;
			while (rs.next())
			{
				concernIDArrIndex = rs.getInt("COUNT(*)");
			}
			System.out.println("1Cget total concerns directed to the district and pass it to an integer COMPLETE");
			System.out.println("The concernIDArrIndex is: " + concernIDArrIndex);
			ps.close();
			rs.close();
			con.close();
		}
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		
		System.out.println("2get concernID's of concerns that is directed to the district and pass it to an array");
		// get concernID's of concerns that is directed to the district and pass it to an array
		int[] concernIDArr = new int[concernIDArrIndex];
		try 
		{
			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
			Connection con = DriverManager.getConnection(sqlurl, sqluser, sqlpass);
			PreparedStatement ps = con.prepareStatement("SELECT * FROM tblConcerns WHERE district=? AND replyStatus='Replied';");
			ps.setString(1, district);
			ResultSet rs = ps.executeQuery();
			int i = 0;
			while (rs.next())
			{
				concernIDArr[i] = rs.getInt("concernID");
				System.out.println("This district's concernID posts are: " + concernIDArr[i]);
				i++;
			}
			
			System.out.println("2Cget concernID's of concerns that is directed to the district and pass it to an array COMPLETE");
			ps.close();
			rs.close();
			con.close();
		}
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		
		System.out.println("3get all concern's postDate that is directed to a district and pass it to an array");
		// get all concern's postDate that is directed to a district and pass it to an array
		int[] postDateArr = new int[concernIDArrIndex];
		
		LocalDate[] datePost = new LocalDate[concernIDArrIndex];
		LocalTime[] timePost = new LocalTime[concernIDArrIndex];
		LocalDateTime[] ldtPost = new LocalDateTime[concernIDArrIndex];
		try 
		{
			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
			Connection con = DriverManager.getConnection(sqlurl, sqluser, sqlpass);
			PreparedStatement ps = null;
			ResultSet rs = null;
			for(int i = 0; i < concernIDArrIndex; i++) {
				System.out.println("3 FOR LOOP, i= " + i);
				ps = con.prepareStatement("SELECT postdate FROM tblConcerns WHERE district=? AND concernID=? ORDER BY postdate");
				ps.setString(1, district);
				System.out.println("Ano bang laman ng concerIDArr: " + concernIDArr[i]);
				ps.setInt(2, concernIDArr[i]);
				rs = ps.executeQuery();
				while (rs.next())
				{
					System.out.println("result set date: " + rs.getDate("postdate").toLocalDate());
					datePost[i] = rs.getDate("postdate").toLocalDate();
					timePost[i] = rs.getTime("postdate").toLocalTime();
					
					ldtPost[i] = LocalDateTime.of(datePost[i], timePost[i]);
					System.out.println(ldtPost[i]);
				}
				System.out.println("3Cget all concern's postDate that is directed to a district and pass it to an array COMPLETE");
				
			}
			ps.close();
			rs.close();
			con.close();
			
			
		}
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		
		System.out.println("4get all the district's first dateCommented in a concern and pass it to an array");
		// get all the district's first dateCommented in a concern and pass it to an array
		int[] dateCommentedArr = new int[concernIDArrIndex];
		
		LocalDate[] dateComment = new LocalDate[concernIDArrIndex];
		LocalTime[] timeComment = new LocalTime[concernIDArrIndex];
		LocalDateTime[] ldtComment = new LocalDateTime[concernIDArrIndex];
		try 
		{
			
			for(int i = 0; i < concernIDArrIndex; i++) {
				DriverManager.registerDriver(new com.mysql.jdbc.Driver());
				Connection con = DriverManager.getConnection(sqlurl, sqluser, sqlpass);
				PreparedStatement ps = con.prepareStatement("SELECT dateCommented FROM tblComments WHERE title=? AND concernID=? ORDER BY dateCommented LIMIT 1");
				ps.setString(1, district);
				ps.setInt(2, concernIDArr[i]);
				ResultSet rs = ps.executeQuery();
				while (rs.next())
				{
					dateComment[i] = rs.getDate("dateCommented").toLocalDate();
					timeComment[i] = rs.getTime("dateCommented").toLocalTime();
					
					ldtComment[i] = LocalDateTime.of(dateComment[i], timeComment[i]);
					System.out.println(ldtComment[i]);
				}
				System.out.println("4Cget all the district's first dateCommented in a concern and pass it to an array COMPLETE");
				ps.close();
				rs.close();
				con.close();
			}

			
		}
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		
		System.out.println("g5et the average of all typically replies difference of every concern directed to a district");
		// get the average of all typically replies difference of every concern directed to a district
		long[] differenceInSeconds = new long[concernIDArrIndex];
		for(int i = 0; i < concernIDArrIndex; i++) {
			System.out.println("now getting the diferrence of " + ldtPost[i] + " and " + ldtComment[i]);
			differenceInSeconds[i] = ChronoUnit.SECONDS.between(ldtPost[i], ldtComment[i]);
		}
		
		System.out.println("6if theres only one pair of dates, do not get the average");
		// if theres only one pair of dates, do not get the average
		long finalTime = 0;
		if(concernIDArrIndex == 1) {
			finalTime = differenceInSeconds[0];
		}
		else {
			for(int i = 0; i < concernIDArrIndex-1; i++) {
				finalTime = finalTime + (differenceInSeconds[i] + differenceInSeconds[i+1]);
				
			}
			finalTime = finalTime / concernIDArrIndex;
			System.out.println(finalTime);
		}
		
		String stringFinalTime = null;
		if (finalTime < 60) {
			stringFinalTime = String.valueOf(finalTime) + " second/s";
		}
		else if (finalTime < 3600) {
			finalTime = finalTime / 60;
			stringFinalTime = String.valueOf(finalTime) + " minute/s";
		}
		else if (finalTime < 86400) {
			finalTime = (finalTime / 60) / 60;
			stringFinalTime = String.valueOf(finalTime) + " hour/s";
		}
		else if (finalTime < 604800) {
			finalTime = ((finalTime / 60) / 60) / 24;
			stringFinalTime = String.valueOf(finalTime) + " day/s";
		}
		else {
			stringFinalTime = "no data available";
		}
		System.out.println("string final tiem: " + stringFinalTime);
		
		System.out.println("5Cget the average of all typically replies difference of every concern directed to a district COMPLETE");
		
		return stringFinalTime;
	}
	
	
	
	
	
	
}