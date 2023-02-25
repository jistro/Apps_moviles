package com.proyecto.calculadoraimc;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Switch;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import androidx.navigation.Navigation;


public class CalcularAdulto extends Fragment
{
    Switch switchS;
    String texto;

    //SendDataInterface sendDataInterface;

    public CalcularAdulto()
    {
        // Required empty public constructor
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState)
    {

        final View view = inflater.inflate(R.layout.fragment_calcular_adulto, container, false);

        switchS = (Switch) view.findViewById (R.id.switchSexo);


        view.findViewById(R.id.switchSexo).setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View view)
            {
                if (view.getId()==R.id.switchSexo)
                {
                    if (switchS.isChecked()) //hombre
                    {
                        texto="ella es";
                    }
                    else
                    {
                        texto="el es";
                    }
                }
            }
        });

        view.findViewById(R.id.buttonNinos).setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                Navigation.findNavController(view).navigate(R.id.action_calcularAdulto_to_calcularNino);
            }
        });


        view.findViewById(R.id.buttonCalcular).setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                Bundle enviarDatos = new Bundle();
                enviarDatos.putString("sexo",texto);
                Navigation.findNavController(view).navigate(R.id.action_calcularAdulto_to_resultado, enviarDatos);
            }
        });



        return view;
    }



}