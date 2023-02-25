package com.proyecto.calculadoraimc;

import android.os.Bundle;
import androidx.fragment.app.Fragment;
import androidx.navigation.Navigation;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

/**
 * A simple {@link Fragment} subclass.
 * Use the {@link ResultadoNino#newInstance} factory method to
 * create an instance of this fragment.
 *
 */
public class ResultadoNino extends Fragment
{
    public ResultadoNino()
    {
        // Required empty public constructor
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState)
    {
        // Inflate the layout for this fragment
        final View view = inflater.inflate(R.layout.fragment_resultado_nino, container, false);
        view.findViewById(R.id.buttonRegresar).setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                Navigation.findNavController(view).navigate(R.id.action_resultadoNino_to_calcularNino);
            }
        });
        return view;
    }
}