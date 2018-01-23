<%-- 
    Document   : ManageProducts
    Created on : May 4, 2016, 8:20:56 AM
    Author     : jsanchez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Administracion</title>
        <%@ include file="../jspf/Imports.jspf" %>        
    </head>
    <body>
        <%@ include file="../jspf/Encabezado.jspf" %>

        <div id="subheader" style="height:50px;background:gray">
            <div id="logo" style="display:inline-block; vertical-align: top; font-family:Book Antiqua; font-size:30px; font-weight:700; color:white;margin-left:5px;">
                Administración de Médicos
            </div>

            <div id="mantenimientos" style="display:inline-block">
                <ul class="menu">
                    <a href="../jsp/AdministradorPaciente.jsp" title="Paciente" style ="color:white">Administración de Pacientes</a>
                </ul> 
            </div>
        </div>
        <div style= "font-family:Book Antiqua; font-size:20px;"> <center>  <br><td>Buscar: <input type="text" id="buscar_field">
                    <input type = "button" id = "buscar_buton" value = "Procesar" onClick = "busqueda()"><br>
                    Filtro:   <input type = "radio" name = "busqueda" id = "codigo" checked> Código
                    <input type = "radio" id = "Rnombre" name = "busqueda" >   Nombre</td<center> </div>
                    <div id="agregardiv"  >
                        <table  id ="tablaAgregar" class="GRID" style="font-family:Book Antiqua;color: #030849;float:left; width: 23%;background: #F4F3C9;"> 
                            <br><br>
                            <tr><br>
                            <td colspan = 2 style="font-size:20px;color: white; background:gray;"><center>Administrar</center></td>
                            </tr>
                            <tr >
                                <td>Código:</td>
                                <td><input type="text" id="codigo_field" maxlength="5" ></td>
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
                                <td>Teléfono:</td>
                                <td><input type="text" id="telefono_field" maxlength=8></td>
                            </tr>
                            <tr>
                                <td>Correo:</td>
                                <td><input type="text" id="correo_field"></td>
                            </tr>
                            <tr>
                                <td>Contraseña de Usuario:</td>
                                <td><input type="password" id="contraseña_field" maxlength="8"></td>
                            </tr>
                            <tr>
                                <td colspan=2>
                            <center><input type="button" id="agregar_boton" class = "Boton" value = "Agregar" onclick="agregar()"> 
                                <input type="button" id="editar_boton" value = "Editar" class = "Boton2" onclick="editar()" hidden>
                                <input type="button" id="cancelar" value = "Cancelar" class = "Boton2" onClick="limpiarCampos()" hidden>
                            </center></td>
                            </tr>
                    </div>
                    <div id="popup2" class="popup"> <center>Agregado Correctamente!!</center>
                        <br><br><br><center>
                            <input type = "button" value = "Aceptar" id="aceptar" class="Boton2" onclick = "finalizarAgregar()"> </center>
                </center>     
        </div>
        <div id="popup3" class="popup"> <center>Modificado Correctamente!!</center>
            <br><br><br> <br><center>
                <input type = "button" value = "Aceptar" id="aceptar2" class="Boton2" onclick = "finalizarModificar();"> </center>
        </center>     
    </div>
    <div id="tabladiv" style="display:inline-block; margin-top: 5px;  overflow:auto; font-size:20px; font-weight:700; color:gray; width:500px">

        <table border id ="tabla" class="GRID" style = "font-family:Book Antiqua;color: #030849;float: right; width: 70%;">          
            <thead><tr style ="background: gray; color : white"><th>Código</th><th>Cédula</th><th>Nombre</th><th>Teléfono</th><th>Correo</th>
                    <th>Modificar</th></tr></thead>
            <tbody></tbody>
        </table>
    </div>
    <script>
        document.addEventListener("DOMContentLoaded", pageLoad);

        function pageLoad() {
            Tabla = document.getElementById("tabla");
            Tabla.modelId = location.pathname.split("/").slice(-1) + "_" + Tabla.id;
            Tabla.toCell = tabla_toCell;
            limpiarCampos();
            ListaMedicos();
}

        function tabla_toCell(obj, colIdx) {
            switch (colIdx) {
                case 0:
                    content = document.createTextNode(obj.codigo);
                    return content;
                case 1:
                    content = document.createTextNode(obj.cedula);
                    return content;
                case 2:
                    content = document.createTextNode(obj.nombre);
                    return content;
                case 3:
                    content = document.createTextNode(obj.telefono);
                    return content;
                case 4:
                    content = document.createTextNode(obj.email);
                    return content;
                case 5:
                    content = document.createElement("button");
                    content.innerHTML = "Modificar ";
                    content.className = "Boton2";
                    content.addEventListener("click", function(e) {
                        modificar(obj.codigo, obj.cedula, obj.nombre, obj.telefono, obj.email);
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
            if (validar()) {
                medico = new Medico("", "", "", 0, "");
                usuario = new Usuario("", "", 1);
                medico.codigo = document.getElementById("codigo_field").value;
                medico.nombre = document.getElementById("nombre_field").value;
                medico.cedula = document.getElementById("cedula_field").value;
                medico.telefono = document.getElementById("telefono_field").value;
                medico.email = document.getElementById("correo_field").value;
                model = retrieve(document.getElementById("tabla").modelId);
                Proxy.agregarMedico(medico,
                        function(status) {
                            usuario = new Usuario("", "", 1);
                            usuario.clave = document.getElementById("contraseña_field").value;
                            usuario.id = document.getElementById("codigo_field").value;
                            store(document.getElementById("tabla").modelId, new Lista());
                            switch (status) {
                                case 1:
                                    document.getElementById("codigo_field").className = "error";
                                    document.getElementById("codigo_field").title = "Código duplicado";
                                    break;
                                case 0:
                                    Proxy.agregarUsuario(usuario,
                                            function(usuario) {
                                                store(document.getElementById("tabla").modelId, new Lista());
                                            });
                                    popup = document.getElementById("popup2");
                                    popup.style.display = "block";
                                    break
                            }
                        });
            }
        }

        function finalizarAgregar() {
            document.getElementById('popup2').style.display = 'none';
            ListaMedicos();
            limpiarCampos();
            document.getElementById('buscar_field').value = "";
        }

//-----------------------------------------------------------------------------------------------------------------
//----------------------------------------- Modificar -------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------

        function modificar(codigo, cedula, nombre, telefono, email) {
            limpiarErrores();
             ListaMedicos();
            document.getElementById("editar_boton").hidden = false;
            document.getElementById("cancelar").hidden = false;
            document.getElementById("agregar_boton").hidden = true;
            document.getElementById("codigo_field").value = codigo;
            document.getElementById("codigo_field").disabled = true;
            document.getElementById("cedula_field").disabled = true;
            document.getElementById("nombre_field").value = nombre;
            document.getElementById("cedula_field").value = cedula;
            document.getElementById("telefono_field").value = telefono;
            document.getElementById("correo_field").value = email;
            a = document.getElementById("codigo_field").value;
            Proxy.buscarUsuario(a,
                    function(usuario) {
                        document.getElementById("contraseña_field").value = usuario.clave;
                    });
        }

        function editar() {
            if (validar()) {
                medico = new Medico("", "", "", 0, "");
                usuario = new Usuario("", "", 2);
                medico.codigo = document.getElementById("codigo_field").value;
                medico.nombre = document.getElementById("nombre_field").value;
                medico.cedula = document.getElementById("cedula_field").value;
                medico.telefono = document.getElementById("telefono_field").value;
                medico.email = document.getElementById("correo_field").value;
                usuario.id = medico.codigo = document.getElementById("codigo_field").value;
                usuario.clave = document.getElementById("contraseña_field").value;
                Proxy.modificarMedico(medico,
                        function(medico) {
                            store(document.getElementById("tabla").modelId, new Lista());
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
            ListaMedicos();
            limpiarCampos();
            document.getElementById('buscar_field').value = "";
        }

//-----------------------------------------------------------------------------------------------------------------
//----------------------------------------- Consultar -------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------
        function ListaMedicos() {
            Proxy.ListaMedicos(
                    function(lista) {
                        lis = new Lista();
                        lis.items = lista;
                        store("Administrador.jsp_tabla", lis);
                        tabl = document.getElementById("tabla");
                        Table.refresh(tabl);
                    });
        }

        function busqueda() {
            limpiarCampos2();
            criterio = document.getElementById("buscar_field").value;
            radio = document.getElementById("Rnombre");
            if(validarBuscar()){
            if (criterio == "") {
                ListaMedicos();
            }
            if (radio.checked == true) {
                Proxy.busquedaNombreMedicos(criterio,
                        function(lista) {
                            lis = new Lista();
                            lis.items = lista;
                            store("Administrador.jsp_tabla", lis);
                            tabl = document.getElementById("tabla");
                            Table.refresh(tabl);
                        });
            }
            else {
                Proxy.busquedaCodigoMedicos(criterio,
                        function(lista) {
                            lis = new Lista();
                            lis.items = lista;
                            store("Administrador.jsp_tabla", lis);
                            tabl = document.getElementById("tabla");
                            Table.refresh(tabl);
                        });
            }
         }
        }
        function finalizarAgregar() {
            document.getElementById('popup2').style.display = 'none';
            ListaMedicos();
            limpiarCampos();
            document.getElementById('buscar_field').value = "";
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

        function validarCodigo() {
             if (document.getElementById("codigo_field").value == "") {
                document.getElementById("codigo_field").className = "error";
                document.getElementById("codigo_field").title = "Debe llenar este espacio";
                return false;
            }
            if (isNaN(document.getElementById("codigo_field").value) == true) {
                document.getElementById("codigo_field").className = "error";
                document.getElementById("codigo_field").title = "Solo se permite numeros";
                return false;
            }
            if (parseInt(document.getElementById("codigo_field").value) < 0) {
                document.getElementById("codigo_field").className = "error";
                document.getElementById("codigo_field").title = "Numero fuera de rango";
                return false;
            }
            else {
                document.getElementById("codigo_field").className = "";
                document.getElementById("codigo_field").title = "";
                return true;
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
            if (document.getElementById("cedula_field").length == 0) {
                document.getElementById("cedula_field").className = "error";
                document.getElementById("cedula_field").title = "Debe llenar este espacio";
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
            if (!expr.test(document.getElementById("correo_field").value) || document.getElementById("correo_field").value == "") {
                document.getElementById("correo_field").className = "error";
                document.getElementById("correo_field").title = "Direccion Invalida";
                return false;
            }
            else {
                document.getElementById("correo_field").className = "";
                document.getElementById("correo_field").title = "";
                return true;
            }
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
            validar1 = validarCodigo();
            validar2 = validarCedula();
            validar3 = validarNombre();
            validar4 = validarTelefono();
            validar5 = validarEmail();
            validar6 = validarContrasena();
            if (validar1 && validar2 && validar3 && validar4 && validar5 && validar6) {
                return true;
            }
            else {
                return false;
            }
        }

        function limpiarCampos() {
            document.getElementById("codigo_field").className = "";
            document.getElementById("codigo_field").title = "";
            document.getElementById("codigo_field").value = "";
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
            document.getElementById('buscar_field').value = "";
            document.getElementById("contraseña_field").className = "";
            document.getElementById("contraseña_field").title = "";
            document.getElementById("contraseña_field").value = "";
            document.getElementById("codigo_field").disabled = false;
            document.getElementById("cedula_field").disabled = false;
            document.getElementById("editar_boton").hidden = true;
            document.getElementById("cancelar").hidden = true;
            document.getElementById("agregar_boton").hidden = false;
            document.getElementById("codigo").checked = true;
            cuadroBusqueda = document.getElementById("buscar_field");
            cuadroBusqueda.value="";
            cuadroBusqueda.className="";
            cuadroBusqueda.title="";
            ListaMedicos();
        }

        function limpiarCampos2() {
            document.getElementById("codigo_field").className = "";
            document.getElementById("codigo_field").title = "";
            document.getElementById("codigo_field").value = "";
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
            document.getElementById("contraseña_field").className = "";
            document.getElementById("contraseña_field").title = "";
            document.getElementById("contraseña_field").value = "";
            document.getElementById("codigo_field").disabled = false;
            document.getElementById("cedula_field").disabled = false;
            document.getElementById("editar_boton").hidden = true;
            document.getElementById("cancelar").hidden = true;
            document.getElementById("agregar_boton").hidden = false;
        }

        function limpiarErrores() {
            document.getElementById("codigo_field").className = "";
            document.getElementById("codigo_field").title = "";
            document.getElementById("codigo_field").value = "";
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
    </script>

</body>
</html>
