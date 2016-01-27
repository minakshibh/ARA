package com.ara.board;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.Semaphore;

import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;

import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.content.pm.PackageManager.NameNotFoundException;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import com.ara.async_tasks.AsyncResponseForARA;
import com.ara.async_tasks.AsyncTaskForARA;
import com.ara.base.R;
import com.ara.model.Notification;
import com.ara.util.DatabaseHandler;
import com.ara.util.Util;

public class NotificationActivity extends Activity implements AsyncResponseForARA{

private TextView txtBack,txtHeader;
private ImageView backArrow;
public ListView listView;
private List<Notification> listDataHeader;
private int count=0;



public void onCreate(Bundle savedInstanceState) {
	super.onCreate(savedInstanceState);
	requestWindowFeature(Window.FEATURE_NO_TITLE);
	setContentView(R.layout.activity_notification);



	initUIComponents();
	
	OnClickListener();
	//NotificationApi();
	prepareListData();
	
	

	}



private void setAdapter() {
	// TODO Auto-generated method stub
	 // preparing list data
	listView=(ListView)findViewById(R.id.listView);
	listView.setAdapter(new ListAdapter(NotificationActivity.this));
	listView.setOnItemClickListener(new OnItemClickListener()
	   {
	    

		@Override
		public void onItemClick(AdapterView<?> arg0, View view, int arg2,
				long arg3) {
			// TODO Auto-generated method stub
			TextView Description = (TextView) view.findViewById(R.id.Description);
			ImageView imageview=(ImageView) view.findViewById(R.id.imageView);
			
			
			count++;
			if(count==1)
			{
		
				Description.setMaxLines(Integer.MAX_VALUE);
				imageview.setImageResource(R.drawable.collapse_icon);
			}
			else if(count==2)
			{
				Description.setMaxLines(3);
				imageview.setImageResource(R.drawable.expand_icon);
				count=0;
			}
		}
	   });
}

/*public int GetDipsFromPixel(float pixels)
{
 // Get the screen's density scale
 final float scale = getResources().getDisplayMetrics().density;
 // Convert the dps to pixels, based on density scale
 return (int) (pixels * scale + 0.5f);
}*/


private void initUIComponents() {
	// TODO Auto-generated method stub
	
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

public class ListAdapter extends BaseAdapter {
	private Context context;
	private TextView Description, date, lblListHeader;
	private ImageView imageview;
	private String newDate;
	int lineCnt=0;

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

	// @Override
	public View getView(final int position, View convertView,
			ViewGroup parent) {
		LayoutInflater inflater = (LayoutInflater) context
				.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		if (convertView == null) {
			convertView = inflater.inflate(R.layout.list_group, parent,
					false);
		}

		
		lblListHeader = (TextView) convertView.findViewById(R.id.lblListHeader);
		lblListHeader.setText(listDataHeader.get(position).getTitle());
		Description = (TextView) convertView.findViewById(R.id.Description);
		
		Description.setText(listDataHeader.get(position).getDescription());
		Description.post(new Runnable() {
		    @Override
		    public void run() {
		        lineCnt = Description.getLineCount();
		        // Perform any actions you want based on the line count here.
		        System.err.println("length="+lineCnt);
		    }
		});
		date = (TextView) convertView.findViewById(R.id.Date);
		date.setText(listDataHeader.get(position).getDate());
		
		imageview=(ImageView) convertView.findViewById(R.id.imageView);
		
		
		
		/*if(lineCnt<4)
		{
			imageview.setVisibility(View.GONE);
		}*/
		Description.setMaxLines(3);
		//makeTextViewResizable(Description, 3, "View More", true);

		return convertView;
	}
}

/*
 * Preparing the list data
 */
private void prepareListData() {
  
    DatabaseHandler db = new DatabaseHandler(this);
    Notification noti=new Notification();

    noti.setTitle("Notitifcation 1");
    noti.setDate("2014-06-12");
    noti.setRead("0");
    noti.setDescription("The Shawshank Redemption The Godfather The Godfather sdbgksbgk sg kg kdf gkdf g gk kdfgkjdf gk dfkgkdf gkdf kg dfk gkdf gk The Godfather: Part II Pulp Fiction The Good, the Bad and the Ugly");
    
  
    db.addContact(noti); 
    noti=new Notification();

    noti.setTitle("Notitifcation 2");
    noti.setDate("2016-06-13");
    noti.setRead("0");
    noti.setDescription("The Shawshank Redemption Godfather: Part II Pulp Fiction The Good, the Bad and the Ugly");
    
 
    db.addContact(noti); 
    saveDataBase();
    getdata();
    
}
private void saveDataBase()
{
	 DatabaseHandler db = new DatabaseHandler(this);
	
   
     // Inserting Contacts
    // Log.d("Insert: ", "Inserting .."); 
     db.addContact(new Notification("Notification1", "9100000000","0"));        
     db.addContact(new Notification("Notification2", "9199999999","0"));
     db.addContact(new Notification("Notification3", "9522222222","0"));
     db.addContact(new Notification("Karthik", "9533333333","0"));
     }
private void getdata()
{
	// Reading all contacts
	 DatabaseHandler db = new DatabaseHandler(this);
    Log.d("Reading: ", "Reading all contacts.."); 
    List<Notification> contacts = db.getAllContacts();       
   System.err.println("size="+contacts.size());
   listDataHeader = new ArrayList<Notification>();
    for (Notification cn : contacts) {
      //  String log = "Id: "+cn.getId()+" ,Title: " + cn.getTitle() + " ,Des: " + cn.getDescription();
    	
    	  
    	  
    	  Notification noti=new Notification();
    	  noti.setTitle(cn.getTitle());
    	  noti.setDescription(cn.getDescription());
    	  noti.setDate(cn.getDate());
    	  listDataHeader.add(noti);
            // Writing Contacts to log
  
    	}
    setAdapter();
	}

}
/*public static void makeTextViewResizable(final TextView tv, final int maxLine, final String expandText, final boolean viewMore) {

    if (tv.getTag() == null) {
        tv.setTag(tv.getText());
    }
    ViewTreeObserver vto = tv.getViewTreeObserver();
    vto.addOnGlobalLayoutListener(new OnGlobalLayoutListener() {

        @SuppressWarnings("deprecation")
        @Override
        public void onGlobalLayout() {

            ViewTreeObserver obs = tv.getViewTreeObserver();
            obs.removeGlobalOnLayoutListener(this);
            if (maxLine == 0) {
                int lineEndIndex = tv.getLayout().getLineEnd(0);
                String text = tv.getText().subSequence(0, lineEndIndex - expandText.length() + 1) + " " + expandText;
                tv.setText(text);
                tv.setMovementMethod(LinkMovementMethod.getInstance());
                tv.setText(
                        addClickablePartTextViewResizable(Html.fromHtml(tv.getText().toString()), tv, maxLine, expandText,
                                viewMore), BufferType.SPANNABLE);
            } else if (maxLine > 0 && tv.getLineCount() >= maxLine) {
                int lineEndIndex = tv.getLayout().getLineEnd(maxLine - 1);
                String text = tv.getText().subSequence(0, lineEndIndex - expandText.length() + 1) + " " + expandText;
                tv.setText(text);
                tv.setMovementMethod(LinkMovementMethod.getInstance());
                tv.setText(addClickablePartTextViewResizable(Html.fromHtml(tv.getText().toString()), tv, maxLine, expandText,
                                viewMore), BufferType.SPANNABLE);
            } else {
                int lineEndIndex = tv.getLayout().getLineEnd(tv.getLayout().getLineCount() - 1);
                String text = tv.getText().subSequence(0, lineEndIndex) + " " + expandText;
                tv.setText(text);
                tv.setMovementMethod(LinkMovementMethod.getInstance());
                tv.setText(
                        addClickablePartTextViewResizable(Html.fromHtml(tv.getText().toString()), tv, lineEndIndex, expandText,
                                viewMore), BufferType.SPANNABLE);
            }
        }
    });

}

private static SpannableStringBuilder addClickablePartTextViewResizable(final Spanned strSpanned, final TextView tv,
        final int maxLine, final String spanableText, final boolean viewMore) {
    String str = strSpanned.toString();
    SpannableStringBuilder ssb = new SpannableStringBuilder(strSpanned);

    if (str.contains(spanableText)) {
        ssb.setSpan(new ClickableSpan() {

            @Override
            public void onClick(View widget) {

                if (viewMore) {
                    tv.setLayoutParams(tv.getLayoutParams());
                    tv.setText(tv.getTag().toString(), BufferType.SPANNABLE);
                    tv.invalidate();
                    makeTextViewResizable(tv, -1, "View Less", false);
                } else {
                    tv.setLayoutParams(tv.getLayoutParams());
                    tv.setText(tv.getTag().toString(), BufferType.SPANNABLE);
                    tv.invalidate();
                    makeTextViewResizable(tv, 3, "View More", true);
                }

            }
        }, str.indexOf(spanableText), str.indexOf(spanableText) + spanableText.length(), 0);

    }
    return ssb;

}*/


