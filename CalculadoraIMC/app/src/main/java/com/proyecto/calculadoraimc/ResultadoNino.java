package com.proyecto.calculadoraimc;

import android.os.Bundle;
import androidx.fragment.app.Fragment;
import androidx.navigation.Navigation;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

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
        final View view;
        view = inflater.inflate(R.layout.fragment_resultado_nino, container, false);
        TextView saludNino = view.findViewById(R.id.textSaludNino);
        TextView imcNino = view.findViewById(R.id.textResultadoNino);

        saludNino.setText(getArguments().getString("saludTextoNino"));
        imcNino.setText(getArguments().getString("imcResulatadoNino"));


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