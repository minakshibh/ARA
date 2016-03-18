package com.ara.model;

import android.os.Parcel;
import android.os.Parcelable;

public class Referral implements Parcelable {

	private String comments, createdDate, email, firstName, lastName, MeaID,
			MeaName, phoneNumber, referralId, referralStatus, referralType,
			referrerEmail, referrarId, referrerName, referrerUserName,
			soldDate, referralNumber, userDetailId,bothdate;

	
	 public Referral(Parcel source) {
		 comments = source.readString();
		 createdDate = source.readString();
		email= source.readString();
		firstName= source.readString();
		lastName= source.readString();
		MeaID= source.readString();
		MeaName= source.readString();
		phoneNumber= source.readString();
		
		referralId= source.readString();
		referralStatus= source.readString();
		referralType= source.readString();
		referrerEmail= source.readString();
		referrarId= source.readString();
		referrerName= source.readString();
		referrerUserName= source.readString();
		soldDate= source.readString();
		referralNumber= source.readString();
		userDetailId= source.readString();
		bothdate=source.readString();
		
	    }
	 
	public String getBothdate() {
		return bothdate;
	}

	public void setBothdate(String bothdate) {
		this.bothdate = bothdate;
	}

	public static Parcelable.Creator<Referral> getCreator() {
		return CREATOR;
	}

	public Referral() {
		// TODO Auto-generated constructor stub
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
	}

	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getMeaID() {
		return MeaID;
	}

	public void setMeaID(String meaID) {
		MeaID = meaID;
	}

	public String getMeaName() {
		return MeaName;
	}

	public void setMeaName(String meaName) {
		MeaName = meaName;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getReferralId() {
		return referralId;
	}

	public void setReferralId(String referralId) {
		this.referralId = referralId;
	}

	public String getReferralStatus() {
		return referralStatus;
	}

	public void setReferralStatus(String referralStatus) {
		this.referralStatus = referralStatus;
	}

	public String getReferralType() {
		return referralType;
	}

	public void setReferralType(String referralType) {
		this.referralType = referralType;
	}

	public String getReferrerEmail() {
		return referrerEmail;
	}

	public void setReferrerEmail(String referrerEmail) {
		this.referrerEmail = referrerEmail;
	}

	public String getReferrarId() {
		return referrarId;
	}

	public void setReferrarId(String referrarId) {
		this.referrarId = referrarId;
	}

	public String getReferrerName() {
		return referrerName;
	}

	public void setReferrerName(String referrerName) {
		this.referrerName = referrerName;
	}

	public String getReferrerUserName() {
		return referrerUserName;
	}

	public void setReferrerUserName(String referrerUserName) {
		this.referrerUserName = referrerUserName;
	}

	public String getSoldDate() {
		return soldDate;
	}

	public void setSoldDate(String soldDate) {
		this.soldDate = soldDate;
	}

	public String getReferralNumber() {
		return referralNumber;
	}

	public void setReferralNumber(String referralNumber) {
		this.referralNumber = referralNumber;
	}

	public String getUserDetailId() {
		return userDetailId;
	}

	public void setUserDetailId(String userDetailId) {
		this.userDetailId = userDetailId;
	}


	public static final Parcelable.Creator<Referral> CREATOR
	  = new Parcelable.Creator<Referral>() 
	{
	       public Referral createFromParcel(Parcel in) 
	       {
	           return new Referral(in);
	       }

	       public Referral[] newArray (int size) 
	       {
	           return new Referral[size];
	       }
	};

	@Override
	public int describeContents() {
		// TODO Auto-generated method stub
		return this.hashCode();
	}

	@Override
	public void writeToParcel(Parcel dest, int flags) {
		dest.writeString(comments);
		dest.writeString(createdDate);
		dest.writeString(email);
		dest.writeString(firstName);
		dest.writeString(lastName);
		dest.writeString(MeaID);
		dest.writeString(MeaName);
		dest.writeString(phoneNumber);
		
		dest.writeString(referralId);
		dest.writeString(referralStatus);
		dest.writeString(referralType);
		dest.writeString(referrerEmail);
		dest.writeString(referrarId);
		dest.writeString(referrerName);
		dest.writeString(referrerUserName);
		dest.writeString(soldDate);
		dest.writeString(referralNumber);
		dest.writeString(userDetailId);
		dest.writeString(bothdate);
	}
}
