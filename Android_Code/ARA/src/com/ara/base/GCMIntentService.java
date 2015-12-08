package com.ara.base;

import java.util.List;
import java.util.Random;

import com.ara.base.R;
import com.ara.board.DashBoardActivity;
import com.ara.referral.SubmitReferralActivity;
import com.google.android.gcm.GCMBaseIntentService;
import com.google.android.gcm.GCMRegistrar;

import android.app.ActivityManager;
import android.app.ActivityManager.RunningTaskInfo;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.media.MediaPlayer;
import android.media.RingtoneManager;
import android.net.Uri;
import android.telephony.TelephonyManager;
import android.util.Log;

public class GCMIntentService extends GCMBaseIntentService{
	//android:theme="@android:style/Theme.Dialog"
	MediaPlayer mp;
	private static final String TAG = "GCMIntentService";
	public GCMIntentService() {
		super(Notification_Util.SENDER_ID);
	}
	int flag = 0;
	
	protected void onRegistered(Context context, String registrationId) {
		String str_role = null,str_userid=null;
		
		Log.e(TAG, "Device registered: regId = " + registrationId);
		Notification_Util.displayMessage(context, getString(R.string.gcm_registered));
		TelephonyManager tManager = (TelephonyManager)context.getSystemService(Context.TELEPHONY_SERVICE);
		String udid = tManager.getDeviceId();
		
		ServerUtilities.register(context, "Android",registrationId, udid);
	}


	protected void onUnregistered(Context context, String registrationId) {
		Log.e(TAG, "Device unregistered");
		Notification_Util.displayMessage(context, getString(R.string.gcm_unregistered));
		if (GCMRegistrar.isRegisteredOnServer(context)) {
			//	             ServerUtilities.unregister(context, registrationId);
		} else {
			// This callback results from the call to unregister made on
			// ServerUtilities when the registration to the server failed.
			Log.i(TAG, "Ignoring unregister callback");
		}
	}


	protected void onMessage(final Context context, Intent intent) {
		
	
		//String message = getString(R.string.gcm_message);
		String message = intent.getStringExtra("message");
		//Log.e("tutor: On message", message);
		
		Notification_Util.displayMessage(context, message);

		ActivityManager am = (ActivityManager) getSystemService(ACTIVITY_SERVICE);
		List<RunningTaskInfo> taskInfo = am.getRunningTasks(1);
		Log.d("current task :", "CURRENT Activity ::" + taskInfo.get(0).topActivity.getClass().getSimpleName());
		ComponentName componentInfo = taskInfo.get(0).topActivity;
		if(componentInfo.getPackageName().equalsIgnoreCase("com.ara.login")){

			Log.e("inside application","app running");
		
			Log.e("message", message);
			
			/*Intent mIntent = new Intent(context,SubmitReferralActivity.class);
			mIntent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP |Intent.FLAG_ACTIVITY_SINGLE_TOP);
			context.startActivity(mIntent);*/
		}
		else {
		
			generateNotification(context, message);
			Log.e("message", message);
			
		
		}
	}

	protected void onDeletedMessages(Context context, int total) {
		Log.e(TAG, "Received deleted messages notification");
		String message = getString(R.string.gcm_deleted, total);
		Notification_Util.displayMessage(context, message);
		// notifies user
		generateNotification(context, message);
	}

	public void onError(Context context, String errorId) {
		Log.e(TAG, "Received error: " + errorId);
		Notification_Util.displayMessage(context, getString(R.string.gcm_error, errorId));
	}

	protected boolean onRecoverableError(Context context, String errorId) {
		// log message
		Log.e(TAG, "Received recoverable error: " + errorId);
		Notification_Util.displayMessage(context, getString(R.string.gcm_recoverable_error,  errorId));
		return super.onRecoverableError(context, errorId);
	}

	/**Issues a notification to inform the user that server has sent a message. */
	@SuppressWarnings("deprecation")
	private static void generateNotification(Context context, String message) {

		Intent notificationIntent = null;
		int icon = R.drawable.appicon;
		long when = System.currentTimeMillis();
		NotificationManager notificationManager = (NotificationManager)context.getSystemService(Context.NOTIFICATION_SERVICE);
		Notification notification = new Notification(icon, message, when);

		String title = context.getString(R.string.app_name);
		System.err.println("title="+title);
		System.err.println("message="+message);
	
	
		notificationIntent = new Intent(context, DashBoardActivity.class);
			
		notificationIntent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP |Intent.FLAG_ACTIVITY_SINGLE_TOP);
		PendingIntent intent = PendingIntent.getActivity(context, 0, notificationIntent, PendingIntent.FLAG_UPDATE_CURRENT);
		notification.setLatestEventInfo(context, title, message, intent);
		notification.flags |= Notification.FLAG_AUTO_CANCEL;
		notification.icon = R.drawable.appicon;

		Uri notificationSound = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION);
		notification.sound = notificationSound;
	


		Random r = new Random();
		int random = r.nextInt(100);
		notificationManager.notify(message.length() + random, notification);	     
	}
	

}
