package com.ara.board;

import java.util.ArrayList;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.graphics.Typeface;
import android.net.Uri;
import android.os.Bundle;
import android.telephony.PhoneNumberFormattingTextWatcher;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Window;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.RelativeLayout.LayoutParams;
import android.widget.TextView;
import com.ara.async_tasks.AsyncResponseForARA;
import com.ara.async_tasks.AsyncTaskForARA;
import com.ara.base.BaseActivity;
import com.ara.base.R;
import com.ara.imageloader.ImageLoader;
import com.ara.login.AboutActivity;
import com.ara.login.LoginActivity;
import com.ara.model.ReferralType;
import com.ara.model.User;
import com.ara.profile.MyProfile;
import com.ara.referral.ReferralListActivity;
import com.ara.referral.SubmitReferralActivity;
import com.ara.rewards.RewardsListActivity;
import com.ara.util.ARAParser;
import com.ara.util.Util;

public class DashBoardActivity extends Activity implements AsyncResponseForARA{

	private LinearLayout activeReferrals, LayShdulerService, RewardReferralLayout,
	layoutAANews;
	private TextView activeReferralCount, inActiveReferralCount,
			soldReferralCount, totalReferralCount, activeReferralAmount,
			soldReferralAmount,referralDashboard,textView_activeReferral,textView_soldReferral,
			textView_inactiveRederral,textView_total_Referral,txt_username,textViewName,txtAbout,TxtNotiCount,
			txtProfile,txtSubmit,txtLogout,textViewEmail,textViewPhone,activeRewardAmount,txtWebLink,SoldAmount;
	private SharedPreferences spref;
	private ArrayList<ReferralType> referralTypeArray;
	private ImageView submit_Referral;
	public static final String STATUS_OPEN = "open";
	public static final String STATUS_SOLD = "sold";
	public static final String STATUS_INACTIVE = "inactive";
	public static final String STATUS_TOTAL = "Total";
	private User user_Model=null;
	private ImageLoader imageLoader;
	private RelativeLayout RelNotification;
	private String imageurl="";
	private ImageView imageView_profilepic;
	public static Typeface typeface_roboto,typeface_timeburner;
	public static String notiCount="0";
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.activity_dashboard);

		initUIComponents();
		setValue();
		
		setClickListeners();
	}

	

	private void initUIComponents() {
		// TODO Auto-generated method stub
		typeface_timeburner= Typeface.createFromAsset(getAssets(), "timeburner_regular.ttf");
		typeface_roboto = Typeface.createFromAsset(getAssets(), "Roboto-Regular.ttf");
		
		imageView_profilepic=(ImageView)findViewById(R.id.imageView_profilepic);
		RelNotification=(RelativeLayout)findViewById(R.id.RelNotification);
		activeReferrals = (LinearLayout)findViewById(R.id.activeReferralLayout);
		RewardReferralLayout = (LinearLayout)findViewById(R.id.RewardReferralLayout);
		LayShdulerService = (LinearLayout)findViewById(R.id.LayShdulerService);
		layoutAANews = (LinearLayout)findViewById(R.id.layoutAANews);
		
		textViewEmail=(TextView)findViewById(R.id.textViewEmail);
		textViewEmail.setTypeface(typeface_roboto);
		textViewPhone=(TextView)findViewById(R.id.textViewPhone);
		textViewPhone.setTypeface(typeface_roboto);
		
		TxtNotiCount=(TextView)findViewById(R.id.TxtNotiCount);
		TxtNotiCount.setTypeface(typeface_roboto);
		
		activeReferralAmount = (TextView)findViewById(R.id.activeReferralAmount);
		activeReferralAmount.setTypeface(typeface_roboto);
		activeRewardAmount= (TextView)findViewById(R.id.activeRewardAmount);
		activeRewardAmount.setTypeface(typeface_roboto);
		
		SoldAmount= (TextView)findViewById(R.id.SoldAmount);
		SoldAmount.setTypeface(typeface_roboto);
		/*activeReferralCount = (TextView)findViewById(R.id.activeReferralCount);
		activeReferralCount.setTypeface(typeface_roboto);
		soldReferralCount = (TextView)findViewById(R.id.soldReferralCount);
		soldReferralCount.setTypeface(typeface_roboto);
		
		inActiveReferralCount = (TextView)findViewById(R.id.inActiveReferralCount);
		inActiveReferralCount.setTypeface(typeface_roboto);
		totalReferralCount = (TextView)findViewById(R.id.totalReferralCount);
		totalReferralCount.setTypeface(typeface_roboto);
		
		activeReferralAmount = (TextView)findViewById(R.id.activeReferralAmount);
		activeReferralAmount.setTypeface(typeface_roboto);
		soldReferralAmount = (TextView)findViewById(R.id.soldReferralAmount);
		soldReferralAmount.setTypeface(typeface_roboto);*/
		
		//referralDashboard=(TextView)findViewById(R.id.referralDashboard);
		//referralDashboard.setTypeface(BaseActivity.typeface_timeburner);
		
		/*textView_activeReferral=(TextView)findViewById(R.id.textView_activeReferral);
		textView_activeReferral.setTypeface(typeface_roboto);
		
		textView_soldReferral=(TextView)findViewById(R.id.textView_soldReferral);
		textView_soldReferral.setTypeface(typeface_roboto);
		
		textView_inactiveRederral=(TextView)findViewById(R.id.textView_inactiveRederral);
		textView_inactiveRederral.setTypeface(typeface_roboto);
		
		textView_total_Referral=(TextView)findViewById(R.id.textView_total_Referral);
		textView_total_Referral.setTypeface(typeface_roboto);*/
		
		txtWebLink=(TextView) findViewById(R.id.txtWebLink);
		txtWebLink.setTypeface(typeface_roboto);
		
		txtProfile = (TextView) findViewById(R.id.txtProfile);
		txtProfile.setTypeface(typeface_roboto);
		
		txtSubmit = (TextView) findViewById(R.id.txtSubmit);
		txtSubmit.setTypeface(typeface_roboto);
		
		txtLogout= (TextView) findViewById(R.id.txtLogout);
		txtLogout.setTypeface(typeface_roboto);
		
		textViewName = (TextView) findViewById(R.id.textViewName);
		textViewName.setTypeface(typeface_roboto);
		txtAbout= (TextView) findViewById(R.id.txtAbout);
		txtAbout.setTypeface(typeface_roboto);
		user_Model = (User) getIntent().getParcelableExtra("user");
		if(user_Model!=null)
		{
			//textViewEmail.setText("Email :"+user_Model.getEmail());
			//textViewPhone.setText("Phone :"+user_Model.getPhoneNumber());
			//textViewPhone.addTextChangedListener(new PhoneNumberFormattingTextWatcher());
			textViewName.setText(user_Model.getFirstName()+" "+ user_Model.getLastName());
			}
	}
	private void setValue() {
		// TODO Auto-generated method stub
		spref = getSharedPreferences("ara_prefs", MODE_PRIVATE);
		
		imageurl=spref.getString("userimage", "");
		imageLoader = new ImageLoader(DashBoardActivity.this);
	    imageLoader.DisplayImage(imageurl, imageView_profilepic);
	}

	private void setClickListeners() {
		// TODO Auto-generated method stub
		activeReferrals.setOnClickListener(listener);
		RewardReferralLayout.setOnClickListener(listener);
		LayShdulerService.setOnClickListener(listener);
		layoutAANews.setOnClickListener(listener);
		
		txtAbout.setOnClickListener(listener);
		txtProfile.setOnClickListener(listener);
		txtSubmit.setOnClickListener(listener);
		txtLogout.setOnClickListener(listener);
		textViewEmail.setOnClickListener(listener);
		textViewPhone.setOnClickListener(listener);
		txtWebLink.setOnClickListener(listener);
		RelNotification.setOnClickListener(listener);
	}
	private View.OnClickListener listener = new View.OnClickListener() {
		
		@Override
		public void onClick(View v) {
			// TODO Auto-generated method stub
			
			if(v == activeReferrals){
				Intent intent = new Intent(DashBoardActivity.this, ReferralListActivity.class);
				intent.putExtra("referralStatus", "all");
				startActivity(intent);
			}else if (v == RewardReferralLayout){
				Intent intent = new Intent(DashBoardActivity.this, RewardsListActivity.class);
				intent.putExtra("referralStatus", STATUS_SOLD);
				startActivity(intent);
			}else if(v == layoutAANews){
				/*Intent intent = new Intent(DashBoardActivity.this, ReferralListActivity.class);
				intent.putExtra("referralStatus", STATUS_INACTIVE);
				startActivity(intent);*/
				
			}else if(v == LayShdulerService){
				Intent intent = new Intent(DashBoardActivity.this, ScheduleActivity.class);
				intent.putExtra("user", user_Model);
				startActivity(intent);
			}
			else if(v == txtAbout){
				Intent intent = new Intent(DashBoardActivity.this, AboutActivity.class);
				startActivity(intent);
			}
			else if(v == txtProfile){
				Intent intent = new Intent(DashBoardActivity.this, MyProfile.class);
				startActivity(intent);
			}
			else if(v == txtSubmit){
				Intent intent = new Intent(DashBoardActivity.this, SubmitReferralActivity.class);
				startActivity(intent);
			}
			else if(v == textViewEmail){
				Intent emailIntent = new Intent(Intent.ACTION_SENDTO, Uri.fromParts(
	                    "mailto",  user_Model.getEmail(), null));
	            startActivity(Intent.createChooser(emailIntent, "Send email..."));
			}
			else if(v == textViewPhone){
				  String uri = "tel:" + user_Model.getPhoneNumber();
                  Intent intent = new Intent(Intent.ACTION_CALL);
                  intent.setData(Uri.parse(uri));
                  startActivity(intent);
			}
			else if(v == txtWebLink){
				
				Intent i = new Intent(Intent.ACTION_VIEW, 
					       Uri.parse("http://"+txtWebLink.getText().toString()));
					startActivity(i);
			}
			else if(v==RelNotification)
			{
				Intent intent = new Intent(DashBoardActivity.this, NotificationActivity.class);
				startActivity(intent);
			}
			else if(v == txtLogout){
				logoutApi();
			}
			
		}
	};
	private void logoutApi()
	{
		
		//"%@/users/%@/logout
		
		
		if (Util.isNetworkAvailable(DashBoardActivity.this)) {
			
			String userid=spref.getString("userid", "");
			ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
			

			AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(
					DashBoardActivity.this, "post", "users/"+userid+"/logout", nameValuePairs,
					true, "Please wait...",true);
			mWebPageTask.delegate = (AsyncResponseForARA) DashBoardActivity.this;
			mWebPageTask.execute();
		} else {
			Util.alertMessage(DashBoardActivity.this, Util.network_error);
		}
	}

	protected void onResume() {
		super.onResume();
		if(Util.isNetworkAvailable(DashBoardActivity.this)){
			spref = getSharedPreferences("ara_prefs", MODE_PRIVATE);
			String userid=spref.getString("userid", "");
		// [HttpPost]dashboard  (userId, Timestamp)
				String time=spref.getString("Timestamp", "");
				ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
				nameValuePairs.add(new BasicNameValuePair("userId", userid));
				nameValuePairs.add(new BasicNameValuePair("Timestamp", time));		
				
				Log.e("dashboard", nameValuePairs.toString());
				AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(DashBoardActivity.this,"post","dashboard",nameValuePairs, false, "Please wait...",true);
				mWebPageTask.delegate = (AsyncResponseForARA) DashBoardActivity.this;
				mWebPageTask.execute();	
				
		}
		else
		{
			Util.alertMessage(DashBoardActivity.this, Util.network_error);
		}
	};
	
	@Override
	public void processFinish(String output, String methodName) {
		// TODO Auto-generated method stub
		String reward="";
		ARAParser parser = new ARAParser(DashBoardActivity.this);
		if(methodName.contains("dashboard"))
		{
			int activeCount=0;
			String soldCount="";
			
			try{
				activeCount=Integer.parseInt(notiCount);
					}
				catch (Exception e) {
					// TODO: handle exception
				}
			if(activeCount>0)
			{
				TxtNotiCount.setText(activeCount);
				TxtNotiCount.setVisibility(View.VISIBLE);
				}
			else
			{
				TxtNotiCount.setVisibility(View.GONE);
				}//+" Active/"+soldCount+" Sold");
			referralTypeArray = parser.parseDashboardContent(output);
			for(int i = 0; i<referralTypeArray.size(); i++){
				ReferralType referralType = referralTypeArray.get(i);
				
				if(referralType.getType().equalsIgnoreCase(STATUS_OPEN)){
					
					reward=referralType.getAmount();
					//activeReferralAmount.setText("($"+referralType.getAmount()+")");
				}else if(referralType.getType().equalsIgnoreCase(STATUS_SOLD)){
					soldCount=referralType.getCount();
					//soldReferralAmount.setText("($"+referralType.getAmount()+")");
				}else if(referralType.getType().equalsIgnoreCase(STATUS_INACTIVE)){
					//inActiveReferralCount.setText(referralType.getCount());
				}else if(referralType.getType().equalsIgnoreCase(STATUS_TOTAL)){
					//totalReferralCount.setText(referralType.getCount());
				}
			}
			
			SoldAmount.setText(" "+soldCount);
			activeRewardAmount.setText("$ "+reward);
			/*if(referralTypeArray.get(0).getNotificationCount().equals("0"))
			{
				TxtNotiCount.setVisibility(View.GONE);
			}
			else
				{
					TxtNotiCount.setVisibility(View.VISIBLE);
					TxtNotiCount.setText(referralTypeArray.get(0).getNotificationCount());
					}*/
		}
		else if(methodName.contains("logout"))
			{
				Editor ed = spref.edit();
				ed.putString("useremail", "");
				ed.putString("userid", "");
				ed.putString("access_token","");
				ed.commit();
				Intent intent = new Intent(DashBoardActivity.this,LoginActivity.class);
				intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
				startActivity(intent);
				finish();
				}
		}
	
}