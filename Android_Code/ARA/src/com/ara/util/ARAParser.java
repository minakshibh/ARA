package com.ara.util;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.ara.model.Badge;
import com.ara.model.MEA;
import com.ara.model.Notification;
import com.ara.model.Payment;
import com.ara.model.PaymentMode;
import com.ara.model.Referral;
import com.ara.model.ReferralEarn;
import com.ara.model.ReferralType;
import com.ara.model.Reward;
import com.ara.model.Role;
import com.ara.model.ScoreBoard;
import com.ara.model.User;


import android.content.Context;

public class ARAParser {
	public Context mContext;

	

	public ARAParser(Context ctx) {
		ctx = mContext;
	}

	public ArrayList<MEA> parseMEAResponse(String response) {
		ArrayList<MEA> array_list_MEA = new ArrayList<MEA>();
		// MEA_Model mea_Model1 = new MEA_Model();
		MEA mea_Model = null;
		mea_Model = new MEA();
		mea_Model.setId("-1");
		mea_Model.setName("Select MEA");
		array_list_MEA.add(mea_Model);
		try {
			JSONArray jsonArray = new JSONArray(response);
			for (int i = 0; i < jsonArray.length(); i++) {
				JSONObject jsonObject = jsonArray.getJSONObject(i);

				mea_Model = new MEA(jsonObject.getString("Name"),
						jsonObject.getString("ID"),jsonObject.getString("Email"));

				array_list_MEA.add(mea_Model);
			}

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return array_list_MEA;
	}

	public ArrayList<Role> parseRoleResponse(String response) {
		ArrayList<Role> array_list_role = new ArrayList<Role>();
		Role mea_Model = null;
		mea_Model = new Role();
		mea_Model.setId("-1");
		mea_Model.setName("Select Role");
		array_list_role.add(mea_Model);

		try {
			JSONArray jsonArray = new JSONArray(response);
			for (int i = 0; i < jsonArray.length(); i++) {
				JSONObject jsonObject = jsonArray.getJSONObject(i);

				mea_Model = new Role();
				mea_Model.setName(jsonObject.getString("Name").toString());
				mea_Model.setId(jsonObject.getString("ID").toString());
				array_list_role.add(mea_Model);
				System.err.println("add role");
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return array_list_role;
	}

	public ArrayList<Payment> parsePaymentListResponse(String response) {
		ArrayList<Payment> paymentList = new ArrayList<Payment>();
		
		try {
			JSONArray jsonArray = new JSONArray(response);
			for (int i = 0; i < jsonArray.length(); i++) {
				JSONObject jsonObject = jsonArray.getJSONObject(i);
				
				Payment paymentObject = new Payment();

				paymentObject.setPaymentAccountInfoId(jsonObject.getString("PaymentAccountInfoId").toString());
				paymentObject.setUserID(jsonObject.getString("UserId").toString());
				paymentObject.setPaymentModeId(jsonObject.getString("PaymentModeID").toString());
				paymentObject.setPaypalEmail(jsonObject.getString("PaypalEmail").toString());
				paymentObject.setIsDefault(jsonObject.getString("IsDefault").toString());
				paymentObject.setPaymentMode(jsonObject.getString("PaymentModeName").toString());
				
				paymentList.add(paymentObject);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return paymentList;
	}
	
	public ArrayList<PaymentMode> parsePaymentModeResponse(String response) {
		ArrayList<PaymentMode> paymentModeList = new ArrayList<PaymentMode>();
		
		PaymentMode paymentModeObject = null;
		paymentModeObject = new PaymentMode();
		//paymentModeObject.setModeID("-1");
		//paymentModeObject.setModeName("Select Payment Mode");
		//paymentModeList.add(paymentModeObject);
		
		try {
			JSONArray jsonArray = new JSONArray(response);
			for (int i = 0; i < jsonArray.length(); i++) {
				JSONObject jsonObject = jsonArray.getJSONObject(i);
				
				paymentModeObject = new PaymentMode();

				paymentModeObject.setModeName(jsonObject.getString("Name").toString());
				paymentModeObject.setModeID(jsonObject.getString("ID").toString());
				
				paymentModeList.add(paymentModeObject);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return paymentModeList;
	}
	
	public User parseSignUpResponse(String response) {
	
		User user_Model = null;

		try {
		
			JSONObject jsonObject = new JSONObject(response);

			user_Model = new User();
			user_Model.setUserId(jsonObject.getString("UserId").toString());
			user_Model.setUserName(jsonObject.getString("UserName").toString());
			user_Model.setPassword(jsonObject.getString("Password").toString());
			user_Model.setRoleID(jsonObject.getString("RoleID").toString());
			user_Model.setFirstName(jsonObject.getString("FirstName")
					.toString());
			user_Model.setLastName(jsonObject.getString("LastName").toString());
			user_Model.setPhoneNumber(jsonObject.getString("PhoneNumber")
					.toString());
			user_Model.setEmail(jsonObject.getString("Email").toString());
			user_Model.setIsFacebookUser(jsonObject.getString("IsFacebookUser")
					.toString());
			user_Model.setPurchasedBefore(jsonObject.getString(
					"PurchasedBefore").toString());
			user_Model.setProfilePicName(jsonObject.getString("ProfilePicName")
					.toString());
			user_Model.setMEAID(jsonObject.getString("MEAID").toString());
			user_Model.setMEAName(jsonObject.getString("MEAName").toString());
			user_Model.setRoleName(jsonObject.getString("RoleName").toString());
			user_Model.setUserType(jsonObject.getString("UserType").toString());
			user_Model.setUserDetailId(jsonObject.getString("UserDetailId").toString());
			try{
			user_Model.setUserToken(jsonObject.getString("UserToken").toString());
			}
			catch(Exception e)
			{
				
			}
		
			System.err.println("add role");
			return user_Model;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}

	}
	public ArrayList<ReferralType> parseDashboardContent(String response) {
		ArrayList<ReferralType> referralTypeArray = new ArrayList<ReferralType>();

		try {
			ReferralType referralType = null;
			JSONObject DashboardResult = new JSONObject(response);
			JSONArray jsonArray = DashboardResult.getJSONArray("DashboardResult");
			for (int i = 0; i < jsonArray.length(); i++) {
				JSONObject jsonObject = jsonArray.getJSONObject(i);

				 referralType = new ReferralType();
				referralType.setAmount(jsonObject.getString("Amount")
						.toString());
				referralType.setCount(jsonObject.getString("ReferralCount")
						.toString());
				referralType.setType(jsonObject.getString("ReferralType")
						.toString());
				referralType.setNotificationCount(DashboardResult.getString("NotificationsCount"));
				referralTypeArray.add(referralType);
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return referralTypeArray;
	}
	
	public ArrayList<Referral> parseReferralList(String response) {
		ArrayList<Referral> referralArray = new ArrayList<Referral>();
		
		try {
			JSONArray jsonArray = new JSONArray(response);
			for (int i = 0; i < jsonArray.length(); i++) {
				JSONObject jsonObject = jsonArray.getJSONObject(i);

				Referral referral = new Referral();
				referral.setComments(jsonObject.getString("Comments")
						.toString());
				referral.setCreatedDate(jsonObject.getString("CreatedDate")
						.toString());
				referral.setEmail(jsonObject.getString("Email")
						.toString());
				referral.setFirstName(jsonObject.getString("FirstName")
						.toString());
				referral.setLastName(jsonObject.getString("LastName")
						.toString());
				referral.setMeaID(jsonObject.getString("MeaId")
						.toString());
				referral.setMeaName(jsonObject.getString("MeaName")
						.toString());
				referral.setPhoneNumber(jsonObject.getString("PhoneNumber")
						.toString());
				referral.setReferralId(jsonObject.getString("ReferralId")
						.toString());
				referral.setReferralStatus(jsonObject.getString("ReferralStatus")
						.toString());
				referral.setReferralType(jsonObject.getString("ReferralType")
						.toString());
				referral.setReferrerEmail(jsonObject.getString("ReferrerEmail")
						.toString());
				referral.setReferralId(jsonObject.getString("ReferrerID")
						.toString());
				referral.setReferrerName(jsonObject.getString("ReferrerName")
						.toString());
				referral.setReferrerUserName(jsonObject.getString("ReferrerUserName")
						.toString());
				referral.setSoldDate(jsonObject.getString("SoldDate")
						.toString());
				if(referral.getSoldDate() == null || referral.getSoldDate().equalsIgnoreCase("null"))
					referral.setSoldDate("");
				
				referral.setReferralNumber(jsonObject.getString("UniqueReferralNumber")
						.toString());
				referral.setUserDetailId(jsonObject.getString("UserDetailId")
						.toString());
				
				referralArray.add(referral);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return referralArray;
	}

	public ArrayList<Reward> parseRewardListResponse(String output) {
		// TODO Auto-generated method stub
		ArrayList<Reward> RewardArray = new ArrayList<Reward>();
		
		try {
			JSONArray jsonArray = new JSONArray(output);
			for (int i = 0; i < jsonArray.length(); i++) {
				JSONObject jsonObject = jsonArray.getJSONObject(i);

				
				
				Reward reward = new Reward();
			reward.setRewardAmount(jsonObject.getString("RewardAmount")
						.toString());
				reward.setRewardType(jsonObject.getString("RewardType")
						.toString());
				reward.setRewardlevel(jsonObject.getString("Rewardlevel")
						.toString());
				reward.setRewardName(jsonObject.getString("RewardName")
						.toString());
				reward.setRewardDescription(jsonObject.getString("RewardDescription")
						.toString());
				reward.setIsReceived(jsonObject.getString("IsReceived")
						.toString());
				reward.setReceivedDate(jsonObject.getString("ReceivedDate")
						.toString());
				reward.setCreatedDate(jsonObject.getString("CreatedDate")
						.toString());
				reward.setTransactionID(jsonObject.getString("TransactionID")
						.toString());
			
				
				
				//referral
				
				
				JSONObject jsonObject_Referral =new JSONObject(jsonObject.getString("Referral"));
				
						reward.setReferralId(jsonObject_Referral.getString("ReferralId")
						.toString());
				reward.setUniqueReferralNumber(jsonObject_Referral.getString("UniqueReferralNumber")
						.toString());
				reward.setReferralId(jsonObject_Referral.getString("ReferrerID")
						.toString());
				reward.setFirstName(jsonObject_Referral.getString("FirstName")
						.toString());
				reward.setLastName(jsonObject_Referral.getString("LastName")
						.toString());
				reward.setPhoneNumber(jsonObject_Referral.getString("PhoneNumber")
						.toString());
				reward.setEmail(jsonObject_Referral.getString("Email")
						.toString());
				reward.setComments(jsonObject_Referral.getString("Comments")
						.toString());
				reward.setSoldDate(jsonObject_Referral.getString("SoldDate")
						.toString());
				reward.setCreatedDate(jsonObject_Referral.getString("CreatedDate")
						.toString());
				
				reward.setMeaId(jsonObject_Referral.getString("MeaId")
						.toString());
				
				reward.setUserDetailId(jsonObject_Referral.getString("UserDetailId")
						.toString());
				reward.setReferrerUserName(jsonObject_Referral.getString("ReferrerUserName")
						.toString());
				reward.setReferrerName(jsonObject_Referral.getString("ReferrerName")
						.toString());
				reward.setReferrerEmail(jsonObject_Referral.getString("ReferrerEmail")
						.toString());
				reward.setReferralStatus(jsonObject_Referral.getString("ReferralStatus")
						.toString());
				reward.setReferralType(jsonObject_Referral.getString("ReferralType")
						.toString());
				reward.setMeaName(jsonObject_Referral.getString("MeaName")
						.toString());
				
				
				
				
			/*	Referral referral = new Referral();
				referral.setComments(jsonObject_Referral.getString("Comments")
						.toString());
				referral.setCreatedDate(jsonObject_Referral.getString("CreatedDate")
						.toString());
				referral.setEmail(jsonObject_Referral.getString("Email")
						.toString());
				referral.setFirstName(jsonObject_Referral.getString("FirstName")
						.toString());
				referral.setLastName(jsonObject_Referral.getString("LastName")
						.toString());
				referral.setMeaID(jsonObject_Referral.getString("MeaId")
						.toString());
				referral.setMeaName(jsonObject_Referral.getString("MeaName")
						.toString());
				referral.setPhoneNumber(jsonObject_Referral.getString("PhoneNumber")
						.toString());
				referral.setReferralId(jsonObject_Referral.getString("ReferralId")
						.toString());
				referral.setReferralStatus(jsonObject_Referral.getString("ReferralStatus")
						.toString());
				referral.setReferralType(jsonObject_Referral.getString("ReferralType")
						.toString());
				referral.setReferrerEmail(jsonObject_Referral.getString("ReferrerEmail")
						.toString());
				referral.setReferralId(jsonObject_Referral.getString("ReferrerID")
						.toString());
				referral.setReferrerName(jsonObject_Referral.getString("ReferrerName")
						.toString());
				referral.setReferrerUserName(jsonObject_Referral.getString("ReferrerUserName")
						.toString());
				referral.setSoldDate(jsonObject_Referral.getString("SoldDate")
						.toString());
				if(referral.getSoldDate() == null || referral.getSoldDate().equalsIgnoreCase("null"))
					referral.setSoldDate("");
				
				referral.setReferralNumber(jsonObject_Referral.getString("UniqueReferralNumber")
						.toString());
				referral.setUserDetailId(jsonObject_Referral.getString("UserDetailId")
						.toString());
				RewardArray.add(referral);*/
				
				
				RewardArray.add(reward);
				
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return RewardArray;
	}

	public String parsePayPalAccount(String output) {
		// TODO Auto-generated method stub
		String ack="";
	
		
		JSONObject jsonObject,jsonObjectResponse;
		try {
			jsonObject = new JSONObject(output);
		
			jsonObjectResponse = jsonObject.getJSONObject("responseEnvelope");
			jsonObjectResponse.getString("timestamp").toString();
			ack=jsonObjectResponse.getString("ack").toString();
			jsonObjectResponse.getString("correlationId").toString();
			jsonObjectResponse.getString("build").toString();
		
			return ack;
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}

		
	}

	public ScoreBoard parseScoreBoardContent(String output) {
		// TODO Auto-generated method stub
		//{"HighestEarning":600.000,"HighestReferrals":3,"HighestSoldReferrals":1}
		JSONObject jsonObject;
		
		try {
			jsonObject = new JSONObject(output);
			ScoreBoard scoreBoard=new ScoreBoard();
			//jsonObject.getString("responseEnvelope").toString();
			
			scoreBoard.setHighestEarning(jsonObject.getString("HighestEarning").toString());
			scoreBoard.setHighestReferrals(jsonObject.getString("HighestReferrals").toString());
			scoreBoard.setHighestSoldReferrals(jsonObject.getString("HighestSoldReferrals").toString());
			
		
			return scoreBoard;
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}

	public ArrayList<ReferralEarn> parseReferralEarn(String output) {
		// TODO Auto-generated method stub
		//[{"ReferralCount":1,"Earning":0.0,"UserName":"parvb"},{"ReferralCount":1,"Earning":0.0,"UserName":"parv1"},
		//{"ReferralCount":1,"Earning":0.0,"UserName":"parv5"}]

		ArrayList<ReferralEarn> array_referralEarn=new ArrayList<ReferralEarn>();
		try {
				JSONArray jsonArray = new JSONArray(output);
				for (int i = 0; i < jsonArray.length(); i++) {
					JSONObject jsonObject = jsonArray.getJSONObject(i);
					ReferralEarn referralEarn=new ReferralEarn();
			
			
			referralEarn.setReferralCount(jsonObject.getString("ReferralCount").toString());
			referralEarn.setEarning(jsonObject.getString("Earning").toString());
			referralEarn.setUserName(jsonObject.getString("UserName").toString());
			
			array_referralEarn.add(referralEarn);
				}
			return array_referralEarn;
				
		} 
				catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
		
		
	}

	public ArrayList<Badge> parseBadgeContent(String output) {
		// TODO Auto-generated method stub
		
	/*	 [ {
			    "BadgeId": 5,
			    "BadgeEarnedUserId": 0,
			    "BadgeEarnedId": 0,
			    "BadgeName": "Bronze",
			    "BadgeUrl": "http://63.255.19.72:801/badgesicon/Bronze-badges.png",
			    "EarnedDate": "2015-10-12 11:41:50 PM",
			    "CreatedDate": "2015-28-09 7:18:40 PM",
			    "IsBadgeEarned": true,
			    "BadgesCrieteria": {
			      "BadgeCriteriaId": 7,
			      "BadgeType": "Referral",
			      "BadgeStatus": "open",
			      "MinimumReferralsRequired": 1,
			      "ApplicableTimeFrameInDays": 30,
			      "CreatedDate": "2015-28-09 7:18:24 PM"
			    }
			    ]*/
		
		ArrayList<Badge> array_Badge=new ArrayList<Badge>();
		try {
				JSONArray jsonArray = new JSONArray(output);
				for (int i = 0; i < jsonArray.length(); i++) {
					JSONObject jsonObject = jsonArray.getJSONObject(i);
			Badge badge=new Badge();
			
			
			badge.setBadgeId(jsonObject.getString("BadgeId").toString());
			badge.setBadgeName(jsonObject.getString("BadgeName").toString());
			badge.setBadgeUrl(jsonObject.getString("BadgeUrl").toString());
			
			badge.setEarnedDate(jsonObject.getString("EarnedDate").toString());
			badge.setCreatedDate(jsonObject.getString("CreatedDate").toString());
			String earned=jsonObject.getString("IsBadgeEarned").toString();
			badge.setIsBadgeEarned(earned);
			
			JSONObject jsonObject_BadgesCrieteria =new JSONObject(jsonObject.getString("BadgesCrieteria"));
			
			badge.setBadgeCriteriaId(jsonObject_BadgesCrieteria.getString("BadgeCriteriaId")
					.toString());
			badge.setBadgeType(jsonObject_BadgesCrieteria.getString("BadgeType")
					.toString());
			badge.setBadgeStatus(jsonObject_BadgesCrieteria.getString("BadgeStatus")
					.toString());
			badge.setMinimumReferralsRequired(jsonObject_BadgesCrieteria.getString("MinimumReferralsRequired")
					.toString());
			badge.setApplicableTimeFrameInDays(jsonObject_BadgesCrieteria.getString("ApplicableTimeFrameInDays"));
			badge.setBadgesCrieteria_CreatedDate(jsonObject_BadgesCrieteria.getString("CreatedDate"));
			//if(earned.equalsIgnoreCase("true"))
			array_Badge.add(badge);
			
				
			}
				//sorted
				ArrayList<Badge> sortarArrayList1=new ArrayList<Badge>();
				
				 Collections.sort(array_Badge, new Comparator<Badge>() {
					 public int compare(Badge v1, Badge v2) {
					 return v1.getBadgeName().compareTo(v2.getBadgeName());
					 }
					 });

					Iterator<Badge> iterator1 = array_Badge.iterator();
					while (iterator1.hasNext()) {
						sortarArrayList1.add(iterator1.next());
					}
					array_Badge.clear();
					array_Badge.addAll(sortarArrayList1);
					
					
				///earned sorted	
					ArrayList<Badge> sortarArrayList2=new ArrayList<Badge>();
					
					 Collections.sort(array_Badge, new Comparator<Badge>() {
						 public int compare(Badge v1, Badge v2) {
						 return v2.getIsBadgeEarned().compareTo(v1.getIsBadgeEarned());
						 }
						 });

						Iterator<Badge> iterator2 = array_Badge.iterator();
						while (iterator2.hasNext()) {
							sortarArrayList2.add(iterator2.next());
						}
						array_Badge.clear();
						array_Badge.addAll(sortarArrayList2);
			return array_Badge;
				
		} 
				catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
		
		
	}
	public ArrayList<Notification> parseNotification(String output) {
		// TODO Auto-generated method stub
		
	/*	"Notifications": [
    {
      "NotificationId": 10,
      "NotificationType": {
        "ID": 5,
        "Name": "Service"
      },
      "NotificationTypeId": 0,
      "NotificationTitle": "Notification 2",
      "NotificationText": "This is the second service notification.",
      "IsScheduled": true,
      "ScheduledAt": "2016-01-15T18:30:00",
      "CreatedDate": "2016-01-15T16:30:00",
      "ModifiedDate": "2016-01-15T00:00:00",
      "Recipients": [
        {
          "ID": 179,
          "Name": "David Test"
        },
        {
          "ID": 191,
          "Name": "Manu Test1"
        }
      ]
    },
			    ]*/
		
		ArrayList<Notification> array_noti=new ArrayList<Notification>();
		try {
				
				
			
				JSONObject jsonNotification = new JSONObject(output);
				JSONArray jsonArray = jsonNotification.getJSONArray("Notifications");
				for (int i = 0; i < jsonArray.length(); i++) {
					JSONObject jsonObject = jsonArray.getJSONObject(i);
			Notification noti=new Notification();
			
			
			noti.setNotificationTypeId(jsonObject.getString("NotificationTypeId").toString());
			noti.setNotificationTitle(jsonObject.getString("NotificationTitle").toString());
			noti.setNotificationText(jsonObject.getString("NotificationText").toString());
			
			noti.setIsScheduled(jsonObject.getString("IsScheduled").toString());
			noti.setScheduledAt(jsonObject.getString("ScheduledAt").toString());
			noti.setCreatedDate(jsonObject.getString("CreatedDate").toString());
			noti.setModifiedDate(jsonObject.getString("ModifiedDate").toString());
			noti.setCreatedDate(jsonObject.getString("CreatedDate").toString());
			
			
			//JSONObject jsonObject_BadgesCrieteria =new JSONObject(jsonObject.getString("BadgesCrieteria"));
			
		/*	badge.setBadgeCriteriaId(jsonObject_BadgesCrieteria.getString("BadgeCriteriaId")
					.toString());
			badge.setBadgeType(jsonObject_BadgesCrieteria.getString("BadgeType")
					.toString());
			badge.setBadgeStatus(jsonObject_BadgesCrieteria.getString("BadgeStatus")
					.toString());
			badge.setMinimumReferralsRequired(jsonObject_BadgesCrieteria.getString("MinimumReferralsRequired")
					.toString());
			badge.setApplicableTimeFrameInDays(jsonObject_BadgesCrieteria.getString("ApplicableTimeFrameInDays"));
			badge.setBadgesCrieteria_CreatedDate(jsonObject_BadgesCrieteria.getString("CreatedDate"));*/
			//if(earned.equalsIgnoreCase("true"))
			array_noti.add(noti);
			
				
			}
				
			return array_noti;
				
		} 
				catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
		
		
	}

}
