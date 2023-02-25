package com.proyecto.calculadoraimc;

import android.os.Bundle;

import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.navigation.Navigation;

import android.view.LayoutInflater;
import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.Toast;

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
        View view;
        view = inflater.inflate(R.layout.fragment_resultado, container, false);
        view.findViewById(R.id.buttonRegresar);
        TextView salud = view.findViewById(R.id.textSaludAdulto);
        salud.setText(getArguments().getString("sexo"));

        view.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                Navigation.findNavController(view).navigate(R.id.action_resultado_to_calcularAdulto);
            }
        });
        return view;
    }
}