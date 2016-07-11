package com.me.WebApp.ServerJ;

import com.me.WebApp.Conexion.ConexionPsql;
import com.me.WebApp.Helper.Helper;
import com.me.WebApp.Modelo.Cliente;
import com.me.WebApp.Servlets.ServletComandos;
import com.me.WebApp.Servlets.ServletIdCliente;
import org.eclipse.jetty.server.*;
import org.eclipse.jetty.server.handler.*;
import org.eclipse.jetty.servlet.*;
import org.eclipse.jetty.util.component.AbstractLifeCycle;
import org.jdatepicker.impl.JDatePickerImpl;

import javax.servlet.*;
import javax.servlet.http.HttpServletResponse;
import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.awt.event.*;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;

/**
 * Servidor Jetty embebido.
 */
public class JettyServer {

    public static void main(String[] args) throws Exception {
        JettyServer servidor = JettyServer.getInstance();
        /*
        String cad;
        do {
            cad = Helper.entradaTerminal("\nIngrese 'salir' para cerrar el servidor : ");
        } while (!cad.toUpperCase().equals("SALIR"));

        servidor.doStop();
        */
    }

    // Singleton
    private static final JettyServer ser = new JettyServer();
    public static JettyServer getInstance() { return ser; }

    private Server server;
    private ServerConnector http;

    private ConexionPsql conexion;

    private JFrame frame;
    private ServerGUI gui;
    private JRadioButton btnOff;
    private JTextField txtHost;
    private JTextField txtPort;

    private JDatePickerImpl fechaUno;
    private JDatePickerImpl fechaDos;

    DefaultTableModel modeloTabla;
    DefaultTableModel modeloTablaCli;

    // mapa que contiene id -> cliente
    private final HashMap<Integer, Cliente> mapaClientes = new HashMap<>();

    // arreglar esta porqueria
    private static int id = 0;
    public synchronized static int genId() { return ++id; }
    private void reiniciarId() { id = 0; }

    private JettyServer() {
        System.out.println("Configurando server Jetty...");
        server = new Server();
        http   = new ServerConnector(server);

        http.setIdleTimeout(30000);
        server.addConnector(http);

        // resource handle, para manejo de contenido html estatico
        ResourceHandler resource_handler = new ResourceHandler();
        resource_handler.setDirectoriesListed(true);

        resource_handler.setWelcomeFiles(new String[]{"index.html"});
        resource_handler.setResourceBase("./src/com/me/WebApp");

        ServletContextHandler context = new ServletContextHandler(ServletContextHandler.SESSIONS);
        context.setResourceBase("./WebApp/Servlets"); // seteando path donde se encuentran los servlets
        context.setClassLoader(Thread.currentThread().getContextClassLoader());

        // asocio servlets - uri
        context.addServlet(ServletComandos.class, "/ServletComandos");
        context.addServlet(ServletIdCliente.class, "/ServletIdCliente");

        // asocio lista de handlers al servidor (file server + servlets)
        HandlerList handlers = new HandlerList();
        handlers.setHandlers(new Handler[]{context, resource_handler, new DefaultHandler()});
        server.setHandler(handlers);

        // creo/obtengo conexion
        conexion = ConexionPsql.getInstance();

        // inicio gui
        initGUI();
    }

