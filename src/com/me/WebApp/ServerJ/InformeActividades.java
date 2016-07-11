package com.me.WebApp.ServerJ;

import com.me.WebApp.Conexion.ConexionPsql;
import com.me.WebApp.Helper.Helper;

import javax.swing.*;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

/**
 * Created by Spirok on 17/9/2015.
 * Clase encargada de generar un informe .txt con todas las actividades del servicio entre un rango de fechas.
 */
public class InformeActividades {

    private Date fechaUno;
    private Date fechaDos;
    private static final ConexionPsql conexion = ConexionPsql.getInstance();
    private JFrame framePadre;

    // Constructor
    public InformeActividades(JFrame ventana, Date fechaUno, Date fechaDos) {
        setFechaUno(fechaUno);
        setFechaDos(fechaDos);
        this.framePadre = ventana;
    }

    // Getters
    public Date getFechaUno() { return fechaUno; }
    public Date getFechaDos() { return fechaDos; }

    // Setters
    private void setFechaUno(Date fecha) { this.fechaUno = fecha; }
    private void setFechaDos(Date fecha) { this.fechaDos = fecha; }

    // Customs

    private boolean fechasOk() {
        if (getFechaUno() == null || getFechaDos() == null) {
            JOptionPane.showMessageDialog(this.framePadre, "Especifique los dias.");
            return false;
        }
        // si la segunda fecha es menor a la primera error
        if (getFechaDos().compareTo(getFechaUno()) != 1) {
            JOptionPane.showMessageDialog(this.framePadre, "La segunda fecha DEBE ser mayor o igual que la primera.");
            return false;
        }
        return true;
    }

    public void generarInforme() {
        String fechaUnoStr;
        String fechaDosStr;
        String query;
        ResultSet r;
        JFileChooser chooser;
        StringBuilder contenido;
        FileWriter fw ;
        BufferedWriter bw;
        // valido las fechas
        if (!fechasOk()) return;
        
        // convierto date a string AAAA/MM/DD
        fechaUnoStr = Helper.dateToString(getFechaUno());
        fechaDosStr = Helper.dateToString(getFechaDos());
        query = "SELECT comando, id_cliente, respuesta, fecha " +
                "FROM peticiones " +
                "WHERE fecha BETWEEN '" + fechaUnoStr + " 00:00:00' AND '" + fechaDosStr + " 24:00:00'";
        // realizando consulta
        r = conexion.ejecutarConsulta(query);
        contenido = new StringBuilder();

        try {
            while (r.next()) {
                contenido.append(r.getString("comando").trim() + " " +
                        r.getString("id_cliente").trim() + " " +
                        r.getString("respuesta").trim() + " " +
                        r.getTimestamp("fecha") + "\n");
                        /*System.out.printf(r.getString("comando").trim() + " " +
                                r.getString("id_cliente").trim() + " " +
                                r.getString("respuesta").trim() + " " +
                                r.getDate("fecha") + "\n");*/
            }
            // mostrando ventana donde se selecciona la ruta a guardar el txt
            chooser = new JFileChooser();
            chooser.setFileSelectionMode(JFileChooser.FILES_ONLY);
            chooser.setSelectedFile(new File("informe.txt"));
            int returnVal = chooser.showSaveDialog(this.framePadre);
            if (returnVal == JFileChooser.APPROVE_OPTION) {
                File fileToSave = chooser.getSelectedFile();
                try {
                    // generando archivo con el informe
                    fw = new FileWriter(fileToSave.getAbsolutePath());
                    bw = new BufferedWriter(fw);
                    bw.write(contenido.toString());
                    bw.close();
                    JOptionPane.showMessageDialog(this.framePadre, "Informe generado correctamente.");
                } catch (IOException ioe) {
                    ioe.printStackTrace();
                    JOptionPane.showMessageDialog(this.framePadre, "Error!");
                }
            }
        } catch (SQLException sqle) {
            conexion.showSQLException(sqle);
        }
    }

}
