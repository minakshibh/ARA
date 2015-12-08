package com.ara.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.ParseException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;
import org.apache.http.util.EntityUtils;
import org.json.JSONException;
import org.json.JSONObject;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import android.content.SharedPreferences;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Environment;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.widget.Toast;

import com.ara.base.R;

public class Util {
static 	Context context;
static	public String network_error="Please check your internet connection, try again";
static int statusCode;
	
	static	public void ToastMessage(Context ctx,String str)
	{
		context=ctx;
		Toast.makeText(ctx, str, 1000).show();
	}
	static	public void alertMessage(final Context ctx,String str)
	{
		context=ctx;
		AlertDialog.Builder alert = new AlertDialog.Builder(context);
		alert.setTitle("");
		alert.setMessage(str);
		alert.setPositiveButton("OK", new OnClickListener() {
			
			@Override
			public void onClick(DialogInterface dialog, int which) {
				// TODO Auto-generated method stub
			((Activity) ctx).finish();
			}

		
		});
		alert.show();
	}
	static public boolean isNetworkAvailable(Context mCtx) {
	    ConnectivityManager connectivityManager 
	          = (ConnectivityManager) mCtx.getSystemService(Context.CONNECTIVITY_SERVICE);
	    NetworkInfo activeNetworkInfo = connectivityManager.getActiveNetworkInfo();
	    return activeNetworkInfo != null && activeNetworkInfo.isConnected();
	}
	static public  void hideKeyboard(Context cxt) {
		context=cxt;
	    InputMethodManager inputManager = (InputMethodManager) cxt.getSystemService(Context.INPUT_METHOD_SERVICE);

	    // check if no view has focus:
	    View view = ((Activity) cxt).getCurrentFocus();
	    if (view != null) {
	        inputManager.hideSoftInputFromWindow(view.getWindowToken(), InputMethodManager.HIDE_NOT_ALWAYS);
	    }
	}
	public static final boolean isValidPhoneNumber(CharSequence target) {
	    if (target == null || TextUtils.isEmpty(target)) {
	        return false;
	    } else {
	        return android.util.Patterns.PHONE.matcher(target).matches();
	    }
	}
	public static String getResponseFromUrlPost(Boolean token,String functionName, List<NameValuePair> param, Context context){
		String responseString = "";
		SharedPreferences spref = context.getSharedPreferences("ara_prefs", 1);
		try {
			
			
			
			HttpParams httpParameters = new BasicHttpParams();
			int timeoutConnection = 60000;
			HttpConnectionParams.setConnectionTimeout(httpParameters, timeoutConnection);
			int timeoutSocket = 61000;
			HttpConnectionParams.setSoTimeout(httpParameters, timeoutSocket);
			
			
			DefaultHttpClient httpClient = new DefaultHttpClient(httpParameters);
	         HttpPost request = new HttpPost(context.getResources().getString(R.string.baseUrl)+"/"+functionName);
	         request.setHeader("Accept", "application/json");
	         request.setHeader("Content-type", "application/json");
	         if(token)
	         {
	        	 request.addHeader("token", spref.getString("usertoken", ""));
	        	 Log.e("token send", spref.getString("usertoken", ""));
	         }
	         
	            
	         JSONObject JSONObjectData = new JSONObject();

	         for (NameValuePair nameValuePair : param) {
	             try {
	                 JSONObjectData.put(nameValuePair.getName(), nameValuePair.getValue());
	             } catch (JSONException e) {

	             }
	         }
	         
	         String st = JSONObjectData.toString();
	         Log.e("tag", st);
	         StringEntity st_entity =  new StringEntity(st);
	         request.setEntity(st_entity);
	         HttpResponse response = httpClient.execute(request);
	         
	         statusCode = response.getStatusLine().getStatusCode();
	         
	         HttpEntity httpEntity = response.getEntity();
	         responseString = EntityUtils.toString(httpEntity);
			
	        Log.e(functionName, responseString);
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
			System.err.println("socket exception"+e);
			//Util.alertMessage(context, "Please check your internet connection or try again later");
		}
		Log.e("responseString",statusCode+" "+ responseString);
		return responseString;
		/*if(statusCode==200)
		{
		
		}
		else
		{
			Toast.makeText(context, responseString, 1000).show();
			
			return null;
		}*/
	}
	public static String getResponseFromUrlGet(Boolean token,String functionName, List<NameValuePair> param, Context context){
		String responseString = "";
	
		SharedPreferences spref = context.getSharedPreferences("ara_prefs", 1);
			HttpParams httpParameters = new BasicHttpParams();
			int timeoutConnection = 60000;
			HttpConnectionParams.setConnectionTimeout(httpParameters, timeoutConnection);
			int timeoutSocket = 61000;
			HttpConnectionParams.setSoTimeout(httpParameters, timeoutSocket);
			
			
			DefaultHttpClient httpClient = new DefaultHttpClient(httpParameters);
	         HttpGet request = new HttpGet(context.getResources().getString(R.string.baseUrl)+"/"+functionName);
	       
	         request.setHeader("Accept", "application/json");
	         request.setHeader("Content-type", "application/json");
	         if(token)
	         {
	        	 request.addHeader("token", spref.getString("usertoken", ""));
	        	 Log.e("token send", spref.getString("usertoken", ""));
	         }
	            
	         JSONObject JSONObjectData = new JSONObject();

	         for (NameValuePair nameValuePair : param) {
	             try {
	                 JSONObjectData.put(nameValuePair.getName(), nameValuePair.getValue());
	             } catch (JSONException e) {

	             }
	         }
	     		try {
					// execute(); executes a request using the default context.
					// Then we assign the execution result to HttpResponse
					HttpResponse httpResponse = httpClient.execute(request);
				//	System.out.println("httpResponse					// getEntity() ; obtains the message entity of this response
					// getContent() ; creates a new InputStream object of the entity.
					// Now we need a readable source to read the byte stream that comes as the httpResponse
					
					statusCode = httpResponse.getStatusLine().getStatusCode();
					InputStream inputStream = httpResponse.getEntity().getContent();

					// We have a byte stream. Next step is to convert it to a Character stream
					InputStreamReader inputStreamReader = new InputStreamReader(inputStream);

					// Then we have to wraps the existing reader (InputStreamReader) and buffer the input
					BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

					// InputStreamReader contains a buffer of bytes read from the source stream and converts these into characters as needed.
					//The buffer size is 8K
					//Therefore we need a mechanism to append the separately coming chunks in to one String element
					// We have to use a class that can handle modifiable sequence of characters for use in creating String
					StringBuilder stringBuilder = new StringBuilder();

					String bufferedStrChunk = null;

					// There may be so many buffered chunks. We have to go through each and every chunk of characters
					//and assign a each chunk to bufferedStrChunk String variable
					//and append that value one by one to the stringBuilder
					while((bufferedStrChunk = bufferedReader.readLine()) != null){
						stringBuilder.append(bufferedStrChunk);
					}
					responseString=stringBuilder.toString();
					// Now we have the whole response as a String value.
					//We return that value then the onPostExecute() can handle the content
					System.out.println("Return of doInBackground :" + stringBuilder.toString());

					// If the Username and Password match, it will return "working" as response
					// If the Username or Password wrong, it will return "invalid" as response					
					
					return responseString;
				/*	if(statusCode==200)
					{
					
					}
					else
					{
						Toast.makeText(context, responseString, 1000).show();
						
						return null;
					}*/

				} catch (ClientProtocolException cpe) {
					System.out.println("Exceptionrates caz of httpResponse :" + cpe);
					cpe.printStackTrace();
				} catch (IOException ioe) {
					System.out.println("IO Exception  :" + ioe);
					ioe.printStackTrace();
				}

				return null;
	
	
	}
	public static String getResponseFromUrlGetHeader(String functionName, List<NameValuePair> param,String user,String pass, Context context){
		String responseString = "";
	
			
			HttpParams httpParameters = new BasicHttpParams();
			int timeoutConnection = 60000;
			HttpConnectionParams.setConnectionTimeout(httpParameters, timeoutConnection);
			int timeoutSocket = 61000;
			HttpConnectionParams.setSoTimeout(httpParameters, timeoutSocket);
			
			
			DefaultHttpClient httpClient = new DefaultHttpClient(httpParameters);
	         HttpGet request = new HttpGet(context.getResources().getString(R.string.baseUrl)+"/"+functionName);
	      
	        
	         if(!pass.equals(""))
	         {
	        	 request.addHeader("username",user);
	        	 request.addHeader("userpassword", pass);
		         }
	         else
	         {
	        	 request.addHeader("useremail",user); 
	         }
	        
	         request.setHeader("Accept", "application/json");
	         request.setHeader("Content-type", "application/json");
	         
	            
	         JSONObject JSONObjectData = new JSONObject();

	         for (NameValuePair nameValuePair : param) {
	             try {
	                 JSONObjectData.put(nameValuePair.getName(), nameValuePair.getValue());
	             } catch (JSONException e) {

	             }
	         }
	     		try {
					// execute(); executes a request using the default context.
					// Then we assign the execution result to HttpResponse
					HttpResponse httpResponse = httpClient.execute(request);
				//	System.out.println("httpResponse					// getEntity() ; obtains the message entity of this response
					// getContent() ; creates a new InputStream object of the entity.
					// Now we need a readable source to read the byte stream that comes as the httpResponse
					
					statusCode = httpResponse.getStatusLine().getStatusCode();
					
					InputStream inputStream = httpResponse.getEntity().getContent();

					// We have a byte stream. Next step is to convert it to a Character stream
					InputStreamReader inputStreamReader = new InputStreamReader(inputStream);

					// Then we have to wraps the existing reader (InputStreamReader) and buffer the input
					BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

					// InputStreamReader contains a buffer of bytes read from the source stream and converts these into characters as needed.
					//The buffer size is 8K
					//Therefore we need a mechanism to append the separately coming chunks in to one String element
					// We have to use a class that can handle modifiable sequence of characters for use in creating String
					StringBuilder stringBuilder = new StringBuilder();

					String bufferedStrChunk = null;

					// There may be so many buffered chunks. We have to go through each and every chunk of characters
					//and assign a each chunk to bufferedStrChunk String variable
					//and append that value one by one to the stringBuilder
					while((bufferedStrChunk = bufferedReader.readLine()) != null){
						stringBuilder.append(bufferedStrChunk);
					}
					responseString=stringBuilder.toString();
					// Now we have the whole response as a String value.
					//We return that value then the onPostExecute() can handle the content
					System.out.println("Return of doInBackground :" +statusCode+" "+stringBuilder.toString());

					// If the Username and Password match, it will return "working" as response
					// If the Username or Password wrong, it will return "invalid" as response					
					
					return responseString;
				

				} catch (ClientProtocolException cpe) {
					System.out.println("Exceptionrates caz of httpResponse :" + cpe);
					cpe.printStackTrace();
				} catch (IOException ioe) {
					System.out.println("IOException httpResponse :" + ioe);
					ioe.printStackTrace();
				}

				return null;
	
	
	}
	public static String getResponsePostPayPal(Boolean token,String functionName, List<NameValuePair> param, String email,Context context){
		String responseString = "";
		//SharedPreferences spref = context.getSharedPreferences("ara_prefs", 1);
		String getemail=email.trim();
		try {
		
			
			HttpParams httpParameters = new BasicHttpParams();
			int timeoutConnection = 60000;
			HttpConnectionParams.setConnectionTimeout(httpParameters, timeoutConnection);
			int timeoutSocket = 61000;
			HttpConnectionParams.setSoTimeout(httpParameters, timeoutSocket);
			
			
			DefaultHttpClient httpClient = new DefaultHttpClient(httpParameters);
			  HttpGet request = new HttpGet("https://svcs.sandbox.paypal.com/AdaptiveAccounts/GetVerifiedStatus?emailAddress="+getemail+"&matchCriteria=NONE");
	     
	    	 request.setHeader("Accept", "application/json");
	         request.setHeader("Content-type", "application/json");
	        
	     
	    	 request.setHeader("X-PAYPAL-SECURITY-USERID","jb-us-seller_api1.paypal.com");//jb-us-seller_api1.paypal.com
	    	 request.setHeader("X-PAYPAL-SECURITY-PASSWORD","WX4WTU3S8MY44S7F");//WX4WTU3S8MY44S7F
			 request.setHeader("X-PAYPAL-SECURITY-SIGNATURE","AFcWxV21C7fd0v3bYYYRCpSSRl31A7yDhhsPUU2XhtMoZXsWHFxu-RWy");
			 //AFcWxV21C7fd0v3bYYYRCpSSRl31A7yDhhsPUU2XhtMoZXsWHFxu-RWy
			 request.setHeader("X-PAYPAL-APPLICATION-ID","APP-80W284485P519543T");//APP-80W284485P519543T
			 request.setHeader("X-PAYPAL-REQUEST-DATA-FORMAT","NV" );
			 request.setHeader("X-PAYPAL-RESPONSE-DATA-FORMAT","JSON");
				
	
	         
	         HttpResponse httpResponse = httpClient.execute(request);
					
					statusCode = httpResponse.getStatusLine().getStatusCode();
					
					InputStream inputStream = httpResponse.getEntity().getContent();

					// We have a byte stream. Next step is to convert it to a Character stream
					InputStreamReader inputStreamReader = new InputStreamReader(inputStream);

					// Then we have to wraps the existing reader (InputStreamReader) and buffer the input
					BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

					// InputStreamReader contains a buffer of bytes read from the source stream and converts these into characters as needed.
					//The buffer size is 8K
					//Therefore we need a mechanism to append the separately coming chunks in to one String element
					// We have to use a class that can handle modifiable sequence of characters for use in creating String
					StringBuilder stringBuilder = new StringBuilder();

					String bufferedStrChunk = null;

					// There may be so many buffered chunks. We have to go through each and every chunk of characters
					//and assign a each chunk to bufferedStrChunk String variable
					//and append that value one by one to the stringBuilder
					while((bufferedStrChunk = bufferedReader.readLine()) != null){
						stringBuilder.append(bufferedStrChunk);
					}
					responseString=stringBuilder.toString();
	        Log.e(functionName, responseString);
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
			System.err.println("socket exception"+e);
			//Util.alertMessage(context, "Please check your internet connection or try again later");
		}
		return responseString;
	
	}	
	

	
	public static String createImageFile() {
		try{
		    String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
		    String imageFileName = "Ara_" + timeStamp;
	
		    String mCurrentPhotoPath = Environment.getExternalStorageDirectory().getAbsolutePath()+ File.separator+imageFileName+".jpg";
		    return mCurrentPhotoPath;
		}catch(Exception e){
			e.printStackTrace();
			return "";
		}
	}
	
	public static int resultCode()
	{
			
		return statusCode;
		
	}
	
	
}