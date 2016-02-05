package com.ara.model;

public class Notification {

	
	int id;
	
String NotificationTypeId,NotificationTitle,NotificationText,IsScheduled,ScheduledAt,CreatedDate,ModifiedDate,read,userID;
	public String getUserID() {
	return userID;
}

public void setUserID(String userID) {
	this.userID = userID;
}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Notification(String title, String des, String date,String string3) {
		 
	        this.NotificationTitle = title;
	        this.NotificationText = des;
	        this.CreatedDate = date;
	        this.read = string3;// TODO Auto-generated constructor stub
	}
	public Notification(int id,String title, String des,String date, String read) {
		
		 this.id=id;
        this.NotificationTitle = title;
        this.NotificationText = des;
        this.CreatedDate = date;
        this.read = read;// TODO Auto-generated constructor stub
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
