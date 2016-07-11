package com.me.WebApp.Conexion;

import java.sql.*;

/**
 * Created by Spirok on 10/9/2015.
 * Clase Singleton de conexion a postgres
 */
public class ConexionPsql {

    // Singleton
    private static final ConexionPsql conPsql = new ConexionPsql();

    private Connection con;

    // constructor privado, no se puede realizar new ConexionPsql
    private ConexionPsql() {
        if (!setConexion())
            System.exit(0);
    }

    // metodo estatico que retorna la unica instancia de la clase
    public static ConexionPsql getInstance() {
        return conPsql;
    }

    /*
     * Metodo que setea conexion a postgres. Retorna true si esta ok, false caso contrario.
     * A futuro implementar una parametrizacion de la url de la base, usuario, pssw, etc.
    */
    private boolean setConexion() {
        try {
            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/TP2_EDI3", "postgres", "masterkey");
            System.out.println("Conexion postgres establecida");
            con.setAutoCommit(true);
            //System.out.println("Auto-commit is disabled.");
            return true;
        } catch (SQLException sqe) {
            showSQLException(sqe);
            return false;
        } catch (ClassNotFoundException cnfe) {
            //showSQLException(cnfe);
            return false;
        }
    }

    /**
     * Metodo que ejecuta una query de accion y retorna true si fue ok, false caso contrario.
     */
    public boolean ejecutarQuery(String query) {
        Statement s;
        boolean ret = true;
        try {
            // creo statement
            s = con.createStatement();
            // creo resultset
            s.executeUpdate(query);
            //con.commit(); //commit seteado auto.
            //System.out.println(query);
        } catch(SQLException e) {
            //System.out.println ("Error al hacer query sobre la base de datos.");
            showSQLException(e);
            ret=false;
        }
        return ret;
    }

    /**
     * Metodo que ejecuta una consulta y devuelve dichos datos en un ResultSet
     */
    public ResultSet ejecutarConsulta(String query) {
        Statement s;
        ResultSet rs = null;
        try {
            // creo statement
            s = con.createStatement();
            // creo resultset
            rs = s.executeQuery(query);
        } catch (SQLException e) {
            //System.out.println ("Error al hacer query sobre la base de datos.");
            showSQLException(e);
        }
        return rs;
    }


    /**
     * Metodo que imprime errores sqlEx.
     */
    public void showSQLException(SQLException e) {
        SQLException next = e;
        while (next != null) {
            System.out.println(next.getMessage());
            System.out.println("Error Code: " + next.getErrorCode());
            System.out.println("SQL State: " + next.getSQLState());
            next = next.getNextException();
        }
    }

    /**
     * Metodo que cierra la conexion con la base de datos
     */
    public void cerrarConexion() {
        if (con == null) return;
        try {
            con.close();
            System.out.println("Conexion postgres cerrada");
        } catch (java.sql.SQLException e) {
            showSQLException(e);
        }

    }
}
