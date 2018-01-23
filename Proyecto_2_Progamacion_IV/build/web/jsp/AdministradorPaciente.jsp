<%-- 
Document   : ManageProducts
Created on : May 4, 2016, 8:20:56 AM
Author     : jsanchez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Paciente</title>
        <%@ include file="../jspf/Imports.jspf" %>        
    </head>
    <body>
        <%@ include file="../jspf/Encabezado.jspf" %>
        <div id="subheader" style="height:50px;background:gray">
            <div id="logo" style="display:inline-block; vertical-align: top; font-family:Comic Sans MS,fantasy; font-size:30px; font-weight:700; color:white;margin-left:5px;">
                Administración de Pacientes
            </div>

            <div id="mantenimientos" style="display:inline-block">
                <ul class="menu">
                    <a href="../jsp/Administrador.jsp" title="Paciente" style ="color:white">Administración de Médicos</a>
                </ul> 
            </div>

            <div style= "font-family:Century Gothic;; font-size:20px;"> <center>  <br><td>Buscar: <input type="text" id="buscar_field">
                        <input type = "button" id = "buscar_buton" value = "Procesar" onClick = "busqueda()"><br>
                        Filtro:   <input type = "radio" name = "busqueda" id = "codigo" checked> Cédula
                        <input type = "radio" id = "Rnombre" name = "busqueda" >   Nombre</td<center> </div>

                        <div id="agregardiv" >
                            <table  id ="tablaAgregar" class="GRID" style="background: #F4F3C9;font-family:Century Gothic;color: #030849;float:left; width: 13%;"> 
                                <br><br><br>
                                <tr><br>
                                <td colspan = 2 style="font-size:20px;color: white; background:gray;"><center>Administrar</center></td>
                                </tr>
                                <tr>
                                    <td>Cédula:</td>
                                    <td><input type="text" id="cedula_field" maxlength=9></td>
                                </tr>
                                <tr>
                                    <td>Nombre:</td>
                                    <td><input type="text" id="nombre_field"></td>
                                </tr>
                                <tr>
                                    <td>Fecha de Nacimiento:</td>
                                    <td><input type="text" id="nacimiento_field" onclick="event.cancelBubble = true;
                                            cal.showCalendar(this);"></td>
                                </tr>
                                <tr>
                                    <td style = "height:  40%">Dirección:</td>
                                    <td><input type="text" id="direccion_field"></td>
                                </tr>
                                <tr>
                                    <td>Teléfono:</td>
                                    <td><input type="text" id="telefono_field" maxlength=8></td>
                                </tr>
                                <tr>
                                    <td>Correo:</td>
                                    <td><input type="text" id="correo_field"></td>
                                </tr>
                                <tr>
                                <tr>
                                    <td>Contraseña de usuario:</td>
                                    <td><input type="password" id="contraseña_field" maxlength=8></td>
                                </tr>
                                <td colspan=2>
                                <center><input type="button" id="agregar_boton" class = "Boton" value = "Agregar" onclick="agregar()"> 
                                    <input type="button" id="editar_boton" value = "Editar" class = "Boton2" onclick="editar()" hidden>
                                    <input type="button" id="cancelar" value = "Cancelar" class = "Boton2" onClick="limpiarCampos()" hidden>
                                </center></td>
                                </tr>
                        </div>

                        <div id="popup2" class="popup"> <center>Agregado Correctamente!!</center>
                            <br><br><br><center>
                                <input type = "button" value = "Aceptar" id="aceptar" class="Boton2" onclick = "finalizarAgregar();"> </center>
                    </center>     
            </div>
            <div id="popup3" class="popup"> <center>Modificado Correctamente!!</center>
                <br><br><br> <br><center>
                    <input type = "button" value = "Aceptar" id="aceptar2" class="Boton2" onclick = "finalizarModificar()"> </center>
                </center>     
            </div>
            <div id="tabladiv" style="display:inline-block; margin-top: 5px;  overflow:auto; font-size:8px; font-weight:700; color:gray; width:500px">

                <table border id ="tablaP" class="GRID" style = "float: right; width: 75%;font-size:15px;font-family:Century Gothic;color: #030849;">          
                    <thead><tr style ="background: gray; color : white"><th>Cédula</th><th>Nombre</th><th>Nacimiento</th><th>Dirección</th><th>Teléfono</th>
                            <th>Correo</th>  <th>Modificar</th></tr></thead>
                    <tbody></tbody>
                </table>
            </div>
            <script>
                document.addEventListener("DOMContentLoaded", pageLoad);

                function pageLoad() {
                    Tabla = document.getElementById("tablaP");
                    Tabla.modelId = location.pathname.split("/").slice(-1) + "_" + Tabla.id;
                    Tabla.toCell = tabla_toCell;
                    ListaPacientes();
                    limpiarCampos();
                }

                function tabla_toCell(obj, colIdx) {
                    switch (colIdx) {
                        case 0:
                            content = document.createTextNode(obj.cedula);
                            return content;
                        case 1:
                            content = document.createTextNode(obj.nombre);
                            return content;
                        case 2:
                            content = document.createTextNode(String(obj.fecha_nacimiento));
                            return content;
                        case 3:
                            content = document.createTextNode(obj.direccion);
                            return content;
                        case 4:
                            content = document.createTextNode(obj.numero_telefono);
                            return content;
                        case 5:
                            content = document.createTextNode(obj.correo);
                            return content;
                        case 6:
                            content = document.createElement("button");
                            content.innerHTML = "Modificar";
                            content.className = "Boton2";
                            content.addEventListener("click", function(e) {
                                modificar(obj.cedula, obj.nombre, obj.fecha_nacimiento, obj.direccion, obj.numero_telefono, obj.correo);
                            });
                            return content;
                    }
                    ;
                    return null;
                }
