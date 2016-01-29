package com.ara.board;

import java.util.ArrayList;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.telephony.PhoneNumberFormattingTextWatcher;
import android.text.TextUtils;
import android.view.View;
import android.view.Window;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;
import com.ara.async_tasks.AsyncResponseForARA;
import com.ara.async_tasks.AsyncTaskForARA;
import com.ara.base.R;
import com.ara.model.ScheduleService;
import com.ara.model.TimeSlot;
import com.ara.model.User;
import com.ara.util.ARAParser;
import com.ara.util.Util;


public class ScheduleActivity   extends Activity implements
	AsyncResponseForARA {


	
	
	private Spinner spService,spTimeSlot;
	private ArrayList<ScheduleService> arrayListService = new ArrayList<ScheduleService>();
	private ArrayList<TimeSlot> arrayListTimeSlot = new ArrayList<TimeSlot>();
	private EditText edittext_firstname, edittext_lastname,
			edittext_phonenumber, edittext_email,edittextPreDate, edittext_comment;
	
	private Button button_submit;
	private TextView  textViewPayPal, textView_back;
	private SharedPreferences spref;
	private ImageView imageView_back;
	private String ScheduledServiceId="0",TimeSlotId="3";

	public void onCreate(Bundle savedInstanceState) {
	super.onCreate(savedInstanceState);
	requestWindowFeature(Window.FEATURE_NO_TITLE);
	setContentView(R.layout.activity_schedule);
	
	initUIComponents();
	
	OnClickListener();
	setValue();
	serviceApi();
	
	}
	
	

	private void initUIComponents() {
		// TODO Auto-generated method stub
		spref = getSharedPreferences("ara_prefs", MODE_PRIVATE);
		textView_back = (TextView) findViewById(R.id.textView_back);
		textView_back.setTypeface(DashBoardActivity.typeface_roboto);
		imageView_back = (ImageView) findViewById(R.id.imageView_back);
		

		
		

		edittext_firstname = (EditText) findViewById(R.id.edittext_firstname);
		edittext_firstname.setTypeface(DashBoardActivity.typeface_roboto);

		edittext_lastname = (EditText) findViewById(R.id.edittext_lastname);
		edittext_lastname.setTypeface(DashBoardActivity.typeface_roboto);

		edittext_phonenumber = (EditText) findViewById(R.id.edittext_phonenumber);
		edittext_phonenumber.setTypeface(DashBoardActivity.typeface_roboto);

		edittext_email = (EditText) findViewById(R.id.edittext_email);
		edittext_email.setTypeface(DashBoardActivity.typeface_roboto);

		edittextPreDate=(EditText)findViewById(R.id.edittextPreDate);
		edittext_comment = (EditText) findViewById(R.id.edittext_comment);
		edittext_comment.setTypeface(DashBoardActivity.typeface_roboto);

		spService = (Spinner) findViewById(R.id.spService);
		spTimeSlot = (Spinner) findViewById(R.id.spTimeSlot);
		
		button_submit = (Button) findViewById(R.id.button_submit);
		button_submit.setTypeface(DashBoardActivity.typeface_roboto);
	

		textViewPayPal = (TextView) findViewById(R.id.textViewPayPal);
		textViewPayPal.setTypeface(DashBoardActivity.typeface_timeburner);
	}
	private void setValue() {
		// TODO Auto-generated method stub
		User user_Model = (User) getIntent().getParcelableExtra("user");
		if(user_Model!=null)
		{
			edittext_email.setText(user_Model.getEmail());
			edittext_phonenumber.setText(user_Model.getPhoneNumber());
			edittext_phonenumber.addTextChangedListener(new PhoneNumberFormattingTextWatcher());
			edittext_firstname.setText(user_Model.getFirstName());
			edittext_lastname.setText(user_Model.getLastName());
			}
	}
	
	private void OnClickListener() {
		// TODO Auto-generated method stub
		button_submit.setOnClickListener(listener);
		textView_back.setOnClickListener(listener);
		imageView_back.setOnClickListener(listener);

		spService.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
					public void onItemSelected(AdapterView<?> arg0, View arg1,
							int position, long arg3) {
						// TODO Auto-generated method stub
						Util.hideKeyboard(ScheduleActivity.this);

						ScheduleService Model = (ScheduleService) spService.getSelectedItem();

						ScheduledServiceId = Model.getId();

						System.err.println("spinnerrr  ScheduledServiceId="+ScheduledServiceId);

					}

					public void onNothingSelected(AdapterView<?> arg0) {
						// TODO Auto-generated method stub

					}
				});
		spTimeSlot.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
			public void onItemSelected(AdapterView<?> arg0, View arg1,
					int position, long arg3) {
				// TODO Auto-generated method stub
				Util.hideKeyboard(ScheduleActivity.this);

				TimeSlot Model = (TimeSlot) spTimeSlot.getSelectedItem();

				TimeSlotId = Model.getId();

				System.err.println("spinnerrr  TimeSlotId="+TimeSlotId);

			}

			public void onNothingSelected(AdapterView<?> arg0) {
				// TODO Auto-generated method stub

			}
		});
		
	}
	private View.OnClickListener listener = new View.OnClickListener() {

		@Override
		public void onClick(View v) {
			// TODO Auto-generated method stub
			// String gettingEmail = edittext_email.getText().toString();
			if (v == textView_back | v == imageView_back) {
				finish();
			}

			else if (v == button_submit) {
				if(edittext_firstname.getText().toString().trim().equals(""))
				{
					Toast.makeText(ScheduleActivity.this, "Please enter First Name", Toast.LENGTH_SHORT).show();
					}
				else if(edittext_lastname.getText().toString().trim().equals(""))
				{
					Toast.makeText(ScheduleActivity.this, "Please enter Last Name", Toast.LENGTH_SHORT).show();
					}
				else{
						if(!edittext_email.getText().toString().trim().equals(""))
						{
							
							String gettingEmail=edittext_email.getText().toString().trim();
							 if (!android.util.Patterns.EMAIL_ADDRESS.matcher(gettingEmail)
										.matches() && !TextUtils.isEmpty(gettingEmail))
							 {
								Toast.makeText(ScheduleActivity.this, "Please enter a valid Email Address", Toast.LENGTH_SHORT).show();
									
							 	}
							 else{
								scheduleApi();
							 	}
							}
						else if(!edittext_phonenumber.getText().toString().trim().equals(""))
						{
							//Toast.makeText(ScheduleActivity.this, "Submit", Toast.LENGTH_SHORT).show();
							scheduleApi();
							}
						else{
												
							Toast.makeText(ScheduleActivity.this, "Please enter Phone Number or Email Address", Toast.LENGTH_SHORT).show();
						}
				}
				
			
			}
		}//

		private void scheduleApi() {
			if (Util.isNetworkAvailable(ScheduleActivity.this)) {
				
			String	phoneNumber = edittext_phonenumber.getText().toString();

			try{
				phoneNumber = phoneNumber.replace("(", "");
				phoneNumber = phoneNumber.replace(")", "");
				phoneNumber = phoneNumber.replace("-", "");
				phoneNumber = phoneNumber.replace(" ", "");
			}catch(Exception e)
			{
				
			}
				
				/*_postData = [NSString stringWithFormat:@"FirstName=%@&LastName=%@&PhoneNumber=%@&Email=%@&ScheduledServiceTypeId=
				 * %@&PreferredDate=%@&TimeSlot=%@&Comments=%@",firstName,lastName,phoneNumber,email,scheduleServiceTyperId,preferredDate,timeSlot,comments];
			    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/scheduledService",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
			    NSLog(@"data post >>> %@",_postData);
			    [request setHTTPMethod:@"POST"];*/
				
			

					ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();

					nameValuePairs.add(new BasicNameValuePair("FirstName", 
							edittext_firstname.getText().toString()));
					nameValuePairs.add(new BasicNameValuePair("LastName",
							edittext_lastname.getText().toString()));
					nameValuePairs.add(new BasicNameValuePair("PhoneNumber",
							phoneNumber));
					nameValuePairs.add(new BasicNameValuePair("Email", 
							edittext_email.getText().toString()));
					nameValuePairs.add(new BasicNameValuePair("ScheduledServiceTypeId",
							ScheduledServiceId));
					nameValuePairs.add(new BasicNameValuePair("PreferredDate",
							edittextPreDate.getText().toString()));
					nameValuePairs.add(new BasicNameValuePair("TimeSlot", 
							TimeSlotId));

					
					nameValuePairs.add(new BasicNameValuePair("Comments",
								edittext_comment.getText().toString()));
					
					AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(
							ScheduleActivity.this, "post", "/scheduledService",
							nameValuePairs, true, "Please wait...", true);
					mWebPageTask.delegate = (AsyncResponseForARA) ScheduleActivity.this;
					mWebPageTask.execute();
				} else {
					Util.alertMessage(ScheduleActivity.this, Util.network_error);
				}
			
		}
	};

	private void serviceApi() {
		// http://112.196.24.205:89/api/scheduledService/types
		if (Util.isNetworkAvailable(ScheduleActivity.this)) {
			
			ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
			AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(
					ScheduleActivity.this, "get", "/scheduledService/types",
					nameValuePairs, false, "Please wait...", true);
			mWebPageTask.delegate = (AsyncResponseForARA) ScheduleActivity.this;
			mWebPageTask.execute();

		} else {
			Util.alertMessage(ScheduleActivity.this, Util.network_error);
		}
	}
	
	@Override
	public void processFinish(String output, String methodName) {
		// TODO Auto-generated method stub
	
		
		if(methodName.contains("scheduledService/types")){
			ARAParser araParser=new ARAParser(this);
			arrayListService=araParser.parseServiceResponse(output);
			setSpinner();
			setTimeSlot();
		}
		else if(methodName.contains("/scheduledService"))
		{
			AlertDialog.Builder alert = new AlertDialog.Builder(ScheduleActivity.this);
			alert.setTitle("ARA");
			alert.setMessage("Your Service Request has been sent. You will be contacted to confirm an appointment. Thank you!");
			alert.setPositiveButton("Ok", new DialogInterface.OnClickListener() {
				
				@Override
				public void onClick(DialogInterface dialog, int which) {
					// TODO Auto-generated method stub
					finish();
				}
			});
			
			alert.show();
				}
		
	}
	private void setTimeSlot() {
		// TODO Auto-generated method stub
		
		/*selectTimeSlotArr = [[NSMutableArray alloc]initWithObjects:@"Morning",@"Afternoon",@"No Preference", nil];
	    selectTimeSlotIdArr = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",nil];*/
		arrayListTimeSlot= new ArrayList<TimeSlot>();
		
		TimeSlot timeSlot = new TimeSlot("Select Time Slot","3");
		arrayListTimeSlot.add(timeSlot);
		
		timeSlot = new TimeSlot("Morning","1");
		arrayListTimeSlot.add(timeSlot);
		
		timeSlot = new TimeSlot("Afternoon","2");
		arrayListTimeSlot.add(timeSlot);
		
		timeSlot = new TimeSlot("No Preference","3");
		arrayListTimeSlot.add(timeSlot);
		
		
		ArrayAdapter<TimeSlot> spinnerArrayAdapter = new ArrayAdapter<TimeSlot>(this,
				R.layout.spinner_dropdown, arrayListTimeSlot);
		spinnerArrayAdapter.setDropDownViewResource(R.layout.spinner_dropdown);
		spTimeSlot.setAdapter(spinnerArrayAdapter);	
	}



	private void setSpinner()
	{
		ArrayAdapter<ScheduleService> spinnerArrayAdapter = new ArrayAdapter<ScheduleService>(this,
				R.layout.spinner_dropdown, arrayListService);
		spinnerArrayAdapter.setDropDownViewResource(R.layout.spinner_dropdown);
		spService.setAdapter(spinnerArrayAdapter);	
		}
	}