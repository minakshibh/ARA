package com.ara.payment;

import java.util.ArrayList;

import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.widget.AdapterView;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import com.ara.async_tasks.AsyncResponseForARA;
import com.ara.async_tasks.AsyncTaskForARA;
import com.ara.base.BaseActivity;
import com.ara.base.R;
import com.ara.board.DashBoardActivity;
import com.ara.model.Payment;
import com.ara.util.ARAParser;
import com.ara.util.Util;
import com.daimajia.swipe.adapters.BaseSwipeAdapter;



public class PaymentListActivity extends Activity implements
		AsyncResponseForARA {

	
	private TextView  txtHeader, back, add;
	private ListView paymentListView;
	public static ArrayList<Payment> paymentList;
	private ImageView backArrow;
	private SharedPreferences spref;
	private String editAPI = "paymentaccountinfo", deleteAPI = "paymentaccountinfo/delete";
	
	
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.activity_payment_list);
		
		
		
		initUIComponents();
		setOnClickListener();
		
	}

	private void initUIComponents() {
		
		paymentList = new ArrayList<Payment>();
		spref = getSharedPreferences("ara_prefs", MODE_PRIVATE);
		txtHeader = (TextView)findViewById(R.id.txtHeader);
		txtHeader.setTypeface(DashBoardActivity.typeface_timeburner);
		//title = (TextView)findViewById(R.id.txtTitle);
		//title.setTypeface(BaseActivity.typeface_timeburner);
		back = (TextView)findViewById(R.id.back);
		add = (TextView)findViewById(R.id.add);
		paymentListView = (ListView)findViewById(R.id.paymentListView);
		backArrow = (ImageView)findViewById(R.id.back_arrow);
		LoadPaymentList();
	}
	
	private void setOnClickListener()
	{
		back.setOnClickListener(listener);
		add.setOnClickListener(listener);
		backArrow.setOnClickListener(listener);
		
		paymentListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1, final int position,
					long arg3) {
				final Payment paymentAccount = paymentList.get(position);
				if(!paymentAccount.getIsDefault().equalsIgnoreCase("true")){
					AlertDialog.Builder alert = new AlertDialog.Builder(PaymentListActivity.this);
					alert.setTitle("Set As Default.");
					alert.setMessage("Are you sure?");
					alert.setPositiveButton("Yes", new DialogInterface.OnClickListener() {
						
						@Override
						public void onClick(DialogInterface dialog, int which) {
							SetPaymentAccountAsDefault(paymentAccount);
						}
					});
					alert.setNegativeButton("Cancel", null);
					alert.show();
				}
			}
		});
	}
	
