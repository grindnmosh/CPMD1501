package com.grinddesign.friends;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Bundle;
import android.os.Messenger;
import android.support.v7.app.ActionBarActivity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.grinddesign.test.Connection;
import com.parse.LogInCallback;
import com.parse.ParseUser;
import com.parse.SignUpCallback;



public class LoginActivity extends ActionBarActivity {

    Button signin;
    Button signup;
    String userid;
    String pass;
    EditText username;
    EditText password;
    Context thisHere = this;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        username = (EditText) findViewById(R.id.username);
        password = (EditText) findViewById(R.id.password);
        signin = (Button) findViewById(R.id.sibutt);
        signup = (Button) findViewById(R.id.subutt);

        signin.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                userid = username.getText().toString();
                pass = password.getText().toString();

                ConnectivityManager cm = (ConnectivityManager) thisHere.getSystemService(Context.CONNECTIVITY_SERVICE);
                NetworkInfo netInfo = cm.getActiveNetworkInfo();
                if (netInfo != null && netInfo.isConnectedOrConnecting()) {



                    ParseUser.logInInBackground(userid, pass,
                            new LogInCallback() {
                                public void done(ParseUser parseUser, com.parse.ParseException e) {
                                    if (parseUser != null) {
                                        Intent intent = new Intent(
                                                LoginActivity.this,
                                                FriendListActivity.class);
                                        startActivity(intent);
                                        Toast.makeText(getApplicationContext(),
                                                "Successfully Logged in",
                                                Toast.LENGTH_LONG).show();
                                        finish();
                                    } else {
                                        Toast.makeText(
                                                getApplicationContext(),
                                                "No such user exist, please signup",
                                                Toast.LENGTH_LONG).show();
                                    }
                                }

                            });


                }else{
                    Toast.makeText(thisHere, "No network detected. Please connect to a network to login", Toast.LENGTH_SHORT).show();
                }

            }
        });

        signup.setOnClickListener(new View.OnClickListener() {

            public void onClick(View arg0) {
                // Retrieve the text entered from the EditText
                userid = username.getText().toString();
                pass = password.getText().toString();

                ConnectivityManager cm = (ConnectivityManager) thisHere.getSystemService(Context.CONNECTIVITY_SERVICE);
                NetworkInfo netInfo = cm.getActiveNetworkInfo();
                if (netInfo != null && netInfo.isConnectedOrConnecting()) {

                    Connection con = new Connection(thisHere);
                    con.connection();

                    // Force user to fill up the form
                    if (userid.equals("") && pass.equals("")) {
                        Toast.makeText(getApplicationContext(),
                                "Please complete the sign up form",
                                Toast.LENGTH_LONG).show();

                    } else {
                        // Save new user data into Parse.com Data Storage
                        ParseUser user = new ParseUser();
                        user.setUsername(userid);
                        user.setPassword(pass);
                        user.signUpInBackground(new SignUpCallback() {
                            public void done(com.parse.ParseException e) {
                                if (e == null) {
                                    // Show a simple Toast message upon successful registration
                                    Toast.makeText(getApplicationContext(),
                                            "Successfully Signed up, please log in.",
                                            Toast.LENGTH_LONG).show();
                                } else {
                                    Toast.makeText(getApplicationContext(),
                                            "Sign up Error", Toast.LENGTH_LONG)
                                            .show();
                                }
                            }


                        });
                    }

                }else{
                    Toast.makeText(thisHere, "No network detected. Please connect to a network", Toast.LENGTH_SHORT).show();
                }


            }
        });
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_login, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
}
