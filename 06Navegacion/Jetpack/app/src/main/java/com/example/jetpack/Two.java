package com.example.jetpack;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.fragment.app.Fragment;
/**
 * A simple {@link Fragment} subclass.
 * Use the {@link two#newInstance} factory method to
 * create an instance of this fragment.
 */
public class Two extends Fragment
{
    public Two()
    {
        // Required empty public constructor
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState)
    {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_two, container, false);
    }

}