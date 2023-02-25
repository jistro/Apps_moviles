package com.proyecto.calculadoraimc;

import android.os.Bundle;

import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.navigation.Navigation;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

public class resultado extends Fragment
{

    public resultado()
    {
        // Required empty public constructor
    }


    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState)
    {
        // Inflate the layout for this fragment
        final View view;
        view = inflater.inflate(R.layout.fragment_resultado, container, false);
        view.findViewById(R.id.buttonRegresar);
        TextView salud = view.findViewById(R.id.textSalud);
        TextView imc = view.findViewById(R.id.textResultado);


        salud.setText(getArguments().getString("textoSalud"));
        imc.setText(getArguments().getString("imcResulatado"));



        view.findViewById(R.id.buttonRegresar).setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                Navigation.findNavController(view).navigate(R.id.action_resultado_to_calcularAdulto);
            }
        });
        return view;
    }
}