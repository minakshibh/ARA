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
	private int PICK_CONTACT;
	private String email, name, phoneNumber, mea_id = "";
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
	private String phonenumber = "", firstName = "", lastName = "";
	private String phoneNumber1="",phoneNumber2="";
	private String email1="",email2="";

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
		textView_back.setTypeface(BaseActivity.typeface_roboto);
		imageView_back = (ImageView) findViewById(R.id.imageView_back);
		//textView_title = (TextView) findViewById(R.id.textView_title);
		//textView_title.setTypeface(BaseActivity.typeface_timeburner);

		progressBar_email = (ProgressBar) findViewById(R.id.progressBar_email);
		progressBar_email.setVisibility(View.INVISIBLE);
		layout_importcontacts = (LinearLayout) findViewById(R.id.layout_importcontacts);

		edittext_firstname = (EditText) findViewById(R.id.edittext_firstname);
		edittext_firstname.setTypeface(BaseActivity.typeface_roboto);

		edittext_lastname = (EditText) findViewById(R.id.edittext_lastname);
		edittext_lastname.setTypeface(BaseActivity.typeface_roboto);

		edittext_phonenumber = (EditText) findViewById(R.id.edittext_phonenumber);
		edittext_phonenumber.setTypeface(BaseActivity.typeface_roboto);

		edittext_email = (EditText) findViewById(R.id.edittext_email);
		edittext_email.setTypeface(BaseActivity.typeface_roboto);

		edittext_comment = (EditText) findViewById(R.id.edittext_comment);
		edittext_comment.setTypeface(BaseActivity.typeface_roboto);

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

						System.err.println("spinnerrr  mea");

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
			Util.ToastMessage(SubmitReferralActivity.this,"Please enter a valid email address");
			img_email_check.setVisibility(View.INVISIBLE);
			emailflag = 0;
		}
		else if (!android.util.Patterns.EMAIL_ADDRESS.matcher(gettingEmail)
				.matches() && !TextUtils.isEmpty(gettingEmail)) {
			 Util.ToastMessage(SubmitReferralActivity.this,"Please enter a valid email address");

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
					Util.ToastMessage(SubmitReferralActivity.this,
							"Please enter first name");
				} else if (edittext_lastname.getText().toString().trim().equals("")) {
					Util.ToastMessage(SubmitReferralActivity.this,
							"Please enter last name");
				} 
				/*else if (edittext_phonenumber.getText().toString().equals("")) {
					Util.ToastMessage(SubmitReferralActivity.this,
							"Please enter phone number");
				}*/
				/*else if (!Util.isValidPhoneNumber(edittext_phonenumber
						.getText().toString())) {
					Util.ToastMessage(SubmitReferralActivity.this,
							"Please enter valid phone number");

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
					emailCheck();

				
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
		lastName = "";
		PICK_CONTACT = 1;

		Intent intent = new Intent(Intent.ACTION_PICK,
				ContactsContract.Contacts.CONTENT_URI);
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
		ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();

		nameValuePairs.add(new BasicNameValuePair(id, value));

		AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(
				SubmitReferralActivity.this, "post", "users/confirm",
				nameValuePairs, false, "Please wait...", false);
		mWebPageTask.delegate = (AsyncResponseForARA) SubmitReferralActivity.this;
		mWebPageTask.execute();
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
					phoneCount++;
					if(phoneCount==1)
					{
						phoneNumber1=phoneNumber;	
					}
					else if(phoneCount==2)
					{
						phoneNumber2=phoneNumber;
					}
					System.out.println("number is:" + name + phoneNumber);
				}
				phones.close();
			}

			// Find Email Addresses
			Cursor emails = getContentResolver().query(
					ContactsContract.CommonDataKinds.Email.CONTENT_URI,
					null,
					ContactsContract.CommonDataKinds.Email.CONTACT_ID + " = "+ contactId, null, null);
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

		

		showDialogPhone(firstName+lastName,phoneNumber1,phoneNumber2);
	}

	private void showDialogPhone(final String name,String phone1,String phone2) {
		
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
			//LinearLayout layout_none = (LinearLayout) dialog.findViewById(R.id.layout3);
			
			TextView title = (TextView) dialog.findViewById(R.id.textView_title);
			
			title.setText(name);
			TextView text1 = (TextView) dialog.findViewById(R.id.phone1);
			text1.setText(phone1);
			final ImageView image1 = (ImageView) dialog.findViewById(R.id.imageView1);
			image1.setImageResource(R.drawable.radio_checked);
			TextView text2 = (TextView) dialog.findViewById(R.id.phone2);
			text2.setText(phone2);
			final ImageView image2 = (ImageView) dialog.findViewById(R.id.imageView2);
			
			
			layPhone1.setOnClickListener(new View.OnClickListener() {
				@Override
				public void onClick(View v) {
					image1.setImageResource(R.drawable.radio_checked);
					phonenumber=phoneNumber1;
					dialog.dismiss();
					showDialogEmail(name,email1,email2);
					
				}
			});
			layPhone2.setOnClickListener(new View.OnClickListener() {
				@Override
				public void onClick(View v) {
					phonenumber=phoneNumber2;
					image2.setImageResource(R.drawable.radio_checked);
					dialog.dismiss();
					showDialogEmail(name,email1,email2);
				}
			});
			
			    
			dialog.show();
		
	}
	
	private void showDialogEmail(String name,final String email1,final String email2) {
		
		final Dialog dialog = new Dialog(this);
		dialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
		dialog.setContentView(R.layout.multi_phoneno);
		
		LinearLayout dailog_layout=(LinearLayout)dialog.findViewById(R.id.dailog_layout);
		dailog_layout.setLayoutParams(new LayoutParams(LayoutParams.MATCH_PARENT,LayoutParams.WRAP_CONTENT));
		
		
		// dialog.setTitle("Title...");
		dialog.setCanceledOnTouchOutside(false);
		// set the custom dialog components - text, image and button
		LinearLayout layPhone1 = (LinearLayout) dialog.findViewById(R.id.phone1);
		LinearLayout layPhone2 = (LinearLayout) dialog.findViewById(R.id.phone2);
		//LinearLayout layout_none = (LinearLayout) dialog.findViewById(R.id.layout3);
		
		TextView title = (TextView) dialog.findViewById(R.id.textView_title);
		
		title.setText(name);
		TextView text1 = (TextView) dialog.findViewById(R.id.textView1);
		text1.setText(email1);
		final ImageView image1 = (ImageView) dialog.findViewById(R.id.imageView1);
		image1.setImageResource(R.drawable.radio_checked);
		TextView text2 = (TextView) dialog.findViewById(R.id.textView2);
		text2.setText(email2);
		final ImageView image2 = (ImageView) dialog.findViewById(R.id.imageView2);
		
		
		layPhone1.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				image1.setImageResource(R.drawable.radio_checked);
				email=email1;
				dialog.dismiss();
				setContactInfo();
			}
		});
		layPhone2.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				email=email2;
				image2.setImageResource(R.drawable.radio_checked);
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

		phonenumber = edittext_phonenumber.getText().toString();

		phonenumber = phonenumber.replace("(", "");
		phonenumber = phonenumber.replace(")", "");
		phonenumber = phonenumber.replace("-", "");
		phonenumber = phonenumber.replace(" ", "");

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
					phonenumber));
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
			Log.e(methodName, output);
			System.err.println(arrayList_Mea.toString());
			ArrayAdapter<MEA> spinnerArrayAdapter = new ArrayAdapter<MEA>(this,
					android.R.layout.simple_spinner_item, arrayList_Mea);
			spinnerArrayAdapter
					.setDropDownViewResource(R.layout.spinner_dropdown);
			// Step 3: Tell the spinner about our adapter
			System.err.println("sizeeeeee===" + arrayList_Mea.size());

			mea_spinner.setAdapter(spinnerArrayAdapter);
			mea_id = spref.getString("meaid", "");

			try {
				if (arrayList_Mea.size() > 0) {

					getId = spref.getString("meaid", "");
					int i = 0;
					for (MEA mea : arrayList_Mea) {
						String id = mea.getId();
						if (getId.equals(id)) {
							gettingStatePosition = i;
						}
						i++;
					}
				}
				mea_spinner.setSelection(gettingStatePosition);

			} catch (Exception e) {
				e.printStackTrace();
			}

		} else if (methodName.equals("referrals")) {
			Log.e(methodName, output);
			//if (output.contains("Ref"))

			//{
				AlertDialog.Builder alert = new AlertDialog.Builder(
						SubmitReferralActivity.this);
				alert.setMessage("Your referral has been submitted. You can track the same by referral id "
						+ output);
				alert.setPositiveButton("ok",
						new DialogInterface.OnClickListener() {
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
				Util.ToastMessage(SubmitReferralActivity.this,
						"Email address already exist");

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
		Util.ToastMessage(SubmitReferralActivity.this,
				"Email address not valid");
	}
	}
}