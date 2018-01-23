package proyecto.modelo;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import proyecto.bd.BD;

/**
 *
 * @author Estudiante
 */
public class Modelo {

    static BD clinica;

    static {
        initProductos();
    }

    private static void initProductos() {
        clinica = new BD(null, null, null);
    }

//*--------------------------------------------------------------------------------------------------------------------
//*--------------------------------------------Usuarios----------------------------------------------------------------
//*--------------------------------------------------------------------------------------------------------------------
//Busca en la base de datos y retorna el usuario que corresponde con el recibido por parámetros 
    public static Usuario userLogin(Usuario usuario) throws Exception {
        try {
            String sql = "select * from "
                    + "Usuario  u  "
                    + "where u.id ='%s' and u.clave='%s'";
            sql = String.format(sql, usuario.getId(), usuario.getClave());

            ResultSet rs = clinica.executeQuery(sql);
            if (rs.next()) {
                return toUser(rs);
            } else {
                return new Usuario(usuario.id, usuario.clave, 0);
            }
        } catch (SQLException ex) {
        }
        return null;
    }
    
//Lee de la variable Result set los datos de un usuario leido desde la base de datos,
//y los asigna a una nueva instancia para después retornarlo.
    private static Usuario toUser(ResultSet rs) throws Exception {
        Usuario obj = new Usuario();
        obj.setId(rs.getString("id"));
        obj.setClave(rs.getString("clave"));
        obj.setTipo(Integer.parseInt(rs.getString("tipo")));
        return obj;
    }

//Guarda en la base de datos el usuario que recibe por parámetros.
    public static int agregarUsuario(Usuario us) throws Exception {
        String sql = "insert into Usuario "
                + "(id,clave,tipo) "
                + "values ('%s','%s',%d)";
        sql = String.format(sql, us.getId(),
                us.getClave(),
                us.getTipo());
        ResultSet rs = clinica.executeUpdateWithKeys(sql);
        if (rs.next()) {
            return rs.getInt(1);
        } else {
            return 0;
        }
    }
    
//Busca en la base de datos y retorna el usuario que corresponde con el recibido por parámetros
    public static Usuario getUsuario(String id) throws Exception {
        try {
            String sql = "select * from "
                    + "Usuario  u  "
                    + "where u.id = '%s'";
            sql = String.format(sql, id);

            ResultSet rs = clinica.executeQuery(sql);
            if (rs.next()) {
                return toUser(rs);
            }
        } catch (SQLException ex) {
        }
        return null;
    }
    
//Busca en la base de datos y modifica el usuario que corresponde con los datos datos recibidos por parámetros
    public static int modificarUsuario(Usuario us) throws Exception {
        String sql = "update Usuario set clave='%s'"
                + " where id='%s'";
        sql = String.format(sql, us.getClave(), us.getId());
        ResultSet rs = clinica.executeUpdateWithKeys(sql);
        if (rs.next()) {
            return rs.getInt(1);
        } else {
            return 0;
        }
    }

//*--------------------------------------------------------------------------------------------------------------------
//*--------------------------------------------Medicos-----------------------------------------------------------------
//*--------------------------------------------------------------------------------------------------------------------

//Guarda en la base de datos el medico que recibe por parámetros.
    public static int agregarMedico(Medico med) throws Exception {
        String sql = "insert into Medicos "
                + "(codigo,cedula,nombre,numero_telefono,correo) "
                + "values ('%s','%s','%s',%d,'%s')";
        sql = String.format(sql, med.getCodigo(),
                med.getCedula(),
                med.getNombre(),
                med.getTelefono(),
                med.getEmail());
        return clinica.executeUpdate(sql);
    }

