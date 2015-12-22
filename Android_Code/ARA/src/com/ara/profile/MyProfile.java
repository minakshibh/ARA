package com.ara.profile;

import java.util.ArrayList;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.os.Bundle;
import android.telephony.PhoneNumberFormattingTextWatcher;
import android.util.Log;
import android.view.View;
import android.view.Window;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;
import com.ara.async_tasks.AsyncResponseForARA;
import com.ara.async_tasks.AsyncTaskForARA;
import com.ara.base.BaseActivity;
import com.ara.imageloader.ImageLoader;
import com.ara.login.ChangePasswordActivity;
import com.ara.model.User;
import com.ara.util.ARAParser;
import com.ara.util.Util;
import com.ara.base.R;

public class MyProfile extends Activity implements AsyncResponseForARA {

	private EditText editText_email, editText_phone, editText_role,
			editText_mea, editText_lastname, editText_name;
	private TextView txt_back, textView_edit, text_changepass,
			textView_photoedit,textView_myprofile,textView_username;
	private ImageView imageView_back;
	private int count = 0, count_purchase = 0;
	private SharedPreferences spref;
	private User usermodel;
	private ImageView image_purchase;
	private ImageView imageView_profilepic;
	private String purchase = "";
	private TextView textView_back,lbl_changepass;
	private TextView textView_name,textView_lastname,textView_email,textView_phone,textView_role,textView_mea,
	textView_purchase,textview_purchase_no;
	private String imageurl="",phonenumber="";
	private ImageLoader imageLoader;
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.activity_myprofile);

		//setUI();
	
		
		
		
		
	}

	private void setUI() {
		usermodel = new User();
		spref = getSharedPreferences("ara_prefs", MODE_PRIVATE);
		editText_name = (EditText) findViewById(R.id.editText_name);
		editText_name.setTypeface(BaseActivity.typeface_roboto);
		
		editText_email = (EditText) findViewById(R.id.editText_email);
		editText_email.setTypeface(BaseActivity.typeface_roboto);
		editText_phone = (EditText) findViewById(R.id.editText_phone);
		editText_phone.setTypeface(BaseActivity.typeface_roboto);
		
		editText_role = (EditText) findViewById(R.id.editText_role);
		editText_role.setTypeface(BaseActivity.typeface_roboto);
		
		editText_mea = (EditText) findViewById(R.id.editText_mea);
		editText_mea.setTypeface(BaseActivity.typeface_roboto);
		
		lbl_changepass= (TextView) findViewById(R.id.lbl_changepass);
		text_changepass = (TextView) findViewById(R.id.text_changepass);
		textView_username = (TextView) findViewById(R.id.textView_username);
		//text_changepass.setTypeface(BaseActivity.typeface_roboto);
		editText_lastname = (EditText) findViewById(R.id.editText_lastname);
		imageView_profilepic = (ImageView) findViewById(R.id.imageView_profilepic);
		textView_edit = (TextView) findViewById(R.id.textView_edit);
		textView_edit.setTypeface(BaseActivity.typeface_roboto);
		textView_edit.setText("Edit");
		count=0;
		textView_photoedit = (TextView) findViewById(R.id.textView_photoedit);
		textView_photoedit.setTypeface(BaseActivity.typeface_roboto);
		image_purchase = (ImageView) findViewById(R.id.image_purchase);
		//textView_title=(TextView)findViewById(R.id.textView_title);
		//textView_title.setTypeface(BaseActivity.typeface_timeburner);
		imageView_back=(ImageView)findViewById(R.id.imageView_back);
		
		textView_back=(TextView)findViewById(R.id.textView_back);
		textView_back.setTypeface(BaseActivity.typeface_roboto);
		
		
		textView_myprofile=(TextView)findViewById(R.id.textView_myprofile);
		textView_myprofile.setTypeface(BaseActivity.typeface_timeburner);
		
		lbl_changepass.setTypeface(BaseActivity.typeface_roboto);
		
		 textView_name=(TextView)findViewById(R.id.textView_name);
		 textView_name.setTypeface(BaseActivity.typeface_roboto);
			
		 textView_lastname=(TextView)findViewById(R.id.textView_lastname);
		 textView_lastname.setTypeface(BaseActivity.typeface_roboto);
			
		 textView_email=(TextView)findViewById(R.id.textView_email);
		 textView_email.setTypeface(BaseActivity.typeface_roboto);
			
		 textView_phone=(TextView)findViewById(R.id.textView_phone);
		 textView_phone.setTypeface(BaseActivity.typeface_roboto);
			
		 textView_role=(TextView)findViewById(R.id.textView_role);
		 textView_role.setTypeface(BaseActivity.typeface_roboto);
			
		 textView_mea=(TextView)findViewById(R.id.textView_mea);
		 textView_mea.setTypeface(BaseActivity.typeface_roboto);
			
		 textView_purchase=(TextView)findViewById(R.id.textView_purchase);
		 textView_purchase.setTypeface(BaseActivity.typeface_roboto);
		 textview_purchase_no=(TextView)findViewById(R.id.textview_purchase_no);
	}

	private void setOnClickListener() {

		text_changepass.setOnClickListener(listener);
		textView_edit.setOnClickListener(listener);
		textView_photoedit.setOnClickListener(listener);
		image_purchase.setOnClickListener(listener);
		textView_back.setOnClickListener(listener);
		imageView_back.setOnClickListener(listener);
		imageView_profilepic.setOnClickListener(listener);
		editText_phone.addTextChangedListener(new PhoneNumberFormattingTextWatcher());
		
		

	}

	private View.OnClickListener listener = new View.OnClickListener() {

		@Override
		public void onClick(View v) {
			if (v == text_changepass) {

				Intent intent = new Intent(MyProfile.this,
						ChangePasswordActivity.class);
				startActivity(intent);
			} else if (v == textView_edit) {
				count++;
				if (count == 1) {
					enableData();
					textView_edit.setText("Save");
				} else if (count == 2) {
					if (editText_name.getText().toString().equals("")) {
						Util.ToastMessage(MyProfile.this, "Please enter name");
						count = 1;
					}
					else if (editText_lastname.getText().toString().equals("")) {
						Util.ToastMessage(MyProfile.this, "Please enter name");
						count = 1;
					}
					
					
					/*else if (editText_phone.getText().toString().length()>= 14) {
						Util.ToastMessage(MyProfile.this,"Please enter 10 digits phone number");
						count = 1;
					}*/
					else if (editText_phone.getText().toString().equals("")) {
						Util.ToastMessage(MyProfile.this,
								"Please enter phone number");
						count = 1;
					} 
					
					else if(!Util.isValidPhoneNumber(editText_phone.getText().toString()))
					{
						Util.ToastMessage(MyProfile.this,"Please enter valid phone number");
						count = 1;
					}
					
					else {
						count = 0;
						disableData();
						textView_edit.setText("Edit");
						// new uploadimage().execute();
						signUpAPI();
					}

				}
			} else if (v == textView_photoedit | v==imageView_profilepic) {
				// selectImage();
				Intent intent = new Intent(MyProfile.this,ImageUploadActivity.class);
				intent.putExtra("url", imageurl);
				startActivity(intent);
			} else if (v == image_purchase) {
				count_purchase++;
				if (count_purchase == 1) {
					image_purchase
							.setImageResource(R.drawable.checkbox2_checked);
					purchase = "true";
					textview_purchase_no.setText("Yes");
				} else if (count_purchase == 2) {
					image_purchase
							.setImageResource(R.drawable.checkbox2_unchecked);
					count_purchase = 0;
					purchase = "false";
					textview_purchase_no.setText("No");

				}
			}
			else if (v == textView_back) {
				finish();
			
			}
			else if (v == imageView_back) {
				finish();
			
			}
			
		}
	};

	private void disableData() {

		editText_name.setEnabled(false);
		editText_email.setEnabled(false);
		editText_phone.setEnabled(false);
		editText_role.setEnabled(false);
		editText_mea.setEnabled(false);
		editText_lastname.setEnabled(false);
		image_purchase.setEnabled(false);
		textView_name.setEnabled(false);
		textView_lastname.setEnabled(false);
		textView_email.setEnabled(false);
		textView_phone.setEnabled(false);
		textView_mea.setEnabled(false);
		lbl_changepass.setEnabled(false);
		textView_role.setEnabled(false);
		textview_purchase_no.setEnabled(false);
		textview_purchase_no.setVisibility(View.VISIBLE);
		textView_purchase.setEnabled(false);
		image_purchase.setVisibility(View.GONE);
		textView_photoedit.setVisibility(View.VISIBLE);
	}

	private void enableData() {
		textView_photoedit.setVisibility(View.GONE);
		editText_name.setEnabled(true);
		editText_lastname.setEnabled(true);
		editText_phone.setEnabled(true);
		image_purchase.setEnabled(true);
		textView_name.setEnabled(true);
		textView_phone.setEnabled(true);
		textView_lastname.setEnabled(true);
		textView_purchase.setEnabled(true);
		textview_purchase_no.setVisibility(View.GONE);
		image_purchase.setVisibility(View.VISIBLE);
		lbl_changepass.setEnabled(false);
	}

	private void loginAPI() {
		if (Util.isNetworkAvailable(MyProfile.this)) {

			ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();

			String user = spref.getString("useremail", "");
			String pass = spref.getString("password", "");

			AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(MyProfile.this,
					"other", "accounts/login", nameValuePairs, user, pass,
					true, "Please wait...");
			mWebPageTask.delegate = (AsyncResponseForARA) MyProfile.this;
			mWebPageTask.execute();

		} else {
			Util.alertMessage(MyProfile.this, Util.network_error);
		}
	}

	@Override
	public void processFinish(String output, String methodName) {
		// TODO Auto-generated method stub
		ARAParser parser = new ARAParser(MyProfile.this);
		if (methodName.equals("accounts/login")) {
			Log.e(methodName, output);
			if (output.contains("Invalid User Name and Password")) {

				Util.ToastMessage(MyProfile.this,
						"Invalid User Name and Password");
			} else {

				usermodel = parser.parseSignUpResponse(output);
			
				Editor ed=spref.edit();
				ed.putString("usertoken", usermodel.getUserToken());
				ed.putString("meaid", usermodel.getMEAID());
				ed.putString("userimage", usermodel.getProfilePicName());
				ed.commit();
				editText_name.setText(usermodel.getFirstName()) ;
						
				editText_lastname.setText(usermodel.getLastName());
				editText_email.setText(usermodel.getEmail());
				textView_username.setText(usermodel.getUserName());
				
			
				String getphone=usermodel.getPhoneNumber();
				editText_phone.setText(getphone);
				
			
				editText_role.setText(usermodel.getRoleName());
				
					if(usermodel.getMEAName().equals("null"))
					{
						editText_mea.setText("");
						}
				
				else{
				
					editText_mea.setText(usermodel.getMEAName());
				}
				imageurl=usermodel.getProfilePicName();
				
				purchase = usermodel.getPurchasedBefore();

				if (usermodel.getPurchasedBefore().equalsIgnoreCase("true")) {
					image_purchase.setImageResource(R.drawable.checkbox2_checked);
					textview_purchase_no.setText("Yes");
				} else {
					image_purchase.setImageResource(R.drawable.checkbox2_unchecked);
					textview_purchase_no.setText("No");

				}

				editText_lastname.setText(usermodel.getLastName());
				  imageLoader = new ImageLoader(MyProfile.this);
			     imageLoader.DisplayImage(imageurl, imageView_profilepic);
			}

		}

		// sign up response
		else if (methodName.equals("users")) {
			if (output.contains("UserId")) {

				AlertDialog.Builder alert = new AlertDialog.Builder(
						MyProfile.this);
				alert.setMessage("Profile updated successfully");
				alert.setPositiveButton("ok",
						new DialogInterface.OnClickListener() {
							public void onClick(DialogInterface arg0, int arg1) {

							}
						});
				alert.show();

			} else {
				Util.ToastMessage(MyProfile.this, output);
			}
		}

	}

	private void signUpAPI() {
		
		phonenumber=editText_phone.getText().toString();
		
		phonenumber=phonenumber.replace("(", "");
		phonenumber=phonenumber.replace(")", "");
		phonenumber=phonenumber.replace("-", "");
		phonenumber=phonenumber.replace(" ", "");
		if (Util.isNetworkAvailable(MyProfile.this)) {

		
			ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();

			nameValuePairs.add(new BasicNameValuePair("UserName", usermodel.getUserName()));
			nameValuePairs.add(new BasicNameValuePair("Password", usermodel
					.getPassword()));
			nameValuePairs.add(new BasicNameValuePair("RoleID", usermodel
					.getRoleID()));
			nameValuePairs.add(new BasicNameValuePair("FirstName", editText_name.getText().toString()));
			nameValuePairs.add(new BasicNameValuePair("LastName", editText_lastname.getText().toString()));
			nameValuePairs.add(new BasicNameValuePair("PhoneNumber",phonenumber));
			nameValuePairs.add(new BasicNameValuePair("Email", usermodel.getEmail()));
			nameValuePairs.add(new BasicNameValuePair("IsFacebookUser",
					usermodel.getIsFacebookUser()));

			nameValuePairs.add(new BasicNameValuePair("PurchasedBefore",
					purchase));
			nameValuePairs.add(new BasicNameValuePair("ProfilePicName", ""));
			nameValuePairs.add(new BasicNameValuePair("MEAID", usermodel
					.getMEAID()));
			nameValuePairs.add(new BasicNameValuePair("userId", usermodel.getUserId()));

			AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(MyProfile.this,
					"post", "users", nameValuePairs, true, "Please wait...",false);
			mWebPageTask.delegate = (AsyncResponseForARA) MyProfile.this;
			mWebPageTask.execute();
		} else {
			Util.alertMessage(MyProfile.this, Util.network_error);
		}
	}
	@Override
	protected void onResume() {
		// TODO Auto-generated method stub
		super.onResume();
		setUI();
		loginAPI();
		setOnClickListener();
		disableData();
	
		
	}
}