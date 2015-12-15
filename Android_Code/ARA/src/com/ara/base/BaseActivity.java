package com.ara.base;

import java.util.ArrayList;
import org.apache.http.NameValuePair;
import android.app.Activity;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.content.res.Configuration;
import android.graphics.Typeface;
import android.os.Bundle;
import android.support.v4.app.ActionBarDrawerToggle;
import android.support.v4.widget.DrawerLayout;
import android.view.MenuItem;
import android.view.View;
import android.view.Window;
import android.view.animation.AlphaAnimation;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;
import com.ara.async_tasks.AsyncResponseForARA;
import com.ara.async_tasks.AsyncTaskForARA;
import com.ara.badge.BadgeListActivity;
import com.ara.board.ScoreBoardActivity;
import com.ara.imageloader.ImageLoader;
import com.ara.login.AboutActivity;
import com.ara.login.LoginActivity;
import com.ara.payment.PaymentListActivity;
import com.ara.profile.MyProfile;
import com.ara.referral.ReferralListActivity;
import com.ara.referral.SubmitReferralActivity;
import com.ara.rewards.RewardsListActivity;
import com.ara.util.Util;

public class BaseActivity extends Activity implements AsyncResponseForARA {

	public ActionBarDrawerToggle mDrawerToggle;
	public DrawerLayout mDrawerLayout;
	public RelativeLayout flyoutDrawerRl;