//-----------------------------------------------------------------------------------------------------------------
//------------------------------------------ Agregar --------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------
                function agregar() {
                    paciente = new Paciente("", "", "", "", -1, "");
                    paciente.cedula = document.getElementById("cedula_field").value;
                    paciente.nombre = document.getElementById("nombre_field").value;
                    fecha = document.getElementById("nacimiento_field").value;
                    var d = dia(fecha);
                    var m = mes(fecha);
                    var a = ano(fecha);
                    paciente.fecha_nacimiento = a + "-" + m + "-" + d;
                    paciente.direccion = document.getElementById("direccion_field").value;
                    paciente.numero_telefono = document.getElementById("telefono_field").value;
                    paciente.correo = document.getElementById("correo_field").value;
                    model = retrieve(document.getElementById("tablaP").modelId);
                    if (validar()) {
                        Proxy.agregarPaciente(paciente,
                                function(status) {
                                    usuario = new Usuario("", "", 2);
                                    usuario.id = document.getElementById("cedula_field").value;
                                    usuario.clave = document.getElementById("contraseña_field").value;
                                    switch (status) {
                                        case 0:
                                            Proxy.agregarUsuario(usuario,
                                                    function(usuario) {
                                                    });
                                            popup = document.getElementById("popup2");
                                            popup.style.display = "block";
                                            store(document.getElementById("tablaP").modelId, new Lista());
                                            break;
                                        case 1:
                                            document.getElementById("cedula_field").className = "error";
                                            document.getElementById("cedula_field").title = "Cédula duplicada";
                                            break;
                                    }
                                });
                    }
                }

                function finalizarAgregar() {
                    document.getElementById('popup2').style.display = 'none';
                    ListaPacientes();
                    limpiarCampos();
                    document.getElementById('buscar_field').value = "";
                }

