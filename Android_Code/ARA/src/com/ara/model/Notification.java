package com.ara.model;

public class Notification {

	String title,date,description,read;
	int id;
String NotificationTypeId,NotificationTitle,NotificationText,IsScheduled,ScheduledAt,CreatedDate,ModifiedDate;
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

	public String getNotificationTypeId() {
		return NotificationTypeId;
	}

	public void setNotificationTypeId(String notificationTypeId) {
		NotificationTypeId = notificationTypeId;
	}

	public String getNotificationTitle() {
		return NotificationTitle;
	}

	public void setNotificationTitle(String notificationTitle) {
		NotificationTitle = notificationTitle;
	}

	public String getNotificationText() {
		return NotificationText;
	}

	public void setNotificationText(String notificationText) {
		NotificationText = notificationText;
	}

	public String getIsScheduled() {
		return IsScheduled;
	}

	public void setIsScheduled(String isScheduled) {
		IsScheduled = isScheduled;
	}

	public String getScheduledAt() {
		return ScheduledAt;
	}

	public void setScheduledAt(String scheduledAt) {
		ScheduledAt = scheduledAt;
	}

	public String getCreatedDate() {
		return CreatedDate;
	}

	public void setCreatedDate(String createdDate) {
		CreatedDate = createdDate;
	}

	public String getModifiedDate() {
		return ModifiedDate;
	}

	public void setModifiedDate(String modifiedDate) {
		ModifiedDate = modifiedDate;
	}
	
}
