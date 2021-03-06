package com.ara.referral;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import org.apache.http.NameValuePair;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.net.ParseException;
import android.os.Bundle;
import android.text.format.DateFormat;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.widget.AdapterView;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.RelativeLayout;
import android.widget.RelativeLayout.LayoutParams;
import android.widget.TextView;
import com.ara.async_tasks.AsyncResponseForARA;
import com.ara.async_tasks.AsyncTaskForARA;
import com.ara.base.BaseActivity;
import com.ara.model.Referral;
import com.ara.util.ARAParser;
import com.ara.util.Util;
import com.ara.base.R;
import com.ara.board.DashBoardActivity;

public class ReferralListActivity extends Activity implements
		AsyncResponseForARA {

	
	private TextView  textView_sort,textView_filter,txtHeader, appliedFilter,textView_back;
	private ListView listView;
	private RelativeLayout RelativeLayout_sort, RelativeLayout_filter;
	private String referralType, selectedSort = "none", selectedFilter = "none";
	private ArrayList<Referral> referralList, sortedFilteredList,nextReferralList;
	private SharedPreferences spref;
	private ImageView imageView_back;
	private LinearLayout filterContainer;
	
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.activity_referrals);
		
		
		
		initUIComponents();
		setOnClickListener();
	
	
		
	}

	private void initUIComponents() {
		
		spref = getSharedPreferences("ara_prefs", MODE_PRIVATE);
		referralType = getIntent().getStringExtra("referralStatus");
		referralList = new ArrayList<Referral>();
		sortedFilteredList = new ArrayList<Referral>();
		nextReferralList= new ArrayList<Referral>();
		txtHeader=(TextView)findViewById(R.id.txtHeader);
		txtHeader.setTypeface(DashBoardActivity.typeface_timeburner);
		appliedFilter = (TextView)findViewById(R.id.appliedFilter);
		//textView_title=(TextView)findViewById(R.id.textView_title);
		//textView_title.setTypeface(BaseActivity.typeface_timeburner);
		
		textView_back=(TextView)findViewById(R.id.textView_back);
		textView_back.setTypeface(DashBoardActivity.typeface_roboto);
		textView_sort = (TextView) findViewById(R.id.textView_sort);
		textView_sort.setTypeface(DashBoardActivity.typeface_roboto);
		imageView_back=(ImageView)findViewById(R.id.imageView_back);
		textView_filter = (TextView) findViewById(R.id.textView_filter);
		textView_filter.setTypeface(DashBoardActivity.typeface_roboto);

		listView = (ListView) findViewById(R.id.listView);

		RelativeLayout_sort = (RelativeLayout) findViewById(R.id.RelativeLayout_sort);
		RelativeLayout_filter = (RelativeLayout) findViewById(R.id.RelativeLayout_filter);
		filterContainer = (LinearLayout)findViewById(R.id.filterContainer);
		
		if(referralType.equalsIgnoreCase("all"))
		{
			RelativeLayout_filter.setVisibility(View.VISIBLE);
		}
		else
		{
			RelativeLayout_filter.setVisibility(View.GONE);
		}
			
			
			loadReferrals(referralType);
	}
	
	private void setOnClickListener()
	{
		RelativeLayout_sort.setOnClickListener(listener);
		RelativeLayout_filter.setOnClickListener(listener);
		appliedFilter.setOnClickListener(listener);
		textView_back.setOnClickListener(listener);
		imageView_back.setOnClickListener(listener);
		
		listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1, int arg2,
					long arg3) {
				// TODO Auto-generated method stub
				if(nextReferralList.size()>0)
				{
					nextReferralList.clear();
					nextReferralList.addAll(sortedFilteredList);
					}
				
				Intent intent = new Intent(ReferralListActivity.this,
						ReferralsDetailsActivity.class);
				intent.putExtra("referral", nextReferralList.get(arg2));
				startActivity(intent);
				//finish();
			}
		});
	}
	
