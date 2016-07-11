package com.me.WebApp.Servlets;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by spirok on 03/09/15.
 * Servlet que le informa su ID al cliente.
 * En construccion...
 */
public class ServletIdCliente extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest peticion, HttpServletResponse respuesta)
            throws ServletException, IOException {

        HttpSession sesion = peticion.getSession();
        PrintWriter out    = respuesta.getWriter();

        String salida = (sesion.getAttribute("ID") == null ? "" : "ID Cliente : " + sesion.getAttribute("ID") );

        out.write(salida);
        out.close();
    }
}
