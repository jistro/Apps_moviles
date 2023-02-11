package com.example.fragmentos3;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.annotation.NonNull;
import static com.example.fragmentos3.R.layout.*;


public class Fragmento3 extends Fragment 
{
    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) 
    {
        final View view = inflater.inflate(fragment_3, container, false);
        return view;
    }
}

