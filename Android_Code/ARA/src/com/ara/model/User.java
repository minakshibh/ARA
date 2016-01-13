package com.ara.model;

import android.os.Parcel;
import android.os.Parcelable;

public class User implements Parcelable {

	String UserId, UserName, Password, RoleID, FirstName, LastName,
			PhoneNumber, Email, IsFacebookUser, PurchasedBefore,
			ProfilePicName, MEAID, MEAName, RoleName, UserType, UserDetailId,UserToken;

	
	
	 public  User(Parcel source) {
		 UserId = source.readString();
		 UserName = source.readString();
		 Password = source.readString();
		 RoleID = source.readString();
		 FirstName = source.readString();
		 LastName = source.readString();
		 Email=source.readString();
		 PhoneNumber=source.readString();
				 
		
	}
	 
	public User() {
		// TODO Auto-generated constructor stub
	}
	
	
	public String getUserId() {
		return UserId;
	}

	public void setUserId(String userId) {
		UserId = userId;
	}

	public String getUserName() {
		return UserName;
	}

	public void setUserName(String userName) {
		UserName = userName;
	}

	public String getPassword() {
		return Password;
	}

	public void setPassword(String password) {
		Password = password;
	}

	public String getRoleID() {
		return RoleID;
	}

	public void setRoleID(String roleID) {
		RoleID = roleID;
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

	public String getIsFacebookUser() {
		return IsFacebookUser;
	}

	public void setIsFacebookUser(String isFacebookUser) {
		IsFacebookUser = isFacebookUser;
	}

	public String getPurchasedBefore() {
		return PurchasedBefore;
	}

	public void setPurchasedBefore(String purchasedBefore) {
		PurchasedBefore = purchasedBefore;
	}

	public String getProfilePicName() {
		return ProfilePicName;
	}

	public void setProfilePicName(String profilePicName) {
		ProfilePicName = profilePicName;
	}

	public String getMEAID() {
		return MEAID;
	}

	public void setMEAID(String mEAID) {
		MEAID = mEAID;
	}

	public String getMEAName() {
		return MEAName;
	}

	public void setMEAName(String mEAName) {
		MEAName = mEAName;
	}

	public String getRoleName() {
		return RoleName;
	}

	public void setRoleName(String roleName) {
		RoleName = roleName;
	}

	public String getUserType() {
		return UserType;
	}

	public void setUserType(String userType) {
		UserType = userType;
	}

	public String getUserDetailId() {
		return UserDetailId;
	}

	public void setUserDetailId(String userDetailId) {
		UserDetailId = userDetailId;
	}

	public String getUserToken() {
		return UserToken;
	}

	public void setUserToken(String userToken) {
		UserToken = userToken;
	}

	
	
	
	
	
	
	public static final Parcelable.Creator<User> CREATOR
	  = new Parcelable.Creator<User>() 
	{
	       public User createFromParcel(Parcel in) 
	       {
	           return new User(in);
	       }

	       public User[] newArray (int size) 
	       {
	           return new User[size];
	       }
	};

	public int describeContents() {
		// TODO Auto-generated method stub
		return this.hashCode();
	}

	@Override
	public void writeToParcel(Parcel dest, int flags) {
	
		dest.writeString(UserId);
		dest.writeString(UserName);
		dest.writeString(Password);
		dest.writeString(RoleID);
		dest.writeString(FirstName);
		dest.writeString(LastName);
		dest.writeString(Email);
		dest.writeString(PhoneNumber);
	}
}
