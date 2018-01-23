package proyecto.modelo;

import java.io.Serializable;
import java.sql.Date;

public class Cita implements Serializable, Jsonable{
 String medico;
 int paciente;
 Date fecha;
 String hora;
 String descripcion;
 int codigo_cita;

    public Cita(String medico,int paciente,Date fecha,String hora,String descripcion,int codigo_cita) {
        this.medico = medico;
        this.paciente = paciente;
        this.fecha = fecha;
        this.hora = hora;
        this.descripcion = descripcion;
        this.codigo_cita = codigo_cita;
    }

    public Cita() {
        this.medico = "";
        this.paciente = 0;
        this.fecha = null;
        this.hora = "";
        this.descripcion = "";
        this.codigo_cita = 0;
    }

    public String getMedico() {
        return medico;
    }

    public void setMedico(String medico) {
        this.medico = medico;
    }

    public int getPaciente() {
        return paciente;
    }

    public void setPaciente(int paciente) {
        this.paciente = paciente;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getHora() {
        return hora;
    }

    public void setHora(String hora) {
        this.hora = hora;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getCodigoCita() {
        return codigo_cita;
    }

    public void setCodigoCita(int codigo_cita) {
        this.codigo_cita = codigo_cita;
    }
}
