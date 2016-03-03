package com.ara.board;

import java.io.InputStream;
import java.net.URL;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Typeface;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.telephony.PhoneNumberFormattingTextWatcher;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Window;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ProgressBar;
import android.widget.RelativeLayout;
import android.widget.RelativeLayout.LayoutParams;
import android.widget.TextView;
import android.widget.Toast;

import com.ara.async_tasks.AsyncResponseForARA;
import com.ara.async_tasks.AsyncTaskForARA;
import com.ara.base.BaseActivity;
import com.ara.base.R;
import com.ara.imageloader.ImageLoader;
import com.ara.login.AboutActivity;
import com.ara.login.LoginActivity;
import com.ara.model.ReferralType;
import com.ara.model.User;
import com.ara.profile.ImageUploadActivity;
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
	private ImageView imageView_profilepic,imageViewNotitfication;
	public static Typeface typeface_roboto,typeface_timeburner;
	public static String notiCount="0",EarnedRewards="0",UpcomingRewards="0";
	private int activeCount=0;
	private ProgressBar progressBar;
	private TextView txtPaidAmount,txtPaid,txtPeningAmount,txtPending;

	private String countOpen="0";
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.activity_dashboard);

		initUIComponents();
		setClickListeners();
		setValue();
	}

	

	private void initUIComponents() {
		// TODO Auto-generated method stub
		
		spref = getSharedPreferences("ara_prefs", MODE_PRIVATE);
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
		//TxtNotiCount.setTypeface(typeface_roboto);
		TxtNotiCount.setVisibility(View.GONE);
		progressBar=(ProgressBar)findViewById(R.id.progressBar);
		progressBar.setVisibility(View.GONE);
		
		activeReferralAmount = (TextView)findViewById(R.id.activeReferralAmount);
		activeReferralAmount.setTypeface(typeface_roboto);
		imageViewNotitfication=(ImageView)findViewById(R.id.imageViewNotitfication);
		//activeRewardAmount= (TextView)findViewById(R.id.activeRewardAmount);
		//activeRewardAmount.setTypeface(typeface_roboto);
		//txtPaidAmount,txtPaid,txtPeningAmount,txtPending;
		
		
		SoldAmount= (TextView)findViewById(R.id.SoldAmount);
		SoldAmount.setTypeface(typeface_roboto);
		
		txtPaidAmount= (TextView)findViewById(R.id.txtPaidAmount);
		txtPaidAmount.setTypeface(typeface_roboto);
		
		txtPaid= (TextView)findViewById(R.id.txtPaid);
		txtPaid.setTypeface(typeface_roboto);
		
		txtPeningAmount= (TextView)findViewById(R.id.txtPeningAmount);
		txtPeningAmount.setTypeface(typeface_roboto);
		
		txtPending= (TextView)findViewById(R.id.txtPending);
		txtPending.setTypeface(typeface_roboto);
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
		//imageLoader = new ImageLoader(DashBoardActivity.this);
		System.err.println("dashboard="+imageurl);
	    //imageLoader.DisplayImage(imageurl, imageView_profilepic);
		new LoadImage().execute(imageurl);
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
		imageViewNotitfication.setOnClickListener(listener);
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
	                    "mailto",  "robert.seeley@autoaves.com", null));
	            startActivity(Intent.createChooser(emailIntent, "Send email..."));
			}
			else if(v == textViewPhone){
				  String uri = "tel:" + "3037505000";
                  Intent intent = new Intent(Intent.ACTION_CALL);
                  intent.setData(Uri.parse(uri));
                  startActivity(intent);
			}
			else if(v == txtWebLink){
				
				Intent i = new Intent(Intent.ACTION_VIEW, 
					       Uri.parse("http://"+txtWebLink.getText().toString()));
					startActivity(i);
			}
			else if(v==imageViewNotitfication)
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
	
			String date=spref.getString(userid, "");
			
			String timeStamp=spref.getString("TS"+userid,date);
				/*try{
					date_after = formateDateFromstring("yyyy-MM-dd'T'HH:mm:ss.SSS", "yyyy-MM-dd'T'HH:mm:ss.SSS", time);
				}catch(Exception e)
				{
					e.printStackTrace();
				}*/
				ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
				nameValuePairs.add(new BasicNameValuePair("userId", userid));
				nameValuePairs.add(new BasicNameValuePair("Timestamp", timeStamp));		
				
				Log.e("dashboard", nameValuePairs.toString());
				AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(DashBoardActivity.this,"post","dashboard",nameValuePairs, false, "Please wait...",true);
				mWebPageTask.delegate = (AsyncResponseForARA) DashBoardActivity.this;
				mWebPageTask.execute();	
				
			//ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
				//AsyncTaskForARA mWebPageTask1 = new AsyncTaskForARA(
						//DashBoardActivity.this, "get", "/users/"+userid+"/SendUserNotification", nameValuePairs,
						//true, "Please wait...",true);
				//mWebPageTask1.delegate = (AsyncResponseForARA) DashBoardActivity.this;
				//mWebPageTask1.execute();
		}
		else
		{
			Util.alertMessage(DashBoardActivity.this, Util.network_error);
		}
	};
	
	@Override
	public void processFinish(String output, String methodName) {
		// TODO Auto-generated method stub
		String rewardAmount="";
		ARAParser parser = new ARAParser(DashBoardActivity.this);
		if(methodName.contains("dashboard"))
		{
			referralTypeArray = parser.parseDashboardContent(output);
		
			String soldCount="";
			
			try{
				activeCount=Integer.parseInt(notiCount);
				
					}
				catch (Exception e) {
					// TODO: handle exception
				}
			//activeCount=99;
			if(activeCount>0)
			{
				//if(activeCount.)
				TxtNotiCount.setText(""+activeCount);
				TxtNotiCount.setVisibility(View.VISIBLE);
				String ss=""+activeCount;
				if(ss.length()==1)
				{
					TxtNotiCount.setPadding(7, 2, 7, 2);
					//TxtNotiCount.setPadding(left, top, right, bottom)
					System.err.println("one");
					}
				else if(ss.length()==2)
				{
					TxtNotiCount.setPadding(3, 2, 3, 2);
					System.err.println("two");
					}
				}
			else
			{
				TxtNotiCount.setVisibility(View.GONE);
				}//+" Active/"+soldCount+" Sold");
			
			for(int i = 0; i<referralTypeArray.size(); i++){
				ReferralType referralType = referralTypeArray.get(i);
				
				if(referralType.getType().equalsIgnoreCase(STATUS_OPEN)){
					
					countOpen=referralType.getCount();
				
				
					//activeReferralAmount.setText("($"+referralType.getAmount()+")");
				}else if(referralType.getType().equalsIgnoreCase(STATUS_SOLD)){
					soldCount=referralType.getCount();
					rewardAmount=referralType.getAmount();
					//soldReferralAmount.setText("($"+referralType.getAmount()+")");
				}else if(referralType.getType().equalsIgnoreCase(STATUS_INACTIVE)){
					//inActiveReferralCount.setText(referralType.getCount());
				}else if(referralType.getType().equalsIgnoreCase(STATUS_TOTAL)){
					//totalReferralCount.setText(referralType.getCount());
				}
			}
			
			SoldAmount.setText(" "+soldCount);
			//activeRewardAmount.setText("$ "+rewardAmount);
			activeReferralAmount.setText(countOpen);
			
			try{
		
     
   		    txtPaidAmount.setText("$"+(int)Float.parseFloat(EarnedRewards));
			txtPeningAmount.setText("$"+(int)Float.parseFloat(UpcomingRewards) );
			}catch(Exception e)
			{
				e.printStackTrace();
			}
			
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
				intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK | Intent.FLAG_ACTIVITY_NEW_TASK);
				startActivity(intent);
				finish();
				}
		
	//else if(methodName.contains("SendUserNotification"))
	//{
	//	System.err.println(output);
	//}
	}
	 public static String formateDateFromstring(String inputFormat, String outputFormat, String inputDate){

		    Date parsed = null;
		    String outputDate = "";

		    SimpleDateFormat df_input = new SimpleDateFormat(inputFormat, java.util.Locale.getDefault());
		    SimpleDateFormat df_output = new SimpleDateFormat(outputFormat, java.util.Locale.getDefault());

		    try {
		        parsed = df_input.parse(inputDate);
		        outputDate = df_output.format(parsed);

		    } catch (Exception e) { 
		      //  LOGE(TAG, "ParseException - dateFormat");
		    }

		    return outputDate;

		}
	 private String getCurrentDate()
		{
			Calendar c = Calendar.getInstance();
			System.out.println("Current time => " + c.getTime());
				//2016-01-15 14:15:00.000
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
			String formattedDate = df.format(c.getTime());
			return formattedDate;
		}
	 public class LoadImage extends AsyncTask<String, String, Bitmap> {
	     Bitmap bitmap;
		 @Override
	        protected void onPreExecute() {
	            super.onPreExecute();
	        	progressBar.setVisibility(View.VISIBLE);
	           /* pDialog = new ProgressDialog(MainActivity.this);
	            pDialog.setMessage("Loading Image ....");
	            pDialog.show();*/
	 	        }
	         protected Bitmap doInBackground(String... args) {
	             try {
	                   bitmap = BitmapFactory.decodeStream((InputStream)new URL(args[0]).getContent());
	 
	            } catch (Exception e) {
	                  e.printStackTrace();
	            }
	            return bitmap;
	         }
	       protected void onPostExecute(Bitmap image) {
	    	   progressBar.setVisibility(View.GONE);
	            if(image != null){
	            	 imageView_profilepic.setImageBitmap(image);
	             //pDialog.dismiss();
	             }else{
	             //pDialog.dismiss();
	             Toast.makeText(DashBoardActivity.this, "Image Does Not exist or Network Error", Toast.LENGTH_SHORT).show();
	 
	             }
	         }
	     }
	 @Override
	public void onBackPressed() {
		
		finish();
		moveTaskToBack(true);
		
	}
	 
}