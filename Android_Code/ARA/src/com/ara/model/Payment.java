package com.ara.model;

import android.os.Parcel;
import android.os.Parcelable;

public class Payment implements Parcelable {
	
	private String paymentAccountInfoId, userID, paymentModeId, paypalEmail, isDefault, paymentMode,userFirstName,userLastName;

	 public Payment(Parcel source) {
		 paymentAccountInfoId = source.readString();
		 userID = source.readString();
		 paymentModeId = source.readString();
		 paypalEmail = source.readString();
		 isDefault = source.readString();
		 paymentMode = source.readString();
		 userFirstName=source.readString();
		 userLastName=source.readString();
	}
	 
	public Payment() {
		// TODO Auto-generated constructor stub
	}
	
	public String getPaymentAccountInfoId() {
		return paymentAccountInfoId;
	}

	public void setPaymentAccountInfoId(String paymentAccountInfoId) {
		this.paymentAccountInfoId = paymentAccountInfoId;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getPaymentModeId() {
		return paymentModeId;
	}

	public void setPaymentModeId(String paymentModeId) {
		this.paymentModeId = paymentModeId;
	}

	public String getPaypalEmail() {
		return paypalEmail;
	}

	public void setPaypalEmail(String paypalEmail) {
		this.paypalEmail = paypalEmail;
	}

	public String getIsDefault() {
		return isDefault;
	}

	public void setIsDefault(String isDefault) {
		this.isDefault = isDefault;
	}

	public String getPaymentMode() {
		return paymentMode;
	}

	public void setPaymentMode(String paymentMode) {
		this.paymentMode = paymentMode;
	}

	
	
	
	
	public static Parcelable.Creator<Payment> getCreator() {
		return CREATOR;
	}





	public static final Parcelable.Creator<Payment> CREATOR
	  = new Parcelable.Creator<Payment>() 
	{
	       public Payment createFromParcel(Parcel in) 
	       {
	           return new Payment(in);
	       }

	       public Payment[] newArray (int size) 
	       {
	           return new Payment[size];
	       }
	};

	@Override
	public int describeContents() {
		// TODO Auto-generated method stub
		return this.hashCode();
	}

	@Override
	public void writeToParcel(Parcel dest, int flags) {
		dest.writeString(paymentAccountInfoId);
		dest.writeString(userID);
		dest.writeString(paymentModeId);
		dest.writeString(paypalEmail);
		dest.writeString(isDefault);
		dest.writeString(paymentMode);
		dest.writeString(userFirstName);
		dest.writeString(userLastName);
	}

	public String getUserFirstName() {
		return userFirstName;
	}

	public void setUserFirstName(String userFirstName) {
		this.userFirstName = userFirstName;
	}

	public String getUserLastName() {
		return userLastName;
	}

	public void setUserLastName(String userLastName) {
		this.userLastName = userLastName;
	}
	
}
