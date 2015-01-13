package com.grinddesign.friends;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import com.parse.FindCallback;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;


public class FriendListActivity extends ActionBarActivity implements AdapterView.OnItemLongClickListener, AdapterView.OnItemClickListener {

    public static ArrayList<String> nameArray = new ArrayList<String>();
    public static ArrayList<String> stateArray = new ArrayList<String>();
    public static ArrayList<String> oidArray = new ArrayList<String>();
    public static ArrayList<String> yearArray = new ArrayList<String>();
    public static ArrayAdapter<String> mainAdapter;
    ListView lv;
    String namePos;
    String oidPos;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_friendlist);

        lv = (ListView) findViewById(R.id.lv);
        nameArray = new ArrayList<String>();
        stateArray = new ArrayList<String>();
        oidArray = new ArrayList<String>();
        yearArray = new ArrayList<String>();
        Log.i("Array", "Entry POint Query");
        ParseQuery<ParseObject> query = ParseQuery.getQuery("rf");
        query.findInBackground(new FindCallback<ParseObject>() {

            @Override
            public void done(List list, com.parse.ParseException e) {
                Log.i("Array", "Entry POint Done");


                if (e == null) {
                    for (int i = 0; i < list.size(); i++) {

                        Object object = list.get(i);
                        String name = ((ParseObject) object).getString("Name");
                        String state = ((ParseObject) object).getString("State");
                        String year = ((ParseObject) object).getString("Age");
                        String oid = ((ParseObject) object).getObjectId();
                        Log.i("Array", name);
                        Log.i("Array", state);
                        Log.i("Array", year);
                        Log.i("ID", oid);

                        nameArray.add(name);
                        stateArray.add(state);
                        oidArray.add(oid);
                        yearArray.add(year);
                        if (nameArray != null) {
                            Log.i("Array", oidArray.toString());
                            mainAdapter.notifyDataSetChanged();
                        }

                    }

                } else {
                    Log.d("Failed", "Error: " + e.getMessage());
                }
            }
        });

        mainAdapter = new FriendCell(this, R.layout.activity_friendcell, nameArray);
        lv.setOnItemClickListener(this);
        lv.setOnItemLongClickListener(this);
        lv.setAdapter(mainAdapter);

    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_friendlist, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.add) {
            Intent addnew = new Intent(this, NewFriendActivity.class);
            this.startActivity(addnew);
        }
        else if (id == R.id.logout) {
            ParseUser.logOut();
            Intent logout = new Intent(this, LoginActivity.class);
            this.startActivity(logout);
            finish();
        }

        return super.onOptionsItemSelected(item);

    }

    @Override
    public boolean onItemLongClick(AdapterView<?> parent, View strings,
                                   final int position, long id) {
        Log.i("CLick Click", "BOOOOOM");
        ParseQuery<ParseObject> query = ParseQuery.getQuery("rf");
        query.findInBackground(new FindCallback<ParseObject>() {

            @Override
            public void done(List list, com.parse.ParseException e) {

                if (e == null) {
                    namePos = nameArray.get(position);
                    for (int i = 0; i < list.size(); i++) {
                        Object object = list.get(i);
                        String name = ((ParseObject) object).getString("Name");
                        String state = ((ParseObject) object).getString("State");
                        if (namePos.equals(name)) {
                            ((ParseObject) object).deleteInBackground();
                            nameArray.remove(name);
                            stateArray.remove(state);
                            mainAdapter.notifyDataSetChanged();
                        }



                    }

                } else {
                    Log.d("Failed", "Error: " + e.getMessage());
                }
            }
        });
        return false;
    }


    @Override
    public void onItemClick(AdapterView<?> parent, View view, final int position, long id) {
        ParseQuery<ParseObject> query = ParseQuery.getQuery("rf");
        query.findInBackground(new FindCallback<ParseObject>() {

            @Override
            public void done(List list, com.parse.ParseException e) {

                if (e == null) {
                    oidPos = oidArray.get(position);
                    for (int i = 0; i < list.size(); i++) {
                        Object object = list.get(i);
                        String oid = ((ParseObject) object).getObjectId();
                        if (oidPos.equals(oid)) {
                            Log.i("ObjectID", oid);
                            Intent update = new Intent(FriendListActivity.this, UpdateActivity.class);
                            update.putExtra("object ID", oid);
                            startActivity(update);
                        }



                    }

                } else {
                    Log.d("Failed", "Error: " + e.getMessage());
                }
            }
        });


    }
}
