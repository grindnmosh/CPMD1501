package com.grinddesign.friends;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.Toast;

import com.grinddesign.test.Connection;
import com.parse.FindCallback;
import com.parse.GetCallback;
import com.parse.Parse;
import com.parse.ParseACL;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;
import com.parse.SignUpCallback;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;


public class FriendListActivity extends ActionBarActivity implements AdapterView.OnItemLongClickListener, AdapterView.OnItemClickListener {

    public static ArrayList<String> nameArray = new ArrayList<String>();
    public static ArrayList<String> stateArray = new ArrayList<String>();
    public static ArrayList<String> oidArray = new ArrayList<String>();
    public static ArrayList<Number> yearArray = new ArrayList<Number>();
    public static ArrayAdapter<String> mainAdapter;
    ListView lv;
    String namePos;
    String oidPos;
    Context thisHere = this;
    private Timer sched;
    Context context;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getIntent().getBooleanExtra("EXIT", false)) {
            finish();
        }
        setContentView(R.layout.activity_friendlist);



        lv = (ListView) findViewById(R.id.lv);
        nameArray = new ArrayList<String>();
        stateArray = new ArrayList<String>();
        oidArray = new ArrayList<String>();
        yearArray = new ArrayList<Number>();
        Log.i("Array", "Entry POint Query");

        Parse.initialize(this, "jR7Hl4PT0g2y5BZQP1kpwHduKbSKs5B8ZqUZgkW7", "T3wn1MrWL1cQb3Act2u3GvSFlkJZIegx55gdmdqy");

        ConnectivityManager cm = (ConnectivityManager) thisHere.getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo netInfo = cm.getActiveNetworkInfo();
        if (netInfo != null && netInfo.isConnectedOrConnecting()) {

            Connection con = new Connection(thisHere);
            con.connection();


            ParseQuery<ParseObject> query = ParseQuery.getQuery("rf");
            try {
                List<ParseObject> objects = query.find();
                ParseObject.pinAllInBackground(objects);
            } catch (com.parse.ParseException e) {
                e.printStackTrace();
            }
            query.fromLocalDatastore();
            query.findInBackground(new FindCallback<ParseObject>() {

                @Override
                public void done(List list, com.parse.ParseException e) {
                    Log.i("Array", "Entry Point Done");

                    if (e == null) {
                        for (int i = 0; i < list.size(); i++) {

                            Object object = list.get(i);



                            String name = ((ParseObject) object).getString("Name");
                            String state = ((ParseObject) object).getString("State");
                            Number year = ((ParseObject) object).getNumber("Age");
                            String oid = ((ParseObject) object).getObjectId();



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



        }else{
            Log.i("testing", "HITTTTTTT!!!!!!");

            ParseQuery<ParseObject> query = ParseQuery.getQuery("rf");
            query.fromLocalDatastore();
            query.findInBackground(new FindCallback() {
                @Override
                public void done(List list, com.parse.ParseException e) {
                    Log.i("testing", "HITTTTTTT!!!!!!");
                    Log.i("testing", list.toString());
                    for (int i = 0; i < list.size(); i++) {
                        Log.i("testing", "HITTTTTTT!!!!!!");
                        Object object = list.get(i);
                        Log.i("testing", object.toString());
                        String name = ((ParseObject) object).getString("Name");
                        String state = ((ParseObject) object).getString("State");
                        Number year = ((ParseObject) object).getNumber("Age");
                        String oid = ((ParseObject) object).getObjectId();


                        nameArray.add(name);
                        stateArray.add(state);
                        oidArray.add(oid);
                        yearArray.add(year);
                        if (nameArray != null) {
                            Log.i("Array", oidArray.toString());
                            mainAdapter.notifyDataSetChanged();
                        }

                    }

                }


            });

            mainAdapter = new FriendCell(this, R.layout.activity_friendcell, nameArray);
            lv.setOnItemClickListener(this);
            lv.setOnItemLongClickListener(this);
            lv.setAdapter(mainAdapter);


        }

        resume();
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

        ConnectivityManager cm = (ConnectivityManager) thisHere.getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo netInfo = cm.getActiveNetworkInfo();
        if (netInfo != null && netInfo.isConnectedOrConnecting()) {
            this.sched.cancel();
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
                            String age = ((ParseObject) object).getString("Age");
                            String oid = ((ParseObject) object).getObjectId();
                            if (namePos.equals(name)) {
                                ((ParseObject) object).deleteInBackground();
                                nameArray.remove(name);
                                stateArray.remove(state);
                                stateArray.remove(age);
                                oidArray.remove(oid);
                                mainAdapter.notifyDataSetChanged();

                            }



                        }

                    } else {
                        Log.d("Failed", "Error: " + e.getMessage());
                    }
                }
            });

        }else{
            final ParseQuery<ParseObject> query = ParseQuery.getQuery("rf");
            query.fromLocalDatastore();
            query.findInBackground(new FindCallback<ParseObject>() {

                @Override
                public void done(List list, com.parse.ParseException e) {

                    if (e == null) {
                        namePos = nameArray.get(position);
                        for (int i = 0; i < list.size(); i++) {
                            Object object = list.get(i);
                            String name = ((ParseObject) object).getString("Name");
                            String state = ((ParseObject) object).getString("State");
                            String age = ((ParseObject) object).getString("Age");
                            if (namePos.equals(name)) {
                                ((ParseObject) object).unpinInBackground();
                                ((ParseObject) object).deleteEventually();
                                nameArray.remove(name);
                                stateArray.remove(state);
                                stateArray.remove(age);
                                mainAdapter.notifyDataSetChanged();
                            }
                        }

                    } else {
                        Log.d("Failed", "Error: " + e.getMessage());
                    }
                }
            });

        }


        return false;
    }


    @Override
    public void onItemClick(AdapterView<?> parent, View view, final int position, long id) {

        ConnectivityManager cm = (ConnectivityManager) thisHere.getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo netInfo = cm.getActiveNetworkInfo();
        if (netInfo != null && netInfo.isConnectedOrConnecting()) {

            Connection con = new Connection(thisHere);
            con.connection();

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


        }else{
            ParseQuery<ParseObject> query = ParseQuery.getQuery("rf");
            query.fromLocalDatastore();
            query.findInBackground(new FindCallback() {
                @Override
                public void done(List list, com.parse.ParseException e) {
                    if (e == null) {
                        oidPos = oidArray.get(position);
                        for (int i = 0; i < list.size(); i++) {
                            Object object = list.get(i);
                            String oid = ((ParseObject) object).getObjectId();

                            Intent update = new Intent(FriendListActivity.this, UpdateActivity.class);
                            update.putExtra("object ID", oidPos);
                            startActivity(update);

                        }

                    } else {
                        Log.d("Failed", "Error: " + e.getMessage());
                    }

                }


            });
        }



    }

    private void TimerMethod()
    {
        this.runOnUiThread(Timer_Tick);
    }


    private Runnable Timer_Tick = new Runnable() {
        public void run() {


            ConnectivityManager cm = (ConnectivityManager) thisHere.getSystemService(Context.CONNECTIVITY_SERVICE);
            NetworkInfo netInfo = cm.getActiveNetworkInfo();
            if (netInfo != null && netInfo.isConnectedOrConnecting()) {

                ParseQuery<ParseObject> query = ParseQuery.getQuery("rf");
                try {
                    List<ParseObject> objects = query.find();
                    ParseObject.pinAllInBackground(objects);
                } catch (com.parse.ParseException e) {
                    e.printStackTrace();
                }
                query.fromLocalDatastore();
                query.findInBackground(new FindCallback<ParseObject>() {

                    @Override
                    public void done(List list, com.parse.ParseException e) {
                        Log.i("Array", "Entry POint Done");
                        nameArray = new ArrayList<String>();
                        stateArray = new ArrayList<String>();
                        oidArray = new ArrayList<String>();
                        yearArray = new ArrayList<Number>();
                        if (e == null) {
                            for (int i = 0; i < list.size(); i++) {

                                Object object = list.get(i);



                                String name = ((ParseObject) object).getString("Name");
                                String state = ((ParseObject) object).getString("State");
                                Number year = ((ParseObject) object).getNumber("Age");
                                String oid = ((ParseObject) object).getObjectId();



                                nameArray.add(name);
                                stateArray.add(state);
                                oidArray.add(oid);
                                yearArray.add(year);
                                if (nameArray != null) {
                                    Log.i("Array", oidArray.toString());
                                    mainAdapter.notifyDataSetChanged();
                                }

                            }
                            mainAdapter = new FriendCell(thisHere, R.layout.activity_friendcell, nameArray);
                            lv.setOnItemClickListener(FriendListActivity.this);
                            lv.setOnItemLongClickListener(FriendListActivity.this);

                            lv.setAdapter(mainAdapter);

                        } else {
                            Log.d("Failed", "Error: " + e.getMessage());
                        }
                    }
                });



            }else{
                //. Do Nothing
            }
        }
    };

    public void resume() {
        sched = new Timer();
        sched.schedule(new TimerTask() {
            @Override
            public void run() {
                TimerMethod();
            }

        }, 0, 20000);
    }

    @Override
    public void onBackPressed()
    {
        Intent intent = new Intent(Intent.ACTION_MAIN);
        intent.addCategory(Intent.CATEGORY_HOME);
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(intent);


    }

}