	public AlphaAnimation buttonClick = new AlphaAnimation(1F, 0.2F);
	public RelativeLayout contentFrame;
	public ImageView slider, Slidermenu,userImage;
	public TextView submitReferral;
	public LinearLayout profile, referrals, paymentAccounts,
			myBadges, myRewards, scoreboard, logout,layout_imagename,about;
	private TextView txt_username, txt_useremail,headerText;
	private TextView txt_profile,txt_referral,
	txt_paymentAccounts,txt_myBadges,txt_myRewards,txt_scoreboard,txt_logout,txtAbout;
	private SharedPreferences spref;
	public static Typeface typeface_roboto,typeface_timeburner;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.activity_base);

		
		
		setUI();
		
		
		slider.setOnClickListener(DrawerListener);
		sliderOnClickListener();
		setListenerOnDrawer();

		Slidermenu.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				if (mDrawerLayout.isDrawerOpen(flyoutDrawerRl)) {
					mDrawerLayout.closeDrawers();
				}
			}
		});
	}

	private void setUI() {
		// TODO Auto-generated method stub
		typeface_timeburner= Typeface.createFromAsset(getAssets(), "timeburner_regular.ttf");
		typeface_roboto = Typeface.createFromAsset(getAssets(), "Roboto-Regular.ttf");
	
		spref = getSharedPreferences("ara_prefs", MODE_PRIVATE);
		slider = (ImageView) findViewById(R.id.menuSlider);
		Slidermenu = (ImageView) findViewById(R.id.Slidermenu);
		flyoutDrawerRl = (RelativeLayout) findViewById(R.id.left_drawer);
		contentFrame = (RelativeLayout) findViewById(R.id.content_frame);

		mDrawerLayout = (DrawerLayout) findViewById(R.id.drawer_layout);
		mDrawerLayout.setScrimColor(getResources().getColor(
				android.R.color.transparent));
		userImage=(ImageView)findViewById(R.id.userImage);
		profile = (LinearLayout) findViewById(R.id.profile);
		referrals = (LinearLayout) findViewById(R.id.referrals);
		submitReferral = (TextView) findViewById(R.id.submit_Referral);
		paymentAccounts = (LinearLayout) findViewById(R.id.paymentAccounts);
		myBadges = (LinearLayout) findViewById(R.id.myBadges);
		myRewards = (LinearLayout) findViewById(R.id.myRewards);
		scoreboard = (LinearLayout) findViewById(R.id.scoreboard);
		logout = (LinearLayout) findViewById(R.id.logout);
		about = (LinearLayout) findViewById(R.id.about);
		//headerText=(TextView)findViewById(R.id.headerText);
		//headerText.setTypeface(typeface_timeburner);
		txt_username = (TextView) findViewById(R.id.username);
		
		txt_username.setText(spref.getString("username", ""));
		txt_username.setTypeface(typeface_roboto);
		layout_imagename=(LinearLayout)findViewById(R.id.layout_imagename);
		txt_useremail = (TextView) findViewById(R.id.txt_useremail);
		txt_useremail.setText(spref.getString("useremail", ""));
		txt_useremail.setTypeface(typeface_roboto);

		txt_profile = (TextView) findViewById(R.id.txt_profile);
		txt_profile.setTypeface(typeface_roboto);
		
		//txt_submitReferral=(TextView) findViewById(R.id.txt_submitReferral);
		//txt_submitReferral.setTypeface(typeface_roboto);
		
		txt_referral = (TextView) findViewById(R.id.txt_referral);
		txt_referral.setTypeface(typeface_roboto);
		
		txt_paymentAccounts = (TextView) findViewById(R.id.txt_paymentAccounts);
		txt_paymentAccounts.setTypeface(typeface_roboto);
		
		txt_myBadges = (TextView) findViewById(R.id.txt_myBadges);
		txt_myBadges.setTypeface(typeface_roboto);
		
		txt_myRewards = (TextView) findViewById(R.id.txt_myRewards);
		txt_myRewards.setTypeface(typeface_roboto);
		
		txt_scoreboard = (TextView) findViewById(R.id.txt_scoreboard);
		txt_scoreboard.setTypeface(typeface_roboto);
		
		txt_logout = (TextView) findViewById(R.id.txt_logout);
		txt_logout.setTypeface(typeface_roboto);
		
		txtAbout = (TextView) findViewById(R.id.txtAbout);
		txt_logout.setTypeface(typeface_roboto);
		
	}

	public View.OnClickListener DrawerListener = new View.OnClickListener() {

		@Override
		public void onClick(View v) {
			// TODO Auto-generated method stub

			if (mDrawerLayout.isDrawerOpen(flyoutDrawerRl)) {
				mDrawerLayout.closeDrawers();
			} else {
				mDrawerLayout.openDrawer(flyoutDrawerRl);
			}
		}
	};

	private void setListenerOnDrawer() {
		mDrawerToggle = new ActionBarDrawerToggle(this, mDrawerLayout,
				R.drawable.ic_launcher, R.string.app_name, R.string.app_name) {
			/** Called when a drawer has settled in a completely closed state. */
			public void onDrawerClosed(View view) {
				super.onDrawerClosed(view);
			}

			/** Called when a drawer has settled in a completely open state. */
			public void onDrawerOpened(View drawerView) {
				super.onDrawerOpened(drawerView);
			}
		};
		// mDrawerLayout.setDrawerListener(mDrawerToggle);
	}

	@Override
	protected void onPostCreate(Bundle savedInstanceState) {
		super.onPostCreate(savedInstanceState);
		// Sync the toggle state after onRestoreInstanceState has occurred.
		mDrawerToggle.syncState();
	}

	@Override
	public void onConfigurationChanged(Configuration newConfig) {
		super.onConfigurationChanged(newConfig);
		mDrawerToggle.onConfigurationChanged(newConfig);
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		// Pass the event to ActionBarDrawerToggle, if it returns
		// true, then it has handled the app icon touch event
		if (mDrawerToggle.onOptionsItemSelected(item)) {
			return true;
		}
		// we can handle other action bar items here later...

		return super.onOptionsItemSelected(item);
	}

	@Override
	protected void onResume() {
		// TODO Auto-generated method stub
		super.onResume();
		
		spref = getSharedPreferences("ara_prefs", MODE_PRIVATE);
		String imageurl=spref.getString("userimage", "");
		
		System.err.println("urlllllllllll"+imageurl);
		 ImageLoader imageLoader = new ImageLoader(BaseActivity.this);
	     imageLoader.DisplayImage(imageurl, userImage);
	}

	private View.OnClickListener listener = new View.OnClickListener() {

		@Override
		public void onClick(View v) {
			if (v == profile) {

				Intent intent = new Intent(BaseActivity.this, MyProfile.class);
				startActivity(intent);
				DrawerLayoutClose();
				
			} else if (v == referrals) {
				Intent intent = new Intent(BaseActivity.this,ReferralListActivity.class);
				intent.putExtra("referralStatus", "all");
				startActivity(intent);
				DrawerLayoutClose();
			} 
			else if (v == submitReferral) {
				Intent intent = new Intent(BaseActivity.this,SubmitReferralActivity.class);
				startActivity(intent);
				DrawerLayoutClose();
			} 
			else if (v == paymentAccounts) {
				Intent intent = new Intent(BaseActivity.this,PaymentListActivity.class);
				startActivity(intent);
				DrawerLayoutClose();
			} 
			else if (v == myBadges) {

				Intent intent = new Intent(BaseActivity.this,BadgeListActivity.class);
				startActivity(intent);
				DrawerLayoutClose();
			} 
			else if (v == myRewards) {

				Intent intent = new Intent(BaseActivity.this,RewardsListActivity.class);
				startActivity(intent);
				DrawerLayoutClose();
			} 
			else if (v == layout_imagename) {
				Intent intent = new Intent(BaseActivity.this, MyProfile.class);
				startActivity(intent);
				DrawerLayoutClose();
			}
			else if (v == scoreboard) {
				Intent intent = new Intent(BaseActivity.this, ScoreBoardActivity.class);
				intent.putExtra("base", "yes");
				startActivity(intent);
				DrawerLayoutClose();
			} 
			else if (v == about) {
				Intent intent = new Intent(BaseActivity.this, AboutActivity.class);
				startActivity(intent);
				DrawerLayoutClose();
			} 
			else if (v == logout) {
				
				logoutApi();
			

			}
		}
	};

	public void sliderOnClickListener() {

		profile.setOnClickListener(listener);
		referrals.setOnClickListener(listener);
		submitReferral.setOnClickListener(listener);
		paymentAccounts.setOnClickListener(listener);
		myBadges.setOnClickListener(listener);
		myRewards.setOnClickListener(listener);
		layout_imagename.setOnClickListener(listener);
		scoreboard.setOnClickListener(listener);
		about.setOnClickListener(listener);
		logout.setOnClickListener(listener);

	}
	private void DrawerLayoutClose()
	{
		if (mDrawerLayout.isDrawerOpen(flyoutDrawerRl)) {
			mDrawerLayout.closeDrawers();
		}
	}
	private void logoutApi()
	{
		
		//"%@/users/%@/logout
		
		
		if (Util.isNetworkAvailable(BaseActivity.this)) {
			
			String userid=spref.getString("userid", "");
			ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
			

			AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(
					BaseActivity.this, "post", "users/"+userid+"/logout", nameValuePairs,
					true, "Please wait...",true);
			mWebPageTask.delegate = (AsyncResponseForARA) BaseActivity.this;
			mWebPageTask.execute();
		} else {
			Util.alertMessage(BaseActivity.this, Util.network_error);
		}
	}

	@Override
	public void processFinish(String output, String methodName) {
		// TODO Auto-generated method stub
		if(methodName.contains("logout"))
		{
			Editor ed = spref.edit();
			ed.putString("useremail", "");
			ed.putString("userid", "");
			ed.putString("access_token","");
			ed.commit();
			Intent intent = new Intent(BaseActivity.this,LoginActivity.class);
			intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
			startActivity(intent);
			finish();
			}
		
		
	}
}