private View.OnClickListener listener = new View.OnClickListener() {
		@Override
		public void onClick(View v) {
			// TODO Auto-generated method stub
		
			if(v == RelativeLayout_sort){
				dialogforSort();
			
			}else if (v == RelativeLayout_filter){
				dialogforFilter();
			}else if(v == appliedFilter){
				filterContainer.setVisibility(View.GONE);
				selectedFilter = "none";
				filterReferrals();
			}
			else if(v == textView_back | v == imageView_back){
			finish();	
			}
			
		}
	};
	
	
	private void loadReferrals(String referralType) {
		// TODO Auto-generated method stub
		String userid=spref.getString("userid", "");
		
		if (Util.isNetworkAvailable(ReferralListActivity.this)) {

			ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();

			AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(
					ReferralListActivity.this, "get",
					"referrals/"+userid+"/statusType/" + referralType, nameValuePairs,
					true, "Please wait...", true);
			mWebPageTask.delegate = (AsyncResponseForARA) ReferralListActivity.this;
			mWebPageTask.execute();
		} else {
			Util.alertMessage(ReferralListActivity.this, Util.network_error);
		}
	}

	

	private void dialogforSort() {
		// custom dialog
		final Dialog dialog = new Dialog(this);
		dialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
		dialog.setContentView(R.layout.dailog_layout);
		
		LinearLayout dailog_layout=(LinearLayout)dialog.findViewById(R.id.dailog_layout);
		dailog_layout.setLayoutParams(new LayoutParams(LayoutParams.MATCH_PARENT,LayoutParams.WRAP_CONTENT));
		
		
		// dialog.setTitle("Title...");
		dialog.setCanceledOnTouchOutside(false);
		// set the custom dialog components - text, image and button
		LinearLayout layout_name = (LinearLayout) dialog.findViewById(R.id.layout1);
		LinearLayout layout_date = (LinearLayout) dialog.findViewById(R.id.layout2);
		LinearLayout layout_none = (LinearLayout) dialog.findViewById(R.id.layout3);
		
		TextView title = (TextView) dialog.findViewById(R.id.textView_title);
		
		title.setText("SELECT SORT");
		TextView text1 = (TextView) dialog.findViewById(R.id.textView1);
		text1.setText("By First Name");
		final ImageView image1 = (ImageView) dialog
				.findViewById(R.id.imageView1);

		TextView text2 = (TextView) dialog.findViewById(R.id.textView2);
		text2.setText("By Date");
		final ImageView image2 = (ImageView) dialog
				.findViewById(R.id.imageView2);
		
		TextView text3 = (TextView) dialog.findViewById(R.id.textView3);
		text3.setText("None");
		final ImageView image3 = (ImageView) dialog
				.findViewById(R.id.imageView3);
		
		if(selectedSort.equalsIgnoreCase("none")){
			image1.setImageResource(R.drawable.radio_unchecked);
			image2.setImageResource(R.drawable.radio_unchecked);
			image3.setImageResource(R.drawable.radio_checked);
		}else if(selectedSort.equalsIgnoreCase("name")){
			image1.setImageResource(R.drawable.radio_checked);
			image2.setImageResource(R.drawable.radio_unchecked);
			image3.setImageResource(R.drawable.radio_unchecked);
		}else if(selectedSort.equalsIgnoreCase("date")){
			image1.setImageResource(R.drawable.radio_unchecked);
			image2.setImageResource(R.drawable.radio_checked);
			image3.setImageResource(R.drawable.radio_unchecked);
		}
		
		// Button dialogButton = (Button)
		// dialog.findViewById(R.id.dialogButtonOK);
		// if button is clicked, close the custom dialog
		layout_name.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				
			// for name sort................
				selectedSort = "name";
				sortReferrals();
				dialog.dismiss();
		
			}
		});
		layout_date.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				
				// for date sort................
				selectedSort = "date";
				sortReferrals();
				dialog.dismiss();
			}
		});
		layout_none.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				
				// for clearing sort................
				selectedSort = "none";
				sortReferrals();
				dialog.dismiss();
			}
		});
		
		 
	    
		dialog.show();
	}
	private void sortReferrals(){
		
		if(selectedSort.equalsIgnoreCase("none")){
			if(!selectedFilter.equalsIgnoreCase("none"))
				filterReferrals();
			else{
				sortedFilteredList.clear();
				sortedFilteredList.addAll(referralList);
				listView.setAdapter(new ReferralListAdapter(ReferralListActivity.this));
			}
		}else{
			Collections.sort(sortedFilteredList, new Comparator<Referral>() {
				
				 public int compare(Referral v1, Referral v2) {
					 if(selectedSort.equalsIgnoreCase("name"))
					 {
						 return  v1.getFirstName().toLowerCase().compareTo(v2.getFirstName().toLowerCase());
					 	}
					 else if(selectedSort.equalsIgnoreCase("date"))
					 {
						 //"02/23/2016 02:24:40 AM",
						 SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss a");
						// SimpleDateFormat format = new SimpleDateFormat("yyyy-dd-MM hh:mm:ss a");
						 Date datev2 = null,datev1=null,dateS2 = null,dateS1=null;
						 try {
							/* if(v1.getReferralStatus().equalsIgnoreCase("open") | v2.getReferralStatus().equalsIgnoreCase("open"))
							 {*/
						      datev2 = format.parse(v2.getBothdate());
				 		      datev1 = format.parse(v1.getBothdate());
							// }
							/* else if(v1.getReferralStatus().equalsIgnoreCase("sold") | v2.getReferralStatus().equalsIgnoreCase("sold"))
								{
									if(v2.getSoldDate()!=null | !v2.getSoldDate().equals("null")| !v2.getSoldDate().equals("")| 
											v1.getSoldDate()!=null | !v1.getSoldDate().equals("null")| !v1.getSoldDate().equals(""))
									{
						 		      dateS2 = format.parse(v2.getSoldDate());
						 		      dateS1 = format.parse(v1.getSoldDate());
										}
									}*/
						 		} 
						 catch (Exception e) {
						     Log.e("log", e.getMessage(), e);
						 	}

						 /*if(v1.getReferralStatus().equalsIgnoreCase("open") | v2.getReferralStatus().equalsIgnoreCase("open"))
						 {*/
							 return  datev2.compareTo(datev1);
							/* }
						 else{
							 return  dateS2.compareTo(dateS1); 
						 }*/
						// return  v2.getCreatedDate().compareTo(v1.getCreatedDate());
					 	}
					 else
					 {
						 return 0;
					 	}
				 }
			});
			listView.setAdapter(new ReferralListAdapter(ReferralListActivity.this));
			if(selectedFilter.equalsIgnoreCase("open"))
			{
				txtHeader.setText("ACTIVE REFERRALS"+" ("+sortedFilteredList.size()+")");
				}
			else if(selectedFilter.equalsIgnoreCase("sold"))
			{
				txtHeader.setText("SOLD REFERRALS"+" ("+sortedFilteredList.size()+")");
				}
			else
			{
				txtHeader.setText("TOTAL REFERRALS"+" ("+sortedFilteredList.size()+")");
				}
		}
	}
	
	private void filterReferrals(){
		sortedFilteredList.clear();
		
		if(selectedFilter.equalsIgnoreCase("none")){
			sortedFilteredList.addAll(referralList);
		}else{
			for(int i = 0; i<referralList.size(); i++)
			{
				if(referralList.get(i).getReferralStatus().equalsIgnoreCase(selectedFilter))
					sortedFilteredList.add(referralList.get(i));
			}
		}
		
		if(!selectedSort.equalsIgnoreCase("none"))
		{
			sortReferrals();
		}
		else
		{
			listView.setAdapter(new ReferralListAdapter(ReferralListActivity.this));
			if(selectedFilter.equalsIgnoreCase("open"))
			{
				txtHeader.setText("ACTIVE REFERRALS"+" ("+sortedFilteredList.size()+")");
				}
			else if(selectedFilter.equalsIgnoreCase("sold"))
			{
				txtHeader.setText("SOLD REFERRALS"+" ("+sortedFilteredList.size()+")");
				}
			else
			{
				txtHeader.setText("TOTAL REFERRALS"+" ("+sortedFilteredList.size()+")");
				}
		}
	}
	
	private void dialogforFilter() {
		final Dialog dialog = new Dialog(this);
		dialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
		dialog.setContentView(R.layout.dailog_layout);
		
		LinearLayout dailog_layout=(LinearLayout)dialog.findViewById(R.id.dailog_layout);
		dailog_layout.setLayoutParams(new LayoutParams(LayoutParams.MATCH_PARENT,LayoutParams.WRAP_CONTENT));
		
		
		// dialog.setTitle("Title...");
		dialog.setCanceledOnTouchOutside(false);
		// set the custom dialog components - text, image and button
		LinearLayout layout_sold = (LinearLayout) dialog.findViewById(R.id.layout1);
		LinearLayout layout_open = (LinearLayout) dialog.findViewById(R.id.layout2);
		LinearLayout layout_none = (LinearLayout) dialog.findViewById(R.id.layout3);
		
		TextView title = (TextView) dialog.findViewById(R.id.textView_title);
		
		title.setText("SELECT FILTER");
		TextView text1 = (TextView) dialog.findViewById(R.id.textView1);
		text1.setText("Sold Only");
		final ImageView image1 = (ImageView) dialog
				.findViewById(R.id.imageView1);

		TextView text2 = (TextView) dialog.findViewById(R.id.textView2);
		text2.setText("Open Only");
		final ImageView image2 = (ImageView) dialog
				.findViewById(R.id.imageView2);
		
		TextView text3 = (TextView) dialog.findViewById(R.id.textView3);
		text3.setText("None");
		final ImageView image3 = (ImageView) dialog
				.findViewById(R.id.imageView3);
		
		if(selectedFilter.equalsIgnoreCase("none")){
			image1.setImageResource(R.drawable.radio_unchecked);
			image2.setImageResource(R.drawable.radio_unchecked);
			image3.setImageResource(R.drawable.radio_checked);
		}else if(selectedFilter.equalsIgnoreCase("sold")){
			image1.setImageResource(R.drawable.radio_checked);
			image2.setImageResource(R.drawable.radio_unchecked);
			image3.setImageResource(R.drawable.radio_unchecked);
		}else if(selectedFilter.equalsIgnoreCase("open")){
			image1.setImageResource(R.drawable.radio_unchecked);
			image2.setImageResource(R.drawable.radio_checked);
			image3.setImageResource(R.drawable.radio_unchecked);
		}
		
		// Button dialogButton = (Button)
		// dialog.findViewById(R.id.dialogButtonOK);
		// if button is clicked, close the custom dialog
		layout_sold.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				
			// for name sort................
				selectedFilter = "sold";
				appliedFilter.setText("Sold Only  X");
				appliedFilter.setBackgroundResource(R.drawable.bluedark_rounded_btn);
				filterContainer.setVisibility(View.VISIBLE);
				
				filterReferrals();
				dialog.dismiss();
		
			}
		});
		layout_open.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				
				// for date sort................
				selectedFilter = "open";
				appliedFilter.setText("Open Only  X");
				appliedFilter.setBackgroundResource(R.drawable.green_rounded_btn);
				filterContainer.setVisibility(View.VISIBLE);
				
				filterReferrals();
				dialog.dismiss();
			}
		});
		layout_none.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				
				// for clearing sort................
				selectedFilter = "none";
				filterContainer.setVisibility(View.GONE);
				filterReferrals();
				dialog.dismiss();
			}
		});
		
		 
	    
		dialog.show();
	}

	public class ReferralListAdapter extends BaseAdapter {
		private Context context;
		private TextView userID, date, status;
		private ImageView imageview;
		private String newDate;

		public ReferralListAdapter(Context ctx) {
			context = ctx;
		}

		// @Override
		public int getCount() {
			// TODO Auto-generated method stub
			return sortedFilteredList.size();
		}

		// @Override
		public Object getItem(int position) {
			// TODO Auto-generated method stub
			return sortedFilteredList.get(position);
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
				convertView = inflater.inflate(R.layout.referral_row, parent,
						false);
			}

			userID = (TextView) convertView.findViewById(R.id.userId);
			date = (TextView) convertView.findViewById(R.id.date);
			status = (TextView) convertView.findViewById(R.id.referralStatus);
			imageview=(ImageView) convertView.findViewById(R.id.imageView);
			Referral referral = sortedFilteredList.get(position);
			userID.setText(referral.getFirstName() + " "
					+ referral.getLastName());
			userID.setTypeface(BaseActivity.typeface_roboto);
			status.setText(referral.getReferralStatus().toUpperCase());
			//status.setTypeface(BaseActivity.typeface_roboto);

			if(referral.getReferralType().equalsIgnoreCase("direct"))
			{
				imageview.setImageResource(R.drawable.direct);
				}
			else
			{
				imageview.setImageResource(R.drawable.indirect);
				}
			
			if (referral.getReferralStatus().equalsIgnoreCase(DashBoardActivity.STATUS_SOLD)) {
				/*if(referral.getSoldDate()!=null)
				{
					try{
						//"CreatedDate": "12-27-2015 5:04:25 PM",
						newDate = Util.formateDateFromstring("MM-dd-yyyy hh:mm:ss a", "MM/dd/yyyy hh:mm a", referral.getSoldDate());
						}catch(Exception e)
						{
							e.printStackTrace();
						}
					
					}*/
				date.setText("Sold date: " + referral.getSoldDate());
				date.setTypeface(BaseActivity.typeface_roboto);
				status.setTextColor(getResources().getColor(R.color.app_blue));

			} else {
				String newDate1="";
				/*if(referral.getCreatedDate()!=null)
				{
					try{
						newDate1 = Util.formateDateFromstring("MM-dd-yyyy hh:mm:ss a", "MM/dd/yyyy hh:mm a", referral.getCreatedDate());
						System.err.println(newDate1);	
						
					}catch(Exception e)
						{
							e.printStackTrace();
						}
					}*/
				date.setText("Submit Date: " + referral.getCreatedDate());
				if (referral.getReferralStatus().equalsIgnoreCase(
						DashBoardActivity.STATUS_OPEN)) {
					status.setTextColor(getResources().getColor(R.color.bright_green));
				} else {
					status.setTextColor(getResources().getColor(R.color.app_orange));
				}
			}

			return convertView;
		}
	}
	private void setHeader(String str, int count)
	{
		if(str.equalsIgnoreCase("open"))
		{
			txtHeader.setText("ACTIVE REFERRALS"+" ("+count+")");
			}
		else if(str.equalsIgnoreCase("sold"))
		{
			txtHeader.setText("SOLD REFERRALS"+" ("+count+")");
			}
		else if(str.equalsIgnoreCase("inactive"))
		{
			txtHeader.setText("INACTIVE REFERRALS"+" ("+count+")");
			}
		else if(str.equalsIgnoreCase("all"))
		{
			txtHeader.setText("TOTAL REFERRALS"+" ("+count+")");
			}
		
		}
	@Override
	public void processFinish(String output, String methodName) {
		// TODO Auto-generated method stub
		try{
			ARAParser parser = new ARAParser(ReferralListActivity.this);
			referralList = parser.parseReferralList(output);
			sortedFilteredList.clear();
			sortedFilteredList.addAll(referralList);
			nextReferralList.clear();
			nextReferralList.addAll(referralList);
		}
		catch(Exception e){}
		setHeader(referralType,  sortedFilteredList.size());
		
		if (output.contains("No referrals to display yet")) {
			AlertDialog.Builder alert = new AlertDialog.Builder(
					ReferralListActivity.this);
		
			alert.setMessage("No referrals to display yet. Start submitting some referrals.");
			alert.setPositiveButton("ok",
					new DialogInterface.OnClickListener() {
						public void onClick(DialogInterface arg0, int arg1) {
							finish();
						}
					});
			alert.show();

		} else {
		
			listView.setAdapter(new ReferralListAdapter(ReferralListActivity.this));
		}
	}
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