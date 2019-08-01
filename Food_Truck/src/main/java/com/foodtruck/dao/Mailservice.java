package com.foodtruck.dao;

public interface Mailservice {
	
	public boolean send(String subject, String text, String from, String to);
	
}
