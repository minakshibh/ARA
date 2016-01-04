package com.ara.login;

import android.app.Activity;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.Window;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;

import com.ara.async_tasks.AsyncResponseForARA;
import com.ara.base.R;
import com.ara.model.User;

public class EmailValidatorActivity  extends Activity implements AsyncResponseForARA {

	private ImageView imageView_back;
	private TextView textView_back,textView_header;
	private Button btn_changepass;
	private User user_model;
	private EditText oldpassword, newpassword, confirm_pass;
	private SharedPreferences spref;

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.activity_emailvalidator);

		setUI();
	}

	private void setUI() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void processFinish(String output, String methodName) {
		// TODO Auto-generated method stub
		
	}
	
}