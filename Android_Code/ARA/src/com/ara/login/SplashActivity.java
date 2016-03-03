package com.ara.login;

import java.util.ArrayList;
import java.util.Timer;
import java.util.TimerTask;
import org.apache.http.NameValuePair;
import android.app.Activity;
import android.app.DownloadManager;
import android.app.DownloadManager.Request;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.Window;
import android.widget.ImageView;
import com.ara.async_tasks.AsyncResponseForARA;
import com.ara.async_tasks.AsyncTaskForARA;
import com.ara.model.User;
import com.ara.util.ARAParser;
import com.ara.util.Util;
import com.ara.base.R;
import com.ara.base.ServerUtilities;
import com.ara.board.DashBoardActivity;

public class SplashActivity extends Activity implements AsyncResponseForARA {

	private User usermodel;
	private ImageView imageView;
	private Timer timer;

	private TimerTask backgroundTimerTask;
	private int i = 0;
	private SharedPreferences spref;
	private Integer imageset[] = { 
			R.drawable.one, R.drawable.two,R.drawable.three, 
			R.drawable.four, R.drawable.five, R.drawable.six, 
			R.drawable.seven, R.drawable.eight, R.drawable.nine,
			R.drawable.ten, R.drawable.eleven, R.drawable.twelve,
			R.drawable.thirteen, R.drawable.fourteen, R.drawable.fourteen,
			R.drawable.fourteen, R.drawable.fourteen, R.drawable.fourteen,
			R.drawable.fourteen,R.drawable.fourteen,R.drawable.fourteen, };//21 image

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.activity_splash);

		//startBackgroundTimer();
		imageView = (ImageView) findViewById(R.id.imageView);
		//signUpAPI();
		
		spref = getSharedPreferences("ara_prefs",MODE_PRIVATE);
		withoutAnimation();
		
	}

	protected void startBackgroundTimer() {

		timer = new Timer();
		initializeBackgroundTimerTask();
		timer.schedule(backgroundTimerTask, 0, 120);
		Log.e("", "backtimerStart");
	}

	public void stopBackgroundTimer() {

		if (timer != null) {
			timer.cancel();
			timer = null;
			// System.out.println("backtimerStop");
			Log.e("", "backtimerStop");
		}
	}

	private void initializeBackgroundTimerTask() {
		backgroundTimerTask = new TimerTask() {
			public void run() {
				runOnUiThread(new Runnable() {
					@Override
					public void run() {
						i++;
						System.err.println("iii" + i);
						if (i < 20) {
							imageView.setImageResource(imageset[i]);
							if (i == 19) {
								stopBackgroundTimer();
								spref = getSharedPreferences("ara_prefs",MODE_PRIVATE);

								if (spref.getString("useremail", "").equals("")) {
									Intent mIntent = new Intent(
											SplashActivity.this,
											LoginActivity.class);
									SplashActivity.this.finish();
									startActivity(mIntent);

								} else {

									loginAPI();
								}
							}
						}

					}
				});
			}
		};
	}
	private void withoutAnimation()
		{
			  Runnable mRunnable;
		      Handler mHandler = new Handler();
		      mRunnable = new Runnable() {
		          @Override
		          public void run() {
		
		        	  if (spref.getString("useremail", "").equals("")) {
		      			Intent mIntent = new Intent(
		      					SplashActivity.this,
		      					LoginActivity.class);
		      			SplashActivity.this.finish();
		      			startActivity(mIntent);
		
		      		} else {
		
		      			loginAPI();
		      		}
		        	  
		          }
		      };
		      mHandler.postDelayed(mRunnable, 3 * 1000);	
		}
	private void loginAPI() {
		if (Util.isNetworkAvailable(SplashActivity.this)) {

			ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();

			String user = spref.getString("useremail", "");
			String pass = spref.getString("password", "");

			AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(
					SplashActivity.this, "other", "accounts/login",
					nameValuePairs, user, pass, false, "Please wait...");
			mWebPageTask.delegate = (AsyncResponseForARA) SplashActivity.this;
			mWebPageTask.execute();

		} else {
			Util.alertMessage(SplashActivity.this, Util.network_error);
		}
	}

	@Override
	public void processFinish(String output, String methodName) {
		// TODO Auto-generated method stub
		ARAParser parser = new ARAParser(SplashActivity.this);
		if (methodName.equals("accounts/login")) {
			Log.e(methodName, output);
			if (output.contains("Invalid User Name and Password")) {

				Util.ToastMessage(SplashActivity.this,
						"Invalid User Name and Password");
			} 
			else {
				usermodel = new User();
				usermodel = parser.parseSignUpResponse(output);
				Editor ed = spref.edit();
				ed.putString("usertoken", usermodel.getUserToken());
				ed.putString("meaid", usermodel.getMEAID());
				ed.putString("userimage", usermodel.getProfilePicName());
				ed.commit();

				System.err.println("splash"+usermodel.getProfilePicName());
				/// notification code
				ServerUtilities sUtil = new ServerUtilities();
				sUtil.deviceRegister(SplashActivity.this);
				/////
				Intent mIntent = new Intent(SplashActivity.this,
						DashBoardActivity.class);
				mIntent.putExtra("user", usermodel);
				SplashActivity.this.finish();
				startActivity(mIntent);
			}
		}
	}

	@Override
	protected void onPause() {
		// TODO Auto-generated method stub
		super.onPause();
		stopBackgroundTimer();
	}
	
/*private void signUpAPI() {
		
	 String servicestring = Context.DOWNLOAD_SERVICE;
	    DownloadManager downloadmanager;
	    downloadmanager = (DownloadManager) getSystemService(servicestring);
	    Uri uri = Uri
	      .parse("https://sites.google.com/site/compiletimeerrorcom/android-programming/oct-2013/DownloadManagerAndroid1.zip");
	    DownloadManager.Request request = new Request(uri);
	    Long reference = downloadmanager.enqueue(request);
	   
};*/
	 
		/*if (Util.isNetworkAvailable(SplashActivity.this)) {

		
			
			ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
			AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(SplashActivity.this,"get", "users/Notification/165", nameValuePairs, true, "Please wait...",false);
			mWebPageTask.delegate = (AsyncResponseForARA) SplashActivity.this;
			mWebPageTask.execute();
		} else {
			Util.alertMessage(SplashActivity.this, Util.network_error);
		}*/
	
}