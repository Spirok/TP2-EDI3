package com.me.WebApp.Modelo;

import com.me.WebApp.Conexion.ConexionPsql;
import com.me.WebApp.ServerJ.JettyServer;

import javax.servlet.http.HttpSession;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

/**
 * Created by Spirok on 5/9/2015.
 * Clase base del proyecto la cual contiene metodos que cumplen la funcion de 'comandos', utilizando Reflection.
 */
public class ClaseComando {

    private HttpSession sesion;
    private static final JettyServer servidor = JettyServer.getInstance();
    private static final ConexionPsql conexion = ConexionPsql.getInstance();

    private void setSesion(HttpSession sesion) { this.sesion = sesion; }

    // Constructor
    public ClaseComando(HttpSession sesion) {
        setSesion(sesion);
    }

    private String msjNoConectado() {
        return "No esta conectado!";
    }

    private String msjIdIncorrecta() {
        return "Id incorrecta";
    }
    private boolean estadoSesion() {
        return (sesion.getAttribute("ID") !=  null);
    }

    private boolean idOK(int id) {
        return (id == (int)sesion.getAttribute("ID"));
    }

    public String conectar() {
        // si no esta conectado
        if  (!estadoSesion()) {
            // obtengo id manejada por el servidor
            int numId = JettyServer.genId();
            // seteo id en variables de sesion
            sesion.setAttribute("ID", numId);
            // agrego nuevo cliente en el servidor
            servidor.agregarCliente(new Cliente(numId, sesion.getAttribute("IP").toString()));
            return "Comando conectar OK";
        }  else {
            return "Ya esta conectado!";
        }
    }

    public String estadoServidor(int idCli) {
        // si no esta conecto o la id es incorrecta
        if (!estadoSesion())
            return msjNoConectado();
        if (!idOK(idCli))
            return msjIdIncorrecta();
        return "ACTIVO";
    }

    public String fechaServidor(int idCli) {
        if (!estadoSesion())
            return msjNoConectado();
        if (!idOK(idCli))
            return msjIdIncorrecta();
        return new Date().toString();
    }

    public String nroSolicitud(int idCli) {
        int ultimoId;
        ResultSet r;
        if (!estadoSesion())
            return msjNoConectado();
        if (!idOK(idCli))
            return msjIdIncorrecta();
        // inserto solicitud con estado default ('iniciada')
        if (!conexion.ejecutarQuery("INSERT INTO solicitudes (id_estado) values (default);"))
            return "Error!";
        // obtengo el id del insert
        r = conexion.ejecutarConsulta("SELECT currval('solicitudes_id_seq');");
        try {
            r.next();
            ultimoId = r.getInt("currval");
        } catch (SQLException sqle) {
            ultimoId = -1;
            conexion.showSQLException(sqle);
        }
        return "Numero solicitud : " + String.valueOf(ultimoId);

    }

    public String cambiarEstadoSolicitud(int idCli, int nroSol, String estadoNuevo) {
        ResultSet r;
        int idEstado;
        if (!estadoSesion())
            return msjNoConectado();
        if (!idOK(idCli))
            return msjIdIncorrecta();
        // chequeo que el estado ingresado por el cliente sea valido
        r = conexion.ejecutarConsulta("SELECT id FROM estados WHERE descripcion = '" + estadoNuevo + "'");
        try {
            if ( !r.next() )
                return "ERROR ( Estado : "+ estadoNuevo + " no contemplado por el servidor)";
            // estado valido, obtengo el id de la descripcion del estado
            idEstado = r.getInt("id");
            // realizo el update
            if (!conexion.ejecutarQuery("UPDATE solicitudes SET id_estado = " + idEstado +" WHERE id = " + nroSol ))
                return "Error!";
            // update ok
            return "OK";
        } catch (SQLException sqle) {
            conexion.showSQLException(sqle);
            return "Error";
        }
    }

    public String consultarEstadoSolicitud(int idCli, int nroSol) {
        ResultSet r;
        String estadoActual = null;
        if (!estadoSesion())
            return msjNoConectado();
        if (!idOK(idCli))
            return msjIdIncorrecta();
        r = conexion.ejecutarConsulta("SELECT e.descripcion " +
                                        "FROM solicitudes s " +
                                        "INNER JOIN estados e ON e.id = s.id_estado " +
                                        "WHERE s.id = " + nroSol);
        try {
            if (r.next())
                estadoActual = r.getString("descripcion");
            else
                estadoActual = "Solicitud inexistente";
        } catch (SQLException e) {
            conexion.showSQLException(e);
        }
        return estadoActual;
    }

    public String desconectar(int idCli) {
        if (!estadoSesion())
            return msjNoConectado();
        if (!idOK(idCli))
            return msjIdIncorrecta();
        sesion.invalidate();
        servidor.eliminarCliente(idCli);
        return "Sesion Cerrada (id : "+ idCli + ")";
    }

}
