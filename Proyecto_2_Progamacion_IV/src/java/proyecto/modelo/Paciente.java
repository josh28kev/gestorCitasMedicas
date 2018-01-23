package proyecto.modelo;

import java.io.Serializable;

public class Paciente implements Serializable, Jsonable{
    String cedula;
    String nombre;
    String fecha_nacimiento;
    String direccion;
    int numero_telefono;
    String correo;

    public Paciente(){
    this("","","","",-1,"");
    }
    
    public Paciente(String cedula, String nombre, String fecha_nacimiento, String direccion, int numero_telefono, String correo) {
        this.cedula = cedula;
        this.nombre = nombre;
        this.fecha_nacimiento = fecha_nacimiento;
        this.direccion = direccion;
        this.numero_telefono = numero_telefono;
        this.correo = correo;
    }

    public String getCedula() {
        return cedula;
    }

    public void setCedula(String cedula) {
        this.cedula = cedula;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getFecha_nacimiento() {
        return fecha_nacimiento;
    }

    public void setFecha_nacimiento(String fecha_nacimiento) {
        this.fecha_nacimiento = fecha_nacimiento;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public int getNumero_telefono() {
        return numero_telefono;
    }

    public void setNumero_telefono(int numero_telefono) {
        this.numero_telefono = numero_telefono;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }
    
    
}
