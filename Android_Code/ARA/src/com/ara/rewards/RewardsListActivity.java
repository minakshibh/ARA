package com.ara.rewards;

import java.util.ArrayList;
import org.apache.http.NameValuePair;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.SeekBar;
import android.widget.TextView;
import com.ara.async_tasks.AsyncResponseForARA;
import com.ara.async_tasks.AsyncTaskForARA;
import com.ara.base.BaseActivity;
import com.ara.base.R;
import com.ara.base.ServerUtilities;
import com.ara.board.DashBoardActivity;
import com.ara.login.RegisterActivity;
import com.ara.model.Reward;
import com.ara.model.User;
import com.ara.util.ARAParser;
import com.ara.util.Util;

public class RewardsListActivity extends Activity implements
AsyncResponseForARA {

	private TextView  txtHeader, back;
	private ListView rewardListView;
	public static ArrayList<Reward> rewardList;
	private ImageView backArrow;
	private SharedPreferences spref;
	private TextView button_Earned,button_Upcoming;
	private String rewardType ="earned";
	private String rewardTypeHeader ="PAYMENT EARNED";
	
	
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.activity_rewards_list);
		
		
		initUIComponents();
		setOnClickListener();
		LoadRewardsList();
		
	}
	
	

	private void initUIComponents() {
		// TODO Auto-generated method stub
		rewardList = new ArrayList<Reward>();
		spref = getSharedPreferences("ara_prefs", MODE_PRIVATE);
		txtHeader = (TextView)findViewById(R.id.txtHeader);
		txtHeader.setTypeface(BaseActivity.typeface_timeburner);
		//title = (TextView)findViewById(R.id.txtTitle);
		//title.setTypeface(BaseActivity.typeface_timeburner);
		back = (TextView)findViewById(R.id.back);
		back.setTypeface(BaseActivity.typeface_roboto);
		
		button_Earned=(TextView)findViewById(R.id.button_Earned);
		button_Earned.setTypeface(BaseActivity.typeface_roboto);
		
		button_Upcoming=(TextView)findViewById(R.id.button_Upcoming);
		button_Upcoming.setTypeface(BaseActivity.typeface_roboto);
		
		rewardListView = (ListView)findViewById(R.id.rewardListView);
		backArrow = (ImageView)findViewById(R.id.back_arrow);
		
	}
	private void setOnClickListener() {
		// TODO Auto-generated method stub
		back.setOnClickListener(listener);
		backArrow.setOnClickListener(listener);
		button_Earned.setOnClickListener(listener);
		button_Upcoming.setOnClickListener(listener);
		
		rewardListView.setOnItemClickListener(new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> parent, View view,
					int position, long id) {
				// TODO Auto-generated method stub
				Reward reward = rewardList.get(position);
				
				Intent intent=new Intent(RewardsListActivity.this,RewardDetailsActivity.class);
				intent.putExtra("reward", reward);
				intent.putExtra("header", rewardTypeHeader);
			    startActivity(intent);
			}
		});
	}
	private void LoadRewardsList() {
		// TODO Auto-generated method stub
		
		String userid=spref.getString("userid", "");
		
		if (Util.isNetworkAvailable(RewardsListActivity.this)) {

			ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();

			AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(
					RewardsListActivity.this, "get","/Rewards/"+userid+"/rewardType/"+rewardType, nameValuePairs,
					true, "Please wait...", true);
			mWebPageTask.delegate = (AsyncResponseForARA) RewardsListActivity.this;
			mWebPageTask.execute();
		} else {
			Util.alertMessage(RewardsListActivity.this, Util.network_error);
		}
		
		

	}


	private View.OnClickListener listener = new View.OnClickListener() {
		@Override
		public void onClick(View v) {
			// TODO Auto-generated method stub
		
			if(v == back | v == backArrow){
				finish();
			
			}
			else if (v == button_Earned){
				rewardType="earned";
				LoadRewardsList();
				rewardTypeHeader="PAYMENT EARNED";
				txtHeader.setText(rewardTypeHeader);
				button_Earned.setBackgroundColor(getResources().getColor(R.color.app_yellow));
				button_Earned.setTextColor(getResources().getColor(R.color.black));
				
				button_Upcoming.setTextColor(getResources().getColor(R.color.white));
				button_Upcoming.setBackgroundColor(getResources().getColor(R.color.black));
			}
			else if (v == button_Upcoming){
			  rewardType="upcoming";
			  rewardTypeHeader="PAYMENT UPCOMING";
			  txtHeader.setText(rewardTypeHeader);
			
			  button_Upcoming.setBackgroundColor(getResources().getColor(R.color.app_yellow));
			  button_Upcoming.setTextColor(getResources().getColor(R.color.black));
			  
			 
			  button_Earned.setBackgroundColor(getResources().getColor(R.color.black));
			  button_Earned.setTextColor(getResources().getColor(R.color.white));
			  LoadRewardsList();
		}
			
		}
	};
	public class RewardListAdapter extends BaseAdapter {
		private Context context;
		private TextView name, referralId, amount,date;
	

		public RewardListAdapter(Context ctx) {
			context = ctx;
		}

		// @Override
		public int getCount() {
			// TODO Auto-generated method stub
			return rewardList.size();
		}

		// @Override
		public Object getItem(int position) {
			// TODO Auto-generated method stub
			return rewardList.get(position);
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
				convertView = inflater.inflate(R.layout.reward_list_row, parent,
						false);
			}

			name = (TextView) convertView.findViewById(R.id.name);
			referralId = (TextView) convertView.findViewById(R.id.referralId);
			amount = (TextView) convertView.findViewById(R.id.amount);
			date= (TextView) convertView.findViewById(R.id.date);
			Reward reward = rewardList.get(position);
			
	
			
			name.setText(reward.getFirstName() + " "
					+ reward.getLastName());
			name.setTypeface(BaseActivity.typeface_roboto);
			
			referralId.setText(reward.getUniqueReferralNumber());
			referralId.setTypeface(BaseActivity.typeface_roboto);
			
			amount.setText("$ "+reward.getRewardAmount());
			amount.setTypeface(BaseActivity.typeface_roboto);
			
			date.setText("Sold Date : "+reward.getSoldDate());
			date.setTypeface(BaseActivity.typeface_roboto);

			return convertView;
		}
	}	
	@Override
	public void processFinish(String output, String methodName) {
		
		// TODO Auto-generated method stub
		System.err.println(output);
		
		ARAParser parser = new ARAParser(RewardsListActivity.this);
		rewardList = parser.parseRewardListResponse(output);
				
		if(rewardList.size()>0)
		{
		rewardListView.setAdapter(new RewardListAdapter(RewardsListActivity.this));
		}
		else
		{
			AlertDialog.Builder alert = new AlertDialog.Builder(
					RewardsListActivity.this);
			alert.setMessage("No rewards to display yet.");
			alert.setPositiveButton("ok",
					new DialogInterface.OnClickListener() {
						public void onClick(DialogInterface arg0, int arg1) {
								//finish();
							
						}
					});
			alert.show();
		}
	}
}
