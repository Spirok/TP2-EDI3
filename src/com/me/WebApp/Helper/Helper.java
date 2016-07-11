package com.me.WebApp.Helper;

import org.jdatepicker.impl.JDatePanelImpl;
import org.jdatepicker.impl.JDatePickerImpl;
import org.jdatepicker.impl.UtilDateModel;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.reflect.Method;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;
import java.util.StringTokenizer;

/**
 * Created by spirok on 01/09/15.
 * Clase de utileria.
 */
public class Helper {

    private static final BufferedReader entrada = new BufferedReader(new InputStreamReader(System.in));

    /**
     * Metodo generico para entrada por teclado por consola.
     */
    public static String entradaTerminal(String msj) {
        String input;
        try {
            System.out.printf(msj);
            input = entrada.readLine();
        } catch (IOException ioe) {
            input ="";
        }
        return input;
    }

    /**
     * Metodo que recibe un Date y lo retorna en String con formato AAAA/MMDD.
     * 15/09/15
     */
    public static String dateToString(Date dia) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(dia);
        int year  = cal.get(Calendar.YEAR);
        int month = cal.get(Calendar.MONTH);
        month++;
        int day = cal.get(Calendar.DAY_OF_MONTH);
        return year + "/" + month + "/" + day;
    }

    /**
     * Metodo que retorna un Widget JDatePicker
     * 15/09/15
     */
    public static JDatePickerImpl createJdatePicker() {
        UtilDateModel model = new UtilDateModel();
        Properties p = new Properties();
        p.put("text.today", "Today");
        p.put("text.month", "Month");
        p.put("text.year", "Year");
        JDatePanelImpl datePanel = new JDatePanelImpl(model, p);
        return  new JDatePickerImpl(datePanel, new DateLabelFormatter());
    }

    /**
     * Metodo que recibe un StringTokenizer representando un conjunto de strings separados por algun delimitador
     * y un array de tipo Class que indica tipos de datos(int,String, etc). Se recorre el StringTokenizer cargando un array
     * de Object con los valores de cada token dependiendo del tipo de dato especificado para cada posicion.
     * El arreglo 'tipoParametros' hace referencia al conjunto de tipos de datos de un metodo de una clase.
     * MEJORAR/REFEDINIR este metodo
     */
    public static Object[] tokenToTypes(StringTokenizer tokenParam, Class[] tipoParametros) {
        int i = 0;
        Object[] parametrosMetodo =  new Object[tokenParam.countTokens()];
        while(tokenParam.hasMoreTokens()) {
            String p = tokenParam.nextToken();
            //System.out.println(tipoParametros[i].getSimpleName());
            if (tipoParametros[i].getSimpleName().equals("double")) {
                parametrosMetodo[i] = Double.valueOf(p);
            }
            else if (tipoParametros[i].getSimpleName().equals("int")) {
                parametrosMetodo[i] = Integer.parseInt(p);
            } else parametrosMetodo[i] = p;
            i++;
        }
        return parametrosMetodo;
    }

    /**
     * Metodo que recibe una clase (Class) y el nombre de un metodo y retorna un arreglo con los tipos de parametros de dicho
     * metodo de dicha clase si es que existe el metodo.
     */
    public static Class[] getTipoParametros(Class clase, String nombreMetodo)
            throws ClassNotFoundException {
        Class[] tipos = null;
        for (Method m : clase.getDeclaredMethods()) {
            if (!m.getName().equals(nombreMetodo)) continue;
            /*
            System.out.println("metodo :" + m.getName());
            for (Class tipo : m.getParameterTypes()) {
                System.out.println("\tParameterType : " + tipo.getSimpleName());
            }
            */
            tipos = m.getParameterTypes();
        }
        return tipos;
    }



}
