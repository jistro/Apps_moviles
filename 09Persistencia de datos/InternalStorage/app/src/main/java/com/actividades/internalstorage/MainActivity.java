package com.actividades.internalstorage;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

public class MainActivity extends AppCompatActivity
{
    EditText editText;
    private String filename = "myfile.txt";

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        editText = (EditText) findViewById(R.id.edittext);
    }
        public void saveData(View v)
        {
            String str  = editText.getText().toString();

            FileOutputStream out = null;
            try
            {
                out = openFileOutput(filename, Context.MODE_APPEND);
                out.write(str.getBytes());
            } catch (IOException e)
            {
                e.printStackTrace();
            }
            finally
            {
                if (out != null)
                {
                    try
                    {
                        out.close();
                    } catch (IOException e)
                    {
                        e.printStackTrace();
                    }
                }
            }
        }
        public void loadData(View v)
        {
            TextView tv = (TextView) findViewById(R.id.textView);
            FileInputStream in = null;
            StringBuilder sb = new StringBuilder();

            try
            {
                in = openFileInput(filename);

                int read = 0;
                while ((read = in.read()) != -1)
                {
                    sb.append((char) read);
                }
                tv.setText(sb.toString());
            }catch (FileNotFoundException e)
            {
                e.printStackTrace();
            } catch (IOException e)
            {
                e.printStackTrace();
            }
            finally
            {
                if (in != null)
                {
                    try
                    {
                        in.close();
                    } catch (IOException e)
                    {
                        e.printStackTrace();
                    }
                }
            }
        }

}