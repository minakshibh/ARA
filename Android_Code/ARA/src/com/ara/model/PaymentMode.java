package com.ara.model;

public class PaymentMode {

	private String modeName, modeID;

	public String getModeName() {
		return modeName;
	}

	public void setModeName(String modeName) {
		this.modeName = modeName;
	}

	public String getModeID() {
		return modeID;
	}

	public void setModeID(String modeID) {
		this.modeID = modeID;
	}
	
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return modeName;
	}
}
