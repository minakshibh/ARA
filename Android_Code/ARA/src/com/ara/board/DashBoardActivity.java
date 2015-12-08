package com.ara.board;

import java.util.ArrayList;
import org.apache.http.NameValuePair;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout.LayoutParams;
import android.widget.TextView;
import com.ara.async_tasks.AsyncResponseForARA;
import com.ara.async_tasks.AsyncTaskForARA;
import com.ara.base.BaseActivity;
import com.ara.base.R;
import com.ara.login.LoginActivity;
import com.ara.model.ReferralType;
import com.ara.model.User;
import com.ara.referral.ReferralListActivity;
import com.ara.util.ARAParser;
import com.ara.util.Util;

public class DashBoardActivity extends BaseActivity implements AsyncResponseForARA{

	private LinearLayout activeReferrals, inActiveReferrals, soldReferrals,
			totalReferrals;
	private TextView activeReferralCount, inActiveReferralCount,
			soldReferralCount, totalReferralCount, activeReferralAmount,
			soldReferralAmount,referralDashboard,textView_activeReferral,textView_soldReferral,
			textView_inactiveRederral,textView_total_Referral,txt_username;
	private SharedPreferences spref;
	private ArrayList<ReferralType> referralTypeArray;
	private ImageView submit_Referral;
	public static final String STATUS_OPEN = "open";
	public static final String STATUS_SOLD = "sold";
	public static final String STATUS_INACTIVE = "inactive";
	public static final String STATUS_TOTAL = "Total";
	private User user_Model;
	
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		LayoutInflater inflater = (LayoutInflater) this
				.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		View contentView = inflater.inflate(R.layout.activity_dashboard, null,false);
		contentView.setLayoutParams(new LayoutParams(LayoutParams.MATCH_PARENT,LayoutParams.MATCH_PARENT));
		contentFrame.addView(contentView, 0);

		initUIComponents();
		setClickListeners();
	}

	private void setClickListeners() {
		// TODO Auto-generated method stub
		activeReferrals.setOnClickListener(listener);
		soldReferrals.setOnClickListener(listener);
		inActiveReferrals.setOnClickListener(listener);
		totalReferrals.setOnClickListener(listener);
	}

	private void initUIComponents() {
		// TODO Auto-generated method stub
		activeReferrals = (LinearLayout)findViewById(R.id.activeReferralLayout);
		soldReferrals = (LinearLayout)findViewById(R.id.soldReferralLayout);
		inActiveReferrals = (LinearLayout)findViewById(R.id.inActiveReferralLayout);
		totalReferrals = (LinearLayout)findViewById(R.id.totalReferralLayout);
		
		activeReferralCount = (TextView)findViewById(R.id.activeReferralCount);
		activeReferralCount.setTypeface(BaseActivity.typeface_roboto);
		soldReferralCount = (TextView)findViewById(R.id.soldReferralCount);
		soldReferralCount.setTypeface(BaseActivity.typeface_roboto);
		
		inActiveReferralCount = (TextView)findViewById(R.id.inActiveReferralCount);
		inActiveReferralCount.setTypeface(BaseActivity.typeface_roboto);
		totalReferralCount = (TextView)findViewById(R.id.totalReferralCount);
		totalReferralCount.setTypeface(BaseActivity.typeface_roboto);
		
		activeReferralAmount = (TextView)findViewById(R.id.activeReferralAmount);
		activeReferralAmount.setTypeface(BaseActivity.typeface_roboto);
		soldReferralAmount = (TextView)findViewById(R.id.soldReferralAmount);
		soldReferralAmount.setTypeface(BaseActivity.typeface_roboto);
		
		referralDashboard=(TextView)findViewById(R.id.referralDashboard);
		referralDashboard.setTypeface(BaseActivity.typeface_timeburner);
		
		textView_activeReferral=(TextView)findViewById(R.id.textView_activeReferral);
		textView_activeReferral.setTypeface(BaseActivity.typeface_roboto);
		
		textView_soldReferral=(TextView)findViewById(R.id.textView_soldReferral);
		textView_soldReferral.setTypeface(BaseActivity.typeface_roboto);
		
		textView_inactiveRederral=(TextView)findViewById(R.id.textView_inactiveRederral);
		textView_inactiveRederral.setTypeface(BaseActivity.typeface_roboto);
		
		textView_total_Referral=(TextView)findViewById(R.id.textView_total_Referral);
		textView_total_Referral.setTypeface(BaseActivity.typeface_roboto);
		
		txt_username = (TextView) findViewById(R.id.username);
		txt_username.setTypeface(BaseActivity.typeface_roboto);
		
		user_Model = (User) getIntent().getParcelableExtra("user");
		if(user_Model!=null)
		{
			txt_username.setText(user_Model.getFirstName()+" "+ user_Model.getLastName());
			}
	}
	
	private View.OnClickListener listener = new View.OnClickListener() {
		
		@Override
		public void onClick(View v) {
			// TODO Auto-generated method stub
			Intent intent = new Intent(DashBoardActivity.this, ReferralListActivity.class);
			if(v == activeReferrals){
				intent.putExtra("referralStatus", STATUS_OPEN);
			}else if (v == soldReferrals){
				intent.putExtra("referralStatus", STATUS_SOLD);
			}else if(v == inActiveReferrals){
				intent.putExtra("referralStatus", STATUS_INACTIVE);
			}else if(v == totalReferrals){
				intent.putExtra("referralStatus", "all");
			}
			startActivity(intent);
		}
	};

	protected void onResume() {
		super.onResume();
		if(Util.isNetworkAvailable(DashBoardActivity.this)){
			spref = getSharedPreferences("ara_prefs", MODE_PRIVATE);
			String userid=spref.getString("userid", "");
				
				ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
				AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(DashBoardActivity.this,"get","dashboard/"+userid,nameValuePairs, false, "Please wait...",true);
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
		ARAParser parser = new ARAParser(DashBoardActivity.this);
		if(methodName.contains("dashboard"))
		{
			referralTypeArray = parser.parseDashboardContent(output);
			for(int i = 0; i<referralTypeArray.size(); i++){
				ReferralType referralType = referralTypeArray.get(i);
				if(referralType.getType().equalsIgnoreCase(STATUS_OPEN)){
					activeReferralCount.setText(referralType.getCount());
					activeReferralAmount.setText("($"+referralType.getAmount()+")");
				}else if(referralType.getType().equalsIgnoreCase(STATUS_SOLD)){
					soldReferralCount.setText(referralType.getCount());
					soldReferralAmount.setText("($"+referralType.getAmount()+")");
				}else if(referralType.getType().equalsIgnoreCase(STATUS_INACTIVE)){
					inActiveReferralCount.setText(referralType.getCount());
				}else if(referralType.getType().equalsIgnoreCase(STATUS_TOTAL)){
					totalReferralCount.setText(referralType.getCount());
				}
			}
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