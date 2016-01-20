package com.ara.login;

import java.io.File;
import java.lang.reflect.Method;
import java.text.DecimalFormat;
import java.util.concurrent.Semaphore;

import android.app.Activity;
import android.content.Intent;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.PackageStats;
import android.content.pm.ResolveInfo;
import android.content.res.Resources;
import android.os.Bundle;
import android.os.RemoteException;
import android.util.Log;
import android.view.View;
import android.view.Window;
import android.widget.ImageView;
import android.widget.TextView;

import com.ara.badge.BadgeListActivity;
import com.ara.base.BaseActivity;
import com.ara.base.R;
import com.ara.board.DashBoardActivity;
import com.ara.board.ScoreBoardActivity;
import com.ara.payment.PaymentListActivity;
import com.ara.profile.MyProfile;
import com.ara.referral.ReferralListActivity;
import com.ara.referral.SubmitReferralActivity;
import com.ara.rewards.RewardsListActivity;
import com.daimajia.swipe.BuildConfig;

public class AboutActivity extends Activity{

private TextView txtBack,txtHeader,txtBuildVersion,txtBuildVersionOutput,txtBuildSize,txtBuildSizeOutput;
private ImageView backArrow;
private ResolveInfo ri;
String size = null; 
PackageManager packageManager;
Semaphore codeSizeSemaphore = new Semaphore(1, true);


public void onCreate(Bundle savedInstanceState) {
	super.onCreate(savedInstanceState);
	requestWindowFeature(Window.FEATURE_NO_TITLE);
	setContentView(R.layout.activity_about);



	initUIComponents();
	setValue();
	sliderOnClickListener();
	
	}

private void setValue() {
	// TODO Auto-generated method stub
	PackageManager manager = this.getPackageManager();
	PackageInfo info;
	try {
		info = manager.getPackageInfo(this.getPackageName(), 0);
		txtBuildVersionOutput.setText( ""+info.versionName);
	} catch (NameNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	txtBuildSizeOutput.setText(getFileSize(getSize())+"");
}

private void initUIComponents() {
	// TODO Auto-generated method stub
	txtBack = (TextView)findViewById(R.id.back);
	txtBack.setTypeface(DashBoardActivity.typeface_roboto);
	backArrow = (ImageView)findViewById(R.id.back_arrow);
	txtHeader=(TextView)findViewById(R.id.txtHeader);
	txtHeader.setTypeface(DashBoardActivity.typeface_timeburner);
	backArrow=(ImageView)findViewById(R.id.backArrow);
	txtBuildVersion=(TextView)findViewById(R.id.txtBuildVersion);
	txtBuildVersion.setTypeface(DashBoardActivity.typeface_roboto);
	txtBuildVersionOutput=(TextView)findViewById(R.id.txtBuildVersionOutput);
	txtBuildVersionOutput.setTypeface(DashBoardActivity.typeface_roboto);
	txtBuildSize=(TextView)findViewById(R.id.txtBuildSize);
	txtBuildSize.setTypeface(DashBoardActivity.typeface_roboto);
	txtBuildSizeOutput=(TextView)findViewById(R.id.txtBuildSizeOutput);
	txtBuildSizeOutput.setTypeface(DashBoardActivity.typeface_roboto);
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

public void sliderOnClickListener() {

	txtBack.setOnClickListener(listener);
	backArrow.setOnClickListener(listener);
	

}
public long getSize() {
	long size=0;
	ApplicationInfo tmpInfo;
	try {
		tmpInfo = AboutActivity.this.getPackageManager().getApplicationInfo(getPackageName(),-1);
		File file = new File(tmpInfo.publicSourceDir);
		 size = file.length();
		
	} catch (NameNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return size;
	
}
public static String getFileSize(long size) {
    if (size <= 0)
        return "0";
    final String[] units = new String[] { "B", "KB", "MB", "GB", "TB" };
    int digitGroups = (int) (Math.log10(size) / Math.log10(1024));
    return new DecimalFormat("#,##0.#").format(size / Math.pow(1024, digitGroups)) + " " + units[digitGroups];
}
}