 //Retorna en una lista todos los medicos almacenados en la BD
    public static List<Medico> listarTodosLosMedicos() throws Exception {
        List<Medico> medicos;
        medicos = new ArrayList();
        try {
            String sql = "select * "
                    + "from medicos";
            ResultSet rs = clinica.executeQuery(sql);
            while (rs.next()) {
                medicos.add(toMedico(rs));
            }
        } catch (SQLException ex) {
        }
        return medicos;
    }

//Busca en la base de datos y retorna el medico que corresponde con el recibido por parámetros
    public static Medico medicoGet(String id) throws Exception {
        String sql = "select * from "
                + "Medicos  c  "
                + "where c.codigo = %s";
        sql = String.format(sql, Integer.parseInt(id));
        ResultSet rs = clinica.executeQuery(sql);
        if (rs.next()) {
            return toMedico(rs);
        } else {
            throw new Exception("Medico no existe");
        }
    }

//Retorna en una lista los medicos que corresponden con el criterio que recibe por párametros,
// estos medicos son leidos desde la base de datos.
    public static List<Medico> busquedaNombreMedicos(String criterio) throws Exception {
        List<Medico> prods;
        prods = new ArrayList();
        try {
            String sql = "select * from "
                    + "medicos  p  "
                    + "where p.nombre like '%%%s%%'";
            sql = String.format(sql, criterio);

            ResultSet rs = clinica.executeQuery(sql);
            while (rs.next()) {
                prods.add(toMedico(rs));
            }
        } catch (SQLException ex) {
        }
        return prods;
    }

//Retorna en una lista los medicos que corresponden con el criterio que recibe por párametros,
// estos medicos son leidos desde la base de datos.
    public static List<Medico> busquedaCodigoMedicos(String criterio) throws Exception {
        List<Medico> prods;
        prods = new ArrayList();
        try {
            String sql = "select * from "
                    + "medicos  p  "
                    + "where p.codigo like '%%%s%%'";
            sql = String.format(sql, criterio);
            ResultSet rs = clinica.executeQuery(sql);
            while (rs.next()) {
                prods.add(toMedico(rs));
            }
        } catch (SQLException ex) {
        }
        return prods;
    }

//Busca en la base de datos y modifica el médico que corresponde con los datos datos recibidos por parámetros
    public static int modificarMedico(Medico med) throws Exception {
        String sql = "update Medicos set nombre = '%s',numero_telefono = %d, correo ='%s'"
                + "where codigo = %s ";
        sql = String.format(sql, med.getNombre(), med.getTelefono(), med.getEmail(), med.getCodigo());
        ResultSet rs = clinica.executeUpdateWithKeys(sql);
        if (rs.next()) {
            return rs.getInt(1);
        } else {
            return 0;
        }
    }
    
//Lee de la variable Result set los datos de un MEDICO leido desde la base de datos,
//y los asigna a una nueva instancia para después retornarlo.
    private static Medico toMedico(ResultSet rs) throws Exception {
        Medico obj = new Medico("", -1, "", -1, "");
        obj.setCodigo(rs.getString("codigo"));
        obj.setCedula(Integer.parseInt(rs.getString("cedula")));
        obj.setNombre(rs.getString("nombre"));
        obj.setTelefono(Integer.parseInt(rs.getString("numero_telefono")));
        obj.setEmail(rs.getString("correo"));
        return obj;
    }

//*--------------------------------------------------------------------------------------------------------------------
//*--------------------------------------------Paciente----------------------------------------------------------------
//*--------------------------------------------------------------------------------------------------------------------

//Busca en la base de datos y retorna el medico que corresponde con el recibido por parámetros
    public static Paciente pacienteGet(String id) throws Exception {
        String sql = "select * from "
                + "Pacientes  c  "
                + "where c.cedula = '%s'";
        sql = String.format(sql, id);

        ResultSet rs = clinica.executeQuery(sql);
        if (rs.next()) {
            return toPaciente(rs);
        } else {
            throw new Exception("Medico no existe");
        }
    }

//Lee de la variable Result set los datos de un paciente leido desde la base de datos,
//y los asigna a una nueva instancia para después retornarlo.
    private static Paciente toPaciente(ResultSet rs) throws Exception {
        Paciente obj = new Paciente("", "", "", "", -1, "");
        obj.setCedula(rs.getString("cedula"));
        obj.setNombre(rs.getString("nombre"));
        obj.setFecha_nacimiento(rs.getString("fecha_nacimiento"));
        obj.setDireccion(rs.getString("direccion"));
        obj.setNumero_telefono(Integer.parseInt(rs.getString("numero_telefono")));
        obj.setCorreo(rs.getString("correo"));
        return obj;
    }

//Retorna en una lista todos los pacientes almacenados en la base de datos
    public static List<Paciente> listarTodosLosPacientes() throws Exception {
        List<Paciente> medicos;
        medicos = new ArrayList();
        try {
            String sql = "select * "
                    + "from pacientes";
            ResultSet rs = clinica.executeQuery(sql);
            while (rs.next()) {
                medicos.add(toPaciente(rs));
            }
        } catch (SQLException ex) {
        }
        return medicos;
    }

//Guarda en la base de datos el paciente que recibe por parámetros.
    public static int agregarPaciente(Paciente pac) throws Exception {
        String sql = "insert into Pacientes "
                + "(cedula,nombre,fecha_nacimiento,direccion,numero_telefono,correo) "
                + "values ('%s','%s','%s','%s',%d,'%s')";
        sql = String.format(sql,
                pac.getCedula(),
                pac.getNombre(),
                pac.getFecha_nacimiento(),
                pac.getDireccion(),
                pac.getNumero_telefono(),
                pac.getCorreo());
        return clinica.executeUpdate(sql);
    }

//Retorna en una lista los pacientes que corresponden con el criterio que recibe por párametros,
// estos pacientes son leidos desde la base de datos.
    public static List<Paciente> busquedaNombrePaciente(String criterio) throws Exception {
        List<Paciente> prods;
        prods = new ArrayList();
        try {
            String sql = "select * from "
                    + "pacientes  p  "
                    + "where p.nombre like '%%%s%%'";
            sql = String.format(sql, criterio);

            ResultSet rs = clinica.executeQuery(sql);
            while (rs.next()) {
                prods.add(toPaciente(rs));
            }
        } catch (SQLException ex) {
        }
        return prods;
    }

//Retorna en una lista los pacientes que corresponden con el criterio que recibe por párametros,
// estos pacientes son leidos desde la base de datos.
    public static List<Paciente> busquedaCodigoPaciente(String criterio) throws Exception {
        List<Paciente> prods;
        prods = new ArrayList();
        try {
            String sql = "select * from "
                    + "pacientes  p  "
                    + "where p.cedula like '%%%s%%'";
            sql = String.format(sql, criterio);
            ResultSet rs = clinica.executeQuery(sql);
            while (rs.next()) {
                prods.add(toPaciente(rs));
            }
        } catch (SQLException ex) {
        }
        return prods;
    }
    
//Busca en la base de datos y modifica el paciente que corresponde con los datos datos recibidos por parámetros
    public static int modificarPaciente(Paciente pac) throws Exception {
        String sql = "update Pacientes set nombre = '%s',fecha_nacimiento='%s',direccion = '%s',"
                + "numero_telefono = %d, correo = '%s'"
                + "where cedula = %s ";
        sql = String.format(sql, pac.getNombre(), pac.getFecha_nacimiento(), pac.getDireccion(),
                pac.getNumero_telefono(), pac.getCorreo(), pac.getCedula());
        ResultSet rs = clinica.executeUpdateWithKeys(sql);
        if (rs.next()) {
            return rs.getInt(1);
        } else {
            return 0;
        }
    }
    
//Retorna true si se encuentra ese paciente en la base de datos
    public static boolean existe_paciente(int ced){
        String sql="select count(cedula) as c from clinica.pacientes where cedula = '%d'";
        sql=String.format(sql,ced);
        ResultSet rs = clinica.executeQuery(sql);
        try{
            if(rs.next()){
                if(rs.getInt("c") == 1)
                    return true;
            }
        }catch (SQLException ex) {
            return false;
        }
        return false;
    }
//*--------------------------------------------------------------------------------------------------------------------
//*----------------------------------------------Citas----------------------------------------------------------------
//*--------------------------------------------------------------------------------------------------------------------
    public static List<Cita> busquedaCitasPaciente(int paciente) throws Exception {
       List<Cita> c;
       c = new ArrayList();
       try {
           String sql = "select * from citas where paciente="+paciente+" order by fecha desc";
           ResultSet rs = clinica.executeQuery(sql);
              while (rs.next()) {
                c.add(toCita(rs));
              }
       } catch (SQLException e) {
           
       }
       return c;
   }
   
