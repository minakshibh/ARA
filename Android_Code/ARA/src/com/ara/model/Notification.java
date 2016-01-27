package com.ara.model;

public class Notification {

	String title,date,description,read;
	int id;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Notification(String string, String string2, String date,String string3) {
		 
	        this.title = string;
	        this.description = string2;
	        this.date = date;
	        this.read = string3;// TODO Auto-generated constructor stub
	}
	public Notification(int id,String string, String string2,String date, String string3) {
		
		 this.id=id;
        this.title = string;
        this.description = string2;
        this.date = date;
        this.read = string3;// TODO Auto-generated constructor stub
}

	public Notification() {
		// TODO Auto-generated constructor stub
	}

	public String getRead() {
		return read;
	}

	public void setRead(String read) {
		this.read = read;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
}
