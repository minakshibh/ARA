package com.ara.model;

public class TimeSlot {
	String Id, timeSlot;

	public String getTimeSlot() {
		return timeSlot;
	}

	public void setTimeSlot(String timeSlot) {
		this.timeSlot = timeSlot;
	}

	public String getId() {
		return Id;
	}

	public void setId(String id) {
		Id = id;
	}
	public TimeSlot(String timeSlot, String Id) {

		this.timeSlot = timeSlot;
		this.Id = Id;
		

	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return timeSlot;
	}
}
