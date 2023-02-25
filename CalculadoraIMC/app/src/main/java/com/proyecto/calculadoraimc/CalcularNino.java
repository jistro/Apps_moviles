package com.proyecto.calculadoraimc;

import android.icu.text.DecimalFormat;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.Switch;
import android.widget.Toast;

import androidx.fragment.app.Fragment;
import androidx.navigation.Navigation;

public class CalcularNino extends Fragment
{
    Switch switchS;
    EditText datoMeses;
    EditText datoAnnos;
    EditText datoEstatura;
    EditText datoPeso;
    String texto;
    String error;
    String resultadoDecimalImc;
    boolean flagHombreMujer =false;
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

        switchS = (Switch) view.findViewById (R.id.switchSexo);
        datoMeses = (EditText) view.findViewById(R.id.editTextEdadMes);
        datoAnnos = (EditText) view.findViewById(R.id.editTextEdadAnno);
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

        view.findViewById(R.id.buttonAdultos).setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                Navigation.findNavController(view).navigate(R.id.action_calcularNino_to_calcularAdulto);
            }
        });
        view.findViewById(R.id.buttonCalcular).setOnClickListener(new View.OnClickListener()
        {


            @Override
            public void onClick(View v)
            {
                String estaturaString = datoEstatura.getText().toString();
                String pesoString     = datoPeso.getText().toString();
                String mesString      = datoMeses.getText().toString();
                String annoString     = datoAnnos.getText().toString();

                if ( estaturaString.matches("") || pesoString.matches("") || annoString.matches("") || mesString.matches("") )
                {
                    if ( estaturaString.matches("")  &&  pesoString.matches("") && annoString.matches("") && mesString.matches("") )
                        error="No hay datos";
                    else if (annoString.matches(""))
                        if (mesString.matches(""))
                            error="Falta ingresar edad";
                        else
                            error="Falta ingresar años";
                    else if (mesString.matches(""))
                        if (annoString.matches(""))
                            error="Falta ingresar edad";
                        else
                            error="Falta ingresar meses";
                    else if (estaturaString.matches(""))
                        error="Falta ingresar estatura";
                    else if  (pesoString.matches(""))
                        error="Falta ingresar peso";

                    Toast.makeText(getActivity(),error,Toast.LENGTH_SHORT).show();
                }
                else
                {
                    Bundle enviarDatosNino  = new Bundle();
                    int annos           = Integer.parseInt(annoString);
                    int meses           = Integer.parseInt(mesString);
                    int estatura        = Integer.parseInt(estaturaString);
                    int peso            = Integer.parseInt(pesoString);

                    float desnutricion  = 0;
                    float normal        = 0;
                    float sobrepeso     = 0;
                    float obesidad      = 0;

                    float resultadoIMC =  (float)peso / ( ( (float)estatura*(float)estatura )/10000 );

                    if (annos >=10)
                        Toast.makeText(getActivity(),"La persona debe tener menos de 10 años",Toast.LENGTH_SHORT).show();
                    else if (meses >=12)
                        Toast.makeText(getActivity(),"La persona debe tener menos de 12 meses",Toast.LENGTH_SHORT).show();
                    else
                    {
                        if (flagHombreMujer)
                        {
                            
                            if (annos == 0 && meses < 12) // si se trata de un bebe de menos de 1 año
                            {
                                texto = "La bebé tiene";
                                switch (meses) 
                                {
                                    case 0: //0 meses
                                        desnutricion = 2.8f;
                                        normal       = 3.2f;
                                        sobrepeso    = 3.7f;
                                        obesidad     = 4.2f;
                                        break;
                                    
                                    case 1: //1 meses
                                        desnutricion = 3.8f;
                                        normal       = 4.2f;
                                        sobrepeso    = 4.8f;
                                        obesidad     = 5.6f;
                                        break;

                                    case 2: //2 meses
                                        desnutricion = 4.5f;
                                        normal       = 5.1f;
                                        sobrepeso    = 5.8f;
                                        obesidad     = 6.6f;
                                        break;

                                    case 3: //3 meses
                                        desnutricion = 5.2f;
                                        normal       = 5.8f;
                                        sobrepeso    = 6.6f;
                                        obesidad     = 7.5f;
                                        break;
                                    
                                    case 4: //4 meses
                                        desnutricion = 5.7f;
                                        normal       = 6.4f;
                                        sobrepeso    = 7.3f;
                                        obesidad     = 8.2f;
                                        break;

                                    case 5: //5 meses
                                        desnutricion = 6.1f;
                                        normal       = 6.9f;
                                        sobrepeso    = 7.8f;
                                        obesidad     = 8.8f;
                                        break;
                                    
                                    case 6: //6 meses
                                        desnutricion = 6.5f;
                                        normal       = 7.3f;
                                        sobrepeso    = 8.2f;
                                        obesidad     = 9.3f;
                                        break;
                                    
                                    case 7: //7 meses
                                        desnutricion = 6.8f;
                                        normal       = 7.6f;
                                        sobrepeso    = 8.6f;
                                        obesidad     = 9.8f;
                                        break;
                                    
                                    case 8: //8 meses
                                        desnutricion = 7.0f;
                                        normal       = 7.9f;
                                        sobrepeso    = 9.0f;
                                        obesidad     = 10.2f;
                                        break;
                                    
                                    case 9: //9 meses
                                        desnutricion = 7.3f;
                                        normal       = 8.2f;
                                        sobrepeso    = 9.3f;
                                        obesidad     = 10.5f;
                                        break;
                                    
                                    case 10: //10 meses
                                        desnutricion = 7.5f;
                                        normal       = 8.5f;
                                        sobrepeso    = 9.6f;
                                        obesidad     = 10.9f;
                                        break;
                                    
                                    case 11: //11 meses
                                        desnutricion = 7.7f;
                                        normal       = 8.7f;
                                        sobrepeso    = 9.9f;
                                        obesidad     = 11.2f;
                                        break;

                                    default:
                                        break;
                                }
                            }
                            if (annos >=1) //si ya es una niña
                            {
                                texto = "La niña tiene";
                                switch (annos) 
                                {
                                    case 1: //1 año
                                        if (meses < 6)
                                        {
                                            desnutricion = 7.9f;
                                            normal       = 8.9f;
                                            sobrepeso    = 10.1f;
                                            obesidad     = 11.5f;
                                        }
                                        else
                                        {
                                            desnutricion = 9.1f;
                                            normal       = 10.2f;
                                            sobrepeso    = 11.6f;
                                            obesidad     = 13.2f;
                                        }
                                        break;

                                    case 2: //2 años
                                        if (meses < 6)
                                        {
                                            desnutricion = 10.2f;
                                            normal       = 11.5f;
                                            sobrepeso    = 13.0f;
                                            obesidad     = 14.8f;
                                        }
                                        else
                                        {
                                            desnutricion = 11.2f;
                                            normal       = 12.7f;
                                            sobrepeso    = 14.4f;
                                            obesidad     = 16.5f;
                                        }
                                        break;

                                    case 3: //3 años
                                        if (meses < 6)
                                        {
                                            desnutricion = 12.2f;
                                            normal       = 13.9f;
                                            sobrepeso    = 15.8f;
                                            obesidad     = 18.1f;
                                        }
                                        else
                                        {
                                            desnutricion = 13.1f;
                                            normal       = 15.0f;
                                            sobrepeso    = 17.2f;
                                            obesidad     = 18.1f;
                                        }
                                        break;

                                    case 4: //4 años
                                        if (meses < 6)
                                        {
                                            desnutricion = 14.0f;
                                            normal       = 16.1f;
                                            sobrepeso    = 18.5f;
                                            obesidad     = 21.5f;
                                        }
                                        else
                                        {
                                            desnutricion = 14.9f;
                                            normal       = 17.2f;
                                            sobrepeso    = 19.9f;
                                            obesidad     = 23.2f;
                                        }
                                        break;

                                    case 5: //5 años
                                        if (meses < 6)
                                        {
                                            desnutricion = 15.8f;
                                            normal       = 18.2f;
                                            sobrepeso    = 21.2f;
                                            obesidad     = 24.9f;
                                        }
                                        else
                                        {
                                            desnutricion = 12.7f;
                                            normal       = 15.2f;
                                            sobrepeso    = 16.9f;
                                            obesidad     = 19.0f;
                                        }
                                        break;

                                    case 6: //6 años
                                        if (meses < 6)
                                        {
                                            desnutricion = 12.7f;
                                            normal       = 15.3f;
                                            sobrepeso    = 17.0f;
                                            obesidad     = 19.2f;
                                        }
                                        else
                                        {
                                            desnutricion = 12.7f;
                                            normal       = 15.3f;
                                            sobrepeso    = 17.1f;
                                            obesidad     = 19.5f;
                                        }
                                        break;

                                    case 7: //7 años
                                        if (meses < 6)
                                        {
                                            desnutricion = 12.7f;
                                            normal       = 15.4f;
                                            sobrepeso    = 17.3f;
                                            obesidad     = 19.8f;
                                        }
                                        else
                                        {
                                            desnutricion = 12.8f;
                                            normal       = 15.5f;
                                            sobrepeso    = 17.5f;
                                            obesidad     = 20.1f;
                                        }
                                        break;
                                    
                                    case 8: //8 años
                                        if (meses < 6)
                                        {
                                            desnutricion = 12.9f;
                                            normal       = 15.7f;
                                            sobrepeso    = 17.7f;
                                            obesidad     = 20.6f;
                                        }
                                        else
                                        {
                                            desnutricion = 13.0f;
                                            normal       = 15.9f;
                                            sobrepeso    = 18.0f;
                                            obesidad     = 21.0f;
                                        }
                                        break;

                                    case 9: //9 años
                                        if (meses < 6)
                                        {
                                            desnutricion = 13.1f;
                                            normal       = 16.1f;
                                            sobrepeso    = 18.3f;
                                            obesidad     = 21.5f;
                                        }
                                        else
                                        {
                                            desnutricion = 13.3f;
                                            normal       = 16.3f;
                                            sobrepeso    = 18.7f;
                                            obesidad     = 22.0f;
                                        }
                                        break;

                                
                                    default:
                                        break;
                                }
                            }
                            
                        }
                            
                        else
                        {
                            if (annos == 0 && meses < 12) // si se trata de un bebe de menos de 1 año
                            {
                                texto = "El bebé tiene";
                                switch (meses) 
                                {
                                    case 0: //0 meses
                                        desnutricion = 2.9f;
                                        normal       = 3.3f;
                                        sobrepeso    = 3.9f;
                                        obesidad     = 4.4f;
                                        break;
                                    
                                    case 1: //1 meses
                                        desnutricion = 3.9f;
                                        normal       = 4.5f;
                                        sobrepeso    = 5.1f;
                                        obesidad     = 5.8f;
                                        break;
                                
                                    case 2: //2 meses
                                        desnutricion = 4.9f;
                                        normal       = 5.6f;
                                        sobrepeso    = 6.3f;
                                        obesidad     = 7.1f;
                                        break;
                                    
                                    case 3: //3 meses
                                        desnutricion = 5.7f;
                                        normal       = 6.4f;
                                        sobrepeso    = 7.2f;
                                        obesidad     = 8.0f;
                                        break;
                                    
                                    case 4: //4 meses
                                        desnutricion = 6.2f;
                                        normal       = 7.0f;
                                        sobrepeso    = 7.8f;
                                        obesidad     = 8.7f;
                                        break;

                                    case 5: //5 meses
                                        desnutricion = 6.7f;
                                        normal       = 7.5f;
                                        sobrepeso    = 8.4f;
                                        obesidad     = 9.3f;
                                        break;

                                    case 6: //6 meses
                                        desnutricion = 7.1f;
                                        normal       = 7.9f;
                                        sobrepeso    = 8.8f;
                                        obesidad     = 9.8f;
                                        break;

                                    case 7: //7 meses
                                        desnutricion = 7.4f;
                                        normal       = 8.3f;
                                        sobrepeso    = 9.2f;
                                        obesidad     = 10.3f;
                                        break;

                                    case 8: //8 meses
                                        desnutricion = 7.7f;
                                        normal       = 8.6f;
                                        sobrepeso    = 9.6f;
                                        obesidad     = 10.7f;
                                        break;

                                    case 9: //9 meses
                                        desnutricion = 8.0f;
                                        normal       = 8.9f;
                                        sobrepeso    = 9.9f;
                                        obesidad     = 11.0f;
                                        break;

                                    case 10: //10 meses
                                        desnutricion = 8.2f;
                                        normal       = 9.2f;
                                        sobrepeso    = 10.2f;
                                        obesidad     = 11.4f;
                                        break;
                                    
                                    case 11: //11 meses
                                        desnutricion = 8.4f;
                                        normal       = 9.4f;
                                        sobrepeso    = 10.5f;
                                        obesidad     = 11.7f;
                                        break;






                                    default:
                                        break;
                                }
                            }
                            else if (annos >= 1)  // si se trata de un niño
                            {
                                texto = "El niño tiene";
                                switch (annos) 
                                {
                                    case 1: //1 año
                                        if (meses < 6)
                                        {
                                            desnutricion = 8.6f;
                                            normal       = 9.6f;
                                            sobrepeso    = 10.8f;
                                            obesidad     = 12.0f;
                                        }
                                        else
                                        {
                                            desnutricion = 9.8f;
                                            normal       = 10.9f;
                                            sobrepeso    = 12.2f;
                                            obesidad     = 13.7f;
                                        }
                                        break;
                                    
                                    case 2: //2 años
                                        if (meses < 6)
                                        {
                                            desnutricion = 10.8f;
                                            normal       = 12.2f;
                                            sobrepeso    = 13.6f;
                                            obesidad     = 15.3f;
                                        }
                                        else
                                        {
                                            desnutricion = 11.8f;
                                            normal       = 13.3f;
                                            sobrepeso    = 15.0f;
                                            obesidad     = 16.9f;
                                        }
                                        break;

                                    case 3: //3 años
                                        if (meses < 6)
                                        {
                                            desnutricion = 12.7f;
                                            normal       = 14.3f;
                                            sobrepeso    = 16.2f;
                                            obesidad     = 18.3f;
                                        }
                                        else
                                        {
                                            desnutricion = 13.7f;
                                            normal       = 14.3f;
                                            sobrepeso    = 16.2f;
                                            obesidad     = 19.7f;
                                        }
                                        break;

                                    case 4: //4 años
                                        if (meses < 6)
                                        {
                                            desnutricion = 14.4f;
                                            normal       = 16.3f;
                                            sobrepeso    = 18.6f;
                                            obesidad     = 21.2f;
                                        }
                                        else
                                        {
                                            desnutricion = 15.2f;
                                            normal       = 17.3f;
                                            sobrepeso    = 19.8f;
                                            obesidad     = 22.7f;
                                        }
                                        break;

                                    case 5: //5 años    
                                        if (meses < 6)
                                        {
                                            desnutricion = 16.0f;
                                            normal       = 18.3f;
                                            sobrepeso    = 21.0f;
                                            obesidad     = 24.2f;
                                        }
                                        else
                                        {
                                            desnutricion = 13.0f;
                                            normal       = 15.3f;
                                            sobrepeso    = 16.7f;
                                            obesidad     = 18.4f;
                                        }
                                        break;

                                    case 6: //6 años
                                        if (meses < 6)
                                        {
                                            desnutricion = 13.0f;
                                            normal       = 15.3f;
                                            sobrepeso    = 16.8f;
                                            obesidad     = 18.5f;
                                        }
                                        else
                                        {
                                            desnutricion = 13.1f;
                                            normal       = 15.4f;
                                            sobrepeso    = 16.9f;
                                            obesidad     = 18.7f;
                                        }
                                        break;

                                    case 7: //7 años
                                        if (meses < 6)
                                        {
                                            desnutricion = 13.1f;
                                            normal       = 15.5f;
                                            sobrepeso    = 17.0f;
                                            obesidad     = 19.0f;
                                        }
                                        else
                                        {
                                            desnutricion = 13.2f;
                                            normal       = 15.6f;
                                            sobrepeso    = 17.2f;
                                            obesidad     = 19.3f;
                                        }
                                        break;

                                    case 8: //8 años
                                        if (meses < 6)
                                        {
                                            desnutricion = 13.3f;
                                            normal       = 15.7f;
                                            sobrepeso    = 17.4f;
                                            obesidad     = 19.7f;
                                        }
                                        else
                                        {
                                            desnutricion = 13.4f;
                                            normal       = 15.9f;
                                            sobrepeso    = 17.7f;
                                            obesidad     = 20.1f;
                                        }
                                        break;

                                    case 9: //9 años
                                        if (meses < 6)
                                        {
                                            desnutricion = 13.5f;
                                            normal       = 16.0f;
                                            sobrepeso    = 17.9f;
                                            obesidad     = 20.5f;
                                        }
                                        else
                                        {
                                            desnutricion = 13.6f;
                                            normal       = 16.2f;
                                            sobrepeso    = 18.2f;
                                            obesidad     = 20.9f;
                                        }
                                        break;
                                    default:
                                        break;
                                }
                            }
                            

                        }
                            
                        
                        
                        
                        if (resultadoIMC<desnutricion)
                            texto = texto + " Bajo peso";
                        else if (resultadoIMC >= desnutricion && resultadoIMC <= sobrepeso)
                            texto = texto + " Peso normal";
                        else if (resultadoIMC > sobrepeso && resultadoIMC <= obesidad)
                            texto = texto + " Sobrepeso";
                        else if (obesidad > 29.9)
                            texto = texto + " Obesidad";
                        
                        DecimalFormat df = new DecimalFormat("0.00");
                        resultadoDecimalImc = String.valueOf(df.format(resultadoIMC));

                        enviarDatosNino.putString("saludTextoNino",texto);
                        enviarDatosNino.putString("imcResulatadoNino",resultadoDecimalImc);

                        Navigation.findNavController(view).navigate(R.id.action_calcularNino_to_resultadoNino, enviarDatosNino);
                    }
                }

            }
        });
        return view;
    }

}