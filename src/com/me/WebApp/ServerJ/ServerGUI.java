package com.me.WebApp.ServerJ;



import javax.swing.*;


/**
 * Created by Spirok on 8/9/2015.
 */
public class ServerGUI {
    protected JPanel panel1;
    protected JButton btnGenerarInfo;
    protected JRadioButton ONRadioButton;
    protected JRadioButton OFFRadioButton;
    protected JTextField txtHost;
    protected JTextField txtPort;
    protected JPanel JPfechaUno;
    protected JPanel JPfechaDos;
    protected JButton btnLimpiarSolicitudes;
    protected JButton btnLimpiarPeticiones;
    protected JPanel panelTablaActividad;
    protected JPanel panelTablaClientes;

    public void estadoWidgets(boolean estado) {
        txtHost.setEnabled(estado);
        txtPort.setEnabled(estado);
    }

}
