package com.ara.referral;

import java.text.SimpleDateFormat;
import java.util.Date;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.telephony.PhoneNumberFormattingTextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Window;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout.LayoutParams;
import android.widget.TextView;

import com.ara.base.BaseActivity;
import com.ara.login.ChangePasswordActivity;
import com.ara.model.Referral;
import com.ara.model.Reward;
import com.ara.profile.ImageUploadActivity;
import com.ara.profile.MyProfile;
import com.ara.util.Util;
import com.ara.base.R;
import com.ara.board.DashBoardActivity;

public class ReferralsDetailsActivity extends Activity {

	private TextView txtName, txtEmail, txtPhone, txtSoldDate,
			txtSubmittedDate, txtMea, txtComment,textView_back;
	private TextView lblName, lblEmail, lblPhonenumber, lblSubmittedDate,
			lblSoldDate, lblMEA, lblComment,lbl_DirectReferral,txtHeaderOutput;
	private Referral referral;
	private TextView colorStripe, header,txt_DirectReferral;
	private ImageView imageView_back,imageView_referralType;
	private Reward reward;
	private LinearLayout lay_directReferral;
	

	@Override
	public void onCreate(Bundle savedInstanceState) {

		super.onCreate(savedInstanceState);
		 requestWindowFeature(Window.FEATURE_NO_TITLE);
		 setContentView(R.layout.activity_referrals_details);


		referral = (Referral) getIntent().getParcelableExtra("referral");

		setUI();

		setOnClickListener();

	}

