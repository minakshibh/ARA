package com.ara.referral;

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
			lblSoldDate, lblMEA, lblComment,lbl_DirectReferral;
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
		textView_back.setTypeface(BaseActivity.typeface_roboto);
		//textView_title=(TextView)findViewById(R.id.textView_title);
		//textView_title.setTypeface(BaseActivity.typeface_timeburner);
		imageView_back=(ImageView)findViewById(R.id.imageView_back);
		imageView_referralType=(ImageView)findViewById(R.id.imageView_referralType);
		lblName = (TextView) findViewById(R.id.lblName);
		lblName.setTypeface(BaseActivity.typeface_roboto);

		lblEmail = (TextView) findViewById(R.id.lblEmail);
		lblEmail.setTypeface(BaseActivity.typeface_roboto);

		lblPhonenumber = (TextView) findViewById(R.id.lblPhonenumber);
		lblPhonenumber.setTypeface(BaseActivity.typeface_roboto);

		lblSubmittedDate = (TextView) findViewById(R.id.lblSubmittedDate);
		lblSubmittedDate.setTypeface(BaseActivity.typeface_roboto);
		lbl_DirectReferral= (TextView) findViewById(R.id.lbl_DirectReferral);
		lbl_DirectReferral.setTypeface(BaseActivity.typeface_roboto);
		lblSoldDate = (TextView) findViewById(R.id.lblSoldDate);
		lblSoldDate.setTypeface(BaseActivity.typeface_roboto);

		txt_DirectReferral = (TextView) findViewById(R.id.txt_DirectReferral);
		txt_DirectReferral.setTypeface(BaseActivity.typeface_roboto);
		lblMEA = (TextView) findViewById(R.id.lblMEA);
		lblMEA.setTypeface(BaseActivity.typeface_roboto);

		lblComment = (TextView) findViewById(R.id.lblComment);
		lblComment.setTypeface(BaseActivity.typeface_roboto);

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
		header.setTypeface(BaseActivity.typeface_timeburner);

		
		if(getIntent().getStringExtra("rewardcheck")!=null)
		{
				reward=getIntent().getParcelableExtra("reward");
				
				txtName.setText(reward.getFirstName() + " " + reward.getLastName());
				txtName.setTypeface(BaseActivity.typeface_roboto);
				
				
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
					txtSubmittedDate.setText(reward.getCreatedDate());
					
					}
				
				txtSubmittedDate.setTypeface(BaseActivity.typeface_roboto);
				
				
				
				if(reward.getSoldDate()==null | reward.getSoldDate().equals("null"))
				{
					
					txtSoldDate.setText("");
					}
				else
				{
					txtSoldDate.setText(reward.getSoldDate());
					
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
					imageView_referralType.setImageResource(R.drawable.direct_ref);
					lay_directReferral.setVisibility(View.GONE);
				}
				else
				{
					imageView_referralType.setImageResource(R.drawable.chained_ref);
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
	
				header.setText("REFERRAL ID: " + reward.getUniqueReferralNumber());
				
			
			
		}
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
							txtSubmittedDate.setText(referral.getCreatedDate());
							
							}
						
						txtSubmittedDate.setTypeface(BaseActivity.typeface_roboto);
						
						
						
						if(referral.getSoldDate()==null | referral.getSoldDate().equals("null"))
						{
							
							txtSoldDate.setText("");
							}
						else
						{
							txtSoldDate.setText(referral.getSoldDate());
							
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
							imageView_referralType.setImageResource(R.drawable.direct_ref);
							lay_directReferral.setVisibility(View.GONE);
						}
						else
						{
							imageView_referralType.setImageResource(R.drawable.chained_ref);
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
				
						header.setText("REFERRAL ID: " + referral.getReferralNumber());
						
						
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
}