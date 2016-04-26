package com.ara.login;

import java.util.ArrayList;

import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import com.ara.async_tasks.AsyncResponseForARA;
import com.ara.async_tasks.AsyncTaskForARA;
import com.ara.base.BaseActivity;
import com.ara.base.R;
import com.ara.util.Util;

public class ResetPasswordActivity extends Activity implements AsyncResponseForARA{
	
	//AutoAvesReferralApp://?token=550c5b72-9dba-4b76-80af-b6a9becb3b01
	private TextView signUp, logIn;
	private Button resetPassword;
	private EditText password,confirm;
	private String token="";
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.activity_reset);

		setUI();
		Util.hideKeyboard(ResetPasswordActivity.this);
		setOnClickListener();

	}

	private void setUI() {
		// TODO Auto-generated method stub
	/*	logIn = (TextView) findViewById(R.id.logIn);
		logIn.setTypeface(BaseActivity.typeface_roboto);
		signUp = (TextView) findViewById(R.id.signUp);
		signUp.setTypeface(BaseActivity.typeface_roboto);*/
		
		resetPassword=(Button)findViewById(R.id.resetPassword);
		//resetPassword.setTypeface(BaseActivity.typeface_roboto);
		password=(EditText)findViewById(R.id.userId);
		confirm=(EditText)findViewById(R.id.confirm);
		password.setTypeface(BaseActivity.typeface_roboto);
		
		Intent intent = getIntent();
	    String action = intent.getAction();
	    Uri data = intent.getData();
	    String getData=data.toString();
	    if(getData!=null)
	    {
	    	try{
		    String[] str_array = getData.split("=");
		    String stringa = str_array[0]; 
		    token = str_array[1];
	    	}catch(Exception e)
	    	{
	    		e.printStackTrace();
	    	}
	    }
		
	}

	private void setOnClickListener() {

		
		resetPassword.setOnClickListener(listener);

	}

	private View.OnClickListener listener = new View.OnClickListener() {
		public void onClick(View v) {
		
			 if (v == resetPassword) {
				if(password.getText().toString().equals(""))
				{
					Util.ToastMessage(ResetPasswordActivity.this, "Please enter password");
					}
				else if(!confirm.getText().toString().equals(password.getText().toString()))
				{
					Util.ToastMessage(ResetPasswordActivity.this, "Password and confrim password not match");
				}
				else
				{
					resetPassword();
					Util.hideKeyboard(ResetPasswordActivity.this);
					}
				}
			
		}

		
	};
	
	private void resetPassword() {
		// TODO Auto-generated method stub
		if (Util.isNetworkAvailable(ResetPasswordActivity.this)) {

			
			ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
			//nameValuePairs.add(new BasicNameValuePair("userpassword", password.getText().toString().trim()));
			//nameValuePairs.add(new BasicNameValuePair("useruniqueid", "550c5b72-9dba-4b76-80af-b6a9becb3b01"));
			AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(
					ResetPasswordActivity.this, "reset", "users/resetpassword",nameValuePairs, token,  password.getText().toString().trim(), true, "Please wait...");
			Log.e("users/resetpassword", token+password.getText().toString());
			mWebPageTask.delegate = (AsyncResponseForARA) ResetPasswordActivity.this;
			mWebPageTask.execute();
		} else {
			Util.alertMessage(ResetPasswordActivity.this, Util.network_error);
		}
	}
	@Override
	public void processFinish(String output, String methodName) {
		// TODO Auto-generated method stub
		//"Your password have been changed, Please get login in application."

		if(methodName.equals("users/resetpassword"))
		{
			if(output.contains("been changed"))
			{
				AlertDialog.Builder alert = new AlertDialog.Builder(ResetPasswordActivity.this);
				alert.setMessage("Your password have been changed, Please get login in application.");
				alert.setPositiveButton("ok",
						new DialogInterface.OnClickListener() {
							public void onClick(DialogInterface arg0, int arg1) {
	
								Intent intent = new Intent(ResetPasswordActivity.this,LoginActivity.class);
								intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
								startActivity(intent);
								finish();
							}
						});
				alert.show();
			}

		}
	}
}