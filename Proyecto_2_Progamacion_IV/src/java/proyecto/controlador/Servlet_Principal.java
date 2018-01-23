package proyecto.controlador;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.google.gson.typeadapters.RuntimeTypeAdapterFactory;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import proyecto.modelo.Cita;
import proyecto.modelo.Jsonable;
import proyecto.modelo.Hola;
import proyecto.modelo.Medico;
import proyecto.modelo.Palabra;
import proyecto.modelo.Usuario;
import proyecto.modelo.Modelo;
import proyecto.modelo.Observacion;
import proyecto.modelo.Paciente;

@WebServlet(name = "Servlet_Principal", urlPatterns = {"/Servlet_Principal"})
public class Servlet_Principal extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            response.setContentType("text/xml");
            RuntimeTypeAdapterFactory<Jsonable> rta = RuntimeTypeAdapterFactory.of(Jsonable.class, "_class")
                    .registerSubtype(Palabra.class, "Palabra")
                    .registerSubtype(Usuario.class, "Usuario")
                    .registerSubtype(Medico.class, "Medico")
                    .registerSubtype(Paciente.class, "Paciente")
                    .registerSubtype(Cita.class, "Cita")
                    .registerSubtype(Observacion.class, "Observacion");
            Gson gson = new GsonBuilder().registerTypeAdapterFactory(rta).setDateFormat("dd/MM/yyyy").create();
            String json;
            Medico medico;
            Paciente paciente;
            Usuario usuar = new Usuario();
            Observacion obs;
            List<Medico> medicos;
            List<Paciente> pacientes;
            List<Cita> citas;
            List<Observacion> observaciones;
            String Sfecha;
            String jsonCita;
            String Snombre;
            Cita cita;
            int aux;
            int SCedula;
            int SCodigo;
            java.util.Date fecha;
            Palabra p = new Palabra();
            Usuario uu;
            String accion = request.getParameter("action");
            switch (accion) {
                case "hola":
                    p.setTexto(Hola.retorna_mensaje());
                    json = gson.toJson(p);
                    out.write(json);
                    break;
//-----------------------------------------------------------------------------------------------------------------
//---------------------------------------- Usuarios -----------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------
                case "userLogin":
                    json = request.getParameter("user");
                    Usuario user = gson.fromJson(json, Usuario.class);
                    user = Modelo.userLogin(user);
                    if (user.getTipo() != 0) {
                        request.getSession().setAttribute("user", user);
                        switch (user.getTipo()) {
                            case 1:
                                medico = Modelo.medicoGet(user.getId());
                                request.getSession().setAttribute("medico", medico);
                                break;
                            case 2:
                                paciente = Modelo.pacienteGet(user.getId());
                                request.getSession().setAttribute("paciente", paciente);
                                break;
                            case 3: 
                                break;
                        }
                    }
                    json = gson.toJson(user);
                    out.write(json);
                    break;
                case "userLogout":
                    request.getSession().removeAttribute("user");
                    request.getSession().removeAttribute("medico");
                    request.getSession().removeAttribute("paciente");
                    request.getSession().invalidate();
                    break;
                case "buscarUsuario":
                    String id;
                    id = request.getParameter("id");
                    usuar = Modelo.getUsuario(id);
                    json = gson.toJson(usuar);
                    out.write(json);
                    break;
                case "modificarUsuario":
                    json = request.getParameter("usuario");
                    Usuario usuarioJavas = gson.fromJson(json, Usuario.class);
                    Modelo.modificarUsuario(usuarioJavas);
                    break;
                case "agregarUsuario":
                    json = request.getParameter("usuario");
                    Usuario use = gson.fromJson(json, Usuario.class);
                    Modelo.agregarUsuario(use);
                    json = gson.toJson(use);
                    out.write(json);
                    break;
//-----------------------------------------------------------------------------------------------------------------
//------------------------------------------- Medicos -------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------
                case "agregarMedico":
                    json = request.getParameter("medico");
                    Medico medic = gson.fromJson(json, Medico.class);
                    int updated = Modelo.agregarMedico(medic);
                    if (updated == 1) {
                        json = gson.toJson(0);
                    } else {
                        json = gson.toJson(1);
                    }
                    out.write(json);
                    break;
                case "busquedaNombreMedicos":
                    String criterio;
                    criterio = request.getParameter("criterio");
                    medicos = Modelo.busquedaNombreMedicos(criterio);
                    json = gson.toJson(medicos);
                    out.write(json);
                    break;
                case "busquedaCodigoMedicos":
                    String criterios;
                    criterios = request.getParameter("criterio");
                    medicos = Modelo.busquedaCodigoMedicos(criterios);
                    json = gson.toJson(medicos);
                    out.write(json);
                    break;
                case "ListaMedicos":
                    medicos = Modelo.listarTodosLosMedicos();
                    json = gson.toJson(medicos);
                    out.write(json);
                    break;
                case "medicoGet":
                    medico = (Medico) request.getSession().getAttribute("m");
                    json = gson.toJson(medico);
                    out.write(json);
                    break;
                case "modificarMedico":
                    json = request.getParameter("medico");
                    Medico medicoJavas = gson.fromJson(json, Medico.class);
                    Modelo.modificarMedico(medicoJavas);
                    break;

//-----------------------------------------------------------------------------------------------------------------
//----------------------------------------- Pacientes -------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------
                case "pacienteGet":
                    paciente = (Paciente) request.getSession().getAttribute("p");
                    json = gson.toJson(paciente);
                    out.write(json);
                    break;
                case "agregarPaciente":
                    json = request.getParameter("paciente");
                    Paciente paci = gson.fromJson(json, Paciente.class);
                    int update = Modelo.agregarPaciente(paci);
                    if (update == 1) {
                        json = gson.toJson(0);
                    } else {
                        json = gson.toJson(1);
                    }
                    out.write(json);
                    break;
                case "modificarPaciente":
                    json = request.getParameter("paciente");
                    Paciente pacienteJavas = gson.fromJson(json, Paciente.class);
                    Modelo.modificarPaciente(pacienteJavas);
                    break;

                case "busquedaNombrePaciente":
                    String criterioss;
                    criterioss = request.getParameter("criterio");
                    pacientes = Modelo.busquedaNombrePaciente(criterioss);
                    json = gson.toJson(pacientes);
                    out.write(json);
                    break;
                case "busquedaCodigoPaciente":
                    String criteri;
                    criteri = request.getParameter("criterio");
                    pacientes = Modelo.busquedaCodigoPaciente(criteri);
                    json = gson.toJson(pacientes);
                    out.write(json);
                    break;
                case "ListaPacientes":
                    pacientes = Modelo.listarTodosLosPacientes();
                    json = gson.toJson(pacientes);
                    out.write(json);
                    break;
                case "Existe_Paciente":
                    aux = Integer.parseInt(request.getParameter("codigo"));
                    if(Modelo.existe_paciente(aux))
                        p.setTexto("true");
                    else
                        p.setTexto("false");
                    json = gson.toJson(p);
                    out.write(json);
                    break;
//-----------------------------------------------------------------------------------------------------------------
//-----------------------------------------   Citas   -------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------
                case "busquedaCitasPaciente":
                    Usuario usuari = (Usuario) request.getSession().getAttribute("user");
                    citas = Modelo.busquedaCitasPaciente(Integer.parseInt(usuari.getId()));
                    json = gson.toJson(citas); 
                    out.write(json);
                    break;
                case "busquedaCitasCFecha":
                    String pacien;
                    pacien = request.getParameter("cri");
                    Usuario usua = (Usuario) request.getSession().getAttribute("user");
                    citas = Modelo.busquedaCitasPacientePorFecha(Integer.parseInt(usua.getId()),pacien);
                    json = gson.toJson(citas); 
                    out.write(json);
                    break;
                case "busquedaCitasCMedico":
                    Usuario usuaa = (Usuario) request.getSession().getAttribute("user");
                    String pacient;
                    pacient = request.getParameter("cri");
                    citas = Modelo.busquedaCitasPacientePorMedico(Integer.parseInt(usuaa.getId()),pacient);
                    json = gson.toJson(citas); 
                    out.write(json);
                    break;
                case "Obtener_Observaciones":
                    SCodigo = Integer.parseInt(request.getParameter("codigo_cita"));
                    List<Observacion> observacioness = Modelo.Obtener_Observaciones(SCodigo);
                    json = gson.toJson(observacioness); 
                    out.write(json);
                    break;
                case "obtener_observaciones":
                    String i = request.getParameter("criterio");
                    List<Observacion> observacioness2 = Modelo.busquedaObservaciones(i);
                    json = gson.toJson(observacioness2); 
                    out.write(json);
                    break;
                    
                case "Guardar_Observacion":
                    json = request.getParameter("observacion");
                    obs = gson.fromJson(json, Observacion.class);
                    try{
                        p.setTexto(Modelo.Guardar_Observacion(obs));
                    }catch(Exception e){
                        p.setTexto("-2");
                    }
                    json = gson.toJson(p);
                    out.write(json);
                    break;
                case "Agregar_Cita":
                    uu = (Usuario)request.getSession().getAttribute("user");
                    jsonCita = request.getParameter("cita");
                    cita = gson.fromJson(jsonCita, Cita.class);
                    cita.setMedico(uu.getId());
                    try{
                        p.setTexto(Modelo.Agregar_Cita(cita));
                    }catch(Exception e){
                        p.setTexto("-2");
                    }
                    json = gson.toJson(p);
                    out.write(json);
                    break;
                case "Buscar_Citas_Fecha":
                    Sfecha = request.getParameter("fecha");
                    fecha = new SimpleDateFormat("dd/MM/yyyy").parse(Sfecha);
                    uu = (Usuario) request.getSession().getAttribute("user");
                    int aux2;
                    if (uu != null) aux2 = Integer.parseInt(uu.getId()); else aux2 = -1;
                    List<Cita> citass  = Modelo.Buscar_Citas_Fecha(aux2,fecha);
                    json = gson.toJson(citass); 
                    out.write(json);
                    break;
                    
                case "Actualizar_Cita":
                    uu = (Usuario)request.getSession().getAttribute("user");
                    jsonCita = request.getParameter("cita");
                    cita = gson.fromJson(jsonCita, Cita.class);
                    cita.setMedico(uu.getId());
                    try{
                        p.setTexto(Modelo.Actualizar_Cita(cita));
                    }catch(Exception e){
                        p.setTexto("-2");
                    }
                    json = gson.toJson(p);
                    out.write(json);
                    break;
                    
                case "Buscar_Citas_Nombre":
                    Snombre = request.getParameter("nombre");
                    uu = (Usuario)request.getSession().getAttribute("user");
                    int aux3;
                    if(uu != null) aux3 = Integer.parseInt(uu.getId()); else aux3=0;
                    List<Cita> citas2 = Modelo.Buscar_Citas_Nombre(aux3,Snombre);
                    json = gson.toJson(citas2); 
                    out.write(json);
                    break;
                    
                case "Buscar_Citas_Cedula":
                    SCedula = Integer.parseInt(request.getParameter("cedula"));
                    uu = (Usuario)request.getSession().getAttribute("user");
                    int aux4;
                    if(uu != null) aux4 = Integer.parseInt(uu.getId()); else aux4=0;
                    List<Cita> citas3 = Modelo.Buscar_Citas_Cedula(aux4,SCedula);
                    json = gson.toJson(citas3); 
                    out.write(json);
                    break;
                case "Proximas_Citas":
                    uu = (Usuario)request.getSession().getAttribute("user");
                    int aux5;
                    if(uu != null) aux5 = Integer.parseInt(uu.getId()); else aux5=0;
                    List<Cita> citas4 = Modelo.Proximas_Citas(aux5);
                    json = gson.toJson(citas4); 
                    out.write(json);
                    break;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="Métodos HttpServlet.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Descripción corta";
    }
    // </editor-fold>
}