//-----------------------------------------------------------------------------------------------------------------
//----------------------------------------- Modificar -------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------

                function modificar(cedula, nombre, nacimiento, direccion, telefono, correo) {
                    limpiarErrores();
                     ListaPacientes();
                    document.getElementById("cedula_field").disabled = true;
                    document.getElementById("editar_boton").hidden = false;
                    document.getElementById("agregar_boton").hidden = true;
                    document.getElementById("cancelar").hidden = false;
                    paciente = new Paciente("", "", "", "", -1, "");
                    document.getElementById("cedula_field").value = cedula;
                    document.getElementById("nombre_field").value = nombre;
                    document.getElementById("nacimiento_field").value = nacimiento;
                    document.getElementById("direccion_field").value = direccion;
                    document.getElementById("telefono_field").value = telefono;
                    document.getElementById("correo_field").value = correo;
                    a = document.getElementById("cedula_field").value;
                    Proxy.buscarUsuario(a,
                            function(usuario) {
                                document.getElementById("contraseña_field").value = usuario.clave;
                            });
                }

                function editar() {
                    if (validar()) {
                        paciente = new Paciente("", "", "", "", -1, "");
                        usuario = new Usuario("", "", 2);
                        usuario.id = document.getElementById("cedula_field").value;
                        usuario.clave = document.getElementById("contraseña_field").value;
                        paciente.cedula = document.getElementById("cedula_field").value;
                        paciente.nombre = document.getElementById("nombre_field").value;
                        fecha = document.getElementById("nacimiento_field").value;
                        if (formatoFecha(fecha) == false) {
                            var d = dia(fecha);
                            var m = mes(fecha);
                            var a = ano(fecha);
                            paciente.fecha_nacimiento = a + "-" + m + "-" + d;
                        } else {
                            paciente.fecha_nacimiento = document.getElementById("nacimiento_field").value;
                        }
                        paciente.direccion = document.getElementById("direccion_field").value;
                        paciente.numero_telefono = document.getElementById("telefono_field").value;
                        paciente.correo = document.getElementById("correo_field").value;

                        Proxy.modificarPaciente(paciente,
                                function(paciente) {
                                    store(document.getElementById("tablaP").modelId, new Lista());
                                });
                        Proxy.modificarUsuario(usuario,
                                function(usuario) {
                                });
                        popup = document.getElementById("popup3");
                        popup.style.display = "block";
                    }
                }


                function finalizarModificar() {
                    document.getElementById('popup3').style.display = 'none';
                    ListaPacientes();
                    limpiarCampos();
                    document.getElementById('buscar_field').value = "";
                }

//-----------------------------------------------------------------------------------------------------------------
//----------------------------------------- Consultas -------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------

                function ListaPacientes() {
                    Proxy.ListaPacientes(
                            function(lista) {
                                lis = new Lista();
                                lis.items = lista;
                                store("AdministradorPaciente.jsp_tablaP", lis);
                                tabl = document.getElementById("tablaP");
                                TablaP.refresh(tabl);
                            });
                }

                function busqueda() {
                    limpiarCampos2();
                    criterio = document.getElementById("buscar_field").value;
                    radio = document.getElementById("Rnombre");
                    if(validarBuscar()){
                    if (criterio == "") {
                        ListaPacientes();
                    }
                    if (radio.checked == true) {
                        Proxy.busquedaNombrePacientes(criterio,
                                function(lista) {
                                    lis = new Lista();
                                    lis.items = lista;
                                    store("AdministradorPaciente.jsp_tablaP", lis);
                                    tabl = document.getElementById("tablaP");
                                    TablaP.refresh(tabl);
                                });
                    }
                    else {
                        Proxy.busquedaCodigoPacientes(criterio,
                                function(lista) {
                                    lis = new Lista();
                                    lis.items = lista;
                                    store("AdministradorPaciente.jsp_tablaP", lis);
                                    tabl = document.getElementById("tablaP");
                                    TablaP.refresh(tabl);
                                });
                    }
                 }
                }