   private static Cita toCita(ResultSet rs) throws Exception {
        Cita obj = new Cita("", 0, null, "", "", 0);
        ResultSet rsM = clinica.executeQuery("select * from Medicos where codigo='"+rs.getString("medico")+"'");
        if(rsM.next()) obj.setMedico(rsM.getString("nombre"));
        else obj.setMedico(rs.getString("medico"));
        obj.setPaciente(rs.getInt("paciente"));
        Date fechaD = rs.getDate("fecha");
        //DateFormat fechaDF = new SimpleDateFormat("yyyy/MM/dd");
        //String fecha = fechaDF.format(fechaD);
        obj.setFecha(fechaD);
        obj.setHora(rs.getString("hora"));
        obj.setDescripcion(rs.getString("descripcion"));
        obj.setCodigoCita(rs.getInt("codigo_cita"));
        return obj;
    }
   
   public static List<Cita> busquedaCitasPacientePorFecha(int paciente,String fecha) throws Exception {
       List<Cita> c;
       c = new ArrayList();
       java.util.Date fechautil;
       java.sql.Date fechasql;
       try {
           fecha = fecha.replace('/', '-');
           SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy");
           fechautil = format.parse(fecha);
           fechasql = new java.sql.Date(fechautil.getTime());
       } catch (Exception e) {
           fechasql = new Date(0,1,1);
       }
       try {
           String sql = "select * from citas where paciente="+paciente+
                   " and fecha='"+fechasql+"' order by fecha desc";
           ResultSet rs = clinica.executeQuery(sql);
              while (rs.next()) {
                c.add(toCita(rs));
              }
       } catch (SQLException e) {
           
       }
       return c;
   }
   
