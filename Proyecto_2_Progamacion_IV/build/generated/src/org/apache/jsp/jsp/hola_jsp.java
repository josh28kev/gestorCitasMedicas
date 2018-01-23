package org.apache.jsp.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import proyecto.modelo.Usuario;
import proyecto.modelo.Medico;
import proyecto.modelo.Paciente;
import proyecto.modelo.Administrador;

public final class hola_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList<String>(2);
    _jspx_dependants.add("/jsp/../jspf/Imports.jspf");
    _jspx_dependants.add("/jsp/../jspf/Encabezado.jspf");
  }

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			"../jsp/ErrorSeguridad.jsp", true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <title>Ejemplo</title>\n");
      out.write("        ");
      out.write("<meta http-equiv=\"Cache-Control\" content=\"no-cache, no-store, must-revalidate\" />\n");
      out.write("<meta http-equiv=\"Pragma\" content=\"no-cache\" />\n");
      out.write("<meta http-equiv=\"Expires\" content=\"0\" />\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("\n");
      out.write("<script type=\"text/javascript\" src=\"../js/Palabra.js\"></script>    \n");
      out.write("<!--<script type=\"text/javascript\" src=\"../js/Conexion.js\"></script>-->  \n");
      out.write("<script type=\"text/javascript\" src=\"../js/Proxy.js\"></script>\n");
      out.write("<script type=\"text/javascript\" src=\"../js/Usuario.js\"></script>   \n");
      out.write("<script type=\"text/javascript\" src=\"../js/BaseDatos.js\"></script>\n");
      out.write("<script type=\"text/javascript\" src=\"../js/Utils.js\"></script>\n");
      out.write("<link rel=\"stylesheet\" title=\"Basico\" type=\"text/css\" href=\"../css/Estilo.css\">");
      out.write("\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        ");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<link rel=\"stylesheet\" title=\"Basico\" type=\"text/css\" href=\"../css/Estilo.css\">\n");
      out.write("<div id=\"header\" style=\"line-height:60px;  background:green;\">\n");
      out.write("    <div id=\"logo\" class=\"titulo\">\n");
      out.write("            Sistema de la clínica sin nombre \n");
      out.write("    </div>\n");
      out.write("    <div id=\"links\" class=\"div_enlaces\">    \n");
      out.write("    ");
 Usuario user = (Usuario) request.getSession().getAttribute("user"); 
      out.write("\n");
      out.write("\n");
      out.write("        ");
 if (user==null){
      out.write("        \n");
      out.write("            <div id=\"login\"> \n");
      out.write("                    <a href=\"Login.jsp\" title=\"Login\">\n");
      out.write("                            <div style=\"width: 40px; height:40px; background-image: url(../imagenes/login.png); background-repeat: no-repeat; background-size:contain;\"></div>\n");
      out.write("                    </a>\n");
      out.write("            </div>\n");
      out.write("        ");
}
      out.write(" \n");
      out.write("        <!--A partir de aquí no funciona completamente-->\n");
      out.write("        ");
   if (user!=null){
      out.write("\n");
      out.write("            <div id=\"user\" class=\"cod_nombre_usuario\">\n");
      out.write("                ");
      out.print(user.getId());
      out.write("\n");
      out.write("            </div> \n");
      out.write("            ");
 if(user.getTipo()==2){ // Médico 
      out.write("\n");
      out.write("                <div id=\"client\" style=\"font-family:Papyrus,fantasy; font-size:15px; font-weight:700; color:white;\">\n");
      out.write("                    ");
      out.print(( (Medico) request.getSession().getAttribute("client")).getNombre() );
      out.write("\n");
      out.write("                </div> \n");
      out.write("            ");
}
      out.write("\n");
      out.write("            \n");
      out.write("            <div id=\"logout\" onclick=\"logout();return false;\" style=\"\"> \n");
      out.write("                    <a href=\"\" title=\"Logout\">\n");
      out.write("                            <div style=\"width: 30px; height:30px;  background-image: url(images/logout.png); background-repeat: no-repeat; background-size:contain;\"></div>\n");
      out.write("                    </a>\n");
      out.write("            </div>\n");
      out.write("        ");
}
      out.write("\n");
      out.write("    </div>\n");
      out.write("</div>\n");
      out.write("<script>\n");
      out.write("    function logout(){\n");
      out.write("           Proxy.userLogout(\n");
      out.write("                function(){\n");
      out.write("                    store(\"ShowCarrito.jsp_carTable\", new Carrito());\n");
      out.write("                    document.location=\"/33-CarritoCompra/Login.jsp\";\n");
      out.write("               });\n");
      out.write("    \n");
      out.write("}\n");
      out.write("</script>");
      out.write("\n");
      out.write("        <table id=\"hola\"></table>\n");
      out.write("    </body>\n");
      out.write("    <!--<script>\n");
      out.write(" document.addEventListener(\"DOMContentLoaded\", pageLoad);\n");
      out.write("\n");
      out.write("    function pageLoad(){\n");
      out.write("        retornar_palabra(\"hola\");\n");
      out.write("    }\n");
      out.write("        \n");
      out.write("    function retornar_palabra(t){\n");
      out.write("        Proxy.ejemplo(t,\n");
      out.write("                function(palabra){\n");
      out.write("                    tabla = document.getElementById(\"hola\");\n");
      out.write("                    tr_inicio = document.createElement(\"tr\");\n");
      out.write("                    td = document.createElement(\"td\");\n");
      out.write("                    hola = palabra;\n");
      out.write("                    td.appendChild(document.createTextNode(hola));\n");
      out.write("                    tr_inicio.appendChild(td);\n");
      out.write("                    tabla.appendChild(tr_inicio);\n");
      out.write("                });\n");
      out.write("    }\n");
      out.write("    </script>-->\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
