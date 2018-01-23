<%-- 
    Document   : Login
    Created on : 10-may-2016, 9:06:59
    Author     : Estudiante
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Login</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <head>
        <title>Ejemplo</title>
        <%@ include file="../jspf/Imports.jspf" %>
    </head>
    <body>
        <%@ include file="../jspf/Encabezado.jspf" %>
        <br><br><br>
        <div>
            <form>
                <center>
                    <table id = "form" style ="background : #D8F5DF;width: 30%;" >
                        <tr>
                            <td colspan = 2 style ="font-family:Bernard MT Condensed;color: gray;font-size:40px;">
                        <center>Log In</center>
                        </td>
                        </tr>
                        <Tr>
                            <td style ="font-family:Century Gothic;color: #030849;">
                                Usuario: 
                            </td>
                            <td><input type = "text" id ="usuarios" maxlength="9"> </td>
                        </tr>
                        <div id="popuppac" class="popup"> <center>Usuario o contraseña invalidos!!</center>
                            <br><br><br><center>
                                <input type = "button" value = "Aceptar" id="aceptar" class="Boton2" onclick = "document.getElementById('popup').style.display = 'none';"> </center>
                            </center>     
                        </div>
                        <tr>
                            <td style ="font-family:Century Gothic;color: #030849;">
                                Contraseña: 
                            </td>
                            <td>
                                <input type = "password" id ="contraseña" maxlength="10">
                            </td>
                        </tr>
                        <Tr >
                            <td id = "error" style ="font-size:9pt;color : #5F0B0B;font-family: Times New Roman;">

                            </td>
                        </tr>
                        <tr rowspan = 3>
                            <td colspan =2>
                        <center><input type="button" class = "Boton" onclick="login();" value ="Ingresar"></button></center>
                        </td>
                        </tr>
                    </table>
                </center>
            </form>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", pageLoad);

            function pageLoad() {
                limpiarErrores();
                document.addEventListener("keydown", function e(e){procesaLogin(e);});
            }
            
               function procesaLogin(e) {
  if(e.keyCode == 13) {
    login();
  }
}
            function login() {
                usuario = new Usuario(document.getElementById("usuarios").value, get("contraseña"), 0);
                if (validar()) {
                    Proxy.userLogin(usuario,
                            function(usuario) {
                                switch (usuario.tipo) {
                                    case 0:
                                        popup = document.getElementById("popup");
                                        popup.style.display = "block";
                                        document.getElementById("usuarios").className = "error";
                                        document.getElementById("usuarios").title = "Usuario no válido";
                                        document.getElementById("contraseña").className = "error";
                                        document.getElementById("contraseña").title = "Contraseña no válida";
                                        break;
                                    case 1:
                                        limpiarErrores();
                                        document.location = "/Proyecto_2_Progamacion_IV/jsp/Listado_Citas.jsp";
                                        break;
                                    case 2:
                                        limpiarErrores();
                                        document.location = "/Proyecto_2_Progamacion_IV/jsp/Paciente.jsp";
                                        break;
                                    case 3:
                                        limpiarErrores();
                                        document.location = "/Proyecto_2_Progamacion_IV/jsp/Administrador.jsp";
                                        break;
                                }
                            });
                }
            }

//-----------------------------------------------------------------------------------------------------------------
//---------------------------------------- Validaciones -----------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------
            function validarUsuario() {
                if (isNaN(document.getElementById("usuarios").value) == true) {
                    document.getElementById("usuarios").className = "error";
                    document.getElementById("usuarios").title = "Solo se permite numeros";
                    return false;
                }
                if (document.getElementById("usuarios").value == "") {
                    document.getElementById("usuarios").className = "error";
                    document.getElementById("usuarios").title = "Debe llenar este espacio";
                    return false;
                }
                else {
                    document.getElementById("usuarios").className = "";
                    document.getElementById("usuarios").title = "";
                    return true;
                }
            }
            function validarContraseña() {
                if (document.getElementById("contraseña").value == "") {
                    document.getElementById("contraseña").className = "error";
                    document.getElementById("contraseña").title = "Debe llenar este espacio";
                    return false;
                }
                else {
                    document.getElementById("contraseña").className = "";
                    document.getElementById("contraseña").title = "";
                    return true;
                }
            }
            function validar() {
                valida1 = validarUsuario();
                valida2 = validarContraseña();
                document.getElementById("error").appendChild((document.createTextNode("")));
                if (valida1 && valida2) {
                    return true;
                }
                else {
                    return false;
                }
            }
            function limpiarErrores() {
                document.getElementById("contraseña").value = "";
                document.getElementById("contraseña").className = "";
                document.getElementById("contraseña").title = "";
                document.getElementById("usuarios").className = "";
                document.getElementById("usuarios").className = "";
                document.getElementById("usuarios").value = "";
            }
        </script>
    </body>
</html>
