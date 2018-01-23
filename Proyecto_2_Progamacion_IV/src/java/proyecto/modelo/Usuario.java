package proyecto.modelo;

import java.io.Serializable;

public class Usuario implements Serializable, Jsonable{
    String id;
    String clave;
    int tipo;
    
    public Usuario(String id, String clave, int tipo) {
        this.id = id;
        this.clave = clave;
        this.tipo = tipo;
    }

    public Usuario() {
    }
    
    public int getTipo(){
        return tipo;
    }

    public String getId() {
        return id;
    }

    public String getClave() {
        return clave;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
    }
}