//-----------------------------------------------------------------------------------------------------------------
//---------------------------------------- Validaciones -----------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------
                
                function validarBuscar(){
                    cuadroBusqueda = document.getElementById("buscar_field");
                    radio = document.getElementById("Rnombre");
                    if (radio.checked == true){
                        if (isNaN(cuadroBusqueda.value) == false) {
                        cuadroBusqueda.className = "error";
                        cuadroBusqueda .title = "Debe digitar solo letras";
                        return false;
                        }
                        else{
                        cuadroBusqueda.className = "";
                        cuadroBusqueda .title = "";  
                        return true;
                        }                     
                    }
                    else{
                          if (isNaN(cuadroBusqueda.value) == true) {
                        cuadroBusqueda.className = "error";
                        cuadroBusqueda .title = "Debe digitar solo numeros";
                        return false;
                        }
                        else{
                        cuadroBusqueda.className = "";
                        cuadroBusqueda .title = "";  
                        return true;
                        
                    }                    
                }
            }
                function validarCedula() {
                    if (document.getElementById("cedula_field").value == "") {
                        document.getElementById("cedula_field").className = "error";
                        document.getElementById("cedula_field").title = "Debe llenar este espacio";
                        return false;
                    }
                    if (isNaN(document.getElementById("cedula_field").value) == true) {
                        document.getElementById("cedula_field").className = "error";
                        document.getElementById("cedula_field").title = "Solo se permite numeros";
                        return false;
                    }
                    if (parseInt(document.getElementById("cedula_field").value) < 0 || parseInt(document.getElementById("cedula_field").value) < 99999999 ||
                            document.getElementById("cedula_field").value.length < 9) {
                        document.getElementById("cedula_field").className = "error";
                        document.getElementById("cedula_field").title = "Numero fuera de rango";
                        return false;
                    }
                    else {
                        document.getElementById("cedula_field").className = "";
                        document.getElementById("cedula_field").title = "";
                        return true;
                    }

                }

                function validarNombre() {
                    if (document.getElementById("nombre_field").value == "") {
                        document.getElementById("nombre_field").className = "error";
                        document.getElementById("nombre_field").title = "Debe llenar este espacio";
                        return false;
                    }
                    if (isNaN(document.getElementById("nombre_field").value) == false) {
                        document.getElementById("nombre_field").className = "error";
                        document.getElementById("nombre_field").title = "Solo se permiten letras en este espacio";
                        return false;
                    }
                    else {
                        document.getElementById("nombre_field").className = "";
                        document.getElementById("nombre_field").title = "";
                        return true;
                    }
                }

                function validarDireccion() {
                    if (document.getElementById("direccion_field").value == "") {
                        document.getElementById("direccion_field").className = "error";
                        document.getElementById("direccion_field").title = "Debe llenar este espacio";
                        return false;
                    }
                    else {
                        document.getElementById("direccion_field").className = "";
                        document.getElementById("direccion_field").title = "";
                        return true;
                    }
                }

                function validarTelefono() {
                     if (document.getElementById("telefono_field").value == "") {
                        document.getElementById("telefono_field").className = "error";
                        document.getElementById("telefono_field").title = "Debe llenar este espacio";
                        return false;
                    }
                    if (isNaN(document.getElementById("telefono_field").value) == true) {
                        document.getElementById("telefono_field").className = "error";
                        document.getElementById("telefono_field").title = "Solo se permite numeros";
                        return false;
                    }
                    if (parseInt(document.getElementById("telefono_field").value) < 0 || parseInt(document.getElementById("telefono_field").value) < 10000000
                            || document.getElementById("telefono_field").value.length < 8) {
                        document.getElementById("telefono_field").className = "error";
                        document.getElementById("telefono_field").title = "Numero fuera de rango";
                        return false;
                    }
                    else {
                        document.getElementById("telefono_field").className = "";
                        document.getElementById("telefono_field").title = "";
                        return true;
                    }
                }

                function validarEmail( ) {
                    expr = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
                       if( document.getElementById("correo_field").value == ""){
                        document.getElementById("correo_field").className = "error";
                        document.getElementById("correo_field").title = "Debe llenar este espacio";
                        return false;
                    }
                      else {
                        document.getElementById("correo_field").className = "";
                        document.getElementById("correo_field").title = "";
                        return true;
                    }
                    if (!expr.test(document.getElementById("correo_field").value)) {
                        document.getElementById("correo_field").className = "error";
                        document.getElementById("correo_field").title = "Direccion de correo electronico Invalida";
                        return false;
                    }
                    else {
                        document.getElementById("correo_field").className = "";
                        document.getElementById("correo_field").title = "";
                        return true;
                    }
                }

                function validarFecha() {

                    if (document.getElementById("nacimiento_field").value == "") {
                        document.getElementById("nacimiento_field").className = "error";
                        document.getElementById("nacimiento_field").title = "Debe llenar este espacio";
                        return false;
                    }
                    if (document.getElementById("nacimiento_field").value.length < 8) {
                        document.getElementById("nacimiento_field").className = "error";
                        document.getElementById("nacimiento_field").title = "Fecha fuera de rango";
                        return false;
                    }
                    else {
                        document.getElementById("nacimiento_field").className = "";
                        document.getElementById("nacimiento_field").title = "";
                        return true;
                    }
                    if (fecha(document.getElementById("nacimiento_field").value) == false) {
                        document.getElementById("nacimiento_field").className = "error";
                        document.getElementById("nacimiento_field").title = "Fecha invalida";
                        return false;
                    }
                    else {
                        document.getElementById("nacimiento_field").className = "";
                        document.getElementById("nacimiento_field").title = "";
                    }
                    return true;
                }

                function validarContrasena() {
                    if (document.getElementById("contraseña_field").value == "") {
                        document.getElementById("contraseña_field").className = "error";
                        document.getElementById("contraseña_field").title = "Debe llenar este espacio";
                        return false;
                    }
                    else {
                        document.getElementById("contraseña_field").className = "";
                        document.getElementById("contraseña_field").title = "";
                        return true;
                    }
                }

                function validar() {
                    validar1 = validarCedula();
                    validar2 = validarNombre();
                    validar3 = validarDireccion();
                    validar4 = validarTelefono();
                    validar5 = validarEmail();
                    valida6 = validarFecha();
                    valida7 = validarContrasena();
                    if (validar1 && validar2 && validar3 && validar4 && validar5 && valida6 && valida7) {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }

                function limpiarCampos() {
                    document.getElementById("nacimiento_field").className = "";
                    document.getElementById("nacimiento_field").title = "";
                    document.getElementById("nacimiento_field").value = "";
                    document.getElementById("cedula_field").className = "";
                    document.getElementById("cedula_field").title = "";
                    document.getElementById("cedula_field").value = "";
                    document.getElementById("nombre_field").className = "";
                    document.getElementById("nombre_field").title = "";
                    document.getElementById("nombre_field").value = "";
                    document.getElementById("telefono_field").className = "";
                    document.getElementById("telefono_field").title = "";
                    document.getElementById("telefono_field").value = "";
                    document.getElementById("correo_field").className = "";
                    document.getElementById("correo_field").title = "";
                    document.getElementById("correo_field").value = "";
                    document.getElementById("direccion_field").className = "";
                    document.getElementById("direccion_field").title = "";
                    document.getElementById("direccion_field").value = "";
                    document.getElementById('buscar_field').value = "";
                    document.getElementById("contraseña_field").className = "";
                    document.getElementById("contraseña_field").title = "";
                    document.getElementById("contraseña_field").value = "";
                    document.getElementById("cedula_field").disabled = false;
                    document.getElementById("editar_boton").hidden = true;
                    document.getElementById("cancelar").hidden = true;
                    document.getElementById("agregar_boton").hidden = false;
                    document.getElementById("codigo").checked = true;
                    ListaPacientes();
                }
                function limpiarCampos2(){
                    document.getElementById("nacimiento_field").className = "";
                    document.getElementById("nacimiento_field").title = "";
                    document.getElementById("nacimiento_field").value = "";
                    document.getElementById("cedula_field").className = "";
                    document.getElementById("cedula_field").title = "";
                    document.getElementById("cedula_field").value = "";
                    document.getElementById("nombre_field").className = "";
                    document.getElementById("nombre_field").title = "";
                    document.getElementById("nombre_field").value = "";
                    document.getElementById("telefono_field").className = "";
                    document.getElementById("telefono_field").title = "";
                    document.getElementById("telefono_field").value = "";
                    document.getElementById("correo_field").className = "";
                    document.getElementById("correo_field").title = "";
                    document.getElementById("correo_field").value = "";
                    document.getElementById("direccion_field").className = "";
                    document.getElementById("direccion_field").title = "";
                    document.getElementById("direccion_field").value = "";
                    document.getElementById("contraseña_field").className = "";
                    document.getElementById("contraseña_field").title = "";
                    document.getElementById("contraseña_field").value = "";
                    document.getElementById("cedula_field").disabled = false;
                    document.getElementById("editar_boton").hidden = true;
                    document.getElementById("cancelar").hidden = true;
                    document.getElementById("agregar_boton").hidden = false;
                    document.getElementById("codigo").checked = true;
                }
                
                function limpiarErrores() {
                    document.getElementById("nacimiento_field").className = "";
                    document.getElementById("nacimiento_field").title = "";
                    document.getElementById("nacimiento_field").value = "";
                    document.getElementById("cedula_field").className = "";
                    document.getElementById("cedula_field").title = "";
                    document.getElementById("cedula_field").value = "";
                    document.getElementById("nombre_field").className = "";
                    document.getElementById("nombre_field").title = "";
                    document.getElementById("nombre_field").value = "";
                    document.getElementById("telefono_field").className = "";
                    document.getElementById("telefono_field").title = "";
                    document.getElementById("telefono_field").value = "";
                    document.getElementById("correo_field").className = "";
                    document.getElementById("correo_field").title = "";
                    document.getElementById("correo_field").value = "";
                    document.getElementById("direccion_field").className = "";
                    document.getElementById("direccion_field").title = "";
                    document.getElementById("direccion_field").value = "";
                    document.getElementById("contraseña_field").className = "";
                    document.getElementById("contraseña_field").title = "";
                    document.getElementById("contraseña_field").value = "";
                    document.getElementById('buscar_field').value = "";
                    document.getElementById("codigo").checked = true;
                    cuadroBusqueda = document.getElementById("buscar_field");
                    cuadroBusqueda.value="";
                    cuadroBusqueda.className="";
                    cuadroBusqueda.title="";
                }
                function dia(cadenaAnalizar) {
                    var a = "";
                    var b = "0";
                    for (var i = 0; i < cadenaAnalizar.length; i++) {
                        var caracter = cadenaAnalizar.charAt(i);
                        if (caracter != "/") {
                            a = a + caracter;
                            ;
                        }
                        if (caracter == "/") {
                            if (a.length == 1) {
                                a = b + a;
                            }
                            return a;
                        }
                    }
                    return a;
                }
                function mes(cadenaAnalizar) {
                    var a = "";
                    var b = "0";
                    var j = 0;
                    for (var i = 0; i < cadenaAnalizar.length; i++) {
                        var caracter = cadenaAnalizar.charAt(i);
                        if (caracter != "/" && j == 1) {
                            a = a + caracter;
                        }
                        if (caracter == "/") {
                            j++;
                            if (j == 2) {
                                if (a.length == 1) {
                                    a = b + a;
                                }
                                return a;
                            }
                        }
                    }
                    return a;
                }

                function ano(cadenaAnalizar) {
                    var a = "";
                    var b = "0";
                    var j = 0;
                    for (var i = 0; i < cadenaAnalizar.length; i++) {
                        var caracter = cadenaAnalizar.charAt(i);
                        if (caracter != "/" && j == 2) {
                            a = a + caracter;
                        }
                        if (caracter == "/") {
                            j++;
                            if (j == 3) {
                                if (a.length == 4) {
                                    return a;
                                }

                            }
                        }
                    }
                    return a;
                }
                function fecha(cadenaAnalizar) {
                    for (var i = 0; i < cadenaAnalizar.length; i++) {
                        var caracter = cadenaAnalizar.charAt(i);
                        if (caracter == "/" || caracter == "-") {
                            return true;
                        }
                    }
                    return false;
                }
                function formatoFecha(cadenaAnalizar) {
                    for (var i = 0; i < cadenaAnalizar.length; i++) {
                        var caracter = cadenaAnalizar.charAt(i);
                        if (caracter == "/") {
                            return false;
                        }
                    }
                    return true;
                }
            </script>
    </body>
</html>
