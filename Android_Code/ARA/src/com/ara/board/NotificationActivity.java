package com.ara.board;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.Semaphore;

import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;

import android.app.Activity;
import android.content.SharedPreferences;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.content.pm.PackageManager.NameNotFoundException;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.View;
import android.view.Window;

import android.widget.ExpandableListView;
import android.widget.ImageView;
import android.widget.TextView;

import com.ara.async_tasks.AsyncResponseForARA;
import com.ara.async_tasks.AsyncTaskForARA;
import com.ara.base.BaseActivity;
import com.ara.base.R;
import com.ara.util.Util;

public class NotificationActivity extends Activity implements AsyncResponseForARA{

private TextView txtBack,txtHeader;
private ImageView backArrow;
private com.ara.board.ExpandableListAdapter listAdapter;
public ExpandableListView expListView;
private List<String> listDataHeader;
private HashMap<String, List<String>> listDataChild;


public void onCreate(Bundle savedInstanceState) {
	super.onCreate(savedInstanceState);
	requestWindowFeature(Window.FEATURE_NO_TITLE);
	setContentView(R.layout.activity_notification);



	initUIComponents();
	
	OnClickListener();
	//NotificationApi();
	prepareListData();
	setAdapter();
	

	}



private void setAdapter() {
	// TODO Auto-generated method stub
	 // preparing list data
  
	listAdapter = (ExpandableListAdapter) new ExpandableListAdapter(this, listDataHeader, listDataChild);

	DisplayMetrics metrics;
	int width;
	metrics = new DisplayMetrics();
	getWindowManager().getDefaultDisplay().getMetrics(metrics);
	width = metrics.widthPixels;
	
	expListView.setIndicatorBounds(width - GetDipsFromPixel(50), width - GetDipsFromPixel(10));
    // setting list adapter
    expListView.setAdapter(listAdapter);
    
    // Listview Group click listener
  /*  expListView.setOnGroupClickListener(new OnGroupClickListener() {

        @Override
        public boolean onGroupClick(ExpandableListView parent, View v,
                int groupPosition, long id) {
            // Toast.makeText(getApplicationContext(),
            // "Group Clicked " + listDataHeader.get(groupPosition),
            // Toast.LENGTH_SHORT).show();
            return false;
        }
    });

    // Listview Group expanded listener
    expListView.setOnGroupExpandListener(new OnGroupExpandListener() {

        @Override
        public void onGroupExpand(int groupPosition) {
            Toast.makeText(getApplicationContext(),
                    listDataHeader.get(groupPosition) + " Expanded",
                    Toast.LENGTH_SHORT).show();
        }
    });

    // Listview Group collasped listener
    expListView.setOnGroupCollapseListener(new OnGroupCollapseListener() {

        @Override
        public void onGroupCollapse(int groupPosition) {
            Toast.makeText(getApplicationContext(),
                    listDataHeader.get(groupPosition) + " Collapsed",
                    Toast.LENGTH_SHORT).show();

        }
    });

    // Listview on child click listener
    expListView.setOnChildClickListener(new OnChildClickListener() {

        @Override
        public boolean onChildClick(ExpandableListView parent, View v,
                int groupPosition, int childPosition, long id) {
            // TODO Auto-generated method stub
            Toast.makeText(
                    getApplicationContext(),
                    listDataHeader.get(groupPosition)
                            + " : "
                            + listDataChild.get(
                                    listDataHeader.get(groupPosition)).get(
                                    childPosition), Toast.LENGTH_SHORT)
                    .show();
            return false;
        }
    });*/
}

public int GetDipsFromPixel(float pixels)
{
 // Get the screen's density scale
 final float scale = getResources().getDisplayMetrics().density;
 // Convert the dps to pixels, based on density scale
 return (int) (pixels * scale + 0.5f);
}


private void initUIComponents() {
	// TODO Auto-generated method stub
	expListView=(ExpandableListView)findViewById(R.id.expandableListView);
	txtBack = (TextView)findViewById(R.id.back);
	txtBack.setTypeface(DashBoardActivity.typeface_roboto);
	backArrow = (ImageView)findViewById(R.id.back_arrow);
	txtHeader=(TextView)findViewById(R.id.txtHeader);
	txtHeader.setTypeface(DashBoardActivity.typeface_timeburner);
	backArrow=(ImageView)findViewById(R.id.backArrow);
	
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
private void NotificationApi()
{
	  /*[HttpGet]
			api/notification/user (userId, currentPage, pageSize)*/
	
	if(Util.isNetworkAvailable(NotificationActivity.this)){
		SharedPreferences spref = getSharedPreferences("ara_prefs", MODE_PRIVATE);
		String userid=spref.getString("userid", "");
	
		String time="";
			ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
			nameValuePairs.add(new BasicNameValuePair("userId", userid));
			nameValuePairs.add(new BasicNameValuePair("currentPage", time));	
			nameValuePairs.add(new BasicNameValuePair("pageSize", time));	
			
			AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(NotificationActivity.this,"get","notification",nameValuePairs, false, "Please wait...",true);
			mWebPageTask.delegate = (AsyncResponseForARA) NotificationActivity.this;
			mWebPageTask.execute();	
			
	}
	else
	{
		Util.alertMessage(NotificationActivity.this, Util.network_error);
		}
	}



@Override
public void processFinish(String output, String methodName) {
	// TODO Auto-generated method stub
	
}
/*
 * Preparing the list data
 */
private void prepareListData() {
    listDataHeader = new ArrayList<String>();
    listDataChild = new HashMap<String, List<String>>();

    // Adding child data
    listDataHeader.add("Notitifcation 1");
    listDataHeader.add("Notitifcation 2");
    listDataHeader.add("Notitifcation 3");

    // Adding child data
    List<String> top250 = new ArrayList<String>();
    top250.add("The Shawshank Redemption The Godfather The Godfather The Godfather: Part II Pulp Fiction The Good, the Bad and the Ugly");
    

    List<String> nowShowing = new ArrayList<String>();
    nowShowing.add("The Conjuring Despicable Me 2 Turbo Grown Ups 2 Red 2 The Wolverine");

    List<String> comingSoon = new ArrayList<String>();
    comingSoon.add("2 Guns  The Smurfs 2 The Spectacular Now The Canyons Europa Report");

    listDataChild.put(listDataHeader.get(0), top250); // Header, Child data
    listDataChild.put(listDataHeader.get(1), nowShowing);
    listDataChild.put(listDataHeader.get(2), comingSoon);
}
}
