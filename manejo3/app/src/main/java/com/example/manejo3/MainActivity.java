package com.example.manejo3;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity 
{
    @Override
    protected void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        ButtonHandler bh = new ButtonHandler();
        findViewById(R.id.button).setOnClickListener(bh);
        findViewById(R.id.button2).setOnClickListener(bh);
        findViewById(R.id.button3).setOnClickListener(bh);
    }

    private class ButtonHandler implements View.OnClickListener
    {
        @Override
        public void onClick(View view)
        {
            switch(view.getId())
            {
                case R.id.button:
                    show("Boton 1");
                    break;
                case R.id.button2:
                    show("Boton 2");
                    break;
                case R.id.button3:
                    show("Boton 3");
                    break;
                default:
                    show("eh???");
            }
        }
    }

    void show(String message)
    {
        Toast.makeText(this, message, Toast.LENGTH_LONG).show();
        Log.i(getClass().getName(), message);
    }
}