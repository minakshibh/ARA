package com.ara.model;

public class ReferralType {

	private String Type, Amount, Count,NotificationCount;
	
	public String getNotificationCount() {
		return NotificationCount;
	}

	public void setNotificationCount(String notificationCount) {
		NotificationCount = notificationCount;
	}

	public String getType() {
		return Type;
	}

	public void setType(String type) {
		Type = type;
	}

	public String getAmount() {
		return Amount;
	}

	public void setAmount(String amount) {
		Amount = amount;
	}

	public String getCount() {
		return Count;
	}

	public void setCount(String count) {
		Count = count;
	}
}
