package com.grinddesign.friends;

import android.app.Activity;
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


public class FriendListActivity extends ActionBarActivity implements AdapterView.OnItemLongClickListener {

    public static ArrayList<String> nameArray = new ArrayList<String>();
    public static ArrayList<String> stateArray = new ArrayList<String>();
    public static ArrayAdapter<String> mainAdapter;
    ListView lv;
    String namePos;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_friendlist);

        lv = (ListView) findViewById(R.id.lv);
        nameArray = new ArrayList<String>();
        stateArray = new ArrayList<String>();
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
                        Log.i("Array", name);
                        Log.i("Array", state);

                        nameArray.add(name);
                        stateArray.add(state);
                        if (nameArray != null) {
                            Log.i("Array", nameArray.toString());
                        }
                        mainAdapter.notifyDataSetChanged();

                    }

                } else {
                    Log.d("Failed", "Error: " + e.getMessage());
                }
            }
        });

        mainAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, nameArray);
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



}
