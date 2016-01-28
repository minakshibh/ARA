package com.ara.board;

import java.util.ArrayList;
import java.util.List;
import org.apache.http.NameValuePair;
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

	private TextView txtBack, txtHeader;
	private ImageView backArrow;
	public ListView listView;
	private ArrayList<Notification> listDataHeader = new ArrayList<Notification>();
	ArrayList<Notification> arrayList;
	private int count = 0;
	private ListAdapter adapter;
	private SharedPreferences spref;

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.activity_notification);

		initUIComponents();

		OnClickListener();
		
		refreshView();
//		prepareListData();

	}
	
	private void initUIComponents() {
		// TODO Auto-generated method stub
		spref = getSharedPreferences("ara_prefs", MODE_PRIVATE);
		txtBack = (TextView) findViewById(R.id.back);
		txtBack.setTypeface(DashBoardActivity.typeface_roboto);
		backArrow = (ImageView) findViewById(R.id.back_arrow);
		txtHeader = (TextView) findViewById(R.id.txtHeader);
		txtHeader.setTypeface(DashBoardActivity.typeface_timeburner);
		backArrow = (ImageView) findViewById(R.id.backArrow);
		
		if(spref.getString("noti", "no").equalsIgnoreCase("yes"))
		{
			NotificationApi();
			Editor ed=spref.edit();
			ed.putString("noti", "yes");
			ed.commit();
		}

	}
	
	public void OnClickListener() {

		txtBack.setOnClickListener(listener);
		backArrow.setOnClickListener(listener);

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
	private void refreshView() {
		listDataHeader.clear();

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
			listDataHeader.add(notiModel);
		}
		setAdapter();
	}
	private void setAdapter() {
		adapter = new ListAdapter(NotificationActivity.this);
		listView = (ListView) findViewById(R.id.listView);
		
		listView.setOnItemClickListener(new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> arg0, View view,
					int position, long arg3) {
		
				TextView Description = (TextView) view.findViewById(R.id.Description);


				DatabaseHandler db = new DatabaseHandler(NotificationActivity.this);
				
				db.updateNotification(listDataHeader.get(position).getId());
				db.close();
				listDataHeader.get(position).setRead("read");
				adapter.notifyDataSetChanged();

				Description.setMaxLines(Integer.MAX_VALUE);
			}
		});
		listView.setAdapter(adapter);
		
	}



	

	

	
	private void NotificationApi() {
		/*api/notification/user (userId, currentPage, pageSize)
		 * [HttpGet] api/notification/user (userId, currentPage, pageSize)
		 */
		//http://112.196.24.205:89/api/notification/user?userId=179&currentPage=1&pageSize=10

		if (Util.isNetworkAvailable(NotificationActivity.this)) {
			SharedPreferences spref = getSharedPreferences("ara_prefs",
					MODE_PRIVATE);
			String userid = spref.getString("userid", "");

			String time = "";
			ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
			/*nameValuePairs.add(new BasicNameValuePair("userId", "179"));
			nameValuePairs.add(new BasicNameValuePair("currentPage", "1"));
			nameValuePairs.add(new BasicNameValuePair("pageSize", "10"));*/

			AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(
					NotificationActivity.this, "get", "/notification/user?userId=179&currentPage=1&pageSize=10",
					nameValuePairs, false, "Please wait...", true);
			mWebPageTask.delegate = (AsyncResponseForARA) NotificationActivity.this;
			mWebPageTask.execute();

		} else {
			Util.alertMessage(NotificationActivity.this, Util.network_error);
		}
	}

	@Override
	public void processFinish(String output, String methodName) {
		// TODO Auto-generated method stub

		ARAParser araParser=new ARAParser(this);
		 arrayList=araParser.parseNotification(output);
		 saveData();
	}


	public class ListAdapter extends BaseSwipeAdapter {
		private Context context;
		private TextView Description, date, lblListHeader;
		private ImageView imageview, imageReadBell;
		private TextView deleteButton;

		int lineCnt = 0;

		public ListAdapter(Context ctx) {
			context = ctx;
		}

		// @Override
		public int getCount() {
			// TODO Auto-generated method stub
			return listDataHeader.size();
		}

		// @Override
		public Object getItem(int position) {
			// TODO Auto-generated method stub
			return listDataHeader.get(position);
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

			lblListHeader = (TextView) convertView
					.findViewById(R.id.lblListHeader);

			Description = (TextView) convertView.findViewById(R.id.Description);
			date = (TextView) convertView.findViewById(R.id.Date);
			imageview = (ImageView) convertView.findViewById(R.id.imageView);
			imageReadBell = (ImageView) convertView
					.findViewById(R.id.imageReadBell);
			deleteButton=(TextView)convertView.findViewById(R.id.deleteAccount);
		
			Notification notification = listDataHeader.get(position);
		

			Description.setText(notification.getNotificationText());
			lblListHeader.setText(notification.getNotificationTitle() + "");
			date.setText(notification.getCreatedDate());
			Description.setMaxLines(3);
			Description.post(new Runnable() {
			    @Override
			    public void run() {
			    	lineCnt = Description.getLineCount();
			        // Use lineCount here
			    }
			});
			if(lineCnt<3)
			{
				imageview.setVisibility(View.GONE);
				}
			System.err.println("Read=" + listDataHeader.get(position).getRead()
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
			deleteButton.setOnClickListener(new View.OnClickListener() {
				@Override
				public void onClick(View v) {
					
					
					
					DatabaseHandler db = new DatabaseHandler(
							NotificationActivity.this);
					
					db.deleteNotification((listDataHeader.get(position)));
					db.close();
					listDataHeader.remove(position);
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

		for(int i=0;i<arrayList.size();i++)
		{
			noti = new Notification();
			//noti.setNotificationTypeId(arrayList.get(i).getNotificationTypeId());
			noti.setNotificationTitle(arrayList.get(i).getNotificationTitle());
			noti.setNotificationText(arrayList.get(i).getNotificationText());
			noti.setCreatedDate(arrayList.get(i).getCreatedDate());
			noti.setRead("unread");
			db.addContact(noti);
		}
	getDatabase();

	}

	private void getDatabase() {
		// Reading all data
		DatabaseHandler db = new DatabaseHandler(this);
		Log.d("Reading: ", "Reading all contacts..");
		
		List<Notification> listnoti = db.getAllNotification();
		System.err.println("size=" + listnoti.size());
		listDataHeader = new ArrayList<Notification>();
		for (Notification cn : listnoti) {

			Notification noti = new Notification();
			noti.setId(cn.getId());
			noti.setNotificationTitle(cn.getNotificationTitle());
			noti.setNotificationText(cn.getNotificationText());
			noti.setCreatedDate(cn.getCreatedDate());
			noti.setRead(cn.getRead());
			listDataHeader.add(noti);
		}
		setAdapter();
	}

}
