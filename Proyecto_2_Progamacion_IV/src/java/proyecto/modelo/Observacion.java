package proyecto.modelo;

/**
 *
 * @author Pablo
 */
import java.io.Serializable;

public class Observacion implements Serializable, Jsonable{
    int codigo;
    String fecha;
    String observacion;

    public Observacion() {
        this(0,"","");
    }
    
    public Observacion(int cod,String fec,String obs) {
        this.codigo = cod;
        this.fecha = fec;
        this.observacion = obs;
    }
    
    public int getCodigo() {
        return codigo;
    }
    
    public String getFecha() {
        return fecha;
    }
    
    public String getObservacion() {
        return observacion;
    }
    
    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }
    
    public void setFecha(String fecha) {
        this.fecha = fecha;
    }
    
    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }
}
