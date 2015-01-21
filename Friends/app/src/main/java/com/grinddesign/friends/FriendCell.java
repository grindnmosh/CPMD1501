package com.grinddesign.friends;

import android.app.Activity;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;
import java.util.ArrayList;


public class FriendCell extends ArrayAdapter<String> {


    private Context context;
    private ArrayList<String> arrayLister = FriendListActivity.nameArray;

    public FriendCell(Context context, int resource, ArrayList<String> arrayLister) {
        super(context, resource, arrayLister);
        this.context = context;
        this.arrayLister = arrayLister;
    }

    public View getView(final int position, View convertView, ViewGroup parent) {

        String names = arrayLister.get(position);
        String states = FriendListActivity.stateArray.get(position);
        Number years = FriendListActivity.yearArray.get(position);



        //this is my code to inflate the custom layout
        LayoutInflater blowUp = (LayoutInflater) context.getSystemService(Activity.LAYOUT_INFLATER_SERVICE);
        View view = blowUp.inflate(R.layout.activity_friendcell, null);

        //this is to assign the post to the proper field
        TextView tvMain = (TextView) view.findViewById(R.id.name);
        tvMain.setText(names);

        //this is to assign the date to the proper field
        TextView tvSub  = (TextView) view.findViewById(R.id.state);
        tvSub.setText(states);

        //this is to assign the date to the proper field
        TextView tvSub2  = (TextView) view.findViewById(R.id.year);
        tvSub2.setText(years.toString());

        return view;
    }
}
