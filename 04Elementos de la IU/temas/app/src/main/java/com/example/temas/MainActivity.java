package com.example.temas;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.MenuInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Toast;
import android.view.View;

public class MainActivity extends AppCompatActivity 
{

    @Override
    protected void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) 
    {
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.main_menu, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) 
    {
        switch (item.getItemId()) 
        {
            case R.id.menuFile:
                showMessage("File");
                break;
            case R.id.menuEdit:
                showMessage("Edit");
                break;
            case R.id.menuHelp:
                showMessage("Help");
                break;
            case R.id.menuExit:
                showMessage("Exit");
                break;
            default:
                showMessage("???");
        }
        return true;
    }

    
    private void showMessage(String msg) 
    {
        Toast.makeText(this, msg, Toast.LENGTH_SHORT).show();
    }
}