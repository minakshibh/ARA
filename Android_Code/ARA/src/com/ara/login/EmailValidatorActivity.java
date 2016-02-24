package com.ara.login;

import java.util.ArrayList;

import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.ara.async_tasks.AsyncResponseForARA;
import com.ara.async_tasks.AsyncTaskForARA;
import com.ara.base.BaseActivity;
import com.ara.base.R;
import com.ara.model.MEA;
import com.ara.model.User;
import com.ara.util.ARAParser;
import com.ara.util.Util;
import com.facebook.android.AsyncFacebookRunner;
import com.facebook.android.Facebook;

public class EmailValidatorActivity  extends Activity implements AsyncResponseForARA {

	private ImageView imageView_back;
	private TextView txt_Alreadyhave,txt_login,textViewComposeProfile,textViewEmailAdress;
	private Button btnProceedNext;
	private User user_model;
	private EditText email;
	private SharedPreferences spref;
	private LinearLayout login;
	private  User usermodel;
	private boolean IsFacebookUser=false; 
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.activity_emailvalidator);

		setUI();
		setOnClickListener();
	}

	private void setUI() {
		// TODO Auto-generated method stub
		login=(LinearLayout)findViewById(R.id.login);
		email=(EditText)findViewById(R.id.email);
		textViewComposeProfile=(TextView)findViewById(R.id.textViewComposeProfile);
		textViewComposeProfile.setTypeface(BaseActivity.typeface_roboto);
		textViewEmailAdress=(TextView)findViewById(R.id.textViewEmailAdress);
		textViewEmailAdress.setTypeface(BaseActivity.typeface_roboto);
		btnProceedNext=(Button)findViewById(R.id.btnProceedNext);
		//btnProceedNext.setTypeface(BaseActivity.typeface_roboto);
		txt_Alreadyhave=(TextView)findViewById(R.id.txt_Alreadyhave);
		txt_Alreadyhave.setTypeface(BaseActivity.typeface_roboto);
		txt_login=(TextView)findViewById(R.id.txt_login);
		txt_login.setTypeface(BaseActivity.typeface_roboto);
		
		if(getIntent().getStringExtra("firstname")!=null)
		{
			IsFacebookUser=true;
			
			email.setText(getIntent().getStringExtra("email"));
			
		
			}
	}
	
	private void setOnClickListener() {

		
		login.setOnClickListener(listener);
		btnProceedNext.setOnClickListener(listener);
		textViewComposeProfile.setOnClickListener(listener);
	}
	private View.OnClickListener listener = new View.OnClickListener() {

		@SuppressWarnings("deprecation")
		@Override
		public void onClick(View v) {
			if (v == login ) {
			
				Intent intent = new Intent(EmailValidatorActivity.this,LoginActivity.class);
				startActivity(intent);
				finish();
			} 
			
			
			else if (v == btnProceedNext | v == textViewComposeProfile) {
				
				Util.hideKeyboard(EmailValidatorActivity.this);
				String gettingEmail=email.getText().toString().trim();
				if(gettingEmail.length()==0)
				{
					Util.ToastMessage(EmailValidatorActivity.this, "Please enter email address");
				}
				else if (!android.util.Patterns.EMAIL_ADDRESS.matcher(
						gettingEmail).matches()
						&& !TextUtils.isEmpty(gettingEmail)) {
					Util.ToastMessage(EmailValidatorActivity.this,"Please enter a valid email address");
				//	emailCheck=0;
					
				//	img_emailId.setVisibility(View.INVISIBLE);
				}
				else{
					//goToSignUp();
					validationCheck("Email", gettingEmail);
				}
			}
			
		}
	};
	
	private void validationCheck(String id, String value) {
		if (Util.isNetworkAvailable(EmailValidatorActivity.this)) {

		ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();

		nameValuePairs.add(new BasicNameValuePair(id, value));

		AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(
				EmailValidatorActivity.this, "post", "users/confirm", nameValuePairs,
				true, "Please wait...",false);
		mWebPageTask.delegate = (AsyncResponseForARA) EmailValidatorActivity.this;
		mWebPageTask.execute();
		} else {
			Util.alertMessage(EmailValidatorActivity.this, Util.network_error);
		}
	}
	private void resetPassword() {
		// TODO Auto-generated method stub
		if (Util.isNetworkAvailable(EmailValidatorActivity.this)) {

			String user=email.getText().toString();
		
			ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
			AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(
					EmailValidatorActivity.this, "other", "users/forgetpassword",
		    		nameValuePairs, user, "", true, "Please wait...");
			mWebPageTask.delegate = (AsyncResponseForARA) EmailValidatorActivity.this;
			mWebPageTask.execute();
		} else {
			Util.alertMessage(EmailValidatorActivity.this, Util.network_error);
		}
	}
	private void goToSignUp()
	{
		Intent intent = new Intent(EmailValidatorActivity.this,RegisterActivity.class);
		if(IsFacebookUser)
		{
			
			intent.putExtra("firstname",getIntent().getStringExtra("firstname"));
			intent.putExtra("lastname",getIntent().getStringExtra("lastname"));
			intent.putExtra("username",getIntent().getStringExtra("username"));
		}
		else{
			intent.putExtra("newEmail",email.getText().toString());
		}
		startActivity(intent);
		
	}
	
	@Override
	public void processFinish(String output, String methodName) {
		// TODO Auto-generated method stub
		// email validation username
		
		final ARAParser parser = new ARAParser(EmailValidatorActivity.this);
				 if (methodName.equals("users/confirm")) {
						
				/*	if (parameter.equalsIgnoreCase("UserName")) {
						
						progressBar_username.setVisibility(View.GONE);
						if (output.contains("User Name not exist")) {
							// img_userId.setImageResource(R.drawable.checkbox_checked);
							img_userId.setVisibility(View.VISIBLE);
							userId.setError(null);
							checkuserid = 1;
						} else {
							userId.setError("User name already exist");
							img_userId.setVisibility(View.INVISIBLE);
							checkuserid = 2;
						}
					}*/
					//else if (parameter.equalsIgnoreCase("Email")) {
						
						//progressBar_email.setVisibility(View.GONE);
						if (output.contains("Email address not exist")) {
							//img_emailId.setVisibility(View.VISIBLE);
							//emailId.setError(null);
							//checkemail = 1;
							//mea_spinner.setSelection(0);
							//role_spinner.setSelection(0);
							//flag_setspinner=false;
							//str_userId="0";
							goToSignUp();
						}
						
						else {
							String phone=null;
							usermodel = new User();
							usermodel = parser.parseSignUpResponse(output);
					
					/*	// checking for existing mea	
							for(int i=0;i<arrayList_Mea.size();i++)
							{
							if(usermodel.getEmail().equals(arrayList_Mea.get(i).getEmail()))//checking mea list email exit or not
							{
								String name=arrayList_Mea.get(i).getName();
								int gettingStatePosition=0;
								str_userId=arrayList_Mea.get(i).getId();
								
								role_spinner.setSelection(2); //set role spinner position
								
								try {
									if (arrayList_Mea.size() > 0) { ///get mea spinner position

										int j = 0;
										for (MEA mea : arrayList_Mea) {
											String getname = mea.getName();
											if (name.equals(getname)) {
												gettingStatePosition = j;
											
												break;
											}
											j++;
										}
									}
									flag_setspinner=true;
									
									mea_spinner.setSelection(gettingStatePosition);
									img_emailId.setVisibility(View.VISIBLE);
									emailId.setError(null);

								} catch (Exception e) {
									e.printStackTrace();
								}
														
							}
							else
							{
								//flag_setspinner=false;
								
								//emailId.setError("Email address already exist");
								//img_emailId.setVisibility(View.INVISIBLE);
								//checkemail = 2;
								
							}
							}*/
							
									
							if (usermodel.getUserType().equalsIgnoreCase("client")) {

								 phone=usermodel.getPhoneNumber();
								
								
								Intent intent = new Intent(EmailValidatorActivity.this,RegisterActivity.class);
								intent.putExtra("fName", usermodel.getFirstName());
								intent.putExtra("lName", usermodel.getLastName());
								intent.putExtra("clientId",usermodel.getUserDetailId());
								intent.putExtra("email",email.getText().toString());
								if(!usermodel.getUserId().equals("0"))
								{
									intent.putExtra("userid", usermodel.getUserId());
									}
								if(phone!=null)
								{
									intent.putExtra("phone", usermodel.getPhoneNumber());
									}
								
								
								startActivity(intent);
								
								
								
								
								
								
								//"We already have your details. Are you a previous client of ARA?" This should state, 
								//"Are you a previous client of Automotive Avenues?"
								//"We already have your details. Are you a previous client of ARA ?"
		AlertDialog.Builder alert = new AlertDialog.Builder(EmailValidatorActivity.this);
		alert.setMessage("Are you a previous client of Automotive Avenues?");
		alert.setPositiveButton("Yes i am",new DialogInterface.OnClickListener() {
											public void onClick(DialogInterface arg0,
													int arg1) {

												//checkemail = 1;
												//flagClient=true;
												//str_userId="0";
											String 	firstName=(usermodel.getFirstName());
											String	lastName=usermodel.getLastName();
												if(!usermodel.getUserId().equals("0"))
												{
													String userId=usermodel.getUserId();
												}
												String phone=usermodel.getPhoneNumber();
												if(phone!=null)
												{
													String phone1=phone;
													}
												String emailId=usermodel.getEmail();
												// check for error or emailid
											
												//emailId.setError(null);
												String clientId=usermodel.getUserDetailId();
														
												/*try{
												mea_spinner.setSelection(Integer.parseInt(usermodel.getMEAID()));
												role_spinner.setSelection(Integer.parseInt(usermodel.getRoleID()));
																
												}catch(Exception e)
												{
													e.printStackTrace();
												}*/

											}
										});
								alert.setNegativeButton("ok",
										new DialogInterface.OnClickListener() {
											public void onClick(DialogInterface arg0,
													int arg1) {
												
												//str_userId="0";
												//flagClient=false;
											}
										});
								//alert.show();
							} 
							else if(usermodel.getUserType().equalsIgnoreCase("user")) {
									
								
									/*if(role_spinner.getSelectedItemPosition()!=2)
									{
										emailId.setError("Unable to add user--email address already exists");
										img_emailId.setVisibility(View.INVISIBLE);
										checkemail = 2;
									}*/
								
								AlertDialog.Builder alert = new AlertDialog.Builder(EmailValidatorActivity.this);
								alert.setMessage("You are aleady registered. Would you like to reset your password?");
								alert.setPositiveButton("Yes",new DialogInterface.OnClickListener() {
																	public void onClick(DialogInterface arg0,
																			int arg1) {
																	
																		resetPassword();
																	
																		
																		//checkemail = 1;
																		//flagClient=true;
																		//str_userId="0";
																	String 	firstName=(usermodel.getFirstName());
																	String	lastName=usermodel.getLastName();
																		if(!usermodel.getUserId().equals("0"))
																		{
																			String userId=usermodel.getUserId();
																		}
																		String phone=usermodel.getPhoneNumber();
																		if(phone!=null)
																		{
																			String phone1=phone;
																			}
																		String emailId=usermodel.getEmail();
																		// check for error or emailid
																	
																		//emailId.setError(null);
																		String clientId=usermodel.getUserDetailId();
																				
																		/*try{
																		mea_spinner.setSelection(Integer.parseInt(usermodel.getMEAID()));
																		role_spinner.setSelection(Integer.parseInt(usermodel.getRoleID()));
																						
																		}catch(Exception e)
																		{
																			e.printStackTrace();
																		}*/

																	}
																});
														alert.setNegativeButton("No",
																new DialogInterface.OnClickListener() {
																	public void onClick(DialogInterface arg0,
																			int arg1) {
																		
																	finish();
																	}
																});
														alert.show();
									
							}
						}
				//	} 

				}
				 else if(methodName.equals("users/forgetpassword"))
					{
						if(output.contains("further instructions"))
						{
							AlertDialog.Builder alert = new AlertDialog.Builder(EmailValidatorActivity.this);
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