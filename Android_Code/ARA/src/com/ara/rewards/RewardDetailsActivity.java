package com.ara.rewards;


import android.app.Activity;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.widget.ImageView;
import android.widget.TextView;
import com.ara.base.BaseActivity;
import com.ara.base.R;
import com.ara.board.DashBoardActivity;
import com.ara.model.Reward;
import com.ara.referral.ReferralsDetailsActivity;


public class RewardDetailsActivity extends Activity {
	
	private TextView  txtHeader, back,seeReferralDetails;
    private ImageView backArrow;
	private SharedPreferences spref;
	private Reward reward;
	private TextView rewardAmount,rewardAmount_value,rewardDescription,rewardDescription_value,rewardName,rewardName_value,rewardType,
	rewardType_value,rewardLevel,rewardLevel_value,referralId,referralId_value;



	public void onCreate(Bundle savedInstanceState) {
	super.onCreate(savedInstanceState);
	requestWindowFeature(Window.FEATURE_NO_TITLE);
	setContentView(R.layout.activity_reward_details);
	
	reward=getIntent().getParcelableExtra("reward");
	initUIComponents();
	setOnClickListener();
	
	
	
	}
	
	private void initUIComponents() {
		// TODO Auto-generated method stub
		spref = getSharedPreferences("ara_prefs", MODE_PRIVATE);
		txtHeader = (TextView)findViewById(R.id.txtHeader);
		txtHeader.setText(getIntent().getStringExtra("header"));
		
		txtHeader.setTypeface(DashBoardActivity.typeface_timeburner);	
		//title = (TextView)findViewById(R.id.txtTitle);
		//title.setTypeface(BaseActivity.typeface_timeburner);
		back = (TextView)findViewById(R.id.back);
		back.setTypeface(DashBoardActivity.typeface_roboto);
		backArrow = (ImageView)findViewById(R.id.back_arrow);
		
		
		rewardAmount = (TextView)findViewById(R.id.rewardAmount);
		rewardAmount.setTypeface(DashBoardActivity.typeface_roboto);
		
		
		rewardAmount_value = (TextView)findViewById(R.id.rewardAmount_value);
		rewardAmount_value.setTypeface(DashBoardActivity.typeface_roboto);
		rewardAmount_value.setText("$ "+reward.getRewardAmount());
		
		rewardDescription = (TextView)findViewById(R.id.rewardDescription);
		rewardDescription.setTypeface(DashBoardActivity.typeface_roboto);
		
		rewardDescription_value = (TextView)findViewById(R.id.rewardDescription_value);
		rewardDescription_value.setTypeface(DashBoardActivity.typeface_roboto);
		rewardDescription_value.setText(reward.getRewardDescription());
		
		 rewardName_value = (TextView)findViewById(R.id.rewardName_value);
		 rewardName_value.setTypeface(DashBoardActivity.typeface_roboto);
		 rewardName_value.setText(reward.getRewardName());
		
		 rewardType = (TextView)findViewById(R.id.rewardType);
		 rewardType.setTypeface(DashBoardActivity.typeface_roboto);
		
		 rewardType_value = (TextView)findViewById(R.id.rewardType_value);
		 rewardType_value.setText(reward.getRewardType());
		 rewardType_value.setTypeface(DashBoardActivity.typeface_roboto);
		 
		
		 rewardLevel = (TextView)findViewById(R.id.rewardLevel);
		
		 rewardLevel.setTypeface(DashBoardActivity.typeface_roboto);
		
		 rewardLevel_value = (TextView)findViewById(R.id.rewardLevel_value);
		 rewardLevel_value.setText(reward.getRewardlevel());
		 rewardLevel_value.setTypeface(DashBoardActivity.typeface_roboto);
		
		 referralId = (TextView)findViewById(R.id.referralId);
		 referralId.setTypeface(DashBoardActivity.typeface_roboto);
		
		 referralId_value = (TextView)findViewById(R.id.referralId_value);
		 referralId_value.setText(reward.getUniqueReferralNumber());
		 referralId_value.setTypeface(DashBoardActivity.typeface_roboto);
		
	
		
		seeReferralDetails=(TextView)findViewById(R.id.seeReferralDetails);
	}
	
	private void setOnClickListener() {
		// TODO Auto-generated method stub
		back.setOnClickListener(listener);
		backArrow.setOnClickListener(listener);
		seeReferralDetails.setOnClickListener(listener);
	}
	
	private View.OnClickListener listener = new View.OnClickListener() {
		@Override
		public void onClick(View v) {
			// TODO Auto-generated method stub
		
			if(v == back | v == backArrow){
				finish();
			
			}
			else if(v== seeReferralDetails)
			{
				Intent intent=new Intent(RewardDetailsActivity.this,ReferralsDetailsActivity.class);
				intent.putExtra("reward", reward);
				intent.putExtra("rewardcheck", "yes");
				startActivity(intent);
			}
			
			
		}
	};
	
	
}