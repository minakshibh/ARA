package com.ara.board;

import java.util.ArrayList;
import java.util.List;

import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.graphics.Typeface;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;
import com.ara.async_tasks.AsyncResponseForARA;
import com.ara.async_tasks.AsyncTaskForARA;
import com.ara.base.R;
import com.ara.model.Notification;
import com.ara.payment.AddPaymentAccountActivity;
import com.ara.payment.PaymentListActivity;
import com.ara.util.DatabaseHandler;
import com.ara.util.Util;
import com.daimajia.swipe.adapters.BaseSwipeAdapter;

public class NotificationActivity extends Activity implements
		AsyncResponseForARA {

	private TextView txtBack, txtHeader;
	private ImageView backArrow;
	public ListView listView;
	private ArrayList<Notification> listDataHeader = new ArrayList<Notification>();

	private int count = 0;
	private ListAdapter adapter;

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.activity_notification);

		initUIComponents();

		OnClickListener();
		// NotificationApi();
		refresh();
//		prepareListData();

	}

	private void setAdapter() {
		 adapter = new ListAdapter(NotificationActivity.this);
		listView = (ListView) findViewById(R.id.listView);
		listView.setOnItemClickListener(new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> arg0, View view,
					int position, long arg3) {
		//		Toast.makeText(NotificationActivity.this, "Clicked", Toast.LENGTH_LONG).show();
				
				// TODO Auto-generated method stub
//				TextView lblListHeader = (TextView) view
//						.findViewById(R.id.lblListHeader);
//
//				TextView date = (TextView) view.findViewById(R.id.Date);
//				TextView Description = (TextView) view
//						.findViewById(R.id.Description);
//				ImageView imageview = (ImageView) view
//						.findViewById(R.id.imageView);
//				ImageView imageReadBell = (ImageView) view
//						.findViewById(R.id.imageReadBell);

//				count++;
//				if (count == 1) {
//
//					Description.setMaxLines(Integer.MAX_VALUE);
//					imageview.setImageResource(R.drawable.collapse_icon);
//				} else if (count == 2) {
//					Description.setMaxLines(3);
//					imageview.setImageResource(R.drawable.expand_icon);
//					count = 0;
//				}

				DatabaseHandler db = new DatabaseHandler(
						NotificationActivity.this);
				
				db.updateNotification(listDataHeader.get(position).getId());
				db.close();
				listDataHeader.get(position).setRead("read");
				adapter.notifyDataSetChanged();

			
			}
		});
		listView.setAdapter(adapter);
		
	}

	private void refresh() {
		listDataHeader.clear();

		Log.d("Reading: ", "Reading all contacts..");
		DatabaseHandler db = new DatabaseHandler(NotificationActivity.this);
		List<Notification> notification = db.getAllNotification();
		for (Notification noti : notification) {

			Notification notiModel = new Notification();
			notiModel.setId(noti.getId());
			notiModel.setTitle(noti.getTitle());
			notiModel.setDescription(noti.getDescription());
			notiModel.setDate(noti.getDate());
			notiModel.setRead(noti.getRead());
			listDataHeader.add(notiModel);
		}
		setAdapter();
	}

	private void initUIComponents() {
		// TODO Auto-generated method stub

		txtBack = (TextView) findViewById(R.id.back);
		txtBack.setTypeface(DashBoardActivity.typeface_roboto);
		backArrow = (ImageView) findViewById(R.id.back_arrow);
		txtHeader = (TextView) findViewById(R.id.txtHeader);
		txtHeader.setTypeface(DashBoardActivity.typeface_timeburner);
		backArrow = (ImageView) findViewById(R.id.backArrow);

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

	public void OnClickListener() {

		txtBack.setOnClickListener(listener);
		backArrow.setOnClickListener(listener);

	}

	private void NotificationApi() {
		/*
		 * [HttpGet] api/notification/user (userId, currentPage, pageSize)
		 */

		if (Util.isNetworkAvailable(NotificationActivity.this)) {
			SharedPreferences spref = getSharedPreferences("ara_prefs",
					MODE_PRIVATE);
			String userid = spref.getString("userid", "");

			String time = "";
			ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
			nameValuePairs.add(new BasicNameValuePair("userId", userid));
			nameValuePairs.add(new BasicNameValuePair("currentPage", time));
			nameValuePairs.add(new BasicNameValuePair("pageSize", time));

			AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(
					NotificationActivity.this, "get", "notification",
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

		/*
		 * // @Override public View getView(final int position, View
		 * convertView, ViewGroup parent) { LayoutInflater inflater =
		 * (LayoutInflater) context
		 * .getSystemService(Context.LAYOUT_INFLATER_SERVICE); if (convertView
		 * == null) { convertView = inflater.inflate(R.layout.list_group,
		 * parent, false); }
		 */

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
			/*
			 * Description.post(new Runnable() {
			 * 
			 * @Override public void run() { lineCnt =
			 * Description.getLineCount(); // Perform any actions you want based
			 * on the line count here. System.err.println("length="+lineCnt); }
			 * });
			 */

			Description.setText(notification.getDescription());
			lblListHeader.setText(notification.getTitle() + "");
			date.setText(notification.getDate());
			Description.setMaxLines(3);
			
			System.err.println("Read=" + listDataHeader.get(position).getRead()
					+ "=Read");
			if (notification.getRead().equalsIgnoreCase("unread")) {

				lblListHeader.setTypeface(null,
						Typeface.BOLD);
				date.setTypeface(null, Typeface.BOLD);
				Description.setTypeface(null,
						Typeface.BOLD);
//				lblListHeader.setTextColor(Color.GREEN);
				imageReadBell.setImageResource(R.drawable.bell_unread);
			} else {
				lblListHeader.setTypeface(null,
						Typeface.NORMAL);
				date.setTypeface(null, Typeface.NORMAL);
				Description.setTypeface(null,
						Typeface.NORMAL);
//				lblListHeader.setTextColor(Color.GRAY);
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
			Log.e("df", "swipe");
			return LayoutInflater.from(NotificationActivity.this).inflate(
					R.layout.list_group, null);

		}

		@Override
		public int getSwipeLayoutResourceId(int position) {
			System.err.println("swipe");

			
			return R.id.swipe;

		}
	}

	/*
	 * Preparing the list data
	 */
	private void prepareListData() {

		DatabaseHandler db = new DatabaseHandler(this);
		Notification noti = new Notification();

		noti.setTitle("Notitifcation 1");
		noti.setDescription("The Shawshank Redemption The Godfather The Godfather sdbgksbgk sg kg kdf gkdf g gk kdfgkjdf gk dfkgkdf gkdf kg dfk gkdf gk The Godfather: "
				+ "Part II Pulp Fiction The Good, the Bad and the Ugly");
		noti.setDate("2014-06-12");
		noti.setRead("unread");

		db.addContact(noti);
		noti = new Notification();

		noti.setTitle("Notitifcation 2");
		noti.setDescription("The Shawshank Redemption Godfather: Part II Pulp Fiction The Good, the Bad and the Ugly");
		noti.setDate("2016-06-13");
		noti.setRead("unread");

		db.addContact(noti);
		// saveDataBase();
		getdata();

	}

	private void getdata() {
		// Reading all data
		DatabaseHandler db = new DatabaseHandler(this);
		Log.d("Reading: ", "Reading all contacts..");
		List<Notification> listnoti = db.getAllNotification();
		System.err.println("size=" + listnoti.size());
		listDataHeader = new ArrayList<Notification>();
		for (Notification cn : listnoti) {

			Notification noti = new Notification();
			noti.setTitle(cn.getTitle());
			noti.setDescription(cn.getDescription());
			noti.setDate(cn.getDate());
			noti.setRead(cn.getRead());
			listDataHeader.add(noti);
		}
		setAdapter();
	}

}
