package com.ara.login;

import java.util.ArrayList;
import org.apache.http.NameValuePair;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences.Editor;
import android.os.Bundle;
import android.text.TextUtils;
import android.text.method.HideReturnsTransformationMethod;
import android.util.Log;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import com.ara.async_tasks.AsyncResponseForARA;
import com.ara.async_tasks.AsyncTaskForARA;
import com.ara.base.BaseActivity;
import com.ara.base.ServerUtilities;
import com.ara.util.Util;
import com.ara.base.R;
import com.ara.board.DashBoardActivity;
import com.ara.model.User;

public class ForgotPasswordActivity extends Activity implements AsyncResponseForARA{
	private TextView signUp, logIn;
	private Button resetPassword;
	private EditText userId;
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.activity_forgot_password);

		setUI();
		setOnClickListener();

	}

	private void setUI() {
		// TODO Auto-generated method stub
		logIn = (TextView) findViewById(R.id.logIn);
		logIn.setTypeface(BaseActivity.typeface_roboto);
		signUp = (TextView) findViewById(R.id.signUp);
		signUp.setTypeface(BaseActivity.typeface_roboto);
		
		resetPassword=(Button)findViewById(R.id.resetPassword);
		//resetPassword.setTypeface(BaseActivity.typeface_roboto);
		userId=(EditText)findViewById(R.id.userId);
		userId.setTypeface(BaseActivity.typeface_roboto);
		
		if(getIntent().getStringExtra("email")!=null)
		{
			userId.setText(getIntent().getStringExtra("email"));
		}
	}

	private void setOnClickListener() {

		logIn.setOnClickListener(listener);
		signUp.setOnClickListener(listener);
		resetPassword.setOnClickListener(listener);

	}

	private View.OnClickListener listener = new View.OnClickListener() {
		public void onClick(View v) {
			if (v == logIn) {
				Intent intent = new Intent(ForgotPasswordActivity.this,LoginActivity.class);
				intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
				startActivity(intent);
				finish();

			} else if (v == signUp) {
				Intent intent = new Intent(ForgotPasswordActivity.this,EmailValidatorActivity.class);
				intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
				startActivity(intent);
				finish();
			}
			else if (v == resetPassword) {
				if(userId.getText().toString().equals(""))
				{
					Util.ToastMessage(ForgotPasswordActivity.this, "Please enter email address");
					}
				else if (!android.util.Patterns.EMAIL_ADDRESS.matcher(
						userId.getText().toString()).matches()
						&& !TextUtils.isEmpty(userId.getText().toString())) {
					Util.ToastMessage(ForgotPasswordActivity.this,"Please enter a valid email address");
				
				}
				else
				{
					resetPassword();
					Util.hideKeyboard(ForgotPasswordActivity.this);
					}
				}
			
		}

		
	};
	
	private void resetPassword() {
		// TODO Auto-generated method stub
		if (Util.isNetworkAvailable(ForgotPasswordActivity.this)) {

			String user=userId.getText().toString();
		
			ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
			AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(
		    		ForgotPasswordActivity.this, "other", "users/forgetpassword",
		    		nameValuePairs, user, "", true, "Please wait...");
			Log.e("users/forgetpassword", nameValuePairs.toString());
			mWebPageTask.delegate = (AsyncResponseForARA) ForgotPasswordActivity.this;
			mWebPageTask.execute();
		} else {
			Util.alertMessage(ForgotPasswordActivity.this, Util.network_error);
		}
	}
	@Override
	public void processFinish(String output, String methodName) {
		// TODO Auto-generated method stub
		if(methodName.equals("users/forgetpassword"))
		{
			if(output.contains("further instructions"))
			{
				AlertDialog.Builder alert = new AlertDialog.Builder(ForgotPasswordActivity.this);
				alert.setMessage("Please check your email for further instructions.");
				alert.setPositiveButton("ok",
						new DialogInterface.OnClickListener() {
							public void onClick(DialogInterface arg0, int arg1) {
	
							finish();
							}
						});
				alert.show();
			}

		}
	}
}