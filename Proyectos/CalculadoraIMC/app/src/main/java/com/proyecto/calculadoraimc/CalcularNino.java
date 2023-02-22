package com.proyecto.calculadoraimc;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.fragment.app.Fragment;
import androidx.navigation.Navigation;
/**
 * A simple {@link Fragment} subclass.
 * Use the {@link CalcularNino#newInstance} factory method to
 * create an instance of this fragment.
 */
public class CalcularNino extends Fragment
{
    public CalcularNino()
    {
        // Required empty public constructor
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState)
    {
        // Inflate the layout for this fragment
        final View view = inflater.inflate(R.layout.fragment_calcular_nino, container, false);
        view.findViewById(R.id.buttonAdultos).setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                Navigation.findNavController(view).navigate(R.id.action_calcularNino_to_calcularAdulto);
            }
        });
        return view;
    }

}