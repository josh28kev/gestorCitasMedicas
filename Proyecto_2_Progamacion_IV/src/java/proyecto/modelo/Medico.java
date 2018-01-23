package proyecto.modelo;

import java.io.Serializable;

public class Medico implements Serializable, Jsonable{
    String codigo;
    int cedula;
    String nombre;
    int telefono;
    String email;

   public Medico(){
       this("",-1,"",-1,"");
   }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

     public void setNombre(String nombre) {
        this.nombre = nombre;
    }
     
    public int getTelefono() {
        return telefono;
    }

    public void setTelefono(int telefono) {
        this.telefono = telefono;
    }
    
    public int getCedula() {
        return cedula;
    }

    public void setCedula(int cedula) {
        this.cedula = cedula;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

   
   public Medico(String codigo,int cedula, String nombre, int telefono, String email){
        this.codigo=codigo;
        this.cedula = cedula;
        this.nombre=nombre;
        this.telefono=telefono;
        this.email=email;
   }

    public String getNombre() {
        return nombre;
    }
}
