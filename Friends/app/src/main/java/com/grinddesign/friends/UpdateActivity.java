package com.grinddesign.friends;

import android.content.Context;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.grinddesign.test.Connection;
import com.parse.FindCallback;
import com.parse.GetCallback;
import com.parse.ParseACL;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;


public class UpdateActivity extends ActionBarActivity {

    String[] states;
    String name;
    String state;
    String ois;
    Number year;
    EditText upName;
    Spinner upState;
    EditText upYear;
    TextView objId;
    Button upButt;
    Context thisHere = this;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_update);

        upName = (EditText) findViewById(R.id.upName);
        upYear = (EditText) findViewById(R.id.year2);
        upState = (Spinner) findViewById(R.id.stateSpin);
        objId = (TextView) findViewById(R.id.currId);
        upButt = (Button) findViewById(R.id.upButt);

        states = getResources().getStringArray(R.array.states);

        final ArrayAdapter<String> statesAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_dropdown_item, states);

        upState.setAdapter(statesAdapter);

        Intent i = getIntent();
        ois = i.getStringExtra("object ID");

        objId.setText(ois);

        ConnectivityManager cm = (ConnectivityManager) thisHere.getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo netInfo = cm.getActiveNetworkInfo();
        if (netInfo != null && netInfo.isConnectedOrConnecting()) {



            ParseQuery<ParseObject> query = ParseQuery.getQuery("rf");

            query.getInBackground(ois, new GetCallback<ParseObject>() {
                public void done(ParseObject object, com.parse.ParseException e) {
                    if (e == null) {
                        name = object.getString("Name");
                        year = object.getInt("Age");
                        state = object.getString("State");
                        upName.setText(name);
                        upYear.setText(year.toString());
                        if (!state.equals(null)) {
                            int spinnerPosition = statesAdapter.getPosition(state);
                            upState.setSelection(spinnerPosition);
                        }

                    }
                }
            });

        }else{
            ParseQuery<ParseObject> query = ParseQuery.getQuery("rf");
            query.fromLocalDatastore();
            query.getInBackground(ois, new GetCallback<ParseObject>() {
                public void done(ParseObject object, com.parse.ParseException e) {
                    if (e == null) {
                        name = object.getString("Name");
                        year = object.getInt("Age");
                        state = object.getString("State");
                        upName.setText(name);
                        upYear.setText(year.toString());
                        if (!state.equals(null)) {
                            int spinnerPosition = statesAdapter.getPosition(state);
                            upState.setSelection(spinnerPosition);
                        }

                    }
                }
            });
        }


        upButt.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                name = upName.getText().toString();
                year = Integer.parseInt(upYear.getText().toString());
                state = upState.getSelectedItem().toString();
                //FriendListActivity.nameArray = new ArrayList<String>();

                ConnectivityManager cm = (ConnectivityManager) thisHere.getSystemService(Context.CONNECTIVITY_SERVICE);
                NetworkInfo netInfo = cm.getActiveNetworkInfo();
                if (netInfo != null && netInfo.isConnectedOrConnecting()) {



                    ParseQuery<ParseObject> query = ParseQuery.getQuery("rf");
                    query.getInBackground(ois, new GetCallback<ParseObject>() {
                        public void done(ParseObject object, com.parse.ParseException e) {
                            if (e == null) {
                                object.put("Name", name);
                                object.put("State", state);
                                object.put("Age", year);
                                object.pinInBackground();
                                object.saveInBackground();
                                FriendListActivity.mainAdapter.notifyDataSetChanged();

                            }
                        }
                    });
                    FriendListActivity.mainAdapter.notifyDataSetChanged();
                    Intent friendlist = new Intent(UpdateActivity.this, FriendListActivity.class);
                    startActivity(friendlist);

                }else{
                    ParseQuery<ParseObject> query = ParseQuery.getQuery("rf");
                    query.fromLocalDatastore();
                    query.getInBackground(ois, new GetCallback<ParseObject>() {
                        public void done(ParseObject object, com.parse.ParseException e) {
                            if (e == null) {
                                object.put("Name", name);
                                object.put("State", state);
                                object.put("Age", year);

                                object.pinInBackground();
                                object.saveEventually();
                                FriendListActivity.mainAdapter.notifyDataSetChanged();

                            }
                        }
                    });
                    FriendListActivity.mainAdapter.notifyDataSetChanged();
                    Intent friendlist = new Intent(UpdateActivity.this, FriendListActivity.class);
                    startActivity(friendlist);
                }

            }
        });
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_update, menu);
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
