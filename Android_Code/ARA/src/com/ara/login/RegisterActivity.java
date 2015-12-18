package com.ara.login;

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
import android.text.TextUtils;
import android.util.Log;
import android.view.View;
import android.view.View.OnFocusChangeListener;
import android.view.Window;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ProgressBar;
import android.widget.Spinner;
import android.widget.TextView;
import com.ara.async_tasks.AsyncResponseForARA;
import com.ara.async_tasks.AsyncTaskForARA;
import com.ara.base.BaseActivity;
import com.ara.base.ServerUtilities;
import com.ara.model.MEA;
import com.ara.model.Role;
import com.ara.model.User;
import com.ara.util.ARAParser;
import com.ara.util.Util;
import com.ara.base.R;
import com.ara.board.DashBoardActivity;

public class RegisterActivity extends Activity implements AsyncResponseForARA {
	private TextView signUp, logIn,txt_purchase,txt_login,txt_Alreadyhave,txt_mea_name;
	private LinearLayout login,layout_mea;
	private Button btn_signUp;
	private EditText firstName, lastName, userId, phNumber, emailId, password, role;
	private ArrayList<MEA> arrayList_Mea = new ArrayList<MEA>();
	private ArrayList<Role> arrayList_role = new ArrayList<Role>();
	private Spinner mea_spinner, role_spinner;
	private String parameter = "";
	private int checkuserid = 0, checkemail = 0;
	private ImageView img_userId, img_emailId, purchase_chkBox;
	private String mea_id = "-1", role_id = "-1";
	private String PurchasedBefore = "false";
	private int count = 0,emailCheck=0;
	private User usermodel;
	private String phonenumber="",str_userId="0",IsFacebookUser="false";
	private SharedPreferences spref;
	private ProgressBar progressBar_email,progressBar_username;
	private boolean flag_setspinner=false;
	private boolean flagClient=false;
	private String clientId="";
	private String phone=null;

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.activity_register);

		setUI();
		setOnClickListener();
		getMEAData();
		setFacebookValue();
	}

	private void setUI() {
		// TODO Auto-generated method stub
		
		
		
		login = (LinearLayout) findViewById(R.id.login);
		layout_mea =(LinearLayout) findViewById(R.id.layout_mea);
		spref = getSharedPreferences("ara_prefs", MODE_PRIVATE);
		firstName = (EditText) findViewById(R.id.firstName);
		
	
		progressBar_email=(ProgressBar)findViewById(R.id.progressBar_email);
		progressBar_username=(ProgressBar)findViewById(R.id.progressBar_username);
		lastName = (EditText) findViewById(R.id.lastName);
		lastName.setTypeface(BaseActivity.typeface_roboto);
		userId = (EditText) findViewById(R.id.userId);
		userId.setTypeface(BaseActivity.typeface_roboto);
		phNumber = (EditText) findViewById(R.id.phNumber);
		phNumber.setTypeface(BaseActivity.typeface_roboto);
		emailId = (EditText) findViewById(R.id.emailId);
		emailId.setTypeface(BaseActivity.typeface_roboto);
		password = (EditText) findViewById(R.id.password);
		password.setTypeface(BaseActivity.typeface_roboto);
		
		txt_Alreadyhave=(TextView)findViewById(R.id.txt_Alreadyhave);
		txt_Alreadyhave.setTypeface(BaseActivity.typeface_roboto);
		
		txt_login=(TextView)findViewById(R.id.txt_login);
		txt_login.setTypeface(BaseActivity.typeface_roboto);
		
		txt_purchase=(TextView)findViewById(R.id.lbl_purchase);
		txt_purchase.setTypeface(BaseActivity.typeface_roboto);
		
		btn_signUp = (Button) findViewById(R.id.btn_signUp);
		btn_signUp.setTypeface(BaseActivity.typeface_roboto);
		mea_spinner = (Spinner) findViewById(R.id.spinnermea);
		role_spinner = (Spinner) findViewById(R.id.role_spinner);
		img_userId = (ImageView) findViewById(R.id.img_userId);
		img_emailId = (ImageView) findViewById(R.id.img_emailId);
		purchase_chkBox = (ImageView) findViewById(R.id.purchase_chkBox);
		
		txt_mea_name=(TextView)findViewById(R.id.txt_mea_name);
	}
	private void setFacebookValue()
	{
		if(getIntent().getStringExtra("firstname")!=null)
		{
			IsFacebookUser="true";
			firstName.setText(getIntent().getStringExtra("firstname"));
			lastName.setText(getIntent().getStringExtra("lastname"));
			userId.setText(getIntent().getStringExtra("username"));
			emailId.setText(getIntent().getStringExtra("email"));
			userId.setFocusableInTouchMode(true);
			userId.requestFocus();
			userId.setSelection(userId.getText().length());
			
			//usernameChecker();
			emailChecker();
			}
	}
	private void getMEAData() {
		if (Util.isNetworkAvailable(RegisterActivity.this)) {
			AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(
					RegisterActivity.this, "get", "users/mea",
					new ArrayList<NameValuePair>(), true, "Please wait...",false);
			mWebPageTask.delegate = (AsyncResponseForARA) this;
			mWebPageTask.execute();

			AsyncTaskForARA mWebPageTask1 = new AsyncTaskForARA(
					RegisterActivity.this, "get", "roles",
					new ArrayList<NameValuePair>(), true, "Please wait...",false);
			mWebPageTask1.delegate = (AsyncResponseForARA) this;
			mWebPageTask1.execute();

		} else {
			Util.alertMessage(RegisterActivity.this,
					"Please check your internet connection");
		}
	}

	private void setOnClickListener() {

		
		userId.setOnFocusChangeListener(new OnFocusChangeListener() {
			@Override
			public void onFocusChange(View v, boolean hasFocus) {
			    if(hasFocus){
			    
			    }else {
			    	
			    	usernameChecker();
			    	
			    }
			   }
			});
		
		
		emailId.setOnFocusChangeListener(new OnFocusChangeListener() {
			@Override
			public void onFocusChange(View v, boolean hasFocus) {
			    if(hasFocus){
			    
			    }else {
			    	
			    	emailChecker();

			   }
			}
			});
	
	
	
		phNumber.addTextChangedListener(new PhoneNumberFormattingTextWatcher());
		
		phonenumber=phNumber.getText().toString();
		
		phonenumber=phonenumber.replace("(", "");
		phonenumber=phonenumber.replace(")", "");
		phonenumber=phonenumber.replace("-", "");
		phonenumber=phonenumber.replace(" ", "");
		
		System.err.println(phonenumber);
		
	
		role_spinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
					public void onItemSelected(AdapterView<?> arg0, View arg1,
							int position, long arg3) {
						// TODO Auto-generated method stub
						Util.hideKeyboard(RegisterActivity.this);

						Role role_Model = (Role) role_spinner.getSelectedItem();

						role_id = role_Model.getId();
						
						String rolename=role_Model.getName();
						if(!rolename.contains("MEA"))
						{
							
							str_userId="0";
							if(flag_setspinner)
							{
								checkemail = 2;
								emailId.setError("Email address already exist");
								img_emailId.setVisibility(View.INVISIBLE);
							}
							
							try{
							mea_spinner.setSelection(0);
							}
							catch(Exception e)
							{
								e.printStackTrace();
								}
						}
						else
						{
							mea_spinner.setSelection(0);
							/*String gettingEmail=emailId.getText().toString();
						
							 if (android.util.Patterns.EMAIL_ADDRESS.matcher(
										gettingEmail).matches()
										&& !TextUtils.isEmpty(gettingEmail)) {
									parameter = "Email";
						    		emailCheck=1;
									img_emailId.setVisibility(View.INVISIBLE);
									progressBar_email.setVisibility(View.VISIBLE);
									validationCheck("Email", emailId.getText().toString());
					    	}*/
							
						}
						/*String mea_name= role_Model.getName();
						System.err.println("spinnerrr  mea");
						if(mea_name.equals("MEA"))
						{
							txt_mea_name.setVisibility(View.VISIBLE);
							txt_mea_name.setText(mea_name);
							layout_mea.setVisibility(View.GONE);
							usertype=false;
						}
						else
						{
							txt_mea_name.setVisibility(View.GONE);
							layout_mea.setVisibility(View.VISIBLE);
							usertype=true;
							
						}*/
						
					}

					public void onNothingSelected(AdapterView<?> arg0) {
						// TODO Auto-generated method stub

					}
				});
		mea_spinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
			public void onItemSelected(AdapterView<?> arg0, View arg1,
					int position, long arg3) {
				// TODO Auto-generated method stub
				Util.hideKeyboard(RegisterActivity.this);

				MEA mea_Model = (MEA) mea_spinner.getSelectedItem();
		
				mea_id = mea_Model.getId();
				System.err.println("spinnerrr  role");
			
			}

			public void onNothingSelected(AdapterView<?> arg0) {
				// TODO Auto-generated method stub

			}
		});
		
		purchase_chkBox.setOnClickListener(listener);
		login.setOnClickListener(listener);	
		btn_signUp.setOnClickListener(listener);
		txt_purchase.setOnClickListener(listener);
		
	
	}
	
	private void usernameChecker()
	{
		if(!userId.getText().toString().equals(""))
    	{
	    	parameter = "UserName";
			img_userId.setVisibility(View.INVISIBLE);
			progressBar_username.setVisibility(View.VISIBLE);
			validationCheck("UserName", userId.getText().toString());
	    	}
    	else
    	{
    		img_userId.setVisibility(View.INVISIBLE);
    	}
	}
	private void emailChecker()
	{
	
	
		String gettingEmail=emailId.getText().toString();
		
		if (!android.util.Patterns.EMAIL_ADDRESS.matcher(
					gettingEmail).matches()
					&& !TextUtils.isEmpty(gettingEmail)) {
				Util.ToastMessage(RegisterActivity.this,"Please enter a valid email address");
				emailCheck=0;
				
				img_emailId.setVisibility(View.INVISIBLE);
		}
		else if(gettingEmail.equals(""))
		{
			img_emailId.setVisibility(View.INVISIBLE);
			emailCheck=0;
		}
		else
		{
			parameter = "Email";
			emailCheck=1;
			img_emailId.setVisibility(View.INVISIBLE);
			progressBar_email.setVisibility(View.VISIBLE);
			validationCheck("Email", emailId.getText().toString());
		}
	}
	private View.OnClickListener listener = new View.OnClickListener() {

		@Override
		public void onClick(View v) {
			if (v == purchase_chkBox | v==txt_purchase) {
				count++;

				if (count == 1) {
					PurchasedBefore = "true";
					purchase_chkBox.setImageResource(R.drawable.checkbox_checked);
					
				} else if (count == 2) {
					count = 0;
					PurchasedBefore = "false";
					purchase_chkBox.setImageResource(R.drawable.checkbox_unchecked);
				}

			} else if (v == login) {
				Intent intent = new Intent(RegisterActivity.this,
						LoginActivity.class);
				startActivity(intent);
				finish();
			}
			 else if (v == btn_signUp) {
				 System.err.println("size"+ phNumber.getText().toString().length());
				//	String gettingEmail = emailId.getText().toString();

					if (firstName.getText().toString().equals("")) {

						Util.ToastMessage(RegisterActivity.this,
								"Please enter first name");
					} else if (lastName.getText().toString().equals("")) {
						Util.ToastMessage(RegisterActivity.this,
								"Please enter last name");
					}// here check email address is valid or not
					else if (userId.getText().toString().equals("")) {
						Util.ToastMessage(RegisterActivity.this,
								"Please enter user name");
					} else if (phNumber.getText().toString().equals("")) {
						Util.ToastMessage(RegisterActivity.this,
								"Please enter phone number");
					}
					
					else if(!Util.isValidPhoneNumber(phNumber.getText().toString()))
					{
						Util.ToastMessage(RegisterActivity.this,
								"Please enter valid phone number");
					}
					
					else if (emailId.getText().toString().equals("")) {
						Util.ToastMessage(RegisterActivity.this,
								"Please enter email address");
					} else if (password.getText().toString().equals("")) {
						Util.ToastMessage(RegisterActivity.this,
								"Please enter password");
					} else if (role_id.equals("-1")) {
						Util.ToastMessage(RegisterActivity.this,
								"Please select role");
					} 					
					else if (emailCheck == 0) {
						Util.ToastMessage(RegisterActivity.this,
								"Please enter valid Email address");
					} else if (checkuserid == 2) {
						Util.ToastMessage(RegisterActivity.this,
								"User already exist");
					} 
					else if (checkemail == 2) {
						Util.ToastMessage(RegisterActivity.this,
								"Email address already exist");
					}
					else if(mea_id.equals("-1"))
					{
						Util.ToastMessage(RegisterActivity.this,"Please select mea");
						}
					
					else {
						
						//signUpAPI();
					if(role_spinner.getSelectedItemPosition()==2)
					{
						if(str_userId.equals("0"))
						{
							Util.ToastMessage(RegisterActivity.this, "This email address not register as a MEA, Please change role and try again") ;
							
									}
						else
   						{
							//Util.ToastMessage(RegisterActivity.this, "mea register with userid="+str_userId);
							signUpAPI();
							}
					}
					else
					{
						//Util.ToastMessage(RegisterActivity.this, "other role register with userid="+str_userId);
						signUpAPI();
						
						}
						
						
						/*if(usertype)
						{
							if(mea_id.equals("-1"))
							{
								Util.ToastMessage(RegisterActivity.this,"Please select mea");
							}
							else
							{
								signUpAPI();// sign up api
								 System.err.println("sign up");
							}
							
						}
						
						else
						{
							signUpAPI();
						
						}*/
					}

				}
		}
	};
	private void signUpAPI() {
		
		phonenumber=phNumber.getText().toString();
		
		phonenumber=phonenumber.replace("(", "");
		phonenumber=phonenumber.replace(")", "");
		phonenumber=phonenumber.replace("-", "");
		phonenumber=phonenumber.replace(" ", "");
		System.err.println(phonenumber);
		
		
		if (Util.isNetworkAvailable(RegisterActivity.this)) {

			ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();

			nameValuePairs.add(new BasicNameValuePair("UserName", userId
					.getText().toString()));
			nameValuePairs.add(new BasicNameValuePair("Password", password
					.getText().toString().trim()));
			nameValuePairs.add(new BasicNameValuePair("RoleID", role_id));
			nameValuePairs.add(new BasicNameValuePair("FirstName", firstName
					.getText().toString().trim()));
			nameValuePairs.add(new BasicNameValuePair("LastName", lastName
					.getText().toString().trim()));
			nameValuePairs.add(new BasicNameValuePair("PhoneNumber",phonenumber));
			nameValuePairs.add(new BasicNameValuePair("Email", emailId
					.getText().toString()));
			nameValuePairs
					.add(new BasicNameValuePair("IsFacebookUser", IsFacebookUser));

			nameValuePairs.add(new BasicNameValuePair("PurchasedBefore",
					PurchasedBefore));
			nameValuePairs
					.add(new BasicNameValuePair("ProfilePicName", ""));
			nameValuePairs.add(new BasicNameValuePair("MEAID", mea_id));
			nameValuePairs.add(new BasicNameValuePair("userId", str_userId));
			if(flagClient)
			{
				nameValuePairs.add(new BasicNameValuePair("UserDetailId", clientId));
				
			}

			AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(
					RegisterActivity.this, "post", "users", nameValuePairs,
					true, "Please wait...",false);
			mWebPageTask.delegate = (AsyncResponseForARA) RegisterActivity.this;
			mWebPageTask.execute();
		} else {
			Util.alertMessage(RegisterActivity.this, Util.network_error);
		}
	}

	private void validationCheck(String id, String value) {
		if (Util.isNetworkAvailable(RegisterActivity.this)) {

		ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();

		nameValuePairs.add(new BasicNameValuePair(id, value));

		AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(
				RegisterActivity.this, "post", "users/confirm", nameValuePairs,
				false, "Please wait...",false);
		mWebPageTask.delegate = (AsyncResponseForARA) RegisterActivity.this;
		mWebPageTask.execute();
		} else {
			Util.alertMessage(RegisterActivity.this, Util.network_error);
		}
	}

	@Override
	public void processFinish(final String output, String methodName) {
		// TODO Auto-generated method stub
		
		
		final ARAParser parser = new ARAParser(RegisterActivity.this);

		if (methodName.equalsIgnoreCase("users/mea")) {
			arrayList_Mea = parser.parseMEAResponse(output);
			Log.e(methodName, output);
			System.err.println(arrayList_Mea.toString());
			ArrayAdapter<MEA> spinnerArrayAdapter = new ArrayAdapter<MEA>(this,
					android.R.layout.simple_spinner_item, arrayList_Mea);
			spinnerArrayAdapter
					.setDropDownViewResource(R.layout.spinner_dropdown);
			// Step 3: Tell the spinner about our adapter
			System.err.println("sizeeeeee===" + arrayList_Mea.size());

			mea_spinner.setAdapter(spinnerArrayAdapter);

		}

		else if (methodName.equalsIgnoreCase("roles")) {
			Log.e(methodName, output);
			arrayList_role = parser.parseRoleResponse(output);

			ArrayAdapter<Role> spinnerArrayAdapterRole = new ArrayAdapter<Role>(
					this, android.R.layout.simple_spinner_item, arrayList_role);
			spinnerArrayAdapterRole
					.setDropDownViewResource(R.layout.spinner_dropdown);
			role_spinner.setAdapter(spinnerArrayAdapterRole);
		}

		// email validation username
		else if (methodName.equals("users/confirm")) {
				
			if (parameter.equalsIgnoreCase("UserName")) {
				
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
			}
			else if (parameter.equalsIgnoreCase("Email")) {
				
				progressBar_email.setVisibility(View.GONE);
				if (output.contains("Email address not exist")) {
					img_emailId.setVisibility(View.VISIBLE);
					emailId.setError(null);
					checkemail = 1;
					mea_spinner.setSelection(0);
					role_spinner.setSelection(0);
					flag_setspinner=false;
					str_userId="0";
				}
				
				else {
					usermodel = new User();
					usermodel = parser.parseSignUpResponse(output);
			
				// checking for existing mea	
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
					}
					
							
					if (usermodel.getUserType().equalsIgnoreCase("client")) {

						
						AlertDialog.Builder alert = new AlertDialog.Builder(
								RegisterActivity.this);
						alert.setMessage("We already have your details. Are you a previous client of ARA ?");
						alert.setPositiveButton("Yes",
								new DialogInterface.OnClickListener() {
									public void onClick(DialogInterface arg0,
											int arg1) {

										checkemail = 1;
										flagClient=true;
										str_userId="0";
										firstName.setText(usermodel
												.getFirstName());
										lastName.setText(usermodel
												.getLastName());
										if(!usermodel.getUserId().equals("0"))
										{
											userId.setText(usermodel.getUserId());
										}
										phone=usermodel.getPhoneNumber();
										if(phone!=null)
										{
											phNumber.setText(phone);
											}
										emailId.setText(usermodel.getEmail());
										// check for error or emailid
									
										emailId.setError(null);
										clientId=usermodel.getUserDetailId();
												
										try{
										mea_spinner.setSelection(Integer.parseInt(usermodel.getMEAID()));
										role_spinner.setSelection(Integer.parseInt(usermodel.getRoleID()));
														
										}catch(Exception e)
										{
											e.printStackTrace();
										}

									}
								});
						alert.setNegativeButton("No",
								new DialogInterface.OnClickListener() {
									public void onClick(DialogInterface arg0,
											int arg1) {
										
										str_userId="0";
										flagClient=false;
									}
								});
						alert.show();
					} else {
							
							if(role_spinner.getSelectedItemPosition()!=2)
							{
								emailId.setError("Email address already exist");
								img_emailId.setVisibility(View.INVISIBLE);
								checkemail = 2;
							}
							else
							{
								//role_spinner.setSelection(0);
								//mea_spinner.setSelection(0);
							}
					}
				}
			} 

		}

		// sign up response
		else if (methodName.equals("users")) {
			if (output.contains("UserId")) {

				AlertDialog.Builder alert = new AlertDialog.Builder(
						RegisterActivity.this);
				alert.setMessage("You are sucessfully registered with us.");
				alert.setPositiveButton("ok",
						new DialogInterface.OnClickListener() {
							public void onClick(DialogInterface arg0, int arg1) {

								parser.parseSignUpResponse(output);

								usermodel = new User();
								usermodel = parser.parseSignUpResponse(output);
								Editor ed = spref.edit();
								ed.putString("userid", usermodel.getUserId());
								ed.putString("password",usermodel.getPassword());
								ed.putString("username",usermodel.getUserName());
								ed.putString("useremail", usermodel.getEmail());
								ed.putString("userimage", usermodel.getProfilePicName());
								ed.putString("usertoken", usermodel.getUserToken());
								ed.putString("meaid", usermodel.getMEAID());
								ed.commit();
								
								/// notification code
								ServerUtilities sUtil = new ServerUtilities();
								sUtil.deviceRegister(RegisterActivity.this);
								/////
								Intent intent = new Intent(RegisterActivity.this,DashBoardActivity.class);
								intent.putExtra("user", usermodel);
								startActivity(intent);
								finish();
							}
						});
				alert.show();

			} else {
				Util.ToastMessage(RegisterActivity.this, output);
			}
		}

	}
	
	
}