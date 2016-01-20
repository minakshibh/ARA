package com.ara.board;

import java.util.ArrayList;

import org.apache.http.NameValuePair;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import com.ara.async_tasks.AsyncResponseForARA;
import com.ara.async_tasks.AsyncTaskForARA;
import com.ara.base.BaseActivity;
import com.ara.base.R;
import com.ara.model.ReferralEarn;
import com.ara.util.ARAParser;
import com.ara.util.Util;

public class ScoreBoardDetailActivity extends Activity implements

AsyncResponseForARA {

		
	private TextView  title,back,txtHeader;
	//private SharedPreferences spref;
	private ImageView backArrow;
	private ArrayList<ReferralEarn> array_ReferralEarn;
	private TextView button_Quater,button_Year,button_AllTime;
	private ListView listview;

public void onCreate(Bundle savedInstanceState) {
	super.onCreate(savedInstanceState);
	requestWindowFeature(Window.FEATURE_NO_TITLE);
	setContentView(R.layout.activity_scoreboarddetail);



	initUIComponents();
	setOnClickListener();
	scoreBoardApi();
	
	}
private void initUIComponents() {
	// TODO Auto-generated method stub
	txtHeader = (TextView)findViewById(R.id.txtHeader);
	txtHeader.setTypeface(DashBoardActivity.typeface_timeburner);
	txtHeader.setText(ScoreBoardActivity.headertxt);
	//title = (TextView)findViewById(R.id.txtTitle);
	//title.setTypeface(BaseActivity.typeface_timeburner);
	back = (TextView)findViewById(R.id.back);
	back.setTypeface(DashBoardActivity.typeface_roboto);
	backArrow = (ImageView)findViewById(R.id.back_arrow);
	listview=(ListView)findViewById(R.id.listview);
	button_Year=(TextView)findViewById(R.id.button_Year);
	button_Year.setTypeface(DashBoardActivity.typeface_roboto);
	button_Quater=(TextView)findViewById(R.id.button_Quater);
	button_Quater.setTypeface(DashBoardActivity.typeface_roboto);
	button_AllTime=(TextView)findViewById(R.id.button_AllTime);
	button_AllTime.setTypeface(DashBoardActivity.typeface_roboto);
	
	if(ScoreBoardActivity.timestamp.equalsIgnoreCase("quaterly"))
	{
		setBackground(true,false,false);
	}
	else if(ScoreBoardActivity.timestamp.equalsIgnoreCase("yearly"))
	{
		setBackground(false,true,false);
	}
	else if(ScoreBoardActivity.timestamp.equalsIgnoreCase("all"))
	{
		setBackground(false,false,true);
	}
	
}
private void setOnClickListener() {
	// TODO Auto-generated method stub
	back.setOnClickListener(listener);
	backArrow.setOnClickListener(listener);
	button_Year.setOnClickListener(listener);
	button_Quater.setOnClickListener(listener);
	button_AllTime.setOnClickListener(listener);
}


private View.OnClickListener listener = new View.OnClickListener() {
	@Override
	public void onClick(View v) {
		// TODO Auto-generated method stub
	
		if(v == back | v == backArrow){
		
			goBack();
		}
		else if(v == button_Quater ){
			ScoreBoardActivity.timestamp="quaterly";
			scoreBoardApi();
			setBackground(true,false,false);
		}
		else if(v == button_Year ){
			ScoreBoardActivity.timestamp="yearly";
			scoreBoardApi();
			setBackground(false,true,false);
		}
		
		else if(v == button_AllTime ){
			ScoreBoardActivity.timestamp="all";
			scoreBoardApi();
			setBackground(false,false,true);
			
		}
					
	}
};
private void scoreBoardApi() {
	
	if(Util.isNetworkAvailable(ScoreBoardDetailActivity.this)){
	
		//@"%@/scoreboard/%@/timestamp/%@",Kwebservices,_trigger,_timestamp]]
		
		System.err.println("timestamp="+ScoreBoardActivity.timestamp+" trigger="+ScoreBoardActivity.trigger);
		
		ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
		AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(ScoreBoardDetailActivity.this,"get","scoreboard/"+ScoreBoardActivity.trigger+"/timestamp/"+ScoreBoardActivity.timestamp,nameValuePairs, true, "Please wait...",true);
		mWebPageTask.delegate = (AsyncResponseForARA) ScoreBoardDetailActivity.this;
		mWebPageTask.execute();	
	
		}
		else
		{
			Util.alertMessage(ScoreBoardDetailActivity.this, Util.network_error);
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

public class ReferralListAdapter extends BaseAdapter {
	private Context context;
	private TextView userName, EarnAmount, referral;
	
	public ReferralListAdapter(Context ctx) {
		context = ctx;
	}

	// @Override
	public int getCount() {
		// TODO Auto-generated method stub
		return array_ReferralEarn.size();
	}

	// @Override
	public Object getItem(int position) {
		// TODO Auto-generated method stub
		return array_ReferralEarn.get(position);
	}

	// @Override
	public long getItemId(int position) {
		// TODO Auto-generated method stub
		return position;
	}

	// @Override
	public View getView(final int position, View convertView,
			ViewGroup parent) {
		LayoutInflater inflater = (LayoutInflater) context
				.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		if (convertView == null) {
			convertView = inflater.inflate(R.layout.referral_earn_row_list, parent,
					false);
		}

		userName = (TextView) convertView.findViewById(R.id.textView_Username);
		EarnAmount = (TextView) convertView.findViewById(R.id.txt_EarnAmount);
		referral = (TextView) convertView.findViewById(R.id.txt_referral);
	
		ReferralEarn referralEarn = array_ReferralEarn.get(position);
		
		userName.setText(referralEarn.getUserName());
		userName.setTypeface(BaseActivity.typeface_roboto);
		
		
		EarnAmount.setTypeface(BaseActivity.typeface_roboto);
		
		
		referral.setTypeface(BaseActivity.typeface_roboto);
		
		if(ScoreBoardActivity.trigger.equals("HighestEarner"))
		{
			referral.setText("Amount Earned : ");
			EarnAmount.setText("$ "+referralEarn.getEarning());
			
		}
		else if(ScoreBoardActivity.trigger.equals("HighestReferral"))
		{
			referral.setText("Referrals : ");
			EarnAmount.setText(""+referralEarn.getReferralCount());
			
		}
		else 
		{
			referral.setText("Sold Referrals : ");
			EarnAmount.setText(""+referralEarn.getReferralCount());
			
		}
		
		

		return convertView;
	}
}
@Override
public void processFinish(String output, String methodName) {
	// TODO Auto-generated method stub
	
	 array_ReferralEarn=new ArrayList<ReferralEarn>();
	ARAParser parser = new ARAParser(ScoreBoardDetailActivity.this);
	if(methodName.contains("scoreboard"))
	{
		array_ReferralEarn=parser.parseReferralEarn(output);
		listview.setAdapter(new ReferralListAdapter(ScoreBoardDetailActivity.this));
		}
}
@Override
public void onBackPressed() {
	// TODO Auto-generated method stub
	super.onBackPressed();
	
	goBack();
}

private void goBack()
{
	Intent intent=new Intent(ScoreBoardDetailActivity.this,ScoreBoardActivity.class);
	intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
	startActivity(intent);
	finish();}
}