package com.example.manejo3;

import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Toast;
import android.widget.Button;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;


public class MainActivity2 extends AppCompatActivity

    implements View.OnClickListener
    {

        @Override
        public void onCreate (@Nullable Bundle savedInstanceState)
        {
            super.onCreate(savedInstanceState);
            setContentView(R.layout.activity_main);
        }

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
        void show(String message)
        {
            Toast.makeText(this, message, Toast.LENGTH_LONG).show();
            Log.i(getClass().getName(), message);
        }
    }
    

