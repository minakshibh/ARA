package com.ara.profile;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Random;

import org.apache.http.ParseException;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.provider.MediaStore;
import android.util.Log;
import android.view.View;
import android.view.Window;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.ara.base.BaseActivity;
import com.ara.base.R;
import com.ara.board.DashBoardActivity;
import com.ara.imageloader.ImageLoader;
import com.ara.rewards.RewardDetailsActivity;
import com.ara.rewards.RewardsListActivity;
import com.ara.util.ExifUtils;
import com.ara.util.Util;
import com.ara.util.Util.LoadImage;

public class ImageUploadActivity extends Activity {

	private ImageView imageView_back, imageView_profile;
	private TextView textView_back, textView_edit,textView_myprofile;
	private String mCurrentPhotoPath = "", imagePath = "";
	private RelativeLayout Layout_middle;
	private SharedPreferences spref;
	private String  imageurl=null;
	private ProgressBar progressBar;

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.activity_image_upload);

		spref = getSharedPreferences("ara_prefs", MODE_PRIVATE);
		imageView_profile = (ImageView) findViewById(R.id.imageView_profile);
		imageView_back = (ImageView) findViewById(R.id.imageView_back);
		textView_back = (TextView) findViewById(R.id.textView_back);
		Layout_middle=(RelativeLayout)findViewById(R.id.LinearLayout_middle);
		textView_myprofile=(TextView)findViewById(R.id.textView_myprofile);
		textView_myprofile.setTypeface(DashBoardActivity.typeface_timeburner);
		textView_back.setText("Profile");
		textView_back.setTypeface(DashBoardActivity.typeface_roboto);
		textView_edit = (TextView) findViewById(R.id.textView_edit);
		textView_edit.setTypeface(DashBoardActivity.typeface_roboto);
		progressBar=(ProgressBar)findViewById(R.id.progressBar);
		progressBar.setVisibility(View.GONE);
		setOnClickListener();
		
		 imageurl=getIntent().getStringExtra("url");
		if(imageurl!=null)
		{
		// ImageLoader imageLoader = new ImageLoader(ImageUploadActivity.this);
	    // imageLoader.DisplayImage(imageurl, imageView_profile);
			System.err.println("image="+imageurl);
			new LoadImage().execute(imageurl);
		}
		selectImage();
	}

	private void setOnClickListener() {

		imageView_back.setOnClickListener(listener);
		//textView_edit.setOnClickListener(listener);
		textView_back.setOnClickListener(listener);
		Layout_middle.setOnClickListener(listener);

	}

	private View.OnClickListener listener = new View.OnClickListener() {

		@Override
		public void onClick(View v) {
			if (v == imageView_back) {
				goToBack();

			} else if (v == textView_edit) {
				
				selectImage();
				
			} else if (v == textView_back) {

				goToBack();
			}
			else if (v == Layout_middle) {

				selectImage();
			}
		}
	};

	protected void selectImage() {

		final CharSequence[] options = { "Take Photo", "Choose from Gallery","Cancel" };

		AlertDialog.Builder builder = new AlertDialog.Builder(
				ImageUploadActivity.this);
		builder.setTitle("Add Photo!");
		builder.setItems(options, new DialogInterface.OnClickListener() {
			@Override
			public void onClick(DialogInterface dialog, int item) {
				if (options[item].equals("Take Photo")) {
					Intent takePictureIntent = new Intent(
							MediaStore.ACTION_IMAGE_CAPTURE);
					// Ensure that there's a camera activity to handle the
					// intent
					if (takePictureIntent.resolveActivity(getPackageManager()) != null) {
						// Create the File where the photo should go
						File photoFile = null;
						try {
							mCurrentPhotoPath = Util.createImageFile();

							photoFile = new File(mCurrentPhotoPath);
						} catch (Exception ex) {
							// Error occurred while creating the File
							ex.printStackTrace();
						}
						// Continue only if the File was successfully created
						if (photoFile != null) {
							takePictureIntent.putExtra(MediaStore.EXTRA_OUTPUT,
									Uri.fromFile(photoFile));
							startActivityForResult(takePictureIntent, 1);
						}
					}
				} else if (options[item].equals("Choose from Gallery")) {
					// check=1;
					Intent intent = new Intent();
					intent.setType("image/*");
					intent.setAction(Intent.ACTION_GET_CONTENT);
					startActivityForResult(
							Intent.createChooser(intent, "Select Picture"), 2);
				} else if (options[item].equals("Cancel")) {
					dialog.dismiss();
					goToBack();
				}
			}
		});
		builder.show();

	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		super.onActivityResult(requestCode, resultCode, data);
		if (resultCode == RESULT_OK) {

			if (requestCode == 1) {

				Bitmap bitmap = BitmapFactory.decodeFile(mCurrentPhotoPath);
				Bitmap bm2 = ExifUtils.rotateBitmap(mCurrentPhotoPath, bitmap);

				imageView_profile.setImageBitmap(bm2);
				imagePath = SaveImage(bm2);

				new uploadimage().execute();

			} else if (requestCode == 2) {

				
				if (Build.VERSION.SDK_INT < 19) {	
				
				Uri selectedImageUri = data.getData();

				Cursor cursor = getContentResolver()
						.query(selectedImageUri,
								new String[] { android.provider.MediaStore.Images.ImageColumns.DATA },
								null, null, null);
				cursor.moveToFirst();

				// Link to the image
				final String imageFilePath = cursor.getString(0);
				cursor.close();
				imagePath = imageFilePath;

				Bitmap bitmap = BitmapFactory.decodeFile(imagePath);
				Bitmap bm2 = ExifUtils.rotateBitmap(imagePath, bitmap);
				imageView_profile.setImageBitmap(bm2);
				imagePath = SaveImage(bm2);
				}
				else
				{
					 try {
	                        InputStream imInputStream = getContentResolver().openInputStream(data.getData());
	                        Bitmap bitmap = BitmapFactory.decodeStream(imInputStream);
	                        imagePath = saveGalaryImageOnLitkat(bitmap);
	                        imageView_profile.setImageBitmap(BitmapFactory.decodeFile(imagePath));
	                        //encodeImage();
	                    } catch (FileNotFoundException e) {
	                        e.printStackTrace();
	                    }	
					
					
				}
				new uploadimage().execute();

			}
			// Log.d("encodedImage=",encodedImage);
		}
	}
	 private File temp_path;
	    private final int COMPRESS = 100;
	    private String saveGalaryImageOnLitkat(Bitmap bitmap) {
	        try {
	            File cacheDir;
	            if (Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED))
	                cacheDir = new File(Environment.getExternalStorageDirectory(), getResources().getString(R.string.app_name));
	            else
	                cacheDir = getExternalFilesDir(Environment.DIRECTORY_PICTURES);
	            if (!cacheDir.exists())
	                cacheDir.mkdirs();
	            String filename = System.currentTimeMillis() + ".jpg";
	            File file = new File(cacheDir, filename);
	            temp_path = file.getAbsoluteFile();
	            // if(!file.exists())
	            file.createNewFile();
	            FileOutputStream out = new FileOutputStream(file);
	            bitmap.compress(Bitmap.CompressFormat.JPEG, COMPRESS, out);
	            return file.getAbsolutePath();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        return null;

	    }
	private String SaveImage(Bitmap finalBitmap) {

		String root = Environment.getExternalStorageDirectory().toString();
		File myDir = new File(root + "/saved_images");
		myDir.mkdirs();
		Random generator = new Random();
		int n = 10000;
		n = generator.nextInt(n);
		String fname = "Image-" + n + ".jpg";
		File file = new File(myDir, fname);
		if (file.exists())
			file.delete();
		try {
			FileOutputStream out = new FileOutputStream(file);
			finalBitmap.compress(Bitmap.CompressFormat.JPEG, 90, out);
			out.flush();
			out.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return file.getAbsolutePath();
	}

	// class image upload
	private class uploadimage extends AsyncTask<Void, Void, Void> { // Async_task
		// class
		String res, image1;
		private ProgressDialog pDialog;

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			// Showing progress dialog
			
			textView_edit.setEnabled(false);
			pDialog = new ProgressDialog(ImageUploadActivity.this);
			pDialog.setMessage("Please wait...");
			pDialog.setCancelable(false);
			pDialog.show();
		}

		@Override
		protected Void doInBackground(Void... arg0) {

			try {
				Log.e("", "url=" + ImageUploadActivity.this.getResources().getString(
						R.string.baseUrl)
						+ "/users/"
						+ spref.getString("userid", "0")
						+ "/profilepic");
				
				res = multipartRequest(
						ImageUploadActivity.this.getResources().getString(
								R.string.baseUrl)
								+ "/users/"
								+ spref.getString("userid", "0")
								+ "/profilepic", imagePath);
			
				Log.e("", "url" + res);

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			return null;
		}

		@Override
		protected void onPostExecute(Void result) {
			super.onPostExecute(result);
			System.err.println("photo output" + result);
			pDialog.dismiss();
			textView_edit.setEnabled(true);
			if(res.contains("jpg"))
			{
				Util.ToastMessage(ImageUploadActivity.this, "Profile picture upload successfully");
			}
			else
			{
				Util.ToastMessage(ImageUploadActivity.this, "Please try again");
			}
		}
	}

	// image upload in multi part
	public String multipartRequest(String urlTo, String filepath)
			throws ParseException, IOException {
		HttpURLConnection connection = null;
		DataOutputStream outputStream = null;
		InputStream inputStream = null;

		String twoHyphens = "--";
		String boundary = "*****" + Long.toString(System.currentTimeMillis())
				+ "*****";
		String lineEnd = "\r\n";

		String result = "";

		int bytesRead, bytesAvailable, bufferSize;
		byte[] buffer;
		int maxBufferSize = 1 * 1024 * 1024;

		String[] q = filepath.split("/");
		int idx = q.length - 1;

		try {
			File file = new File(filepath);
			FileInputStream fileInputStream = new FileInputStream(file);

			URL url = new URL(urlTo);
			connection = (HttpURLConnection) url.openConnection();

			connection.setDoInput(true);
			connection.setDoOutput(true);
			connection.setUseCaches(false);

			connection.setRequestMethod("POST");
			connection.setRequestProperty("Connection", "Keep-Alive");
			connection.setRequestProperty("User-Agent",
					"Android Multipart HTTP Client 1.0");
			connection.setRequestProperty("Content-Type",
					"multipart/form-data; boundary=" + boundary);

			outputStream = new DataOutputStream(connection.getOutputStream());
			outputStream.writeBytes(twoHyphens + boundary + lineEnd);
			outputStream
					.writeBytes("Content-Disposition: form-data;filename=\""
							+ q[idx] + "\"" + lineEnd);
			outputStream.writeBytes("Content-Type: image/jpeg" + lineEnd);
			outputStream.writeBytes("Content-Transfer-Encoding: binary"
					+ lineEnd);
			outputStream.writeBytes(lineEnd);

			bytesAvailable = fileInputStream.available();
			bufferSize = Math.min(bytesAvailable, maxBufferSize);
			buffer = new byte[bufferSize];

			bytesRead = fileInputStream.read(buffer, 0, bufferSize);
			while (bytesRead > 0) {
				outputStream.write(buffer, 0, bufferSize);
				bytesAvailable = fileInputStream.available();
				bufferSize = Math.min(bytesAvailable, maxBufferSize);
				bytesRead = fileInputStream.read(buffer, 0, bufferSize);
			}

			outputStream.writeBytes(lineEnd);

			outputStream.writeBytes(twoHyphens + boundary + twoHyphens
					+ lineEnd);

			inputStream = connection.getInputStream();
			result = this.convertStreamToString(inputStream);

			fileInputStream.close();
			inputStream.close();
			outputStream.flush();
			outputStream.close();
			Log.e("Multipart result", result);
			return result;
		} catch (Exception e) {
			Log.e("MultipartRequest", "Multipart Form Upload Error");
			e.printStackTrace();
			return "error";
		}
	}

	private String convertStreamToString(InputStream is) {
		BufferedReader reader = new BufferedReader(new InputStreamReader(is));
		StringBuilder sb = new StringBuilder();

		String line = null;
		try {
			while ((line = reader.readLine()) != null) {
				sb.append(line);
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				is.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return sb.toString();
	}
	public class LoadImage extends AsyncTask<String, String, Bitmap> {
	     Bitmap bitmap;
		 @Override
	        protected void onPreExecute() {
	            super.onPreExecute();
	            progressBar.setVisibility(View.VISIBLE);
	           /* pDialog = new ProgressDialog(MainActivity.this);
	            pDialog.setMessage("Loading Image ....");
	            pDialog.show();*/
	 	        }
	         protected Bitmap doInBackground(String... args) {
	             try {
	                   bitmap = BitmapFactory.decodeStream((InputStream)new URL(args[0]).getContent());
	 
	            } catch (Exception e) {
	                  e.printStackTrace();
	            }
	            return bitmap;
	         }
	       protected void onPostExecute(Bitmap image) {
	    		progressBar.setVisibility(View.GONE);
	            if(image != null){
	            	imageView_profile.setImageBitmap(image);
	             //pDialog.dismiss();
	             }else{
	             //pDialog.dismiss();
	             Toast.makeText(ImageUploadActivity.this, "Image Does Not exist or Network Error", Toast.LENGTH_SHORT).show();
	 
	             }
	         }
	     }
	
	private void goToBack()
	{
		/*Intent intent=new Intent(ImageUploadActivity.this,MyProfile.class);
		intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK | Intent.FLAG_ACTIVITY_NEW_TASK);
	    startActivity(intent);*/
		finish();
		}
	@Override
	public void onBackPressed() {
		goToBack();
	}
}
