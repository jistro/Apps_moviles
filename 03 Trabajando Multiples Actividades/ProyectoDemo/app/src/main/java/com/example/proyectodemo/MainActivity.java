package com.example.proyectodemo;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class MainActivity extends AppCompatActivity 
{

    @Override
    protected void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Button objButton = (Button) findViewById(R.id.button);
    }

    public void launchSecondActivity(View view)
    {
        Intent i = new Intent(this, SecondActivity.class);
        startActivity(i);
    }
}