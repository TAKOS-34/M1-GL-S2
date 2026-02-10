package com.example.tp1;
import android.app.Activity;
import android.app.AlertDialog;
import android.graphics.Color;
import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;

public class Main extends Activity {
    private Button btnSubmit;
    private LinearLayout rootLayout;

    @Override
    public void onCreate(Bundle saveInstanceState) {
        super.onCreate(saveInstanceState);
//
//        LinearLayout ll = new LinearLayout(this);
//        ll.setOrientation(LinearLayout.VERTICAL);
//        ll.setPadding(30, 30, 30, 30);
//
//        EditText etName = new EditText(this);
//        etName.setHint(getString(R.string.name));
//        ll.addView(etName);
//
//        EditText etFirstName = new EditText(this);
//        etFirstName.setHint(getString(R.string.firstname));
//        ll.addView(etFirstName);
//
//        EditText etAge = new EditText(this);
//        etAge.setHint(getString(R.string.age));
//        etAge.setInputType(android.text.InputType.TYPE_CLASS_NUMBER);
//        ll.addView(etAge);
//
//        EditText etSkills = new EditText(this);
//        etSkills.setHint(getString(R.string.skills));
//        ll.addView(etSkills);
//
//        EditText etPhone = new EditText(this);
//        etPhone.setHint(getString(R.string.phone));
//        etPhone.setInputType(android.text.InputType.TYPE_CLASS_PHONE);
//        ll.addView(etPhone);
//
//        Button btnSubmit = new Button(this);
//        btnSubmit.setText(getString(R.string.submit));
//        ll.addView(btnSubmit);
//
//        setContentView(ll);

        setContentView(R.layout.main);

        btnSubmit = findViewById(R.id.button);
        btnSubmit.setOnClickListener(v -> showValidationDialog());
    }
    private void showValidationDialog() {
        android.view.LayoutInflater inflater = this.getLayoutInflater();
        android.view.View dialogView = inflater.inflate(R.layout.popup_layout, null);

        new AlertDialog.Builder(this)
                .setView(dialogView)
                .setPositiveButton("Valider", (dialog, which) -> {
                    rootLayout.setBackgroundColor(Color.parseColor("#90EE90"));
                })
                .setNegativeButton("Rejeter", (dialog, which) -> {
                    rootLayout.setBackgroundColor(Color.parseColor("#FFCCCB"));
                })
                .show();
    }
}
