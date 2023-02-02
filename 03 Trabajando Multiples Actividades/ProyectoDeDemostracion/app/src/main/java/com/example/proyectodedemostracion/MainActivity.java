package com.example.proyectodedemostracion;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import android.view.View;

public class MainActivity extends AppCompatActivity implements View.OnClickListener
{

    @Override
    protected void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        findViewById(R.id.btnwebaddress).setOnClickListener(this);
        findViewById(R.id.btnmap).setOnClickListener(this);
        findViewById(R.id.btnphonenumber).setOnClickListener(this);
    }

    @Override
    public void onClick(View v)
    {
        Uri uri = null;
        Intent intent = null;

        switch (v.getId())
        {
            case R.id.btnwebaddress:
                uri = Uri.parse("http://developer.android.com/reference/android/content/Intent.html");
                intent = new Intent(Intent.ACTION_VIEW, uri);
                startActivity(intent);
                break;
            case R.id.btnmap:
                uri = Uri.parse("geo:40.7113399,-74.0263469");
                intent = new Intent(Intent.ACTION_VIEW, uri);
                startActivity(intent);
                break;
            case R.id.btnphonenumber:
                uri = Uri.parse("tel:3334589076");
                intent = new Intent(Intent.ACTION_DIAL, uri);
                startActivity(intent);
                break;
            default:
                Log.i(getClass().getName(), "No se encontro el id del boton");
        }
    }
}