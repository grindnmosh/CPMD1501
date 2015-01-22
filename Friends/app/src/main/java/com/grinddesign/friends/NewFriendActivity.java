package com.grinddesign.friends;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.res.Configuration;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.text.InputFilter;
import android.text.InputType;
import android.text.method.DigitsKeyListener;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.Toast;

import com.grinddesign.test.Connection;
import com.parse.GetCallback;
import com.parse.ParseACL;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;

import java.util.ArrayList;
import java.util.UUID;


public class NewFriendActivity extends ActionBarActivity {

    String[] states;
    Button save;
    String name;
    String state;
    Number year;
    EditText fname;
    EditText fyear;
    Spinner fState;
    Context thisHere = this;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_newfriend);

        fname = (EditText) findViewById(R.id.friend);
        fyear = (EditText) findViewById(R.id.year1);
        save = (Button) findViewById(R.id.save);
        fState = (Spinner) findViewById(R.id.spinner);
        fyear.setFilters(new InputFilter[]{new NumInputFilter(1, 120)});
        states = getResources().getStringArray(R.array.states);

        final ArrayAdapter<String> statesAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_dropdown_item, states);


        fState.setAdapter(statesAdapter);

        save.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                name = fname.getText().toString().trim();
                String age = fyear.getText().toString();

                state = fState.getSelectedItem().toString().trim();

                if (!name.equals("") && !age.equals("") && !state.equals("Select A State")) {
                    year = Integer.parseInt(fyear.getText().toString());
                    ConnectivityManager cm = (ConnectivityManager) thisHere.getSystemService(Context.CONNECTIVITY_SERVICE);
                    NetworkInfo netInfo = cm.getActiveNetworkInfo();
                    if (netInfo != null && netInfo.isConnectedOrConnecting()) {


                        ParseObject rf = new ParseObject("rf");
                        rf.put("Name", name);
                        rf.put("State", state);
                        rf.put("Age", year);
                        rf.setACL(new ParseACL(ParseUser.getCurrentUser()));
                        rf.pinInBackground();
                        rf.saveInBackground();
                        FriendListActivity.mainAdapter.notifyDataSetChanged();
                        Intent friendlist = new Intent(NewFriendActivity.this, FriendListActivity.class);
                        startActivity(friendlist);

                    } else {
                        ParseObject rf = new ParseObject("rf");
                        rf.put("Name", name);
                        rf.put("State", state);
                        rf.put("Age", year);
                        rf.setACL(new ParseACL(ParseUser.getCurrentUser()));
                        rf.pinInBackground();
                        rf.saveEventually();
                        FriendListActivity.mainAdapter.notifyDataSetChanged();
                        Intent friendlist = new Intent(NewFriendActivity.this, FriendListActivity.class);
                        startActivity(friendlist);
                    }

                }else{
                    Toast.makeText(thisHere, "Please fill out all fields before saving", Toast.LENGTH_SHORT).show();
                }
            }
        });
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_newfriend, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.back) {
            Intent addnew = new Intent(this, FriendListActivity.class);
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
}
