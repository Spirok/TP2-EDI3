package com.me.WebApp.Modelo;

/**
 * Created by Spirok on 8/9/2015.
 * Clase que representa un cliente.
 */
public class Cliente {

    private int Id;
    private String Ip;

    public Cliente(int id, String ip) {
        setId(id);
        setIp(ip);
    }

    public int getId() {
        return Id;
    }

    public void setId(int id) {
        Id = id;
    }

    public String getIp() {
        return Ip;
    }

    public void setIp(String ip) {
        Ip = ip;
    }

    public String toString() {
        return "ID : "+ getId() + "  IP : " + getIp()+ "\n";
    }
}
