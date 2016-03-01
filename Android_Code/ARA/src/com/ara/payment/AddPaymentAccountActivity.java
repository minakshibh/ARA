package com.ara.payment;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.net.ssl.HttpsURLConnection;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.ParseException;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;
import org.apache.http.util.EntityUtils;
import org.json.JSONException;
import org.json.JSONObject;

import android.R.bool;
import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;
import android.view.Window;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.ara.async_tasks.AsyncResponseForARA;
import com.ara.async_tasks.AsyncTaskForARA;
import com.ara.base.BaseActivity;
import com.ara.base.R;
import com.ara.board.DashBoardActivity;
import com.ara.login.RegisterActivity;
import com.ara.model.Payment;
import com.ara.model.PaymentMode;
import com.ara.util.ARAParser;
import com.ara.util.Util;
import com.facebook.Request;
import com.facebook.Response;

public class AddPaymentAccountActivity extends Activity implements AsyncResponseForARA {
	private LinearLayout emailLayout;
	private EditText emailId;
	private Spinner paymentModeSpinner;
	private ArrayList<PaymentMode> paymentModeList=new ArrayList<PaymentMode>();
	private String paymentModeId = "-1", trigger;
	private Button save;
	private SharedPreferences spref;
	private ImageView isDefault, backArrow;
	private Boolean setDefault = false;
	private TextView back,txtHeader,Setthisaccount;
	private Payment paymentAccount;
	private int selectedIndex = 0;
	private LinearLayout lay_isDefault;
	private PaymentMode paymentMode;
	
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.add_payment_account);

		setUI();
		LoadPaymentModes();
		setOnClickListener();
		
	}

	private void setUI() {
		// TODO Auto-generated method stub
		 paymentMode =new PaymentMode();
		spref = getSharedPreferences("ara_prefs", MODE_PRIVATE);
		emailLayout = (LinearLayout) findViewById(R.id.emailLayout);
		emailId =(EditText) findViewById(R.id.emailId);
		paymentModeSpinner = (Spinner) findViewById(R.id.account_spinner);
		save = (Button)findViewById(R.id.save);
		//save.setTypeface(DashBoardActivity.typeface_roboto);
		isDefault = (ImageView)findViewById(R.id.isDefault);
		//txtTitle=(TextView)findViewById(R.id.txtTitle);
		//txtTitle.setTypeface(BaseActivity.typeface_timeburner);
		txtHeader=(TextView)findViewById(R.id.txtHeader);
		txtHeader.setTypeface(DashBoardActivity.typeface_timeburner);
		back = (TextView)findViewById(R.id.back);
		back.setTypeface(DashBoardActivity.typeface_roboto);
		backArrow = (ImageView)findViewById(R.id.back_arrow);
		Setthisaccount=(TextView)findViewById(R.id.Setthisaccount);	
		Setthisaccount.setTypeface(DashBoardActivity.typeface_roboto);
		lay_isDefault=(LinearLayout)findViewById(R.id.lay_isDefault);
		
		lay_isDefault.setVisibility(View.GONE);
		save.setVisibility(View.GONE);
		emailLayout.setVisibility(View.GONE);
		
		trigger = getIntent().getStringExtra("trigger");

		
		
		if(trigger!=null){
			paymentAccount = (Payment) getIntent().getParcelableExtra("PaymentAccount");
			emailId.setText(paymentAccount.getPaypalEmail());
			save.setText("Update Payment Account");
		}else{
			trigger = "";
		}
		
		LoadPaymentModes();
	}
	
	private void setOnClickListener() {
	
		paymentModeSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
			public void onItemSelected(AdapterView<?> arg0, View arg1,
					int position, long arg3) {
				PaymentMode paymentMode = (PaymentMode) paymentModeSpinner.getSelectedItem();
				paymentModeId = paymentMode.getModeID();
				
				if(paymentModeId.equals("-1")){
					emailLayout.setVisibility(View.GONE);
					lay_isDefault.setVisibility(View.GONE);
					save.setVisibility(View.GONE);
				}else
				{
					emailLayout.setVisibility(View.VISIBLE);
					lay_isDefault.setVisibility(View.VISIBLE);
					save.setVisibility(View.VISIBLE);
				}
				// TODO Auto-generated method stub
				/*Util.hideKeyboard(RegisterActivity.this);
				 
				mea_id = mea_Model.getId();
				System.err.println("spinnerrr  role");*/
			}

			public void onNothingSelected(AdapterView<?> arg0) {
				// TODO Auto-generated method stub

			}
		});
		
		save.setOnClickListener(listener);
		backArrow.setOnClickListener(listener);
		back.setOnClickListener(listener);
	
		
		if(PaymentListActivity.paymentList.size()<=0 || (trigger.equals("edit") && paymentAccount.getIsDefault().equalsIgnoreCase("true"))){
			setAsDefault(true);
		}else{
			setAsDefault(false);
			isDefault.setOnClickListener(listener);
			Setthisaccount.setOnClickListener(listener);
		}
	}
	
	private void LoadPaymentModes() {
		// TODO Auto-generated method stub
		
		if (Util.isNetworkAvailable(AddPaymentAccountActivity.this)) {

			ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();

			AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(
					AddPaymentAccountActivity.this, "get",
					"paymentmodes", nameValuePairs,
					true, "Please wait...", true);
			mWebPageTask.delegate = (AsyncResponseForARA) AddPaymentAccountActivity.this;
			mWebPageTask.execute();
		} else {
			Util.alertMessage(AddPaymentAccountActivity.this, Util.network_error);
		}
	}

	private View.OnClickListener listener = new View.OnClickListener() {

		@Override
		public void onClick(View v) {
			if (v == save) {
				
				if(paymentModeId.equals("-1"))
				{
					Toast.makeText(AddPaymentAccountActivity.this, "Please select payment mode", Toast.LENGTH_SHORT).show();
				}
				else
				{
				if(trigger.equals("") && accountAlreadyExists()){
					emailId.setError("Payment account already exists.");
				}else if(emailId.getText().toString().equals("")){
					emailId.setError("Please specify Paypal email");
				}
				else if(!android.util.Patterns.EMAIL_ADDRESS.matcher(
						emailId.getText().toString()).matches()
						&& !TextUtils.isEmpty(emailId.getText().toString()))
				{
					emailId.setError("Email address not valid");
					
				}else
					{
						emailId.setError(null);	
						//addPaymentAccountAPI();
						Util.hideKeyboard(AddPaymentAccountActivity.this);
						paypalIDCheck();
					}
				}
			} else if(v == isDefault | v== Setthisaccount) {
				if(setDefault){
					setAsDefault(false);
				}else{
					setAsDefault(true);
				}
			} else if(v == back || v == backArrow){
				finish();
			}
		}
	};
	
	private void setAsDefault(Boolean setDefault){
		this.setDefault = setDefault;
		if(setDefault){
			isDefault.setImageResource(R.drawable.checkbox_checked);
		}else{
			isDefault.setImageResource(R.drawable.checkbox_unchecked);
		}
	}
	private Boolean accountAlreadyExists(){
		for(int i = 0; i<PaymentListActivity.paymentList.size(); i++){
			if(PaymentListActivity.paymentList.get(i).getPaypalEmail().equalsIgnoreCase(emailId.getText().toString().trim()))
				return true;
		}
		
		return false;
	}
	
	private void addPaymentAccountAPI() {
		String userId = spref.getString("userid", "");
		
		paymentModeId = paymentModeList.get(0).getModeID();
		
		
		if (Util.isNetworkAvailable(AddPaymentAccountActivity.this)) {
		
			ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
			
			if(trigger.equalsIgnoreCase("edit"))
			nameValuePairs.add(new BasicNameValuePair("PaymentAccountInfoId", paymentAccount.getPaymentAccountInfoId()));
						
			nameValuePairs.add(new BasicNameValuePair("UserId", userId));
			nameValuePairs.add(new BasicNameValuePair("IsDefault", setDefault.toString()));
			nameValuePairs.add(new BasicNameValuePair("PaymentModeID", paymentModeId));
			nameValuePairs.add(new BasicNameValuePair("PaypalEmail", emailId.getText().toString().trim()));
			

			Log.e("payment", nameValuePairs.toString());
			AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(
					AddPaymentAccountActivity.this, "post", "paymentaccountinfo", nameValuePairs,
					true, "Please wait...",true);
			mWebPageTask.delegate = (AsyncResponseForARA) AddPaymentAccountActivity.this;
			mWebPageTask.execute();
		} else {
			Util.alertMessage(AddPaymentAccountActivity.this, Util.network_error);
		}
	}

	private void paypalIDCheck()
	{
		
		if (Util.isNetworkAvailable(AddPaymentAccountActivity.this)) {
			
						
			AsyncTaskForARA mWebPageTask = new AsyncTaskForARA(
			AddPaymentAccountActivity.this, "paypal", "GetVerifiedStatus", emailId.getText().toString().trim(),true, "Please wait...");
			mWebPageTask.delegate = (AsyncResponseForARA) AddPaymentAccountActivity.this;
			mWebPageTask.execute();
		} else {
			Util.alertMessage(AddPaymentAccountActivity.this, Util.network_error);
		}
	
	}

	@Override
	public void processFinish(final String output, String methodName) {
		// TODO Auto-generated method stub
		final ARAParser parser = new ARAParser(AddPaymentAccountActivity.this);
		if (methodName.equalsIgnoreCase("paymentmodes")) {
			paymentModeList = parser.parsePaymentModeResponse(output);
		
		
			
			if(trigger.equalsIgnoreCase("edit")){
				for(int i = 0; i<paymentModeList.size(); i++){
					
						if(paymentModeList.get(i).getModeID().equals(paymentAccount.getPaymentModeId())){
								selectedIndex = i;
								break;
						}
				}
			}
			
			ArrayAdapter<PaymentMode> spinnerArrayAdapter = new ArrayAdapter<PaymentMode>(this,
					R.layout.spinner_text, paymentModeList);
			spinnerArrayAdapter.setDropDownViewResource(R.layout.spinner_dropdown);
			paymentModeSpinner.setAdapter(spinnerArrayAdapter);
			paymentModeSpinner.setSelection(selectedIndex);
			/*if(paymentModeList.size()>1)
			{
				paymentModeSpinner.setSelection(1);
				}*/
			
		}else if (methodName.equalsIgnoreCase("paymentaccountinfo")) {
			PaymentListActivity.paymentList = parser.parsePaymentListResponse(output);
			finish();
		}
		
		else if(methodName.equals("GetVerifiedStatus"))
		{
			String valid = parser.parsePayPalAccount(output);
			System.err.println("validation="+valid);
			
			if(valid.equalsIgnoreCase("Success"))
			{
				
				addPaymentAccountAPI();
			}
			else
			{
				
				
				Toast.makeText(AddPaymentAccountActivity.this, "This email is not a verified Paypal email.", Toast.LENGTH_LONG).show();
				}
			
		}
			
	}
		
