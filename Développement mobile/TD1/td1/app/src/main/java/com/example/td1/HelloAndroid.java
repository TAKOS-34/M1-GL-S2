package com.example.td1;
import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

public class HelloAndroid extends Activity {
    private Button button;
    private Button button2;

    private CheckBox linux, macos, windows;

    @Override
    public void onCreate(Bundle saveInstanceState) {
        super.onCreate(saveInstanceState);

//        LinearLayout ll = new LinearLayout(this);
//        ll.setOrientation(LinearLayout.VERTICAL);
//
//        TextView tv = new TextView(this);
//        tv.setText("Hello Android");
//
//        EditText et = new EditText(this);
//
//        ll.addView(tv);
//        ll.addView(et);
//
//        setContentView(ll);

//        setContentView(R.layout.layout);

//        setContentView(R.layout.main);
//
//        button = (Button) findViewById(R.id.mainbutton);
//        button.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View arg0) {
//                Toast.makeText(getApplicationContext(), "Message Bouton 1", Toast.LENGTH_LONG).show();
//            }
//        });
//
//        button2 = (Button) findViewById(R.id.buttontoast);
//        button2.setOnLongClickListener(new View.OnLongClickListener() {
//            @Override
//            public boolean onLongClick(View arg0) {
//                Toast.makeText(getApplicationContext(), "Toast", Toast.LENGTH_LONG).show();
//                return true;
//            }
//        });

            setContentView(R.layout.checkbox);
            addListenerOnChkWindows();
            addListenerOnButton();
    }
    public void addListenerOnChkWindows() {
        windows = (CheckBox) findViewById(R.id.windows_option);
        windows.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (((CheckBox) v).isChecked()) {
                    Toast.makeText(getApplicationContext(), "Bro, try Linux :)", Toast.LENGTH_LONG).show();
                }
            }
        });
    }

    public void addListenerOnButton() {
        linux = (CheckBox) findViewById(R.id.linux_option);
        macos = (CheckBox) findViewById(R.id.macos_option);
        windows = (CheckBox) findViewById(R.id.windows_option);
        button = (Button) findViewById(R.id.button);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                StringBuffer result = new StringBuffer();
                result.append("Linux check : ").append(linux.isChecked());
                result.append("\nMac OS check : ").append(macos.isChecked());
                result.append("\nWindows check :").append(windows.isChecked());
                Toast.makeText(getApplicationContext(), result.toString(), Toast.LENGTH_LONG).show();
            }
        });
    }
}