package com.me.WebApp.Servlets;

import com.me.WebApp.Conexion.ConexionPsql;
import com.me.WebApp.Helper.Helper;
import com.me.WebApp.ServerJ.JettyServer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Constructor;
import java.lang.reflect.Method;
import java.util.StringTokenizer;

/**
 * Created by spirok on 03/09/15.
 * Servlet que recibe del cliente un comando y un conjunto de parametros separador por ','. A partir de dichos datos se utiliza
 * Reflection y se delega el trabajo a 'ClaseComando' la cual contiene metodos como conectar, desconectar, estadoServidor,
 * etc con sus respectivos parametros, invocando estos segun sea 'comando'. Si el comando es incorrecto (el metodo no existe)
 * o los parametros sean invalidos se le informa al cliente.
 */
public class ServletComandos extends HttpServlet {

    private ConexionPsql conexion;
    private JettyServer server;

    @Override
    public void init() throws ServletException {
        super.init();
        // cuando se carga el servlet obtengo conexion y server
        conexion = ConexionPsql.getInstance();
        server   = JettyServer.getInstance();
    }

    @Override
    protected void doPost(HttpServletRequest peticion, HttpServletResponse respuesta)
            throws ServletException, IOException {

        String comando     = peticion.getParameter("comando");
        String parametros  = peticion.getParameter("parametros");
        PrintWriter out    = respuesta.getWriter();
        HttpSession sesion = peticion.getSession();
        String salida      = "";

        // ------------------------------------------------------------
        respuesta.addHeader("Access-Control-Allow-Origin", "*");
        // ------------------------------------------------------------

        Object objClase;
        Object parametrosMetodo[] = null;
        Class clase;
        Class tipoParametros[];
        Method metodo;
        StringTokenizer tokenParam;
        Object objReturn;
        String id;

        try {
            // seteo atributo a la sesion
            if (sesion.getAttribute("IP") == null) sesion.setAttribute("IP", peticion.getRemoteAddr());

            // cargando clase 'ClaseComando'
            clase = Class.forName("com.me.WebApp.Modelo.ClaseComando");
            // obteniendo los tipos de cada parametro del metodo de nombre 'comando' (el ingresado por el cliente)
            tipoParametros = Helper.getTipoParametros(clase, comando);

            // obteniendo el constructor que recibe parametro httpsesion
            Constructor constructor = clase.getConstructor(HttpSession.class);
            // instanciando con el constructor anterior
            objClase = constructor.newInstance(sesion);

            // obteniendo metodo de nombre 'comando' con firma de parametros 'tipoParametros'
            metodo = objClase.getClass().getMethod(comando, tipoParametros);
            // token de los parametros ingresados por el cliente
            tokenParam = new StringTokenizer(parametros, ",");
            // si la cantidad de parametros ingresados no coinciden con la cantidad del metodo
            if (tokenParam.countTokens() != metodo.getParameterTypes().length) {
                salida = "cantidad de parametros incorrectos!";
            }
            // si el metodo recibe parametros seteo los valores
            if (metodo.getParameterTypes().length > 0) {
                parametrosMetodo = Helper.tokenToTypes(tokenParam, tipoParametros);
            }

            if (metodo.getReturnType().toString().equals("void")) {
                // invoco metodo que retorna void
                metodo.invoke(objClase, parametrosMetodo);
            } else {
                // invoco metodo y obtengo lo que retorna
                objReturn = metodo.invoke(objClase, parametrosMetodo);
                salida = objReturn.toString();
            }
        } catch (ClassNotFoundException cnfe) {
            System.out.println("no se encontro la clase : " + cnfe.getMessage());
        } catch (NoSuchMethodException nsme) {
            System.out.println("no se encontro el metodo " + nsme.getMessage());
            salida =  comando + " comando desconocido";
        } catch(IllegalArgumentException iae) {
            salida = "Parametro/s incorrecto/s";
        } catch (Exception e) {
            //System.out.println(e.getMessage());
        }

        // id es seteada en el metodo conectar
        try {
            id = sesion.getAttribute("ID").toString();
        } catch (IllegalStateException ise) {
            id = "";
        }
        catch (NullPointerException npe) {
            id = "";
        }

        // insertando log de peticion
        String query = "INSERT INTO peticiones (comando, id_cliente, respuesta, fecha) values ('" +
                        comando + "', '" +
                        id      + "', '" +
                        salida  + "',  " +
                        "now()" + ")";
        conexion.ejecutarQuery(query);

        // agregando log de peticion en jtable
        server.agregarTxtActividad(new Object[]{id, comando, salida});

        // imprimiendo salida al cliente
        out.println(salida);
    }
}