/*	 private class OkHttpTaskWithTlsSocketFactory extends AsyncTask<String, Integer, String> {
	        protected String doInBackground(String... urls) {
	            String result = "";
	            try {
	                result += "result with TlsSocketFactory:";
	                Response response = getOkhttpResponse(urls[0], true);
	                result += response.body().string().trim();
	            } catch (Exception e) {
	                result += "FAIL: " + e.getLocalizedMessage().trim();
	                Log.e("", result, e);
	            }
	            Log.i("", "background result:" + result);
	            return result;
	        }

	        protected void onPostExecute(String result) {
	            setResult(resultText1, result);
	        }
	    }		
	 private Response getOkhttpResponse(String url, boolean useTlsSocketFactory) throws IOException, NoSuchAlgorithmException, KeyManagementException {
	        Request request = new Request.Builder()
	                .url(url)
	                .build();

	        // OK HTTP library is used by the SDK and is a more modern library.
	        OkHttpClient client = new OkHttpClient().setConnectionSpecs(
	                Arrays.asList(ConnectionSpec.MODERN_TLS));

	        if (useTlsSocketFactory) {
	            client.setSslSocketFactory(new TlsSocketFactory());
	        }

	        return client.newCall(request).execute();
	    }

	    private String getContentString(HttpsURLConnection urlConnection) throws IOException {
	        InputStreamReader in = new InputStreamReader((InputStream) urlConnection.getContent());
	        BufferedReader buff = new BufferedReader(in);
	        String line;
	        StringBuilder sb = new StringBuilder();
	        do {
	            line = buff.readLine();
	            if (line != null) sb.append(line + "\n");
	        } while (line != null);
	        String result = sb.toString().trim();
	        return result;
	    }

	    private void setResult(TextView resultTextView, String result) {
	        if (null == result) {
	            result = "FAIL: result was null";
	        }

	        Log.w("", "result:" + result);
	        resultTextView.setText(result);
	        resultTextView.setTextColor(result.contains("FAIL") ? Color.RED : Color.GREEN);
	    }*/
}