   public static List<Cita> busquedaCitasPacientePorMedico(int paciente, String medico) throws Exception {
       List<Cita> c;
       c = new ArrayList();
       try {
           String mysql = "select * from medicos where nombre = '"+medico+"'";
           ResultSet rs2 = clinica.executeQuery(mysql);
           while (rs2.next()) {
               try {
                    String str = rs2.getString("codigo");
                    String sql = "select * from citas where paciente="+paciente+
                            " and medico='"+str+"' order by fecha desc";
                    ResultSet rs = clinica.executeQuery(sql);
                    while (rs.next()) {
                        c.add(toCita(rs));
                    }
               } catch (SQLException e) {
           
               }
           }
       } catch (SQLException e) {
           
       }
       return c;
   }
   
   public static String Agregar_Cita(Cita cita) throws Exception{
        String sql="insert into clinica.citas "+
                "(medico, paciente, fecha, hora, descripcion) "+
                "values ('%s','%d','%s','%s','%s')";
        sql=String.format(sql,cita.getMedico(),cita.getPaciente(),
                new SimpleDateFormat("yyyy-MM-dd").format(cita.getFecha()),
                cita.getHora(),
                cita.getDescripcion());
        ResultSet rs =  clinica.insertar_modificar_borrar(sql);
        if (rs.next()) {
            return "-1"; // fracaso
        }
        else{
            return "0"; // éxito
        }
    }
   
   public static List<Cita> Buscar_Citas_Fecha(int medico,java.util.Date fecha) throws Exception{
        List<Cita> citas = new ArrayList();
        try {
            String sql="select * from clinica.citas "
                    + "where medico = '%d' "
                    + "and citas.fecha = '%s'";
            sql=String.format(sql,medico,
              new SimpleDateFormat("yyyy-MM-dd").format(fecha));
            
            ResultSet rs =  clinica.executeQuery(sql);
            while (rs.next()) {
                citas.add(toCita(rs));
            }
        } catch (SQLException ex) {
        }
        return citas;
    }
   
   public static String Actualizar_Cita(Cita cita) throws Exception{
        String sql="update clinica.citas set "
                + "fecha = '%s', hora = '%s', descripcion = '%s' "
                + "where codigo_cita = '%d'";
        sql=String.format(sql,
                new SimpleDateFormat("yyyy-MM-dd").format(cita.getFecha()),
                cita.getHora(),
                cita.getDescripcion(),
                cita.getCodigoCita());
        ResultSet rs =  clinica.insertar_modificar_borrar(sql);
        if (rs.next()) {
            return "-1"; // fracaso
        }
        else{
            return "0"; // éxito
        }
    }
   
   public static List<Cita> Buscar_Citas_Nombre(int medico,String nombre) throws Exception{
        List<Cita> citas = new ArrayList();
        List<Palabra> cedulas_clientes = new ArrayList();String sql;
        try {
            sql="select cedula from "+
                    "clinica.pacientes  "+
                    "where nombre like '%%%s%%'";
            sql=String.format(sql,nombre);
            ResultSet rs =  clinica.executeQuery(sql);
            while (rs.next()) {
                cedulas_clientes.add(toPalabra(rs));
            }
            sql="select * from clinica.citas "
                    + "where medico = '%d' "
                    + "and paciente = '%s'";
            for (Palabra cedula : cedulas_clientes) {
                sql = String.format(sql, medico, cedula.getTexto());
                rs =  clinica.executeQuery(sql);
                while (rs.next()) {
                    citas.add(toCita(rs));
                }
            }
        } catch (SQLException ex) {
        }
        return citas;
    }
   
