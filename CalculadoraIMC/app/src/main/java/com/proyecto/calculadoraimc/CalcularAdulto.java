package com.proyecto.calculadoraimc;

import android.app.Activity;
import android.content.Context;
import android.icu.text.DecimalFormat;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.Switch;
import android.widget.Toast;
import android.app.Activity;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import androidx.navigation.Navigation;


public class CalcularAdulto extends Fragment
{
    Switch switchS;
    EditText datoEstatura;
    EditText datoPeso;
    String texto;
    String error;
    String resultadoDecimalImc;
    boolean flagHombreMujer =false;



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
        datoEstatura = (EditText) view.findViewById(R.id.editTextNumberEstatura);
        datoPeso = (EditText) view.findViewById(R.id.editTextNumberPeso);



        view.findViewById(R.id.switchSexo).setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View view)
            {
                if (view.getId()==R.id.switchSexo)
                {
                    if (switchS.isChecked()) //mujer
                        flagHombreMujer = true;
                    else //hombre
                        flagHombreMujer = false;
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

                String estaturaString = datoEstatura.getText().toString();
                String pesoString     = datoPeso.getText().toString();

                if ( (estaturaString.matches("")) || (pesoString.matches("")) )
                {
                    if ( (estaturaString.matches("") ) && ( pesoString.matches("") ) )
                        error="No hay datos";
                    else if (estaturaString.matches(""))
                        error="Falta ingresar estatura";
                    else if  (pesoString.matches(""))
                        error="Falta ingresar peso";

                    Toast.makeText(getActivity(),error,Toast.LENGTH_SHORT).show();
                }
                else
                {
                    Bundle enviarDatos  = new Bundle();
                    int estatura        = Integer.parseInt(estaturaString);
                    int peso            = Integer.parseInt(pesoString);
                    float resultadoIMC =  (float)peso / ( ( (float)estatura*(float)estatura )/10000 );


                    if (flagHombreMujer)
                        texto = "Ella tiene";
                    else
                        texto = "El tiene";

                    if (resultadoIMC<18.5)
                        texto = texto + " Bajo peso";
                    else if (resultadoIMC >= 18.5 && resultadoIMC <= 25)
                        texto = texto + " Peso normal";
                    else if (resultadoIMC > 25 && resultadoIMC <= 29.9)
                        texto = texto + " Sobrepeso";
                    else if (resultadoIMC > 29.9)
                        texto = texto + " Obesidad";

                    DecimalFormat df = new DecimalFormat("0.00");
                    resultadoDecimalImc = String.valueOf(df.format(resultadoIMC));

                    enviarDatos.putString("textoSalud",texto);
                    enviarDatos.putString("imcResulatado",resultadoDecimalImc);

                    Navigation.findNavController(view).navigate(R.id.action_calcularAdulto_to_resultado, enviarDatos);
                }



            }
        });



        return view;
    }



}