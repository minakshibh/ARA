package com.ara.referral;

import java.util.ArrayList;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.Dialog;
import android.content.ContentUris;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.database.Cursor;
import android.net.Uri;
import android.os.Bundle;
import android.provider.ContactsContract;
import android.provider.ContactsContract.CommonDataKinds.Phone;
import android.provider.ContactsContract.CommonDataKinds.StructuredName;
import android.provider.ContactsContract.Contacts;
import android.provider.ContactsContract.Contacts.Data;
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
import android.widget.RelativeLayout.LayoutParams;

import com.ara.async_tasks.AsyncResponseForARA;
import com.ara.async_tasks.AsyncTaskForARA;
import com.ara.model.MEA;
import com.ara.model.User;
import com.ara.util.ARAParser;
import com.ara.util.Util;
import com.ara.base.BaseActivity;
import com.ara.base.R;
import com.ara.board.DashBoardActivity;

public class SubmitReferralActivity extends Activity implements
		AsyncResponseForARA {

	private Spinner mea_spinner;
	private ArrayList<MEA> arrayList_Mea = new ArrayList<MEA>();
	private ArrayList<MEA> onlyTwo_Mea = new ArrayList<MEA>();
	private int PICK_CONTACT;
	private String email, name, mea_id = "";
	private LinearLayout layout_importcontacts;
	private EditText edittext_firstname, edittext_lastname,
			edittext_phonenumber, edittext_email, edittext_comment;
	private User usermodel;
	private Button button_submit;
	private TextView textView_import, textView_SubmitReferral, textView_back
			;
	private SharedPreferences spref;
	private ImageView img_email_check;
	private ProgressBar progressBar_email;
	private boolean emailCheck = false;
	private boolean emailClient = false;
	private int emailflag = 0;
	private ImageView imageView_back;
	private String phoneNumber = "", firstName = "", lastName = null;
	private String phoneNumber1="",phoneNumber2="";
	private String email1="",email2="";
	private int phonetype;
	String phonetype1="",phonetype2="",phoneNumber3="",phonetype3="";
	

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.activity_referral_submit);

		initUIComponents();
		setOnClickListener();
		getMEAData();
	}

	private void initUIComponents() {
		// TODO Auto-generated method stub
		usermodel = new User();
		spref = getSharedPreferences("ara_prefs", MODE_PRIVATE);
		textView_back = (TextView) findViewById(R.id.textView_back);
		textView_back.setTypeface(DashBoardActivity.typeface_roboto);
		imageView_back = (ImageView) findViewById(R.id.imageView_back);
		//textView_title = (TextView) findViewById(R.id.textView_title);
		//textView_title.setTypeface(BaseActivity.typeface_timeburner);

		progressBar_email = (ProgressBar) findViewById(R.id.progressBar_email);
		progressBar_email.setVisibility(View.INVISIBLE);
		layout_importcontacts = (LinearLayout) findViewById(R.id.layout_importcontacts);

		edittext_firstname = (EditText) findViewById(R.id.edittext_firstname);
		edittext_firstname.setTypeface(DashBoardActivity.typeface_roboto);

		edittext_lastname = (EditText) findViewById(R.id.edittext_lastname);
		edittext_lastname.setTypeface(DashBoardActivity.typeface_roboto);

		edittext_phonenumber = (EditText) findViewById(R.id.edittext_phonenumber);
		edittext_phonenumber.setTypeface(DashBoardActivity.typeface_roboto);

		edittext_email = (EditText) findViewById(R.id.edittext_email);
		edittext_email.setTypeface(DashBoardActivity.typeface_roboto);

		edittext_comment = (EditText) findViewById(R.id.edittext_comment);
		edittext_comment.setTypeface(DashBoardActivity.typeface_roboto);

		mea_spinner = (Spinner) findViewById(R.id.mea_spinner);
		button_submit = (Button) findViewById(R.id.button_submit);
		button_submit.setTypeface(BaseActivity.typeface_roboto);
		textView_import = (TextView) findViewById(R.id.textView_import);
		textView_import.setTypeface(BaseActivity.typeface_roboto);

		textView_SubmitReferral = (TextView) findViewById(R.id.textView_SubmitReferral);
		textView_SubmitReferral.setTypeface(BaseActivity.typeface_timeburner);

		img_email_check = (ImageView) findViewById(R.id.img_email_check);

	}

	private void setOnClickListener() {

		layout_importcontacts.setOnClickListener(listener);
		button_submit.setOnClickListener(listener);
		textView_back.setOnClickListener(listener);
		imageView_back.setOnClickListener(listener);

		mea_spinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
					public void onItemSelected(AdapterView<?> arg0, View arg1,
							int position, long arg3) {
						// TODO Auto-generated method stub
						Util.hideKeyboard(SubmitReferralActivity.this);

						MEA mea_Model = (MEA) mea_spinner.getSelectedItem();

						mea_id = mea_Model.getId();

						System.err.println("spinnerrr  mea"+mea_id);

					}

					public void onNothingSelected(AdapterView<?> arg0) {
						// TODO Auto-generated method stub

					}
				});

		edittext_email.setOnFocusChangeListener(new OnFocusChangeListener() {
			@Override
			public void onFocusChange(View v, boolean hasFocus) {
				if (hasFocus) {
				} else {
					//emailCheck();
				}
			}
		});

		edittext_phonenumber
				.addTextChangedListener(new PhoneNumberFormattingTextWatcher());

	}

	private void emailCheck() {
		
	
		String gettingEmail = edittext_email.getText().toString();
		if (edittext_email.getText().toString().equals("")) {
			//Util.ToastMessage(SubmitReferralActivity.this,"Please enter a valid email address");
			message("Please enter a valid email address");
			img_email_check.setVisibility(View.INVISIBLE);
			emailflag = 0;
		}
		else if (!android.util.Patterns.EMAIL_ADDRESS.matcher(gettingEmail)
				.matches() && !TextUtils.isEmpty(gettingEmail)) {
			// Util.ToastMessage(SubmitReferralActivity.this,"Please enter a valid email address");
			 message("Please enter a valid email address");
			img_email_check.setVisibility(View.INVISIBLE);
			emailflag = 0;
		} else {

			progressBar_email.setVisibility(View.VISIBLE);
			validationCheck("Email", edittext_email.getText().toString());
			emailflag = 1;
		}
	}

	private View.OnClickListener listener = new View.OnClickListener() {

		@Override
		public void onClick(View v) {
			// TODO Auto-generated method stub
			// String gettingEmail = edittext_email.getText().toString();
			if (v == layout_importcontacts) {
				fetch_Contacts();
			} else if (v == textView_back | v == imageView_back) {
				finish();
			}

			else if (v == button_submit) {
			
				if (edittext_firstname.getText().toString().trim().equals("")) {
					message("Please enter first name");
					//Util.ToastMessage(SubmitReferralActivity.this,"Please enter first name");
				} else if (edittext_lastname.getText().toString().trim().equals("")) {
					//Util.ToastMessage(SubmitReferralActivity.this,"Please enter last name");
					message("Please enter last name");
				} 
				/*else if (edittext_phonenumber.getText().toString().equals("")) {
					Util.ToastMessage(SubmitReferralActivity.this,
							"Please enter phone number");
				}*/
				

				/*else if (edittext_comment.getText().toString().equals("")) {
					Util.ToastMessage(SubmitReferralActivity.this,
							"Please write comment");
				}*/
				/*
				 * else if(emailflag==0) {
				 * Util.ToastMessage(SubmitReferralActivity
				 * .this,"Email address not valid"); }
				 */
				/*
				 * else if (emailCheck) {
				 * Util.ToastMessage(SubmitReferralActivity
				 * .this,"Email address already exist"); }
				 */
				else {

					// Util.ToastMessage(SubmitReferralActivity.this,"Just wait a movement we are verifying your email address.");
				
					 if(edittext_phonenumber.getText().toString().length()>0)
					{
						  if (!Util.isValidPhoneNumber(edittext_phonenumber
								.getText().toString())) {
							message("Please enter valid phone number");
							}
						  else if(edittext_phonenumber.getText().toString().length()<14)
						  {
								message("Please enter valid phone number"); 
						  }
						 else{
							 emailCheck();
						 	}
						}
					 else{
						 emailCheck();
					 }
				
				}
			}
		}//
	};

	private void fetch_Contacts() {
		img_email_check.setVisibility(View.INVISIBLE);
		phoneNumber = "";
		email = "";
		name = "";
		firstName = "";
		lastName = null;
		PICK_CONTACT = 1;
		phoneNumber1="";phoneNumber2="";phoneNumber3="";phonetype3="";
		phonetype1="";phonetype2="";
		email1="";email2="";
		Intent intent = new Intent(Intent.ACTION_PICK,ContactsContract.Contacts.CONTENT_URI);
		startActivityForResult(intent, PICK_CONTACT);
	}

	// code
	@Override
	public void onActivityResult(int requestCode, int resultCode, Intent intent) {
		super.onActivityResult(requestCode, resultCode, intent);

		if (requestCode == PICK_CONTACT) {
			try {
				getContactInfo(intent);

			} catch (Exception e) {
				e.printStackTrace();
			}

		}
	}

	private void validationCheck(String id, String value) {
		if (Util.isNetworkAvailable(SubmitReferralActivity.this)) {
		ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();

		nameValuePairs.add(new BasicNameValuePair(id, value));

		AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(
				SubmitReferralActivity.this, "post", "users/confirm",
				nameValuePairs, false, "Please wait...", false);
		mWebPageTask.delegate = (AsyncResponseForARA) SubmitReferralActivity.this;
		mWebPageTask.execute();
		}
		else {
			Util.alertMessage(SubmitReferralActivity.this,
					"Please check your internet connection");
		}
	}

	private void getMEAData() {
		if (Util.isNetworkAvailable(SubmitReferralActivity.this)) {
			AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(
					SubmitReferralActivity.this, "get", "users/mea",
					new ArrayList<NameValuePair>(), true, "Please wait...",
					false);
			mWebPageTask.delegate = (AsyncResponseForARA) this;
			mWebPageTask.execute();

		} else {
			Util.alertMessage(SubmitReferralActivity.this,
					"Please check your internet connection");
		}
	}

	protected void getContactInfo(Intent intent) {

		int emailCount=0, phoneCount=0;
		
		Cursor cursor = managedQuery(intent.getData(), null, null, null, null);
		while (cursor.moveToNext()) {
			String contactId = cursor.getString(cursor
					.getColumnIndex(ContactsContract.Contacts._ID));

			Uri contactUri = ContentUris.withAppendedId(Contacts.CONTENT_URI,
					Long.parseLong(contactId));
			Uri dataUri = Uri.withAppendedPath(contactUri,
					Contacts.Data.CONTENT_DIRECTORY);
			Cursor nameCursor = this.getContentResolver().query(dataUri, null,
					Data.MIMETYPE + "=?",
					new String[] { StructuredName.CONTENT_ITEM_TYPE }, null);
			while (nameCursor.moveToNext()) {

				firstName = nameCursor.getString(nameCursor
						.getColumnIndex(Data.DATA2));
				lastName = nameCursor.getString(nameCursor
						.getColumnIndex(Data.DATA3));

			}

			nameCursor.close();

			
			String hasPhone = cursor
					.getString(cursor
							.getColumnIndex(ContactsContract.Contacts.HAS_PHONE_NUMBER));

			if (hasPhone.equalsIgnoreCase("1"))
				hasPhone = "true";
			else
				hasPhone = "false";

			if (Boolean.parseBoolean(hasPhone)) {
				Cursor phones = getContentResolver().query(
						ContactsContract.CommonDataKinds.Phone.CONTENT_URI,
						null,ContactsContract.CommonDataKinds.Phone.CONTACT_ID + " = " + contactId, null, null);
				while (phones.moveToNext()) {
					phoneNumber = phones.getString(phones.getColumnIndex(ContactsContract.CommonDataKinds.Phone.NUMBER));
					try{
					phonetype= phones.getInt(phones.getColumnIndex(Phone.TYPE));
					}catch(Exception e){
						e.printStackTrace();
					}
					phoneCount++;
					if(phoneCount==1)
					{
						phoneNumber1=phoneNumber;
						
						if (phonetype == Phone.TYPE_HOME) {
							phonetype1="HOME";
					       
					    }
					    if (phonetype == Phone.TYPE_MOBILE) {
					    	phonetype1="MOBILE";
					       
					    }
					    if (phonetype == Phone.TYPE_WORK) {
					    	phonetype1="WORK";
					        
					    }
						
					}
					else if(phoneCount==2)
					{
						phoneNumber2=phoneNumber;
						
						if (phonetype == Phone.TYPE_HOME) {
							phonetype2="HOME";
					        
					    }
					    if (phonetype == Phone.TYPE_MOBILE) {
					    	phonetype2="MOBILE";
					       
					    }
					    if (phonetype == Phone.TYPE_WORK) {
					    	phonetype2="WORK";
					        
					    }
					}
					else if(phoneCount==3)
					{
						phoneNumber3=phoneNumber;
						
						if (phonetype == Phone.TYPE_HOME) {
							phonetype3="HOME";
					        
					    }
					    if (phonetype == Phone.TYPE_MOBILE) {
					    	phonetype3="MOBILE";
					       
					    }
					    if (phonetype == Phone.TYPE_WORK) {
					    	phonetype3="WORK";
					        
					    }
					}
					System.out.println("number is:" + name + phoneNumber+phoneNumber2);
				}
				phones.close();
			}

			// Find Email Addresses
			Cursor emails = getContentResolver().query(
					ContactsContract.CommonDataKinds.Email.CONTENT_URI,null,ContactsContract.CommonDataKinds.Email.CONTACT_ID + " = "+ contactId, null, null);
			while (emails.moveToNext()) {
				email = emails.getString(emails.getColumnIndex(ContactsContract.CommonDataKinds.Email.DATA));
			
				emailCount++;
				if(emailCount==1)
				{
					email1=email;	
				}
				else if(emailCount==2)
				{
					email2=email;
				}
				System.out.println("mail:" + name + email);
			}
			emails.close();

		}
		while (cursor.moveToNext())
			cursor.close();

		

		if(!phoneNumber3.equals(""))
		{
			showDialogPhone(firstName+" "+lastName,phoneNumber1,phoneNumber2,phoneNumber3);
		}
		else if(!phoneNumber2.equals(""))
		{
			if(lastName!=null)
			{
				showDialogPhone(firstName+" "+lastName,phoneNumber1,phoneNumber2,phoneNumber3);
			}
			else
			{
				showDialogPhone(firstName,phoneNumber1,phoneNumber2,phoneNumber3);	
			}
		}
		else if(!email2.equals(""))
		{
			showDialogEmail(name,email1,email2);
		}
		else
		{
			setContactInfo();
		}
	}

	private void showDialogPhone(final String name,final String phone1,final String phone2,final String phone3) {
		
			phoneNumber=phone1;
			final Dialog dialog = new Dialog(this);
			dialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
			dialog.setContentView(R.layout.multi_phoneno);
			
			LinearLayout dailog_layout=(LinearLayout)dialog.findViewById(R.id.dailog_layout);
			dailog_layout.setLayoutParams(new LayoutParams(LayoutParams.MATCH_PARENT,LayoutParams.WRAP_CONTENT));
			
			
			// dialog.setTitle("Title...");
			dialog.setCanceledOnTouchOutside(false);
			// set the custom dialog components - text, image and button
			LinearLayout layPhone1 = (LinearLayout) dialog.findViewById(R.id.layphone1);
			LinearLayout layPhone2 = (LinearLayout) dialog.findViewById(R.id.layphone2);
			LinearLayout layPhone3 = (LinearLayout) dialog.findViewById(R.id.layphone3);
			if(phone3.equals(""))
			{
				layPhone3.setVisibility(View.GONE);
			}
			else
			{
				layPhone3.setVisibility(View.VISIBLE);
			}
			TextView title = (TextView) dialog.findViewById(R.id.textView_title);
			
			title.setText(name);
			TextView text1 = (TextView) dialog.findViewById(R.id.phone1);
			text1.setText(phone1);
		
			TextView text2 = (TextView) dialog.findViewById(R.id.phone2);
			text2.setText(phone2);
			
			TextView text3 = (TextView) dialog.findViewById(R.id.phone3);
			text3.setText(phone3);
			
			final TextView type1 = (TextView) dialog.findViewById(R.id.type1);
			type1.setText(phonetype1);
			
			
			final TextView type2 = (TextView) dialog.findViewById(R.id.type2);
			type2.setText(phonetype2);
			
			final TextView type3 = (TextView) dialog.findViewById(R.id.type3);
			type3.setText(phonetype3);
			
			final ImageView next = (ImageView) dialog.findViewById(R.id.next);
			final ImageView image1 = (ImageView) dialog.findViewById(R.id.imageView1);
			image1.setImageResource(R.drawable.radio_checked);
			
			final ImageView image2 = (ImageView) dialog.findViewById(R.id.imageView2);
			
			final ImageView image3 = (ImageView) dialog.findViewById(R.id.imageView3);
			layPhone1.setOnClickListener(new View.OnClickListener() {
				@Override
				public void onClick(View v) {
					phoneNumber=phone1;
					
					image1.setImageResource(R.drawable.radio_checked);
					image2.setImageResource(R.drawable.radio_unchecked);
					image3.setImageResource(R.drawable.radio_unchecked);
					
					
										
				}
			});
			layPhone2.setOnClickListener(new View.OnClickListener() {
				@Override
				public void onClick(View v) {
					
					phoneNumber=phone2;
					image2.setImageResource(R.drawable.radio_checked);
					image1.setImageResource(R.drawable.radio_unchecked);
					image3.setImageResource(R.drawable.radio_unchecked);
					
				}
			});
			layPhone3.setOnClickListener(new View.OnClickListener() {
				@Override
				public void onClick(View v) {
					
					phoneNumber=phone3;
					image3.setImageResource(R.drawable.radio_checked);
					image1.setImageResource(R.drawable.radio_unchecked);
					image2.setImageResource(R.drawable.radio_unchecked);
					
					
				}
			});
			next.setOnClickListener(new View.OnClickListener() {
				@Override
				public void onClick(View v) {
				
					dialog.dismiss();
					
					if(!email2.equals(""))
					{
						showDialogEmail(name,email1,email2);
						}
					else{
						setContactInfo();
					}
				}
			});
			    
			dialog.show();
		
	}
	
	private void showDialogEmail(String name,final String email1,final String email2) {
		
		email=email1;
		final Dialog dialog = new Dialog(this);
		dialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
		dialog.setContentView(R.layout.multi_phoneno);
		
		LinearLayout dailog_layout=(LinearLayout)dialog.findViewById(R.id.dailog_layout);
		dailog_layout.setLayoutParams(new LayoutParams(LayoutParams.MATCH_PARENT,LayoutParams.WRAP_CONTENT));
		
		
		// dialog.setTitle("Title...");
		dialog.setCanceledOnTouchOutside(false);
		// set the custom dialog components - text, image and button
		LinearLayout layPhone1 = (LinearLayout) dialog.findViewById(R.id.layphone1);
		LinearLayout layPhone2 = (LinearLayout) dialog.findViewById(R.id.layphone2);
		LinearLayout layphone3 = (LinearLayout) dialog.findViewById(R.id.layphone3);
		
		
		TextView type1 = (TextView) dialog.findViewById(R.id.type1);
		type1.setText(phonetype1);
		
		TextView type2 = (TextView) dialog.findViewById(R.id.type2);
		type2.setText(phonetype2);
		
		
		
		TextView text1 = (TextView) dialog.findViewById(R.id.phone1);
		text1.setText(email1);
		
		TextView text2 = (TextView) dialog.findViewById(R.id.phone2);
		text2.setText(email2);
		
		TextView title = (TextView) dialog.findViewById(R.id.textView_title);
		TextView massage = (TextView) dialog.findViewById(R.id.massage);
		massage.setText("Select Email Address");
		title.setText(name);
		
		final ImageView image1 = (ImageView) dialog.findViewById(R.id.imageView1);
		image1.setImageResource(R.drawable.radio_checked);
	
		final ImageView image2 = (ImageView) dialog.findViewById(R.id.imageView2);
		final ImageView next = (ImageView) dialog.findViewById(R.id.next);
		
		layPhone1.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				image1.setImageResource(R.drawable.radio_checked);
				image2.setImageResource(R.drawable.radio_unchecked);
				email=email1;
				//dialog.dismiss();
				
			}
		});
		layPhone2.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				email=email2;
				image2.setImageResource(R.drawable.radio_checked);
				image1.setImageResource(R.drawable.radio_unchecked);
			}
		});
		next.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
			
				dialog.dismiss();
				setContactInfo();
			}
		});
		    
		dialog.show();
	
}

	private void setContactInfo() {

		edittext_firstname.setText(firstName);
		edittext_lastname.setText(lastName);
		edittext_phonenumber.setText(phoneNumber);
		edittext_email.setText(email);
		edittext_email.setFocusableInTouchMode(true);
		edittext_email.requestFocus();
		edittext_email.setSelection(edittext_email.getText().length());

	}

	private void submitReferralAPI() {

		phoneNumber = edittext_phonenumber.getText().toString();

		phoneNumber = phoneNumber.replace("(", "");
		phoneNumber = phoneNumber.replace(")", "");
		phoneNumber = phoneNumber.replace("-", "");
		phoneNumber = phoneNumber.replace(" ", "");

		if (Util.isNetworkAvailable(SubmitReferralActivity.this)) {

			ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();

			nameValuePairs.add(new BasicNameValuePair("ReferrerID", spref
					.getString("userid", "")));
			nameValuePairs.add(new BasicNameValuePair("FirstName",
					edittext_firstname.getText().toString()));
			nameValuePairs.add(new BasicNameValuePair("LastName",
					edittext_lastname.getText().toString()));
			nameValuePairs.add(new BasicNameValuePair("Email", edittext_email
					.getText().toString()));
			nameValuePairs.add(new BasicNameValuePair("PhoneNumber",
					phoneNumber));
			nameValuePairs.add(new BasicNameValuePair("Comments",
					edittext_comment.getText().toString()));
			nameValuePairs.add(new BasicNameValuePair("MeaId", mea_id));

			if (emailClient) {
				nameValuePairs.add(new BasicNameValuePair("UserDetailId",
						usermodel.getUserDetailId()));
			}
			AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(
					SubmitReferralActivity.this, "post", "referrals",
					nameValuePairs, true, "Please wait...", true);
			mWebPageTask.delegate = (AsyncResponseForARA) SubmitReferralActivity.this;
			mWebPageTask.execute();
		} else {
			Util.alertMessage(SubmitReferralActivity.this, Util.network_error);
		}
	}

	@Override
	public void processFinish(String output, String methodName) {
		// TODO Auto-generated method stub

		final ARAParser parser = new ARAParser(SubmitReferralActivity.this);
		if (methodName.equalsIgnoreCase("users/mea")) {

			MEA mMEA = new MEA();
			String getId;
			int gettingStatePosition = 0;
			
			
			arrayList_Mea = parser.parseMEAResponse(output);
			try {
				if (arrayList_Mea.size() > 0) {

					getId = spref.getString("meaid", "");
					int i = 0;
					for (MEA mea : arrayList_Mea) {
						String id = mea.getId();
						if (getId.equals(id)) {
							gettingStatePosition = i;
							onlyTwo_Mea.add(arrayList_Mea.get(i));
						}
						i++;
					}
				}
				mea_spinner.setSelection(gettingStatePosition);
				MEA mea_Model = new MEA("Any Member Experience Advisor (Sales)","221","testkrishna@gmail.com");
				onlyTwo_Mea.add(mea_Model);

			} catch (Exception e) {
				e.printStackTrace();
			}
			
			Log.e(methodName, output);
			System.err.println(arrayList_Mea.toString());
			
			ArrayAdapter<MEA> spinnerArrayAdapter = new ArrayAdapter<MEA>(this,
			android.R.layout.simple_spinner_item, onlyTwo_Mea);
			spinnerArrayAdapter.setDropDownViewResource(R.layout.spinner_dropdown);
			// Step 3: Tell the spinner about our adapter
			System.err.println("sizeeeeee===" + onlyTwo_Mea.size());

			mea_spinner.setAdapter(spinnerArrayAdapter);
			mea_id = spref.getString("meaid", "");

			

		} else if (methodName.equals("referrals")) {
			Log.e(methodName, output);
			//if (output.contains("Ref"))

			//{
				AlertDialog.Builder alert = new AlertDialog.Builder(
						SubmitReferralActivity.this);
				alert.setMessage("Your referral has been submitted.");// You can track the same by referral id "/+ output);
				alert.setPositiveButton("ok",new DialogInterface.OnClickListener() {
							public void onClick(DialogInterface arg0, int arg1) {

								Intent intent = new Intent(
										SubmitReferralActivity.this,
										DashBoardActivity.class);
								startActivity(intent);
								finish();
							}
						});
				alert.show();
			//}

		} 
		else if (methodName.equals("users/confirm")) {
			progressBar_email.setVisibility(View.INVISIBLE);
			progressBar_email.setVisibility(View.INVISIBLE);

			if (output.contains("not exist")) {

				img_email_check.setVisibility(View.VISIBLE);

				edittext_email.setError(null);
				emailCheck = false;
				emailClient=false;
				
				submitApi();
			} 
			else {

				usermodel = new User();
				usermodel = parser.parseSignUpResponse(output);
				if (usermodel.getUserType().equalsIgnoreCase("client")) {

					emailClient = true;
					AlertDialog.Builder alert = new AlertDialog.Builder(
							SubmitReferralActivity.this);
					alert.setMessage("One of our client already referred this person. Do you want to referrer this person again ?");
					alert.setPositiveButton("Yes",
							new DialogInterface.OnClickListener() {
								public void onClick(DialogInterface arg0,
										int arg1) {

									
									edittext_email.setError(null);
									//emailCheck=false;
									edittext_firstname.setText(usermodel
											.getFirstName());
									edittext_lastname.setText(usermodel
											.getLastName());
									// userId.setText(usermodel.getUserId());
									edittext_phonenumber.setText(usermodel
											.getPhoneNumber());

									
									
									try {
										mea_spinner.setSelection(Integer
												.parseInt(usermodel.getMEAID()));
										// role_spinner.setSelection(Integer.parseInt(usermodel.getRoleID()));

									} catch (Exception e) {
										e.printStackTrace();
									}
									
									submitReferralAPI();

								}
							});
					alert.setNegativeButton("No",
							new DialogInterface.OnClickListener() {
								public void onClick(DialogInterface arg0,
										int arg1) {

								
									emailClient = false;
									emailCheck = true;
									img_email_check.setVisibility(View.INVISIBLE);
									edittext_email.setError("Email address already exist");
								}
							});
					alert.show();
				} 
				else {
					emailCheck = true;
					emailClient=false;
					img_email_check.setVisibility(View.INVISIBLE);
					edittext_email.setError("Email address already exist");
					
					submitApi();
				}

			}
		}

	}
	
	private void submitApi()
	{
		if (emailflag == 1) {
			if (emailCheck) {
				//Util.ToastMessage(SubmitReferralActivity.this,"Email address already exist");
				message("Email address already exist");
			}
			else {
				
				if(emailClient)
						{
							/*Util.ToastMessage(SubmitReferralActivity.this,
									"Please wait");*/
						}
						else{
					
							submitReferralAPI();
						}
			}
	} else {
		//Util.ToastMessage(SubmitReferralActivity.this,"Email address not valid");
		message("Email address not valid");
	}
	}
	private void message(String str)
	{
		AlertDialog.Builder alert = new AlertDialog.Builder(
				SubmitReferralActivity.this);
		alert.setMessage(str);
		alert.setPositiveButton("ok",null);
		alert.show();
	}
}