   public static List<Cita> Buscar_Citas_Cedula(int medico,int cedula) throws Exception{
        List<Cita> citas = new ArrayList();
        try {
            String sql="select * from clinica.citas "
                    + "where medico = '%d' "
                    + "and paciente = '%d'";
            sql=String.format(sql,medico,cedula);
            
            ResultSet rs =  clinica.executeQuery(sql);
            while (rs.next()) {
                citas.add(toCita(rs));
            }
        } catch (SQLException ex) {
        }
        return citas;
    }
   
   public static List<Cita> Proximas_Citas(int medico) throws Exception{
        List<Cita> citas = new ArrayList();
        try {
            String sql="select * from clinica.citas "
                    + "where medico = '%d' "
                    + "and timestamp(fecha, hora) >= '%s' order by fecha asc";
            sql=String.format(sql,medico,
                    new SimpleDateFormat("yyyy-MM-dd HH:mm").format(
                            new java.sql.Date(new java.util.Date().getTime())));
            ResultSet rs =  clinica.executeQuery(sql);
            while (rs.next()) {
                citas.add(toCita(rs));
            }
        } catch (SQLException ex) {
        }
        return citas;
    }
   
//*--------------------------------------------------------------------------------------------------------------------
//*----------------------------------------------Observaciones---------------------------------------------------------
//*--------------------------------------------------------------------------------------------------------------------
   
   public static List<Observacion> busquedaObservaciones(String cita) throws Exception{
       List<Observacion> o;
       o = new ArrayList();
       try {
           String sql;
           int i = Integer.parseInt(cita);
           sql = "select * from observaciones where codigo = "+i;
           ResultSet rs = clinica.executeQuery(sql);
           while(rs.next()) {
               o.add(toObservacion(rs));
           }
       } catch(SQLException e) {
           
       }
       return o;
   }
   
   private static Observacion toObservacion(ResultSet rs) throws Exception {
        Observacion obj = new Observacion(0, "", "");
        obj.setCodigo(rs.getInt("codigo"));
        obj.setFecha(rs.getString("fecha"));
        obj.setObservacion(rs.getString("observacion"));
        return obj;
    }
   
   public static List<Observacion> Obtener_Observaciones(int codigo){
        List<Observacion> observaciones = new ArrayList();
        try {
            String sql="select * from clinica.observaciones "
                    + "where codigo = '%d' ";
            sql=String.format(sql,codigo);
            
            ResultSet rs =  clinica.executeQuery(sql);
            while (rs.next()) {
                observaciones.add(aObservacion(rs));
            }
        } catch (SQLException ex) {
        }
        return observaciones;
    }
    
    private static Observacion aObservacion(ResultSet rs){
        try {
            Observacion o = new Observacion();
            o.setCodigo(rs.getInt("codigo"));
            o.setObservacion(rs.getString("observacion"));
            return o;
        } catch (SQLException ex) {
            return null;
        }
    }
    
    public static String Guardar_Observacion(Observacion o) throws Exception{
        Calendar c = Calendar.getInstance();
        int mes = c.get(Calendar.MONTH);
        mes++;
        String fechasql = c.get(Calendar.YEAR)+
                "-"+mes+
                "-"+c.get(Calendar.DATE);
        String sql="insert into clinica.observaciones "
                + "(codigo, fecha, observacion) values "
                + "('%d', '%s', '%s')";
        sql=String.format(sql,o.getCodigo(),fechasql,o.getObservacion());
        ResultSet rs =  clinica.insertar_modificar_borrar(sql);
        if (rs.next()) {
            return "-1"; // fracaso
        }
        else{
            return "0"; // éxito
        }
    }

//*--------------------------------------------------------------------------------------------------------------------
//*-------------------------------------------------Palabra------------------------------------------------------------
//*--------------------------------------------------------------------------------------------------------------------

    private static Palabra toPalabra(ResultSet rs){
        try {
            Palabra p = new Palabra();
            p.setTexto(""+rs.getInt("cedula"));
            return p;
        } catch (SQLException ex) {
            return null;
        }
    }

}