package com.grinddesign.friends;

import android.app.Activity;
import android.content.Intent;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ArrayAdapter;
import android.widget.Spinner;

import com.parse.ParseUser;


public class NewFriendActivity extends ActionBarActivity {

    String[] states;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_newfriend);

        Spinner s = (Spinner) findViewById(R.id.spinner);
        states = getResources().getStringArray(R.array.states);

        ArrayAdapter<String> statesAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_dropdown_item, states);

        s.setAdapter(statesAdapter);
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
