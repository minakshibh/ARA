package com.ara.login;

import java.util.ArrayList;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import com.ara.async_tasks.AsyncResponseForARA;
import com.ara.async_tasks.AsyncTaskForARA;
import com.ara.base.BaseActivity;
import com.ara.model.User;
import com.ara.util.Util;
import com.ara.base.R;
import com.ara.board.DashBoardActivity;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;

public class ChangePasswordActivity extends Activity implements AsyncResponseForARA {

	private ImageView imageView_back;
	private TextView textView_back,textView_header;
	private Button btn_changepass;
	private User user_model;
	private EditText oldpassword, newpassword, confirm_pass;
	private SharedPreferences spref;

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.activity_changepassword);

		setUI();

		imageView_back.setOnClickListener(listener);
		textView_back.setOnClickListener(listener);
		btn_changepass.setOnClickListener(listener);

	}

	private void setUI() {
		// TODO Auto-generated method stub
		user_model = new User();
		spref = getSharedPreferences("ara_prefs", MODE_PRIVATE);
		oldpassword = (EditText) findViewById(R.id.oldpassword);
		newpassword = (EditText) findViewById(R.id.newpassword);
		textView_header= (TextView) findViewById(R.id.textView_header);
		textView_header.setTypeface(DashBoardActivity.typeface_timeburner);

		confirm_pass = (EditText) findViewById(R.id.confirm_pass);
		btn_changepass = (Button) findViewById(R.id.btn_changepass);
		//btn_changepass.setTypeface(DashBoardActivity.typeface_roboto);

		imageView_back = (ImageView) findViewById(R.id.imageView_back);
		textView_back = (TextView) findViewById(R.id.textView_back);
		textView_back.setTypeface(DashBoardActivity.typeface_roboto);
	}

	private View.OnClickListener listener = new View.OnClickListener() {

		@Override
		public void onClick(View v) {
			if (v == imageView_back) {

				finish();

			} else if (v == textView_back) {

				finish();
			} else if (v == btn_changepass) {

				if (oldpassword.getText().toString().equals("")) {
					Util.ToastMessage(ChangePasswordActivity.this,
							"Please enter old password");
				} else if (newpassword.getText().toString().equals("")) {
					Util.ToastMessage(ChangePasswordActivity.this,
							"Please enter new password");
				} 
				 else if (newpassword.getText().toString().equals(oldpassword.getText().toString())) {
					Util.ToastMessage(ChangePasswordActivity.this,
							"Old and new password cannot be same");
				 }
				else if (!oldpassword.getText().toString()
						.equals(spref.getString("password", ""))) {
					Util.ToastMessage(ChangePasswordActivity.this,
							"Old password not correct");
				} else if (confirm_pass.getText().toString().equals("")) {
					Util.ToastMessage(ChangePasswordActivity.this,
							"Please enter confirm password");
				} else if (!confirm_pass.getText().toString()
						.equals(newpassword.getText().toString())) {
					Util.ToastMessage(ChangePasswordActivity.this,
							"New password and confirm password should be same");
				} else {
					forgotAPI();
				}
			}
		}
	};

	private void forgotAPI() {

		if (Util.isNetworkAvailable(ChangePasswordActivity.this)) {

			ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();

			nameValuePairs.add(new BasicNameValuePair("UserId", spref
					.getString("userid", "0")));
			nameValuePairs.add(new BasicNameValuePair("CurrentPassword",
					oldpassword.getText().toString().trim()));
			nameValuePairs.add(new BasicNameValuePair("NewPassword",
					newpassword.getText().toString().trim()));

			AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(
					ChangePasswordActivity.this, "post",
					"users/changepassword", nameValuePairs, true,
					"Please wait...",true);
			mWebPageTask.delegate = (AsyncResponseForARA) ChangePasswordActivity.this;
			mWebPageTask.execute();
		} else {
			Util.alertMessage(ChangePasswordActivity.this, Util.network_error);
		}
	}

	@Override
	public void processFinish(String output, String methodName) {
		// TODO Auto-generated method stub
		if (methodName.equals("users/changepassword")) {
			Log.e(methodName, output);
			if (output.contains("true")) {
				AlertDialog.Builder alert = new AlertDialog.Builder(
						ChangePasswordActivity.this);
				// alert.setTitle("Congrats!!!");
				alert.setMessage("Your password has been changed successfully..!");
				alert.setPositiveButton("Ok",
						new DialogInterface.OnClickListener() {
							public void onClick(DialogInterface dialog,
									int which) {
								
								Editor ed=spref.edit();
								ed.putString("password", newpassword.getText().toString());
								ed.commit();
								
								finish();

							}
						});
				alert.show();
			} else {
				Util.ToastMessage(ChangePasswordActivity.this, output);
			}
		}
	}
}
