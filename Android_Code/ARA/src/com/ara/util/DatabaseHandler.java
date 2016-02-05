package com.ara.util;



import java.util.ArrayList;
import java.util.List;

import com.ara.model.Notification;
 
import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
 
public class DatabaseHandler extends SQLiteOpenHelper {
 
    // All Static variables
    // Database Version
    private static final int DATABASE_VERSION = 1;
 
    // Database Name
    private static final String DATABASE_NAME = "aradatabase";
 
    // Contacts table name
    private static final String TABLE_NOTIFICATION = "notification";
 
    // Contacts Table Columns names
    private static final String KEY_ID = "id";
    private static final String KEY_TITLE = "title";
    private static final String KEY_DESCRIPTION = "description";
    private static final String KEY_READ = "readnotification";
    private static final String KEY_DATE = "ndate";
    private static final String KEY_USERID = "userid";
    public DatabaseHandler(Context context) {
        super(context, DATABASE_NAME, null, DATABASE_VERSION);
    }
 
    // Creating Tables
    @Override
    public void onCreate(SQLiteDatabase db) {
        String CREATE_CONTACTS_TABLE = "CREATE TABLE " + TABLE_NOTIFICATION + "("
                + KEY_ID + " INTEGER PRIMARY KEY AUTOINCREMENT," + KEY_TITLE + " TEXT,"
                + KEY_DESCRIPTION + " TEXT," + KEY_DATE + " TEXT,"+ KEY_READ + " TEXT,"+  KEY_USERID + " TEXT"+")";
        db.execSQL(CREATE_CONTACTS_TABLE);
    }
 
    // Upgrading database
    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        // Drop older table if existed
        db.execSQL("DROP TABLE IF EXISTS " + TABLE_NOTIFICATION);
 
        // Create tables again
        onCreate(db);
    }
 
    /**
     * All CRUD(Create, Read, Update, Delete) Operations
     */
 
    public // Adding new contact
    void addContact(Notification contact) {
        SQLiteDatabase db = this.getWritableDatabase();
 
        ContentValues values = new ContentValues();
        values.put(KEY_TITLE, contact.getNotificationTitle()); //  title
        values.put(KEY_DESCRIPTION, contact.getNotificationText()); //  des
        values.put(KEY_DATE, contact.getCreatedDate());
        values.put(KEY_READ, contact.getRead());
        values.put(KEY_USERID, contact.getUserID());
        // Inserting Row
        db.insert(TABLE_NOTIFICATION, null, values);
        db.close(); // Closing database connection
    }
 
    // Getting single contact
    Notification getContact(int id) {
        SQLiteDatabase db = this.getReadableDatabase();
 
        Cursor cursor = db.query(TABLE_NOTIFICATION, new String[] { KEY_ID,
                KEY_TITLE, KEY_DESCRIPTION,KEY_DATE ,KEY_READ,KEY_USERID}, KEY_ID + "=?",
                new String[] { String.valueOf(id) }, null, null, null, null);
        if (cursor != null)
            cursor.moveToFirst();
 
        Notification contact = new Notification(Integer.parseInt(cursor.getString(0)),
                cursor.getString(1), cursor.getString(2),cursor.getString(3),cursor.getString(4));
        // return contact
        return contact;
    }
     
    // Getting All Contacts
    public List<Notification> getAllNotification(String userid) {
        List<Notification> contactList = new ArrayList<Notification>();
        // Select All Query//WHERE TRIM(name) = '"+name.trim()+"'",
        //"SELECT * FROM "+SMS_TABLE_RCV+" WHERE Phone_number='" + contact_no + "'",null)
       
       // String selectQuery = "SELECT  * FROM " + TABLE_NOTIFICATION +" ORDER BY "+ KEY_DATE + " DESC";
        String selectQuery = "SELECT  * FROM " + TABLE_NOTIFICATION +" WHERE "+ KEY_USERID + "="+"'"+userid.trim()+"'" + " ORDER BY "+ KEY_DATE + " DESC";
        SQLiteDatabase db = this.getWritableDatabase();
        Cursor cursor = db.rawQuery(selectQuery, null);
 
        // looping through all rows and adding to list
        if (cursor.moveToFirst()) {
            do {
            	Notification contact = new Notification();
                contact.setId(Integer.parseInt(cursor.getString(cursor.getColumnIndex(KEY_ID))));
                contact.setNotificationTitle(cursor.getString(cursor.getColumnIndex(KEY_TITLE)));
                contact.setNotificationText(cursor.getString(cursor.getColumnIndex(KEY_DESCRIPTION)));
                contact.setCreatedDate(cursor.getString(cursor.getColumnIndex(KEY_DATE)));
                contact.setRead(cursor.getString(cursor.getColumnIndex(KEY_READ)));
                contact.setUserID(cursor.getString(cursor.getColumnIndex(KEY_USERID)));
              
                // Adding contact to list
                contactList.add(contact);
            } while (cursor.moveToNext());
        }
 
        // return contact list
        return contactList;
    }
 
    // Updating single contact
    public int updateNotification(int notificationId) {
        SQLiteDatabase db = this.getWritableDatabase();
 
        ContentValues values = new ContentValues();
        values.put(KEY_READ, "read");
        // updating row
        return db.update(TABLE_NOTIFICATION, values, KEY_ID + " = ?",
                new String[] { String.valueOf(notificationId) });
    }
 
    // Deleting single contact
    public void deleteNotification(Notification contact) {
        SQLiteDatabase db = this.getWritableDatabase();
        db.delete(TABLE_NOTIFICATION, KEY_ID + " = ?",
                new String[] { String.valueOf(contact.getId()) });
        db.close();
    }
 
 
    // Getting contacts Count
    public int getContactsCount() {
        String countQuery = "SELECT  * FROM " + TABLE_NOTIFICATION;
        SQLiteDatabase db = this.getReadableDatabase();
        Cursor cursor = db.rawQuery(countQuery, null);
        cursor.close();
 
        // return count
        return cursor.getCount();
    }
 
}