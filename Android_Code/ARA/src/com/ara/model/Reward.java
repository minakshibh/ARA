package com.ara.model;

import android.os.Parcel;
import android.os.Parcelable;

public class Reward implements Parcelable{

	String RewardAmount,RewardType,Rewardlevel,RewardName,RewardDescription,IsReceived,ReceivedDate,reward_CreatedDate,TransactionID;
	String Referral,ReferralId,UniqueReferralNumber,ReferrerID,FirstName,LastName,PhoneNumber,Email,Comments,SoldDate,CreatedDate,
	MeaId,UserDetailId,ReferrerUserName,ReferrerName,ReferrerEmail,ReferralStatus,ReferralType,MeaName;
	
	
	
	public Reward(Parcel source) {
		RewardAmount = source.readString();
		RewardType = source.readString();
		Rewardlevel = source.readString();
		RewardName = source.readString();
		RewardDescription = source.readString();
	    IsReceived = source.readString();
		ReceivedDate = source.readString();
		CreatedDate = source.readString();
		TransactionID = source.readString();
	
		ReferralId = source.readString();
		
		
		UniqueReferralNumber = source.readString();
		FirstName = source.readString();
		LastName = source.readString();
		PhoneNumber = source.readString();
		Email = source.readString();
		 
		Comments = source.readString();
		SoldDate = source.readString();
		
		CreatedDate= source.readString();
		MeaName = source.readString();
		
		ReferralType =source.readString();
		ReferralStatus=source.readString();
		 
	}
	
	public Reward() {
		// TODO Auto-generated constructor stub
	}

	
	public String getRewardAmount() {
		return RewardAmount;
	}

	public void setRewardAmount(String rewardAmount) {
		RewardAmount = rewardAmount;
	}

	public String getRewardType() {
		return RewardType;
	}

	public void setRewardType(String rewardType) {
		RewardType = rewardType;
	}

	public String getRewardlevel() {
		return Rewardlevel;
	}

	public void setRewardlevel(String rewardlevel) {
		Rewardlevel = rewardlevel;
	}

	public String getRewardName() {
		return RewardName;
	}

	public void setRewardName(String rewardName) {
		RewardName = rewardName;
	}

	public String getRewardDescription() {
		return RewardDescription;
	}

	public void setRewardDescription(String rewardDescription) {
		RewardDescription = rewardDescription;
	}

	public String getIsReceived() {
		return IsReceived;
	}

	public void setIsReceived(String isReceived) {
		IsReceived = isReceived;
	}

	public String getReceivedDate() {
		return ReceivedDate;
	}

	public void setReceivedDate(String receivedDate) {
		ReceivedDate = receivedDate;
	}

	public String getReward_CreatedDate() {
		return reward_CreatedDate;
	}

	public void setReward_CreatedDate(String reward_CreatedDate) {
		this.reward_CreatedDate = reward_CreatedDate;
	}

	public String getTransactionID() {
		return TransactionID;
	}

	public void setTransactionID(String transactionID) {
		TransactionID = transactionID;
	}

	public String getReferral() {
		return Referral;
	}

	public void setReferral(String referral) {
		Referral = referral;
	}

	public String getReferralId() {
		return ReferralId;
	}

	public void setReferralId(String referralId) {
		ReferralId = referralId;
	}

	public String getUniqueReferralNumber() {
		return UniqueReferralNumber;
	}

	public void setUniqueReferralNumber(String uniqueReferralNumber) {
		UniqueReferralNumber = uniqueReferralNumber;
	}

	public String getReferrerID() {
		return ReferrerID;
	}

	public void setReferrerID(String referrerID) {
		ReferrerID = referrerID;
	}

	public String getFirstName() {
		return FirstName;
	}

	public void setFirstName(String firstName) {
		FirstName = firstName;
	}

	public String getLastName() {
		return LastName;
	}

	public void setLastName(String lastName) {
		LastName = lastName;
	}

	public String getPhoneNumber() {
		return PhoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		PhoneNumber = phoneNumber;
	}

	public String getEmail() {
		return Email;
	}

	public void setEmail(String email) {
		Email = email;
	}

