package com.ara.board;

import java.util.ArrayList;
import org.apache.http.NameValuePair;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;
import com.ara.async_tasks.AsyncResponseForARA;
import com.ara.async_tasks.AsyncTaskForARA;
import com.ara.base.BaseActivity;
import com.ara.base.R;
import com.ara.model.ScoreBoard;
import com.ara.util.ARAParser;
import com.ara.util.Util;


public class ScoreBoardActivity extends Activity implements

AsyncResponseForARA {

		
	private TextView  title,back,txtHeader,lbl_Highest1,lbl_Highest2,lbl_Highest3,lbl_Earning,lbl_Referral,
	lblsoldReferral,Earning,Referral,soldReferral;
	//private SharedPreferences spref;
	private ImageView backArrow;
	public static String timestamp="",trigger="",headertxt="";
	private TextView button_Quater,button_Year,button_AllTime;
	private LinearLayout lay_Earning,lay_Referrals,lay_SoldReferrals;

public void onCreate(Bundle savedInstanceState) {
	super.onCreate(savedInstanceState);
	requestWindowFeature(Window.FEATURE_NO_TITLE);
	setContentView(R.layout.activity_score_board);



	initUIComponents();
	setOnClickListener();
	scoreBoardApi();
}


	private void initUIComponents() {
		
		//spref = getSharedPreferences("ara_prefs", MODE_PRIVATE);
		txtHeader = (TextView)findViewById(R.id.txtHeader);
		txtHeader.setTypeface(DashBoardActivity.typeface_timeburner);	
		//title = (TextView)findViewById(R.id.txtTitle);
		//title.setTypeface(BaseActivity.typeface_timeburner);
		back = (TextView)findViewById(R.id.back);
		back.setTypeface(DashBoardActivity.typeface_roboto);
		backArrow = (ImageView)findViewById(R.id.back_arrow);
		
		lbl_Highest1 = (TextView)findViewById(R.id.lbl1);
		lbl_Highest1.setTypeface(DashBoardActivity.typeface_roboto);
		lbl_Highest2 = (TextView)findViewById(R.id.lbl2);
		lbl_Highest2.setTypeface(DashBoardActivity.typeface_roboto);
		lbl_Highest3 = (TextView)findViewById(R.id.lbl3);
		lbl_Highest3.setTypeface(DashBoardActivity.typeface_roboto);
		
		
		lbl_Earning = (TextView)findViewById(R.id.lbl_Earning);
		lbl_Earning.setTypeface(DashBoardActivity.typeface_roboto);
		
		
		lbl_Referral = (TextView)findViewById(R.id.lbl_Referral);
		lbl_Referral.setTypeface(DashBoardActivity.typeface_roboto);
		
		
		soldReferral = (TextView)findViewById(R.id.soldReferral);
		soldReferral.setTypeface(DashBoardActivity.typeface_roboto);
		
		lblsoldReferral = (TextView)findViewById(R.id.lblsoldReferral);
		lblsoldReferral.setTypeface(DashBoardActivity.typeface_roboto);
		
		Earning = (TextView)findViewById(R.id.Earning);
		Earning.setTypeface(DashBoardActivity.typeface_roboto);
		Referral= (TextView)findViewById(R.id.Referral);
		Referral.setTypeface(DashBoardActivity.typeface_roboto);
		
		button_Year=(TextView)findViewById(R.id.button_Year);
		button_Year.setTypeface(DashBoardActivity.typeface_roboto);
		button_Quater=(TextView)findViewById(R.id.button_Quater);
		button_Quater.setTypeface(DashBoardActivity.typeface_roboto);
		button_AllTime=(TextView)findViewById(R.id.button_AllTime);
		button_AllTime.setTypeface(DashBoardActivity.typeface_roboto);
		
		lay_Earning=(LinearLayout)findViewById(R.id.lay_Earning);
		lay_Referrals=(LinearLayout)findViewById(R.id.lay_Referrals);
		lay_SoldReferrals=(LinearLayout)findViewById(R.id.lay_SoldReferrals);
		
		if(getIntent().getStringExtra("base")!=null)
		{
			timestamp="quaterly";
			setBackground(true,false,false);
		}
		else{
			if(timestamp.equalsIgnoreCase("quaterly"))
			{
				setBackground(true,false,false);
			}
			else if(timestamp.equalsIgnoreCase("yearly"))
			{
				setBackground(false,true,false);
			}
			else if(timestamp.equalsIgnoreCase("all"))
			{
				setBackground(false,false,true);
			}
		}
	}
	private void setOnClickListener() {
		// TODO Auto-generated method stub
		back.setOnClickListener(listener);
		backArrow.setOnClickListener(listener);
		button_Year.setOnClickListener(listener);
		button_Quater.setOnClickListener(listener);
		button_AllTime.setOnClickListener(listener);
		
		lay_Earning.setOnClickListener(listener);
		lay_Referrals.setOnClickListener(listener);
		lay_SoldReferrals.setOnClickListener(listener);
	}
	
	
	private View.OnClickListener listener = new View.OnClickListener() {
		@Override
		public void onClick(View v) {
			// TODO Auto-generated method stub
		
			if(v == back | v == backArrow){
				finish();
			
			}
			else if(v == button_Quater ){
				timestamp="quaterly";
				scoreBoardApi();
				setBackground(true,false,false);
			}
			else if(v == button_Year ){
				timestamp="yearly";
				scoreBoardApi();
				setBackground(false,true,false);
			}
			
			else if(v == button_AllTime ){
				timestamp="all";
				scoreBoardApi();
				setBackground(false,false,true);
				
			}
			////////////////////
			else if(v == lay_Earning ){
				trigger="HighestEarner";
				headertxt="HIGHEST EARNERS"; 
				Intent intent=new Intent(ScoreBoardActivity.this,ScoreBoardDetailActivity.class);
				startActivity(intent);
				
			}
			else if(v == lay_Referrals ){
				trigger="HighestReferral";
				headertxt="HIGHEST REFERRALS"; 
				Intent intent=new Intent(ScoreBoardActivity.this,ScoreBoardDetailActivity.class);
				startActivity(intent);
				
			}
			else if(v == lay_SoldReferrals ){
			
				trigger="HighestSoldReferral";
				headertxt="HIGHEST SOLD REFERRALS"; 
				Intent intent=new Intent(ScoreBoardActivity.this,ScoreBoardDetailActivity.class);
				startActivity(intent);
				
			}
			
						
		}
	};

	private void scoreBoardApi() {
	
		if(Util.isNetworkAvailable(ScoreBoardActivity.this)){
		
		
			System.err.println("timestamp="+timestamp);
			ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
			AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(ScoreBoardActivity.this,"get","scoreboard/"+timestamp,nameValuePairs, true, "Please wait...",true);
			mWebPageTask.delegate = (AsyncResponseForARA) ScoreBoardActivity.this;
			mWebPageTask.execute();	
		
			}
			else
			{
				Util.alertMessage(ScoreBoardActivity.this, Util.network_error);
				}
		}

	private void setBackground(Boolean qauter,Boolean year, Boolean all)
	{
		if(qauter)
		{
			button_Quater.setBackgroundColor(getResources().getColor(R.color.app_yellow));
			button_Quater.setTextColor(getResources().getColor(R.color.black));
			button_Year.setBackgroundColor(getResources().getColor(R.color.black));
			button_AllTime.setBackgroundColor(getResources().getColor(R.color.black));
			button_Year.setTextColor(getResources().getColor(R.color.white));
			button_AllTime.setTextColor(getResources().getColor(R.color.white));
			}
		else if(year)
		{
			button_Year.setBackgroundColor(getResources().getColor(R.color.app_yellow));
			button_Year.setTextColor(getResources().getColor(R.color.black));
			button_Quater.setBackgroundColor(getResources().getColor(R.color.black));
			button_AllTime.setBackgroundColor(getResources().getColor(R.color.black));
			button_Quater.setTextColor(getResources().getColor(R.color.white));
			button_AllTime.setTextColor(getResources().getColor(R.color.white));
		}
		else if(all)
		{
			button_AllTime.setBackgroundColor(getResources().getColor(R.color.app_yellow));
			button_AllTime.setTextColor(getResources().getColor(R.color.black));
			button_Year.setBackgroundColor(getResources().getColor(R.color.black));
			button_Quater.setBackgroundColor(getResources().getColor(R.color.black));
			button_Quater.setTextColor(getResources().getColor(R.color.white));
			button_Year.setTextColor(getResources().getColor(R.color.white));
		}
		
		
	}
	@Override
	public void processFinish(String output, String methodName) {
		// TODO Auto-generated method stub
		ScoreBoard scoreBoard=null;
		ARAParser parser = new ARAParser(ScoreBoardActivity.this);
		if(methodName.contains("scoreboard"))
		{
			scoreBoard=parser.parseScoreBoardContent(output);
			Earning.setText("$ "+scoreBoard.getHighestEarning());
			soldReferral.setText(scoreBoard.getHighestSoldReferrals());
			Referral.setText(scoreBoard.getHighestReferrals());
		}
	}

}