	private void setUI() {

		textView_back=(TextView)findViewById(R.id.textView_back);
		textView_back.setTypeface(DashBoardActivity.typeface_roboto);
		txtHeaderOutput=(TextView)findViewById(R.id.txtHeaderOutput);
		txtHeaderOutput.setTypeface(DashBoardActivity.typeface_timeburner);
		imageView_back=(ImageView)findViewById(R.id.imageView_back);
		//imageView_referralType=(ImageView)findViewById(R.id.imageView_referralType);
		lblName = (TextView) findViewById(R.id.lblName);
		lblName.setTypeface(DashBoardActivity.typeface_roboto);

		lblEmail = (TextView) findViewById(R.id.lblEmail);
		lblEmail.setTypeface(DashBoardActivity.typeface_roboto);

		lblPhonenumber = (TextView) findViewById(R.id.lblPhonenumber);
		lblPhonenumber.setTypeface(DashBoardActivity.typeface_roboto);

		lblSubmittedDate = (TextView) findViewById(R.id.lblSubmittedDate);
		lblSubmittedDate.setTypeface(DashBoardActivity.typeface_roboto);
		lbl_DirectReferral= (TextView) findViewById(R.id.lbl_DirectReferral);
		lbl_DirectReferral.setTypeface(DashBoardActivity.typeface_roboto);
		lblSoldDate = (TextView) findViewById(R.id.lblSoldDate);
		lblSoldDate.setTypeface(DashBoardActivity.typeface_roboto);

		txt_DirectReferral = (TextView) findViewById(R.id.txt_DirectReferral);
		txt_DirectReferral.setTypeface(DashBoardActivity.typeface_roboto);
		lblMEA = (TextView) findViewById(R.id.lblMEA);
		lblMEA.setTypeface(DashBoardActivity.typeface_roboto);

		lblComment = (TextView) findViewById(R.id.lblComment);
		lblComment.setTypeface(DashBoardActivity.typeface_roboto);

		txtName = (TextView) findViewById(R.id.txtName);
		txtEmail = (TextView) findViewById(R.id.txtEmail);
		txtPhone = (TextView) findViewById(R.id.txtPhoneNumber);
		txtSubmittedDate = (TextView) findViewById(R.id.txtSubmittedDate);
		txtSoldDate = (TextView) findViewById(R.id.txtSoldDate);
		txtMea = (TextView) findViewById(R.id.txtMEA);
		txtComment = (TextView) findViewById(R.id.txtComments);
		lay_directReferral=(LinearLayout)findViewById(R.id.lay_directReferral);
		lay_directReferral.setVisibility(View.GONE);
		colorStripe = (TextView) findViewById(R.id.colorStripe);
		header = (TextView) findViewById(R.id.txtHeader);
		header.setTypeface(DashBoardActivity.typeface_timeburner);

		
		if(getIntent().getStringExtra("rewardcheck")!=null)
		{
				reward=getIntent().getParcelableExtra("reward");
				
				txtName.setText(reward.getFirstName() + " " + reward.getLastName());
				txtName.setTypeface(DashBoardActivity.typeface_roboto);
				
				
				if(reward.getEmail()==null | reward.getEmail().equals("null"))
				{
					txtEmail.setText("");
					}
				else
				{   txtEmail.setText(reward.getEmail());
				
					}
				txtEmail.setTypeface(BaseActivity.typeface_roboto);
				
				
				if(reward.getPhoneNumber()==null | reward.getPhoneNumber().equals("null"))
				{
					txtPhone.setText("");
					
					}
				else
				{
					txtPhone.addTextChangedListener(new PhoneNumberFormattingTextWatcher());
					txtPhone.setText(reward.getPhoneNumber());
								
					}
				
				txtPhone.setTypeface(BaseActivity.typeface_roboto);
	
				
				
				if(reward.getCreatedDate()==null | reward.getCreatedDate().equals("null"))
				{
					txtSubmittedDate.setText("");
					
					}
				else
				{
					String newDate="";
					if(reward.getCreatedDate()!=null)
					{
					 	//newDate=parseDateToddMMyyyy(reward.getCreatedDate());//"yyyy-dd-MM HH:mm:ss";
						try{
							newDate = Util.formateDateFromstring("yyyy-dd-MM hh:mm:ss a", "MM/dd/yyyy hh:mm a", reward.getCreatedDate());
							}catch(Exception e)
							{
								e.printStackTrace();
							}
						}
					txtSubmittedDate.setText(newDate);
					
					}
				
				txtSubmittedDate.setTypeface(BaseActivity.typeface_roboto);
				
				
				
				if(reward.getSoldDate()==null | reward.getSoldDate().equals("null"))
				{
					
					txtSoldDate.setText("");
					}
				else
				{
					String newDate1="";
					if(reward.getSoldDate()!=null)
					{
						try{
							newDate1 = Util.formateDateFromstring("yyyy-dd-MM hh:mm:ss a", "MM/dd/yyyy hh:mm a", reward.getSoldDate());
							}catch(Exception e)
							{
								e.printStackTrace();
							}
						}
					txtSoldDate.setText(newDate1);
					
					}
					
				txtSoldDate.setTypeface(BaseActivity.typeface_roboto);
				
				
				
				if(reward.getMeaName()==null | reward.getMeaName().equals("null"))
				{
					txtMea.setText("");
					}
				else
				{
					
					txtMea.setText(reward.getMeaName());
					}
				
				
				txtMea.setTypeface(BaseActivity.typeface_roboto);
				
				
				
				
				
				if(reward.getComments()==null | reward.getComments().equals("null"))
				{
					txtComment.setText("");
					}
				else
				{
					
					txtComment.setText(reward.getComments());
					}
				
				txtComment.setTypeface(BaseActivity.typeface_roboto);
				
				
				if(reward.getReferralType().equalsIgnoreCase("direct"))
				{
					txtHeaderOutput.setText("DIRECT");
					lay_directReferral.setVisibility(View.GONE);
				}
				else
				{
					txtHeaderOutput.setText("INDIRECT");
					lay_directReferral.setVisibility(View.VISIBLE);
					txt_DirectReferral.setText(reward.getReferrerName());
				}
	
				if (reward.getReferralStatus().equalsIgnoreCase(
						DashBoardActivity.STATUS_OPEN))
					colorStripe.setBackgroundColor(getResources().getColor(
							R.color.bright_green));
				else if (reward.getReferralStatus().equalsIgnoreCase(
						DashBoardActivity.STATUS_SOLD))
					colorStripe.setBackgroundColor(getResources().getColor(
							R.color.bright_blue));
				else
					colorStripe.setBackgroundColor(getResources().getColor(
							R.color.bright_orange));
	
				header.setText("CURRENT REFERRAL");// + reward.getUniqueReferralNumber());
				
			
			
		}
///////////////////referral details
else
				{
						txtName.setText(referral.getFirstName() + " " + referral.getLastName());
						txtName.setTypeface(BaseActivity.typeface_roboto);
						
						
						if(referral.getEmail()==null | referral.getEmail().equals("null"))
						{
							txtEmail.setText("");
							}
						else
						{   txtEmail.setText(referral.getEmail());
						
							}
						txtEmail.setTypeface(BaseActivity.typeface_roboto);
						
						
						if(referral.getPhoneNumber()==null | referral.getPhoneNumber().equals("null"))
						{
							txtPhone.setText("");
							
							}
						else
						{
							txtPhone.addTextChangedListener(new PhoneNumberFormattingTextWatcher());
							txtPhone.setText(referral.getPhoneNumber());
											
							}
						
						txtPhone.setTypeface(BaseActivity.typeface_roboto);
				
						
						
						if(referral.getCreatedDate()==null | referral.getCreatedDate().equals("null"))
						{
							txtSubmittedDate.setText("");
							
							}
						else
						{
							
							String newDate1="";
							if(referral.getCreatedDate()!=null)
							{
								try{
									newDate1 = Util.formateDateFromstring("MM-dd-yyyy hh:mm:ss a", "MM/dd/yyyy hh:mm a", referral.getCreatedDate());
									}catch(Exception e)
									{
										e.printStackTrace();
									}
								}
							txtSubmittedDate.setText(newDate1);
							
							
							}
						
						txtSubmittedDate.setTypeface(BaseActivity.typeface_roboto);
						
						
						
						if(referral.getSoldDate()==null | referral.getSoldDate().equals("null"))
						{
							
							txtSoldDate.setText("");
							}
						else
						{
							String newDate1="";
							if(referral.getSoldDate()!=null)
							{
								try{
									newDate1 = Util.formateDateFromstring("MM-dd-yyyy hh:mm:ss a", "MM/dd/yyyy hh:mm a", referral.getSoldDate());
									}catch(Exception e)
									{
										e.printStackTrace();
									}
								}
							txtSoldDate.setText(newDate1);
							
							
							
							}
							
						txtSoldDate.setTypeface(BaseActivity.typeface_roboto);
						
						
						
						if(referral.getMeaName()==null | referral.getMeaName().equals("null"))
						{
							txtMea.setText("");
							}
						else
						{
							
							txtMea.setText(referral.getMeaName());
							}
						
						
						txtMea.setTypeface(BaseActivity.typeface_roboto);
						
						
						
						
						
						if(referral.getComments()==null | referral.getComments().equals("null"))
						{
							txtComment.setText("");
							}
						else
						{
							
							txtComment.setText(referral.getComments());
							}
						
						txtComment.setTypeface(BaseActivity.typeface_roboto);
						
						
						if(referral.getReferralType().equalsIgnoreCase("direct"))
						{
							txtHeaderOutput.setText("DIRECT");
							lay_directReferral.setVisibility(View.GONE);
						}
						else
						{
							txtHeaderOutput.setText("INDIRECT");
							lay_directReferral.setVisibility(View.VISIBLE);
							txt_DirectReferral.setText(referral.getReferrerName());
						}
				
						if (referral.getReferralStatus().equalsIgnoreCase(
								DashBoardActivity.STATUS_OPEN))
							colorStripe.setBackgroundColor(getResources().getColor(
									R.color.bright_green));
						else if (referral.getReferralStatus().equalsIgnoreCase(
								DashBoardActivity.STATUS_SOLD))
							colorStripe.setBackgroundColor(getResources().getColor(
									R.color.bright_blue));
						else
							colorStripe.setBackgroundColor(getResources().getColor(
									R.color.bright_orange));
				
						header.setText("CURRENT REFERRAL");
						
						
						}
				
				
	}

	private void setOnClickListener() {
		textView_back.setOnClickListener(listener);
		imageView_back.setOnClickListener(listener);

	}
	private View.OnClickListener listener = new View.OnClickListener() {

		@Override
		public void onClick(View v) {
			
		 if (v == textView_back) {
				// selectImage();
				finish();
			} else if (v == imageView_back) {
				finish();
				}
					
		}
	};
	
	/*public String parseDateToddMMyyyy(String time) {
	    String inputPattern = "yyyy-dd-MM HH:mm:ss";
	    String outputPattern = "MM/dd/yyyy";
	    SimpleDateFormat inputFormat = new SimpleDateFormat(inputPattern);
	    SimpleDateFormat outputFormat = new SimpleDateFormat(outputPattern);

	    Date date = null;
	    String str = null;

	    try {
	        date = inputFormat.parse(time);
	        str = outputFormat.format(date);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return str;
	}*/
}