	public String getComments() {
		return Comments;
	}

	public void setComments(String comments) {
		Comments = comments;
	}

	public String getSoldDate() {
		return SoldDate;
	}

	public void setSoldDate(String soldDate) {
		SoldDate = soldDate;
	}

	public String getCreatedDate() {
		return CreatedDate;
	}

	public void setCreatedDate(String createdDate) {
		CreatedDate = createdDate;
	}

	public String getMeaId() {
		return MeaId;
	}

	public void setMeaId(String meaId) {
		MeaId = meaId;
	}

	public String getUserDetailId() {
		return UserDetailId;
	}

	public void setUserDetailId(String userDetailId) {
		UserDetailId = userDetailId;
	}

	public String getReferrerUserName() {
		return ReferrerUserName;
	}

	public void setReferrerUserName(String referrerUserName) {
		ReferrerUserName = referrerUserName;
	}

	public String getReferrerName() {
		return ReferrerName;
	}

	public void setReferrerName(String referrerName) {
		ReferrerName = referrerName;
	}

	public String getReferrerEmail() {
		return ReferrerEmail;
	}

	public void setReferrerEmail(String referrerEmail) {
		ReferrerEmail = referrerEmail;
	}

	public String getReferralStatus() {
		return ReferralStatus;
	}

	public void setReferralStatus(String referralStatus) {
		ReferralStatus = referralStatus;
	}

	public String getReferralType() {
		return ReferralType;
	}

	public void setReferralType(String referralType) {
		ReferralType = referralType;
	}

	public String getMeaName() {
		return MeaName;
	}

	public void setMeaName(String meaName) {
		MeaName = meaName;
	}

	

	
	/*[{"RewardAmount":200.000,"RewardType":"Money","Rewardlevel":"Level 1","RewardName":"Level 1 Incentive","RewardDescription":
		"Incentive Reward","IsReceived":false,"ReceivedDate":null,"CreatedDate":"2015-16-09 3:55:32 PM","TransactionID":null,"Referral":
	
		{"ReferralId":105,"UniqueReferralNumber":"#Ref1537943429","ReferrerID":148,"FirstName":"parv1","LastName":"kis",
		"PhoneNumber":"5645645645","Email":"parv1@gmail.com","Comments":"this is for testing.",
		"SoldDate":"2015-16-09 3:55:32 PM","CreatedDate":"2015-14-09 4:33:41 PM","MeaId":148,"UserDetailId":0,
		"ReferrerUserName":"parv","ReferrerName":"Pa123 Pa123","ReferrerEmail":"parv.kis@gmail.com","ReferralStatus":"sold",
		"ReferralType":"Chained","MeaName":"Pa123 Kisrv123"}}]*/

	

	
	
	
	
	
	
	public static final Parcelable.Creator<Reward> CREATOR
	  = new Parcelable.Creator<Reward>() 
	{
	       public Reward createFromParcel(Parcel in) 
	       {
	           return new Reward(in);
	       }

	       public Reward[] newArray (int size) 
	       {
	           return new Reward[size];
	       }
	};
	@Override
	public int describeContents() {
		// TODO Auto-generated method stub
		return this.hashCode();
	}
	@Override
	public void writeToParcel(Parcel dest, int flags) {
		
				
		dest.writeString(RewardAmount);
		dest.writeString(RewardType);
		dest.writeString(Rewardlevel);
		dest.writeString(RewardName);
		dest.writeString(RewardDescription);
		dest.writeString(IsReceived);
		
		dest.writeString(ReceivedDate);
		dest.writeString(CreatedDate);
		dest.writeString(TransactionID);
		dest.writeString(ReferralId);
		
		
		dest.writeString(UniqueReferralNumber);
		dest.writeString(FirstName);
		
		dest.writeString(LastName);
		dest.writeString(PhoneNumber);
		
		dest.writeString(Email);
		dest.writeString(Comments);
		
		dest.writeString(SoldDate);
		dest.writeString(CreatedDate);
		dest.writeString(MeaName);
		
		dest.writeString(ReferralType);
		dest.writeString(ReferralStatus);
		
	}
}