    private void initGUI() {
        // cambiando la apariencia de swing
        try {
            //UIManager.setLookAndFeel("com.sun.java.swing.plaf.nimbus.NimbusLookAndFeel");
            UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
            UIManager.put("Table.alternateRowColor", Color.CYAN);
            //UIManager.setLookAndFeel("javax.swing.plaf.metal.MetalLookAndFeel");
            //UIManager.setLookAndFeel("com.sun.java.swing.plaf.gtk.GTKLookAndFeel");
            System.out.println("L&F set OK");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        // creando ventana y seteando jpanel
        frame = new JFrame("ServerGUI");
        gui   = new ServerGUI();
        frame.setContentPane(gui.panel1);
        frame.setVisible(true);

        // obteniendo widgets
        JRadioButton btnOn = gui.ONRadioButton;
        btnOff   = gui.OFFRadioButton;
        txtHost  = gui.txtHost;
        txtPort  = gui.txtPort;
        JButton btnGenerarInfo = gui.btnGenerarInfo;

        JPanel panelTablaActividad = gui.panelTablaActividad;
        JPanel panelTablaClientes = gui.panelTablaClientes;

        // creando jtable de actividades
        Object[][] data = {};
        String[] nombreColumnas = {"Id Cliente", "Comando", "Salida"};
        modeloTabla = new DefaultTableModel(data, nombreColumnas) {
            @Override
            public boolean isCellEditable(int row, int column) {
                return false;
            }
        };
        JTable tabla = new JTable(modeloTabla);
        JScrollPane scroll = new JScrollPane(tabla);
        panelTablaActividad.add("Center", scroll);

        // creando jtable de clientes
        Object[][] dataCli = {};
        String[] nombreColumnasCli = {"Id Cliente", "IP"};
        modeloTablaCli = new DefaultTableModel(dataCli, nombreColumnasCli) {
            @Override
            public boolean isCellEditable(int row, int column) {
                return false;
            }
        };
        JTable tablaCli = new JTable(modeloTablaCli);
        JScrollPane scrollCli = new JScrollPane(tablaCli);
        panelTablaClientes.add("Center", scrollCli);

        fechaUno = Helper.createJdatePicker();
        fechaDos = Helper.createJdatePicker();

        gui.JPfechaUno.add(fechaUno);
        gui.JPfechaDos.add(fechaDos);

        frame.pack();
        frame.setLocationRelativeTo(null);

        // ---------estableciendo eventos de gui ----------------------

        // evento click btn generar informe de actividades entre un rago de fechas
        btnGenerarInfo.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                // obtengo las fechas seleccionadas
                Date diaFechaUno = (Date) fechaUno.getModel().getValue();
                Date diaFechaDos = (Date) fechaDos.getModel().getValue();
                // realizo informe
                InformeActividades informe = new InformeActividades(frame, diaFechaUno, diaFechaDos);
                informe.generarInforme();

            }
        });

        // evento click btn limpiar tabla peticiones
        gui.btnLimpiarPeticiones.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if (conexion.ejecutarQuery("DELETE FROM peticiones") &&
                conexion.ejecutarQuery("ALTER SEQUENCE peticiones_id_seq RESTART 1") )
                    JOptionPane.showMessageDialog(frame, "Limpieza peticiones OK");
            }
        });

        // evento click btn limpiar tabla solicitudes
        gui.btnLimpiarSolicitudes.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if (conexion.ejecutarQuery("DELETE FROM solicitudes") &&
                        conexion.ejecutarQuery("ALTER SEQUENCE solicitudes_id_seq RESTART 1") )
                    JOptionPane.showMessageDialog(frame, "Limpieza solicitudes OK");
            }
        });

        // evento click radio btn iniciar servidor
        btnOn.addItemListener(new ItemListener() {
            @Override
            public void itemStateChanged(ItemEvent e) {
                if (e.getStateChange() == ItemEvent.SELECTED) {
                    try {
                        // seteando host y puerto al servidor
                        http.setHost(txtHost.getText());
                        http.setPort(Integer.parseInt(txtPort.getText()));
                        // iniciar el servidor
                        doStart();
                        // si el servidor no se inicio correctamente
                        if (server.getState().equals(AbstractLifeCycle.FAILED)) {
                            JOptionPane.showMessageDialog(frame, "Error al iniciar el servidor!");
                            btnOff.setSelected(true);
                            gui.estadoWidgets(true);
                            server.stop();
                        }
                        if (server.getState().equals(AbstractLifeCycle.STARTED)) {
                            // servidor inicio ok
                            gui.estadoWidgets(false);
                        }
                    } catch (Exception ex) {
                        JOptionPane.showMessageDialog(frame, ex.getMessage());
                        btnOff.setSelected(true);
                    }
                }
            }
        });

        // evento click radio btn apagar servidor
        btnOff.addItemListener(new ItemListener() {
            @Override
            public void itemStateChanged(ItemEvent e) {
                if (e.getStateChange() == ItemEvent.SELECTED) {
                    doStop();
                    reiniciarListaClientes();
                    gui.estadoWidgets(true);
                    //gui.limpiarTxtArea();
                }
            }
        });

        // evento cierra ventana
        frame.addWindowListener(new WindowAdapter() {
            @Override
            public void windowClosing(WindowEvent e) {
                doStop();
                conexion.cerrarConexion();
                System.exit(0);
            }
        });

        // ----------------------------------------------------------------
    }

    /**
     * Metodo que inicia el server
     */
    private boolean doStart() {
        if (server.isRunning()) return false;
        try {
            server.start();
            System.out.println("Servidor Started! version " + Server.getVersion() + " en puerto " + http.getPort());
            return true;
        } catch(Exception ex) {
            System.err.println("Error Starting Server ..."+ex.getMessage());
        }
        return false;
    }

    /**
     * Metodo que finaliza el server
     */
    private boolean doStop() {
        if (server.isStopped()) return false;
        try {
            server.stop();
            System.out.println("Servidor Stopped!");
            return true;
        } catch(Exception ex) {
            System.err.println("Error Stopping Server ..."+ex.getMessage());
        }
        return false;
    }

    /**
     * Metodo que agrega un cliente al mapaClientes, luego se actualiza jtable clientes.
     */
    public void agregarCliente(Cliente cli) {
        mapaClientes.put(cli.getId(), cli);
        modeloTablaCli.addRow(new Object[]{cli.getId(), cli.getIp()});
    }

    /**
     * Metodo que elimina un cliente del mapaClientes, luego se actualiza jtable clientes.
     */
    public void eliminarCliente(int id) {
        mapaClientes.remove(id);
        actualizarViewCli();
    }

    public void agregarTxtActividad(Object[] data) {
        modeloTabla.addRow(data);
    }

    // reinicio el id, limpio el mapa de clientes y la jtable clientes
    private void reiniciarListaClientes() {
        reiniciarId();
        mapaClientes.clear();
        limpiarTablaClientes();
    }

    private void limpiarTablaClientes() {
        for (int i = modeloTablaCli.getRowCount() - 1; i >= 0; i--) {
            modeloTablaCli.removeRow(i);
        }
    }

    /**
     * Metodo que actualiza el contenido de la jtable la cual muestra una lista con los clientes conectados.
     */
    private void actualizarViewCli() {
        limpiarTablaClientes();
        for (Cliente cli : mapaClientes.values()) {
            modeloTablaCli.addRow(new Object[]{cli.getId(), cli.getIp()});
        }
    }

}