private View.OnClickListener listener = new View.OnClickListener() {
		@Override
		public void onClick(View v) {
			// TODO Auto-generated method stub
		
			if(v == back | v == backArrow){
				finish();
			
			}else if (v == add){
				Intent intent = new Intent(PaymentListActivity.this, AddPaymentAccountActivity.class);
				startActivity(intent);
			}
			
		}
	};
	
	
	private void LoadPaymentList() {
		// TODO Auto-generated method stub
		String userid=spref.getString("userid", "");
		
		if (Util.isNetworkAvailable(PaymentListActivity.this)) {

			ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();

			AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(
					PaymentListActivity.this, "get",
					"paymentaccountinfo/"+userid, nameValuePairs,
					true, "Please wait...", true);
			
			mWebPageTask.delegate = (AsyncResponseForARA) PaymentListActivity.this;
			mWebPageTask.execute();
		} else {
			Util.alertMessage(PaymentListActivity.this, Util.network_error);
		}
	}

	

	public class PaymentListAdapter extends BaseSwipeAdapter {
		private Context context;
		private TextView paypalEmail, editAccount, deleteAccount,name;
		private ImageView isDefault;

		public PaymentListAdapter(Context ctx) {
			context = ctx;
		}

		@Override
		public int getCount() {
			// TODO Auto-generated method stub
			return paymentList.size();
		}

		@Override
		public Object getItem(int position) {
			// TODO Auto-generated method stub
			return paymentList.get(position);
		}

		@Override
		public long getItemId(int position) {
			// TODO Auto-generated method stub
			return position;
		}
/*
		// @Override
		public View getView(final int position, View convertView,
				ViewGroup parent) {
			LayoutInflater inflater = (LayoutInflater) context
					.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
			if (convertView == null) {
				convertView = inflater.inflate(R.layout.payment_list_row, parent,
						false);
			}

			paypalEmail = (TextView) convertView.findViewById(R.id.paypalEmail);
			isDefault = (ImageView) convertView.findViewById(R.id.defaultIcon);
			
			paypalEmail.setText(paymentList.get(position).getPaypalEmail());
			if(paymentList.get(position).getIsDefault().equalsIgnoreCase("true"))
				isDefault.setImageResource(R.drawable.tick);
			else
				isDefault.setVisibility(View.INVISIBLE);
		
			return convertView;
		}
*/
		@Override
		public void fillValues(final int position, View convertView) {
			// TODO Auto-generated method stub
			name= (TextView) convertView.findViewById(R.id.name);
			paypalEmail = (TextView) convertView.findViewById(R.id.paypalEmail);
			isDefault = (ImageView) convertView.findViewById(R.id.defaultIcon);
			
			editAccount = (TextView) convertView.findViewById(R.id.editAccount);
			deleteAccount = (TextView) convertView.findViewById(R.id.deleteAccount);
			
			name.setText(paymentList.get(position).getUserFirstName()+ " "+paymentList.get(position).getUserLastName());
			paypalEmail.setText(paymentList.get(position).getPaypalEmail());
			if(paymentList.get(position).getIsDefault().equalsIgnoreCase("true"))
				isDefault.setImageResource(R.drawable.tick);
			else
				isDefault.setVisibility(View.INVISIBLE);
			
			editAccount.setOnClickListener(new View.OnClickListener() {
				@Override
				public void onClick(View v) {
					// TODO Auto-generated method stub
					Intent intent = new Intent(PaymentListActivity.this, AddPaymentAccountActivity.class);
					intent.putExtra("trigger", "edit");
					intent.putExtra("PaymentAccount", paymentList.get(position));
					startActivity(intent);
				}
			});
			
			deleteAccount.setOnClickListener(new View.OnClickListener() {
				@Override
				public void onClick(View v) {
					// TODO Auto-generated method stub
					if(paymentList.get(position).getIsDefault().equalsIgnoreCase("true"))
					{
						AlertDialog.Builder alert = new AlertDialog.Builder(PaymentListActivity.this);
						alert.setTitle("This account cannot be deleated");
						alert.setMessage("This payment account has been set as \"Default\" so it cannot be deleted. " +
								"Set some other account as \"Default\" in order to continue.");
						alert.setPositiveButton("Okay", null);
						//alert.setNegativeButton("Cancel", null);
						alert.show();
					}
					else{
					AlertDialog.Builder alert = new AlertDialog.Builder(PaymentListActivity.this);
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
					alert.show();
				}
				}
			});
		}

		@Override
		public View generateView(int arg0, ViewGroup arg1) {
			return LayoutInflater.from(PaymentListActivity.this).inflate(R.layout.payment_list_row, null);
	    
		}

		@Override
		public int getSwipeLayoutResourceId(int arg0) {
			// TODO Auto-generated method stub
			return R.id.swipe;
		}
	}
	
	private void UpdatePaymentAccount(Payment paymentAccount, String mode) {
		String userId = spref.getString("userid", "");
		String methodName;
		if(mode.equals("Edit"))
			methodName = editAPI;
		else
			methodName = deleteAPI;
		
		if (Util.isNetworkAvailable(PaymentListActivity.this)) {
		
			ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();

			nameValuePairs.add(new BasicNameValuePair("PaymentAccountInfoId", paymentAccount.getPaymentAccountInfoId()));
			nameValuePairs.add(new BasicNameValuePair("UserId", userId));
			
			if(mode.equals("Edit")){
				nameValuePairs.add(new BasicNameValuePair("IsDefault", paymentAccount.getIsDefault()));
				nameValuePairs.add(new BasicNameValuePair("PaymentModeID", paymentAccount.getPaymentModeId()));
				nameValuePairs.add(new BasicNameValuePair("PaypalEmail", paymentAccount.getPaypalEmail()));
			}
			
			AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(
					PaymentListActivity.this, "post", methodName, nameValuePairs,
					true, "Please wait...",true);
			mWebPageTask.delegate = (AsyncResponseForARA) PaymentListActivity.this;
			mWebPageTask.execute();
		} else {
			Util.alertMessage(PaymentListActivity.this, Util.network_error);
		}
	}
	
	private void SetPaymentAccountAsDefault(Payment paymentAccount) {
		String userId = spref.getString("userid", "");
		
		if (Util.isNetworkAvailable(PaymentListActivity.this)) {
		
			ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();

			nameValuePairs.add(new BasicNameValuePair("PaymentAccountInfoId", paymentAccount.getPaymentAccountInfoId()));
			nameValuePairs.add(new BasicNameValuePair("UserId", userId));
			nameValuePairs.add(new BasicNameValuePair("IsDefault", "true"));
			
			AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(
					PaymentListActivity.this, "post", "paymentaccountinfo/mark", nameValuePairs,
					true, "Please wait...",true);
			mWebPageTask.delegate = (AsyncResponseForARA) PaymentListActivity.this;
			mWebPageTask.execute();
		} else {
			Util.alertMessage(PaymentListActivity.this, Util.network_error);
		}
	}
	
	@Override
	protected void onResume() {
		// TODO Auto-generated method stub
		super.onResume();
		try{
			paymentListView.setAdapter(new PaymentListAdapter(PaymentListActivity.this));
			}
		catch(NoClassDefFoundError e)
		{
			e.printStackTrace();
		}
	}
	
	@Override
	public void processFinish(String output, String methodName) {
		// TODO Auto-generated method stub
		Log.e("response payment list", output);
		ARAParser parser = new ARAParser(PaymentListActivity.this);
		paymentList = parser.parsePaymentListResponse(output);
		try{		
			paymentListView.setAdapter(new PaymentListAdapter(PaymentListActivity.this));
			}
		catch(NoClassDefFoundError e)
		{
			e.printStackTrace();
		}
	}
}