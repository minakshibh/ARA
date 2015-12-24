package com.ara.async_tasks;


import java.util.ArrayList;
import org.apache.http.NameValuePair;

import com.ara.util.Util;

import android.app.Activity;
import android.app.ProgressDialog;
import android.os.AsyncTask;
import android.widget.Toast;


public class AsyncTaskForARA extends AsyncTask<String, Void, String> {

	private Activity activity;
	public AsyncResponseForARA delegate = null;
	private String result = "";	
	private  ProgressDialog pDialog;
	private String methodName, message,method_type,email;
	private ArrayList<NameValuePair> nameValuePairs;
	private boolean displayProgress,token;
	
	
	private String name,pass;
	
	public AsyncTaskForARA(Activity activity, String method_type,String methodName,ArrayList<NameValuePair> nameValuePairs, boolean displayDialog, String message,boolean token) {
		this.activity = activity;
		this.methodName = methodName;
		this.nameValuePairs = nameValuePairs;
		this.displayProgress = displayDialog;
		this.message = message;
		this.method_type=method_type;
		this.token=token;
	}
	public AsyncTaskForARA(Activity activity, String method_type,String methodName,ArrayList<NameValuePair> nameValuePairs,String name,String pass, boolean displayDialog, String message) {
		this.activity = activity;
		this.methodName = methodName;
		this.nameValuePairs = nameValuePairs;
		this.displayProgress = displayDialog;
		this.message = message;
		this.method_type=method_type;
		this.name = name;
		this.pass=pass;
	}
	public AsyncTaskForARA(Activity activity, String method_type, String methodName, String email, boolean displayDialog, String message) {
		this.activity = activity;
		this.method_type=method_type;
		this.methodName = methodName;
		this.email=email;
		this.displayProgress = displayDialog;
		this.message = message;
		
	}
	@Override
	protected void onPreExecute() {
		// TODO Auto-generated method stub
		super.onPreExecute();

		if(displayProgress){
			pDialog = new ProgressDialog(activity);
		//	pDialog.setTitle("");
			pDialog.setMessage(message);
			pDialog.setCancelable(false);
			pDialog.show();
		}
	}

	@Override
	protected String doInBackground(String... urls) {
		if(method_type.equalsIgnoreCase("get"))
		{
		result = Util.getResponseFromUrlGet(token,methodName, nameValuePairs, activity);
		}
		else if(method_type.equalsIgnoreCase("post"))
		{
			result = Util.getResponseFromUrlPost(token,methodName, nameValuePairs, activity);
		}
		else if(method_type.equalsIgnoreCase("paypal"))
		{
			result = Util.getResponsePostPayPal(token,methodName, nameValuePairs, email,activity);
		}
		else
		{
			result = Util.getResponseFromUrlGetHeader(methodName, nameValuePairs,name,pass, activity);
		}
		return result;
	}

	
	@Override
	protected void onPostExecute(String result) {
		// TODO Auto-generated method stub
		super.onPostExecute(result);
		int resultcode=0;
		try{
		if(displayProgress)
				
		pDialog.dismiss();
		resultcode=Util.resultCode();
		if(resultcode==200)
		{
			delegate.processFinish(result, methodName);
		}
		else if(methodName.equalsIgnoreCase("users/confirm"))
		{
			delegate.processFinish(result, methodName);
		}
		else if(methodName.contains("statusType"))
		{
			delegate.processFinish(result, methodName);
		}
		else if(result==null)
		{
			Toast.makeText(activity, "Poor network connection, please try again", Toast.LENGTH_LONG).show();	
		}
		else
		{
			Toast.makeText(activity, result, Toast.LENGTH_LONG).show();
			delegate.processFinish(result, methodName);
			}
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}
	
}
