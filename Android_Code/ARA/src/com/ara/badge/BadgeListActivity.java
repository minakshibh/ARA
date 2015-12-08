package com.ara.badge;

import java.util.ArrayList;
import org.apache.http.NameValuePair;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.SharedPreferences;
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
import com.ara.imageloader.ImageLoader;
import com.ara.model.Badge;
import com.ara.util.ARAParser;
import com.ara.util.Util;

public class BadgeListActivity extends Activity implements

AsyncResponseForARA {

	private TextView title, back, txtHeader,all_Badges;

	private ImageView backArrow;
	private ListView listview;
	private SharedPreferences spref;
	private String str_badge="";
	private ArrayList<Badge> array_Badge=new ArrayList<Badge>();

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.activity_badgelist);

		initUIComponents();
		setOnClickListener();
		fetchBadgeApiUser();

	}

	private void initUIComponents() {

		spref = getSharedPreferences("ara_prefs", MODE_PRIVATE);
		txtHeader = (TextView) findViewById(R.id.txtHeader);
		txtHeader.setTypeface(BaseActivity.typeface_timeburner);
		//title = (TextView) findViewById(R.id.txtTitle);
		//title.setTypeface(BaseActivity.typeface_timeburner);
		back = (TextView) findViewById(R.id.back);
		back.setTypeface(BaseActivity.typeface_roboto);
		backArrow = (ImageView) findViewById(R.id.back_arrow);
		listview=(ListView)findViewById(R.id.listview);
		all_Badges=(TextView)findViewById(R.id.all_Badges);
		all_Badges.setTypeface(BaseActivity.typeface_roboto);
	}

	private void setOnClickListener() {
		// TODO Auto-generated method stub
		back.setOnClickListener(listener);
		backArrow.setOnClickListener(listener);
		all_Badges.setOnClickListener(listener);

	}

	private View.OnClickListener listener = new View.OnClickListener() {
		@Override
		public void onClick(View v) {
			// TODO Auto-generated method stub

			if (v == back | v == backArrow) {
			
				gotoBackScreen();
			}
			else if(v== all_Badges)
			{
				fetchBadgeAll();
				all_Badges.setVisibility(View.INVISIBLE);
				
			}

		}
	};
	private void fetchBadgeAll() {
		
		if(Util.isNetworkAvailable(BadgeListActivity.this)){
		
			//[NSString stringWithFormat:@"%@/badges/%@",Kwebservices,userid]]
		
			str_badge="all";
			ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
			AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(BadgeListActivity.this,"get","badges",nameValuePairs, true, "Please wait...",true);
			mWebPageTask.delegate = (AsyncResponseForARA) BadgeListActivity.this;
			mWebPageTask.execute();	
		
			}
			else
			{
				Util.alertMessage(BadgeListActivity.this, Util.network_error);
				}
		}
	private void fetchBadgeApiUser() {
		
		if(Util.isNetworkAvailable(BadgeListActivity.this)){
		
			str_badge="one";
			//[NSString stringWithFormat:@"%@/badges/%@",Kwebservices,userid]]
			String userid=spref.getString("userid", "0");////"151";
			System.err.println("user"+ userid);
			
			ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
			AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(BadgeListActivity.this,"get","badges/"+userid,nameValuePairs, true, "Please wait...",true);
			mWebPageTask.delegate = (AsyncResponseForARA) BadgeListActivity.this;
			mWebPageTask.execute();	
		
			}
			else
			{
				Util.alertMessage(BadgeListActivity.this, Util.network_error);
				}
		}
	
	public class ListAdapter extends BaseAdapter {
		private Context context;
		private TextView name, details, date;
		private ImageView Imageview;
		public ListAdapter(Context ctx) {
			context = ctx;
		}

		// @Override
		public int getCount() {
			// TODO Auto-generated method stub
			return array_Badge.size();
		}

		// @Override
		public Object getItem(int position) {
			// TODO Auto-generated method stub
			return array_Badge.get(position);
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
				convertView = inflater.inflate(R.layout.badge_list_row, parent,
						false);
			}

			name = (TextView) convertView.findViewById(R.id.name);
			details = (TextView) convertView.findViewById(R.id.detail);
			date = (TextView) convertView.findViewById(R.id.date);
			Imageview=(ImageView)convertView.findViewById(R.id.imageview);
			
			
			Badge badge = array_Badge.get(position);
			
			name.setText(badge.getBadgeName());
			name.setTypeface(BaseActivity.typeface_roboto);
			
		
			details.setText(badge.getMinimumReferralsRequired()+" "+badge.getBadgeStatus()+" Referrals with in "+badge.getApplicableTimeFrameInDays()+ " Days" );
			details.setTypeface(BaseActivity.typeface_roboto);
		
			if(str_badge.equalsIgnoreCase("one"))
			{
				date.setText("Earned on : "+badge.getEarnedDate());
				date.setTypeface(BaseActivity.typeface_roboto);
				}
			else
			{
				date.setText("");
				}
				
			ImageLoader  imageLoader = new ImageLoader(BadgeListActivity.this);
			if(badge.getBadgeUrl()!=null)
			{
			     imageLoader.DisplayImage(badge.getBadgeUrl(), Imageview);
				}
			
			return convertView;
		}
	}
	
	@Override
	public void processFinish(String output, String methodName) {
		// TODO Auto-generated method stub
		
		if(methodName.contains("badges"))
		{
			array_Badge=new ArrayList<Badge>();
			ARAParser parser = new ARAParser(BadgeListActivity.this);
				
			array_Badge=parser.parseBadgeContent(output);
			listview.setAdapter(new ListAdapter(BadgeListActivity.this));
				
			if(str_badge.equals("all"))
			{
				txtHeader.setText("All BADGES"+" ("+array_Badge.size()+")");
			}
			else
			{
				txtHeader.setText("MY BADGES"+" ("+array_Badge.size()+")");
				}
			if(array_Badge.size()<1)
			{
				AlertDialog.Builder alert = new AlertDialog.Builder(BadgeListActivity.this);
				alert.setMessage("not badges display yet now");
				alert.setPositiveButton("Ok",null);
				alert.show();
				
				
			}
		}
	}

	@Override
	public void onBackPressed() {
		// TODO Auto-generated method stub
		//super.onBackPressed();
	
		gotoBackScreen();
		
	}
	
	private void gotoBackScreen()
	{
		if(str_badge.equals("all"))
		{
			fetchBadgeApiUser();
			all_Badges.setVisibility(View.VISIBLE);
			//txtHeader.setText("MY BADGES"+" ["+array_Badge.size()+"]");
		}
		else
		{
			finish();
			}
	}
}
