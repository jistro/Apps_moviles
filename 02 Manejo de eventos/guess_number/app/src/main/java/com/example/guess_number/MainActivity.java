package com.example.guess_number;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.EditText;
import android.widget.Button;
import android.widget.TextView;

import java.util.Random;

public class MainActivity extends AppCompatActivity 

    implements View.OnClickListener
    {
        int numberToGuess = 0;
        EditText e;
        TextView t;
        @Override
        protected void onCreate (Bundle savedInstanceState)
        {
            super.onCreate(savedInstanceState);
            setContentView(R.layout.activity_main);
            
            numberToGuess = initNumberToGuess();

            e = (EditText) findViewById(R.id.editText);
            t = (TextView) findViewById(R.id.textView);

            Button b = (Button) findViewById(R.id.button);
            b.setOnClickListener(this);
        }

        @Override
        public void onClick(View view)
        {
            int number = Integer.parseInt(e.getText().toString());

            if (number == numberToGuess) 
            {
                t.setText("es el numero correcto! c:");
            } 
            else if (number < numberToGuess) 
            {
                t.setText("el numero es mas alto");
            } 
            else 
            {
                t.setText("el numero es mas bajo");
            }
            Log.i("======>", numberToGuess+"");
        }

        int initNumberToGuess() 
        {
            Random r = new Random();
            numberToGuess = r.nextInt(100) + 50;
            Log.i("======>", numberToGuess+"");
            return numberToGuess;
        }
    }