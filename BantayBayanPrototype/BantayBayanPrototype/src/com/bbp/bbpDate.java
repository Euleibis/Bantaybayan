package com.bbp;

public class bbpDate {
	public String addZero (int getHourOrMinute){
		String result = String.valueOf(getHourOrMinute);
		if(getHourOrMinute <= 9) {
			result = "0" + String.valueOf(getHourOrMinute);
		}
		return result;
	}
}