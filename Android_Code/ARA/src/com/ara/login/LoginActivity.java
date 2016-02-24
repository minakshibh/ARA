package com.ara.login;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;
import org.json.JSONObject;
import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.Signature;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Base64;
import android.util.Log;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;
import com.ara.async_tasks.AsyncResponseForARA;
import com.ara.async_tasks.AsyncTaskForARA;
import com.ara.base.BaseActivity;
import com.ara.base.Notification_Util;
import com.ara.base.R;
import com.ara.base.ServerUtilities;
import com.ara.board.DashBoardActivity;
import com.ara.model.User;
import com.ara.util.ARAParser;
import com.ara.util.Util;
import com.facebook.android.AsyncFacebookRunner;
import com.facebook.android.DialogError;
import com.facebook.android.Facebook;
import com.facebook.android.Facebook.DialogListener;
import com.facebook.android.FacebookError;
import com.google.android.gcm.GCMRegistrar;

public class LoginActivity extends Activity implements AsyncResponseForARA {

	private Button logIn;
	private TextView signup, forgotpassword;
	private EditText userId, password;
	private ImageView img_chkBox;
	private User usermodel;
	private SharedPreferences spref;
	int count = 0;
	int Remember = 0;
	private LinearLayout layout_fbLogin;
	private TextView txt_Remember_Me,txt_anaccount,txt_loginwith,txt_facebook;

/***********************face book*************************************/
		private Facebook facebook;
	    @SuppressWarnings("deprecation")
		private AsyncFacebookRunner mAsyncRunner;
	    String FILENAME = "AndroidSSO_data";
	  	Context context = LoginActivity.this;
	    // please put your APP-ID below
	    //String Facebook_APP_ID = "557158811114993";// my account "1466930973610943" ;
	    String access_token;
	    Boolean Connectiontimeout = true;
	    String imageURL = "";
	    String userName = "";
	    String gender = "";
	    String emailAddress="", username="",first_name="",last_name="",APP_ID="";
 /***********************face book*************************************/
	    
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.activity_login);

		setUI();
		setOnClickListener();
		notificationGCM();
		 
	}

	private void setUI() {

		spref = getSharedPreferences("ara_prefs", MODE_PRIVATE);
		logIn = (Button) findViewById(R.id.logIn);
		//logIn.setTypeface(BaseActivity.typeface_roboto);
		signup = (TextView) findViewById(R.id.SignUp);
		signup.setTypeface(BaseActivity.typeface_roboto);
		forgotpassword = (TextView) findViewById(R.id.forgotpassword);
		forgotpassword.setTypeface(BaseActivity.typeface_roboto);
		userId = (EditText) findViewById(R.id.userId);
		userId.setTypeface(BaseActivity.typeface_roboto);
		password = (EditText) findViewById(R.id.password);
		password.setTypeface(BaseActivity.typeface_roboto);
		img_chkBox = (ImageView) findViewById(R.id.img_chkBox);
		txt_Remember_Me=(TextView)findViewById(R.id.txt_Remember_Me);
		txt_Remember_Me.setTypeface(BaseActivity.typeface_roboto);
		forgotpassword.setTypeface(BaseActivity.typeface_roboto);
		signup.setTypeface(BaseActivity.typeface_roboto);
		layout_fbLogin=(LinearLayout)findViewById(R.id.fbLogin);
		
		txt_anaccount=(TextView)findViewById(R.id.txt_anaccount);
		txt_anaccount.setTypeface(BaseActivity.typeface_roboto);
		
		txt_loginwith=(TextView)findViewById(R.id.txt_loginwith);
		txt_loginwith.setTypeface(BaseActivity.typeface_roboto);
		
		txt_facebook=(TextView)findViewById(R.id.txt_facebook);
		txt_facebook.setTypeface(BaseActivity.typeface_roboto);
		
		if(spref.getString("remember", "no").equals("yes"))
		{
			userId.setText(spref.getString("useridemail", ""));
			password.setText(spref.getString("password", ""));
			img_chkBox.setImageResource(R.drawable.checkbox_checked);
			Remember=1;
		}
		else
		{
			img_chkBox.setImageResource(R.drawable.checkbox_unchecked);
			Remember=0;
		}

	}

	private void setOnClickListener() {

		img_chkBox.setOnClickListener(listener);
		logIn.setOnClickListener(listener);
		signup.setOnClickListener(listener);
		forgotpassword.setOnClickListener(listener);
		img_chkBox.setOnClickListener(listener);
		txt_Remember_Me.setOnClickListener(listener);
		layout_fbLogin.setOnClickListener(listener);

	}
	private void notificationGCM() {

		try{
		/******************************************************/
		checkNotNull(Notification_Util.SERVER_URL, "SERVER_URL");
		checkNotNull(Notification_Util.SENDER_ID, "SENDER_ID");
		// ------------------------------------
		// Make sure the device has the proper dependencies.
		GCMRegistrar.checkDevice(LoginActivity.this);
		// Make sure the manifest was properly set - comment out this line
		// while developing the app, then uncomment it when it's ready.
		GCMRegistrar.checkManifest(this);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		/******************************************************/
		/******************************************************/
	}

	private View.OnClickListener listener = new View.OnClickListener() {

		@SuppressWarnings("deprecation")
		@Override
		public void onClick(View v) {
			if (v == img_chkBox | v==txt_Remember_Me) {
				count++;

				if (count == 1) {

					img_chkBox.setImageResource(R.drawable.checkbox_checked);
					Remember = 1;
				} else if (count == 2) {
					count = 0;
					img_chkBox.setImageResource(R.drawable.checkbox_unchecked);
					Remember = 0;
				}
			} else if (v == logIn) {
				if (userId.getText().toString().equals("")) {
					Util.ToastMessage(LoginActivity.this, "Please enter email");
				} else if (password.getText().toString().equals("")) {
					Util.ToastMessage(LoginActivity.this,
							"Please enter password");
				} else {

					Util.hideKeyboard(LoginActivity.this);
					loginAPI();
				}
			} else if (v == signup) {
				Intent intent = new Intent(LoginActivity.this,
						EmailValidatorActivity.class);
				startActivity(intent);
				
			} else if (v == forgotpassword) {
				Intent intent = new Intent(LoginActivity.this,ForgotPasswordActivity.class);
				intent.putExtra("email", userId.getText().toString());
				startActivity(intent);
				
			}
			else if (v == layout_fbLogin) {
				
				Log.e("tag", "fbLogin");
				
				if (Util.isNetworkAvailable(LoginActivity.this)) {
				
					APP_ID = getResources().getString(R.string.facebook_appid);
					facebook = new Facebook(APP_ID);
				    mAsyncRunner = new AsyncFacebookRunner(facebook);
					loginToFacebook();
				}
				else
				{
					Util.alertMessage(LoginActivity.this, Util.network_error);	
				}
			}
			
		}
	};

	private void loginAPI() {
		if (Util.isNetworkAvailable(LoginActivity.this)) {

			ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();

			String user = userId.getText().toString().trim();
			String pass = password.getText().toString().trim();

			AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(
					LoginActivity.this, "other", "accounts/login",
					nameValuePairs, user, pass, true, "Please wait...");
			mWebPageTask.delegate = (AsyncResponseForARA) LoginActivity.this;
			mWebPageTask.execute();

		} else {
			Util.alertMessage(LoginActivity.this, Util.network_error);
		}
	}

	@Override
	public void processFinish(String output, String methodName) {
		// TODO Auto-generated method stub
		ARAParser parser = new ARAParser(LoginActivity.this);
		if (methodName.equals("accounts/login")) {
			Log.e(methodName, output);
			if (output.contains("Invalid User Name and Password")) {

				Util.ToastMessage(LoginActivity.this,
						"Invalid User Name and Password");
			} else {
				Editor ed = spref.edit();
				if (Remember == 1) {
					ed.putString("remember", "yes");
					ed.commit();
				}
				else{
					ed.putString("remember", "no");
					ed.commit();
				}
				
				String currentDate=getCurrentDate();
				usermodel = new User();
				usermodel = parser.parseSignUpResponse(output);
				ed.putString("userid", usermodel.getUserId());
				ed.putString("useridemail", userId.getText().toString());
				ed.putString("password", usermodel.getPassword());
				ed.putString("username", usermodel.getUserName());
				ed.putString("useremail", usermodel.getEmail());
				ed.putString("userimage", usermodel.getProfilePicName());
				ed.putString("usertoken", usermodel.getUserToken());
				ed.putString("meaid", usermodel.getMEAID());
				ed.commit();
				System.err.println("login"+usermodel.getProfilePicName());
				if(!spref.getString(usermodel.getUserId().trim(), "").equals(""))
				{
										
					}
				else
				{
					ed.putString(usermodel.getUserId().trim(), currentDate);
					
					}
				ed.commit();
				
				
				/// notification code
				ServerUtilities sUtil = new ServerUtilities();
				sUtil.deviceRegister(LoginActivity.this);
				/////
				
				Intent intent = new Intent(LoginActivity.this,DashBoardActivity.class);
				intent.putExtra("user", usermodel);
				intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK | Intent.FLAG_ACTIVITY_NEW_TASK);
				startActivity(intent);
				finish();
			}

		}
	}
	@Override
	public void onBackPressed() {
		// TODO Auto-generated method stub
		super.onBackPressed();
		moveTaskToBack(true);
	}
	private void checkNotNull(Object reference, String name) {
		if (reference == null) {
			throw new NullPointerException(getString(R.string.error_config, name));
		}
	}
	
	/************************ Function to login into face book **********************/
	
	//login facebook function
	@SuppressWarnings({ "deprecation" })
	public void loginToFacebook() {
		String access_token="";
	     access_token = spref.getString("access_token", null);
	    System.err.println("access_token-" +access_token);
	    long expires = spref.getLong("access_expires", 0);
	 
	    if (access_token != null){
	    	if(access_token.equals("")) {
	    	
	    	 //make the API call 
    	
	        facebook.setAccessToken(access_token);
	      //  getProfileInformation();
	        new getFacebookData().execute();
	    	}
	    }
	    if (expires != 0) {
	        facebook.setAccessExpires(expires);
	        System.err.println("expires");
	    	}
	 
	    if (!facebook.isSessionValid()) {
	    	
	        facebook.authorize(this ,new String[] { "email", "publish_actions" },new DialogListener() {
	 
	                    @Override
	                    public void onCancel() {
	                        // Function to handle cancel event
	                    	Log.e("onCancel", "");
	                    }
	 
	                    @Override
	                    public void onComplete(Bundle values) {
	                        // Function to handle complete event
	                        // Edit Preferences and update facebook acess_token
	                        SharedPreferences.Editor editor = spref.edit();
	                        editor.putString("access_token",facebook.getAccessToken());
	                        editor.putLong("access_expires",facebook.getAccessExpires());
	                        editor.commit();
	                      //  editor.putString("userid", facebook.getAppId());
	                      System.err.println("save spref data"+facebook.getAccessToken()); 
	                    //  facebook.g
	                      
	                      new getFacebookData().execute();
	          
	                    }
	                   
	 
	                    @Override
	                    public void onError(DialogError error) {
	                        // Function to handle error
	                    	Log.e("fb error1", error.toString());
	 
	                    }
	 
	                    @Override
	                    public void onFacebookError(FacebookError fberror) {
	                        // Function to handle Facebook errors
	                    	Log.e("fb error2", fberror.toString());
	                   	 
	                    }
	        });
	    }
	    }
	@Override
	public void onActivityResult(int requestCode, int resultCode, Intent data) {
		super.onActivityResult(requestCode, resultCode, data);
		facebook.authorizeCallback(requestCode, resultCode, data);
		Log.e("fb onActivityResult", "onActivityResult");
	}

	 /**
	  * Async class for getting facebook data in background thread
	  *
	  */

	 public class getFacebookData extends AsyncTask<String, Void, String> {

	  ProgressDialog pd = null;

	  @Override
	  protected void onPreExecute() {
	   pd = ProgressDialog.show(LoginActivity.this, "",
	     "Please wait..", true);
	   pd.setCancelable(false);

	  }

	  @Override
	  protected String doInBackground(String... params) {
	
		  fbUserProfile();
	   return null;
	  }

	  @Override
	  protected void onPostExecute(String result) {
	   pd.dismiss();
	   System.err.println("name"+first_name+"userName"+userName+"");
	  if (Connectiontimeout) {
		  
		  try{
		  String[] separated = emailAddress.split("@");
		  username=separated[0]; }
		  catch(Exception e)
		  {
			  e.printStackTrace();
		  }
		  if(!first_name.equals(""))
		  {
		   Intent intent1=new Intent(LoginActivity.this,EmailValidatorActivity.class);
		   intent1.putExtra("firstname", first_name);
		   intent1.putExtra("lastname", last_name);
		   intent1.putExtra("username", username);
		   intent1.putExtra("email", emailAddress);
		   startActivity(intent1);
		  }
		  else
		  {
			  Toast.makeText(LoginActivity.this, "Something went wrong,  Please try again",Toast.LENGTH_SHORT).show();
		  }
		   System.err.println("name"+first_name+"userName"+userName+"");
	   } else {
	    Toast.makeText(LoginActivity.this, "Connection Time out", Toast.LENGTH_SHORT).show();
	   }
	  }

	 }


	 /** * getting user facebook data from facebook server*/
	 
	 
	 
	 public void fbUserProfile() {

	  try {
	   access_token = spref.getString("access_token", null);
	   JSONObject jsonObj = null;
	   JSONObject jsonObjData = null;
	   JSONObject jsonObjUrl = null;
	   //HttpParams httpParameters = new BasicHttpParams();
	   //HttpConnectionParams.setConnectionTimeout(httpParameters, 50000);
	   //HttpConnectionParams.setSoTimeout(httpParameters, 50000);

	   HttpClient client = new DefaultHttpClient();

	   String requestURL = "https://graph.facebook.com/me?fields=picture,id,first_name,last_name,gender,email&access_token="
	     + access_token;
	   Log.i("Request URL:", "---" + requestURL);
	   HttpGet request = new HttpGet(requestURL);

	   HttpResponse response = client.execute(request);
	   BufferedReader rd = new BufferedReader(new InputStreamReader(
	     response.getEntity().getContent()));
	   String webServiceInfo = "";

	   while ((webServiceInfo = rd.readLine()) != null) {
	    Log.i("Service Response:", "---" + webServiceInfo);
	    jsonObj = new JSONObject(webServiceInfo);
	    try{
	    jsonObjData = jsonObj.getJSONObject("picture");
	    }catch(Exception e){}
	    jsonObjUrl = jsonObjData.getJSONObject("data");
	    first_name = jsonObj.getString("first_name");
	    last_name = jsonObj.getString("last_name");
	    gender = jsonObj.getString("gender");
	    emailAddress = jsonObj.getString("email");
	    imageURL = jsonObjUrl.getString("url");
	    Connectiontimeout = true;
	  //  profilePic = BitmapFactory.decodeStream((InputStream) new URL(imageURL).getContent());
	   }

	  } catch (Exception e) {
		  e.printStackTrace();
	   Connectiontimeout = false;
	  }
	 }
	 private String getCurrentDate()
		{
			Calendar c = Calendar.getInstance();
			System.out.println("Current time => " + c.getTime());
				//2016-01-15 14:15:00.000
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
			String formattedDate = df.format(c.getTime());
			return formattedDate;
			
		}
	 /*try {
	        PackageInfo info = getPackageManager().getPackageInfo(
	                "com.ara.base", PackageManager.GET_SIGNATURES);
	        for (Signature signature : info.signatures) {
	            MessageDigest md = MessageDigest.getInstance("SHA");
	            md.update(signature.toByteArray());
	            Log.i("KeyHash:",
	                    Base64.encodeToString(md.digest(), Base64.DEFAULT));
	        }
	    } catch (NameNotFoundException e) {

	    } catch (NoSuchAlgorithmException e) {

	    }*/
}