package com.ara.board;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;

import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.graphics.Typeface;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.TextView;
import com.ara.async_tasks.AsyncResponseForARA;
import com.ara.async_tasks.AsyncTaskForARA;
import com.ara.base.R;
import com.ara.model.Notification;
import com.ara.util.ARAParser;
import com.ara.util.DatabaseHandler;
import com.ara.util.Util;
import com.daimajia.swipe.adapters.BaseSwipeAdapter;

public class NotificationActivity extends Activity implements
		AsyncResponseForARA {

	private TextView txtBack, txtHeader,txtMore;
	private ImageView backArrow;
	public ListView listView;
	private ArrayList<Notification> getDataBaseList = new ArrayList<Notification>();
	ArrayList<Notification> arrayList= new ArrayList<Notification>();;
	private int count = 0;
	private ListAdapter adapter;
	private SharedPreferences spref;
	private int paddingCount=0,listCount=0;

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.activity_notification);

		initUIComponents();
		OnClickListener();
		NotificationApi();
		//refreshView();


	}
	
	private void initUIComponents() {
	
		spref = getSharedPreferences("ara_prefs", MODE_PRIVATE);
		txtBack = (TextView) findViewById(R.id.back);
		txtBack.setTypeface(DashBoardActivity.typeface_roboto);
		backArrow = (ImageView) findViewById(R.id.back_arrow);
		txtHeader = (TextView) findViewById(R.id.txtHeader);
		txtHeader.setTypeface(DashBoardActivity.typeface_timeburner);
		backArrow = (ImageView) findViewById(R.id.backArrow);
		listView = (ListView) findViewById(R.id.listView);
		txtMore=(TextView)findViewById(R.id.txtMore);
		
		
		/*if(spref.getString("noti", "no").equalsIgnoreCase("no"))
		{
			
			Editor ed=spref.edit();
			ed.putString("noti", "yes");
			ed.commit();
		}*/

	}
	
	public void OnClickListener() {

		txtBack.setOnClickListener(listener);
		backArrow.setOnClickListener(listener);

		listView.setOnItemClickListener(new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> arg0, View convertView,
					int position, long arg3) {
		
				final TextView Description = (TextView) convertView.findViewById(R.id.Description);
				final ImageView imageview = (ImageView) convertView.findViewById(R.id.imageView);
				final LinearLayout layout=(LinearLayout)convertView.findViewById(R.id.bottomSwipe);
				DatabaseHandler db = new DatabaseHandler(NotificationActivity.this);
				
				db.updateNotification(getDataBaseList.get(position).getId());
				db.close();
				getDataBaseList.get(position).setRead("read");
				adapter.notifyDataSetChanged();

				layout.setOnClickListener(new View.OnClickListener() {
					
					@Override
					public void onClick(View v) {
						// TODO Auto-generated method stub
						
						count++;
						if(count==1)
						{
							imageview.setImageResource(R.drawable.collapse_icon);
							Description.setMaxLines(Integer.MAX_VALUE);
						}
						else if(count==2)
						{
							imageview.setImageResource(R.drawable.expand_icon);
							Description.setMaxLines(3);
							count=0;
						}
						
					}
				});
			}
		});
		txtMore.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				listCount++;
				try{
				
					getSize(listCount);
				//adapter.notifyDataSetChanged();
				}
				catch(Exception e)
				{
					e.printStackTrace();
					}
				setAdapter();
				
				/*if(listCount==1)
				{
					getSize(1);
				}
				else if(listCount==2)
				{
					getSize(2);
				}
				else if(listCount==3)
				{
					getSize(3);
				}*/
			}
			
		});
		
	}
	private void getSize(int count)
	{
		
		if(getDataBaseList.size()>count*10)
		{
			paddingCount=count*10;
		}
		else{
			paddingCount=getDataBaseList.size();
		}	
	}
	
	private View.OnClickListener listener = new View.OnClickListener() {

		@Override
		public void onClick(View v) {
			if (v == txtBack) {

				finish();

			} else if (v == backArrow) {

				finish();
			}

		}
	};
	/*private void refreshView() {
		getDataBaseList.clear();

		Log.d("Reading: ", "Reading all contacts..");
		DatabaseHandler db = new DatabaseHandler(NotificationActivity.this);
		List<Notification> listNotification = db.getAllNotification();
		
		for (Notification noti : listNotification) {

			Log.e("database", noti.toString());
			Notification notiModel = new Notification();
			notiModel.setId(noti.getId());
			notiModel.setNotificationTitle(noti.getNotificationTitle());
			notiModel.setNotificationText(noti.getNotificationText());
			notiModel.setCreatedDate(noti.getCreatedDate());
			notiModel.setRead(noti.getRead());
			getDataBaseList.add(notiModel);
		}
		setAdapter();
	}*/
	private void setAdapter() {
		
		adapter = new ListAdapter(NotificationActivity.this);
		listView.setAdapter(adapter);
		
		
		
	}

	

	
	private void NotificationApi() {
		/*api/notification/user (userId, currentPage, pageSize)
		 * [HttpGet] api/notification/user (userId, currentPage, pageSize)
		 */
		//http://112.196.24.205:89/api/notification/user?userId=179&currentPage=1&pageSize=10
		//[HttpPost][Route("api/notification/user")]
		//@"UserId=%@&TimeStamp=%@"
		if (Util.isNetworkAvailable(NotificationActivity.this)) {
			SharedPreferences spref = getSharedPreferences("ara_prefs",MODE_PRIVATE);
			String userid = spref.getString("userid", "");

			String userDate =  spref.getString(userid, "");
			String time1=spref.getString("TS"+userid, userDate);
			ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
			nameValuePairs.add(new BasicNameValuePair("UserId", userid));
			nameValuePairs.add(new BasicNameValuePair("TimeStamp", time1));		
		

			Log.e("notification=", nameValuePairs.toString());
			AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(
					//NotificationActivity.this, "get", "/notification/user?userId="+userid+"&currentPage=1&pageSize=10",
					NotificationActivity.this, "post", "/notification/user",
					nameValuePairs, true, "Please wait...", true);
			mWebPageTask.delegate = (AsyncResponseForARA) NotificationActivity.this;
			mWebPageTask.execute();

		} else {
			Util.alertMessage(NotificationActivity.this, Util.network_error);
		}
	}

	@Override
	public void processFinish(String output, String methodName) {
		
		ARAParser araParser=new ARAParser(this);
		try{
		 arrayList=araParser.parseNotification(output);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			}
		 saveData();
	}


	public class ListAdapter extends BaseSwipeAdapter {
		private Context context;
		private TextView Description, date, lblListHeader;
		private ImageView imageview, imageReadBell;
		private TextView deleteButton;
		private LinearLayout layout;

		int lineCnt = 0;

		public ListAdapter(Context ctx) {
			context = ctx;
		}

		// @Override
		public int getCount() {
			// TODO Auto-generated method stub
			return paddingCount;
		}

		// @Override
		public Object getItem(int position) {
			// TODO Auto-generated method stub
			return getDataBaseList.get(position);
		}

		// @Override
		public long getItemId(int position) {
			// TODO Auto-generated method stub
			return position;
		}

		

		@Override
		public void notifyDataSetChanged() {
			// TODO Auto-generated method stub
			super.notifyDataSetChanged();
		}
		
		@Override
		public void fillValues(final int position, View convertView) {

		
			lblListHeader = (TextView) convertView.findViewById(R.id.lblListHeader);

			Description = (TextView) convertView.findViewById(R.id.Description);
			
			date = (TextView) convertView.findViewById(R.id.Date);
			imageview = (ImageView) convertView.findViewById(R.id.imageView);
			imageReadBell = (ImageView) convertView
					.findViewById(R.id.imageReadBell);
			deleteButton=(TextView)convertView.findViewById(R.id.deleteAccount);
		
			Notification notification = getDataBaseList.get(position);
		
			spref = getSharedPreferences("ara_prefs", MODE_PRIVATE);
			String userId=spref.getString("userid", "");
			Editor ed=spref.edit();
			if(!spref.getString("TS"+userId,"").equals(""))
			{
				ed.putString("TS"+userId, getDataBaseList.get(0).getCreatedDate());
				}
			else{
				ed.putString("TS"+userId, getDataBaseList.get(0).getCreatedDate());
			}
			ed.commit();
			
			Description.setText(notification.getNotificationText());
			lblListHeader.setText("Service - "+notification.getNotificationTitle() + "");
			date.setText(notification.getCreatedDate());
			Description.setMaxLines(3);
			Description.post(new Runnable() {
			    @Override
			    public void run() {
			    	lineCnt = Description.getLineCount();
			        // Use lineCount here
			    }
			});
			
			System.err.println("Read=" + getDataBaseList.get(position).getRead()
					+ "=Read");
			if (notification.getRead().equalsIgnoreCase("unread")) {

				lblListHeader.setTypeface(null,Typeface.BOLD);
				date.setTypeface(null, Typeface.BOLD);
				Description.setTypeface(null,Typeface.BOLD);

				imageReadBell.setImageResource(R.drawable.bell_unread);
			} else {
				lblListHeader.setTypeface(null,
						Typeface.NORMAL);
				date.setTypeface(null, Typeface.NORMAL);
				Description.setTypeface(null,Typeface.NORMAL);

				imageReadBell.setImageResource(R.drawable.bell_read);
			}
			if(Description.getText().toString().length()>110)
			{
				imageview.setVisibility(View.VISIBLE);
				}
			else{
				imageview.setVisibility(View.GONE);
			}
			
			
			
			deleteButton.setOnClickListener(new View.OnClickListener() {
				@Override
				public void onClick(View v) {
					
				DatabaseHandler db = new DatabaseHandler(
							NotificationActivity.this);
					
					db.deleteNotification((getDataBaseList.get(position)));
					db.close();
					getDataBaseList.remove(position);
					paddingCount=getDataBaseList.size();
					adapter.notifyDataSetChanged();

					
					// TODO Auto-generated method stub
					/*if(paymentList.get(position).getIsDefault().equalsIgnoreCase("true"))
					{
						AlertDialog.Builder alert = new AlertDialog.Builder(NotificationActivity.this);
						alert.setTitle("This account cannot be deleated");
						alert.setMessage("This payment account has been set as \"Default\" so it cannot be deleted. " +
								"Set some other account as \"Default\" in order to continue.");
						alert.setPositiveButton("Okay", null);
						//alert.setNegativeButton("Cancel", null);
						alert.show();
					}
					else{
					AlertDialog.Builder alert = new AlertDialog.Builder(NotificationActivity.this);
					alert.setTitle("Delete this account.");
					alert.setMessage("Are you sure?");
					alert.setPositiveButton("Yes", new DialogInterface.OnClickListener() {
						
						@Override
						public void onClick(DialogInterface dialog, int which) {
							// TODO Auto-generated method stub
							UpdatePaymentAccount(paymentList.get(position), "Delete");	
						}
					});
					alert.setNegativeButton("Cancel", null);
					alert.show();*/
			//	}
				}
			});
		}
		

		@Override
		public View generateView(int arg0, ViewGroup arg1) {
			//Log.e("df", "swipe");
			return LayoutInflater.from(NotificationActivity.this).inflate(
					R.layout.list_group, null);

		}

		@Override
		public int getSwipeLayoutResourceId(int position) {
			//System.err.println("swipe");

			
			return R.id.swipe;

		}
	}

	/*
	 * Preparing the list data
	 */
	private void saveData() {

		DatabaseHandler db = new DatabaseHandler(this);
		Notification noti = new Notification();
		String userid=spref.getString("userid", "");
		try{
			for(int i=0;i<arrayList.size();i++)
			{
				noti = new Notification();
				noti.setUserID(userid);
				noti.setNotificationTitle(arrayList.get(i).getNotificationTitle());
				noti.setNotificationText(arrayList.get(i).getNotificationText());
				noti.setCreatedDate(arrayList.get(i).getCreatedDate());
				noti.setRead("unread");
				db.addContact(noti);
				}
			
			}
			catch(Exception e){
			}
	
		getDatabase();
		
	

	}

	private void getDatabase() {
		// Reading all data
		DatabaseHandler db = new DatabaseHandler(this);
		Log.d("Reading: ", "Reading all contacts..");
		String userid=spref.getString("userid", "");
		List<Notification> listnoti = db.getAllNotification(userid);
		System.err.println("size=" + listnoti.size());
		getDataBaseList = new ArrayList<Notification>();
		for (Notification cn : listnoti) {

			Notification noti = new Notification();
			noti.setId(cn.getId());
			noti.setNotificationTitle(cn.getNotificationTitle());
			noti.setNotificationText(cn.getNotificationText());
			noti.setCreatedDate(cn.getCreatedDate());
			noti.setRead(cn.getRead());
			getDataBaseList.add(noti);
		}
		
		if(getDataBaseList.size()<10)
		{
			txtMore.setVisibility(View.GONE);
			}
		if(getDataBaseList.size()>10)
		{
			paddingCount=10;
			}
		else{
			paddingCount=getDataBaseList.size();
		}
		setAdapter();
	}
	/*private String getCurrentDate()
	{
		Calendar c = Calendar.getInstance();
		System.out.println("Current time => " + c.getTime());
			//2016-01-15 14:15:00.000
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
		String formattedDate = df.format(c.getTime());
		return formattedDate;
	}*/

}
