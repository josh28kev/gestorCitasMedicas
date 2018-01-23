<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Listado de citas</title>
        <%@ include file="../jspf/Imports.jspf" %>
        <link rel="stylesheet" type="text/css" href="../css/Calendar.css"/>
        <script type="text/javascript" src="../js/Calendar.js"></script>
        <script type="text/javascript" src="../js/Calendar_aux.js"></script>
    </head>
    <body>
        <%@ include file="../jspf/Encabezado.jspf" %>
        <%@ include file="../jspf/Sub_Encabezado_Medico.jspf" %>
        <div>
            <table>
                <tr>
                    <td>Buscar por: </td>
                    <td><input type="radio" name="radiobutton" id="rfecha" onClick="modo=1;vaciar1();" checked>fecha</td>
                    <td><input type="radio" name="radiobutton" id="rnombre" onClick="modo=2;vaciar1();">nombre</td>
                    <td><input type="radio" name="radiobutton" id="rcedula" onClick="modo=3;vaciar1();">cédula</td>
                </tr>
                <tr>
                    <td colspan="3"><input type="text" size="35" id="campo_buscar" 
                        onClick="if(modo===1){event.cancelBubble=true;cal.showCalendar(this);}"
                        onInput="if(modo===1){vaciar1();}"></td>
                    <td><input type="button" value="Buscar" onClick="buscar();"></td>
                </tr>
            </table>
        </div>
        <span id="titulo">
            Próximas citas:
        </span>
        <div style="width:100%; height:570.25px;">
            <div style="width:60%; height:100%; float:left;">
                <table id="tabla_citas"  class="GRID">
                    <thead>
                        <tr>
                            <th style="width: 12%;">Paciente</th>
                            <th style="width: 12%;">Fecha</th>
                            <th style="width: 12%;">Hora</th>
                            <th style="width: 55%;">Descripción</th>
                            <th style="width: 9%;"></th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
            <div style="width:38%; float:right; padding-top:2%; padding-left:2%;">
            <form>
            <table frame="box">
                <tr>
                    <td>Editar cita:</td><td></td>
                </tr>
                <tr>
                    <td>Código del paciente:</td><td><input type="text" id="cod_paciente" disabled></td>
                </tr>
                <tr>
                    <td>Fecha de la cita:</td>
                    <td><input type="text" id="fecha" oninput="vaciar2();" onclick="event.cancelBubble=true;cal2.showCalendar(this);" disabled></td>
                </tr>
                <tr>
                    <td>Hora:</td><td><input type="text" id="hora" maxlength="5" disabled></td>
                </tr>
                <tr>
                    <td>Descripción:</td><td><input type="text" id="descripcion" disabled></td>
                </tr>
                <tr>
                    <td colSpan="2" style="text-align: center;">
                        <input type="button" id="boton_actualizar" value="Editar" onClick="actualizar();" disabled>
                        <input type="button" id="boton_cancelar" value="Cancelar" onClick="limpiar_campos();bloquear_desbloquear_campos(true);" disabled>
                    </td>
                </tr>
                <tr>
                    <td colSpan="2" id="resultado"></td>
                </tr>
            </table>
            </form>
            </div>
            <div style="width:38%; float:right; padding-top:2%; padding-left:2%;">
                <table frame="box" id="observaciones" >
                    <thead>
                        <tr><td style="width: 278px">Observaciones:</td></tr>
                    </thead>
                    <tbody></tbody>
                </table>
                <table frame="box">
                    <thead></thead>
                    <tbody id="nuevas_observaciones">
                    </tbody>
                    <tbody id="botones">
                        <tr>
                            <td style="width: 278px"><input type="button" id="boton_nueva_ob" value="Nueva" onClick="nueva_observacion();" disabled>
                            <input type="button" id="boton_guardar_obs" value="Guardar" onClick="guardar_observaciones();" disabled></td>
                        </tr>
                        <tr><td id="resultado_obs"></td></tr>
                    </tbody>
                </table>
            </div>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", pageLoad);
            var modo = 1; // 1 fecha 2 nombre 3 cedula
            var nuevas_observaciones = 0;
            
            function pageLoad(){
                tabla_citas = document.getElementById("tabla_citas");
                tabla_citas.toCell = tabla_citas_toCell;
                tabla_observaciones = document.getElementById("observaciones");
                tabla_observaciones.toCell = tabla_observaciones_toCell;
                colocar_proximas_citas();
            }
            
            function buscar(){
                if(modo === 1) // buscar por fecha
                    buscar_citas_fecha(obtener("campo_buscar"));
                if(modo === 2) // buscar por nombre
                    buscar_citas_nombre(obtener("campo_buscar"));
                if(modo === 3) // buscar por cedula
                    buscar_citas_cedula(obtener("campo_buscar"));
            }
            
            function buscar_citas_fecha(fecha){
                if(obtener("campo_buscar") === ""){
                    vaciar_tabla(tabla_citas);
                    document.getElementById("titulo").innerHTML="Búsqueda por fecha: (sin resultados)";
                    return;
                }
                Proxy.buscar_citas_fecha(fecha,
                    function(citas){
                        tabla_citas = document.getElementById("tabla_citas");
                        lista_citas = new Lista();
                        lista_citas.items=citas;
                        if (lista_citas.size() < 1){
                            vaciar_tabla(tabla_citas);
                            document.getElementById("titulo").innerHTML="Búsqueda por fecha: (sin resultados)";
                            return;
                        }
                        document.getElementById("titulo").innerHTML="Búsqueda por fecha:";
                        guardar_citas(lista_citas);
                        Table.actualizar(tabla_citas,lista_citas);
                    });
            }
            
            function buscar_citas_nombre(nombre){
                if(obtener("campo_buscar") === ""){
                    vaciar_tabla(tabla_citas);
                    document.getElementById("titulo").innerHTML="Búsqueda por nombre: (sin resultados)";
                    return;
                }
                Proxy.buscar_citas_nombre(nombre,
                    function(citas){
                        tabla_citas = document.getElementById("tabla_citas");
                        lista_citas = new Lista();
                        lista_citas.items=citas;
                        if (lista_citas.size() < 1){
                            vaciar_tabla(tabla_citas);
                            document.getElementById("titulo").innerHTML="Búsqueda por nombre: (sin resultados)";
                            return;
                        }
                        document.getElementById("titulo").innerHTML="Búsqueda por nombre:";
                        guardar_citas(lista_citas);
                        Table.actualizar(tabla_citas,lista_citas);
                    });
            }
            
            function buscar_citas_cedula(cedula){
                if(obtener("campo_buscar") === ""){
                    vaciar_tabla(tabla_citas);
                    document.getElementById("titulo").innerHTML="Búsqueda por cedula: (sin resultados)";
                    return;
                }
                Proxy.buscar_citas_cedula(cedula,
                    function(citas){
                        tabla_citas = document.getElementById("tabla_citas");
                        lista_citas = new Lista();
                        lista_citas.items=citas;
                        if (lista_citas.size() < 1){
                            vaciar_tabla(tabla_citas);
                            document.getElementById("titulo").innerHTML="Búsqueda por cedula: (sin resultados)";
                            return;
                        }
                        document.getElementById("titulo").innerHTML="Búsqueda por cedula:";
                        guardar_citas(lista_citas);
                        Table.actualizar(tabla_citas,lista_citas);
                    });
            }
            
            function colocar_proximas_citas(){
                Proxy.proximas_citas(
                    function(citas){
                        tabla_citas = document.getElementById("tabla_citas");
                        lista_citas = new Lista();
                        lista_citas.items=citas;
                        if (lista_citas.size() < 1){
                            vaciar_tabla(tabla_citas);
                            document.getElementById("titulo").innerHTML="Próximas citas: (sin resultados)";
                            return;
                        }
                        guardar_citas(lista_citas);
                        Table.actualizar(tabla_citas,lista_citas);
                    });
            }
            
            function vaciar1(){
                poner("campo_buscar","");
            }
            
            function vaciar2(){
                poner("fecha","");
            }
            
            function vaciar_tabla(tabla){
                body = tabla.tBodies[0];
                while (body.firstChild) 
                    body.removeChild(body.firstChild);
            }
            
            function limpiar_msj(td){
                while(td.firstChild)
                    td.removeChild(td.firstChild);
            }
            
            function tabla_citas_toCell(obj,colIdx){
            switch(colIdx){
                case 0:  
                    content=document.createTextNode(obj.paciente);
                    return content;
                case 1: 
                    content=document.createTextNode(obj.fecha);
                    return content;
                case 2: 
                    content=document.createTextNode(obj.hora);
                    return content;
                case 3: 
                    content=document.createTextNode(obj.descripcion);
                    return content;
                case 4: 
                    content= document.createElement("button");
                    content.innerHTML ="Ver";
                    content.addEventListener("click", function(e){editar(e.target);});
                    return content;
                };
                return null;
        }
        
        function tabla_observaciones_toCell(obj,colIdx){
            switch(colIdx){
                case 0:  
                    content=document.createTextNode(obj.observacion);
                    return content;
                };
                return null;
        }
        
        function editar(target){
            lista_citas = cargar_citas();
            cita = lista_citas.get(target.rowIdx);
            bloquear_desbloquear_campos(false);
            poner("cod_paciente",cita.paciente);
            poner("fecha",cita.fecha);
            poner("hora",cita.hora);
            poner("descripcion",cita.descripcion);
            guardar_string("cita_siendo_editada",cita.codigo_cita);
            cargar_observaciones(cita.codigo_cita);
            
            var f = new Date();
            var fechahoy = Date.parse(f.getDate() + "/" + (f.getMonth() +1) + "/" + f.getFullYear()+" "+f.getHours()+":"+f.getMinutes());
            var fechacita = Date.parse(cita.fecha+" "+cita.hora);
            if(fechahoy >= fechacita){
                document.getElementById("fecha").disabled = true;
                document.getElementById("hora").disabled = true;
                document.getElementById("descripcion").disabled = true;
                document.getElementById("boton_actualizar").disabled = true;
            }
        }
        
        function cargar_observaciones(codigo_cita){
           Proxy.obtener_observaciones(codigo_cita,
                    function(observaciones){
                        tabla_observaciones = document.getElementById("observaciones");
                        lista_observaciones = new Lista();
                        lista_observaciones.items=observaciones;
                        if (lista_observaciones.size() < 1){
                            vaciar_tabla(tabla_observaciones);
                            return;
                        }
                        Table.actualizar(tabla_observaciones,lista_observaciones);
                    });
        }
        
        function nueva_observacion(){
            tabla = document.getElementById("nuevas_observaciones");
            tr_inicio = document.createElement("tr");
            td = document.createElement("td");
            campo = document.createElement("INPUT");
            campo.id="no"+nuevas_observaciones;
            campo.size="41";
            nuevas_observaciones++;
            td.appendChild(campo);
            tr_inicio.appendChild(td);
            tabla.appendChild(tr_inicio);
        }
        
        function guardar_observaciones(){
            var num = 0; var bool = false;
            while(num < nuevas_observaciones){
                obs = new Observacion(cargar_string("cita_siendo_editada"),"0000-00-00",document.getElementById("no"+num).value);
                if(obs.observacion !== ""){
                    Proxy.guardar_observacion(obs,
                        function(resultado){
                            if(resultado.texto === "0")
                                bool = true;
                        });
                }
                num++;
            }
            if(!bool){
                document.getElementById("resultado_obs").innerHTML="Observaciones guardadas";
                tabla = document.getElementById("nuevas_observaciones");
                while(tabla.firstChild)
                    tabla.removeChild(tabla.firstChild);
                nuevas_observaciones = 0;
                cargar_observaciones(cargar_string("cita_siendo_editada"));
            }
            else
                document.getElementById("resultado_obs").innerHTML="Error guardando las observaciones";
        }
        
        function actualizar(){
            td = document.getElementById("resultado");
                limpiar_msj(td);
            if(!validar()){return;}
            var codigo_cita = cargar_string("cita_siendo_editada");
            cita = new Cita(-1,obtener("cod_paciente"),obtener("fecha"),obtener("hora"),obtener("descripcion"),codigo_cita);
            
            Proxy.actualizar_cita(cita,
                function(res){
                    if(res.texto === "0"){
                        td.appendChild(document.createTextNode("Cita editada correctamente."));
                        limpiar_campos();
                        bloquear_desbloquear_campos(true);
                        buscar();
                    }
                    else{
                        td.appendChild(document.createTextNode("Error: no se ha podido editar la cita."));
                    }
                });
            
            guardar_string("cita_siendo_editada",null);
        }
        
        function revisar_hora(){
                var hora = obtener("hora");
                var v1 = hora.substring(0, 2);
                var v2 = hora.substring(2, 3);
                var v3 = hora.substring(3, 5);
                if( isNaN(v1) || v2 !== ':' || isNaN(v3) )
                    return false;
                if( v1>23 || v1<0 || v3>59 || v3<0)
                    return false;
                return true;
        }
        
        function limpiar_campos(){
                poner("cod_paciente","");
                poner("fecha","");
                poner("hora","");
                poner("descripcion","");
                vaciar_tabla(document.getElementById("observaciones"));
        }
            
        function bloquear_desbloquear_campos(bool){
            document.getElementById("fecha").disabled = bool;
            document.getElementById("hora").disabled = bool;
            document.getElementById("descripcion").disabled = bool;
            document.getElementById("boton_actualizar").disabled = bool;
            document.getElementById("boton_cancelar").disabled = bool;
            document.getElementById("boton_nueva_ob").disabled = bool;
            document.getElementById("boton_guardar_obs").disabled = bool;
        } 
        
        function validar(){
                var bool = true;
                if (obtener("cod_paciente") === "" || isNaN(obtener("cod_paciente"))){
                    document.getElementById("cod_paciente").className = "error";
                    document.getElementById("cod_paciente").title = "Debe digitar sólo números y el campo no puede estar vacío";
                    bool = false;
                }
                else{
                    document.getElementById("cod_paciente").className = "";
                    document.getElementById("cod_paciente").title = "";
                }
                if(obtener("fecha") === ""){
                    document.getElementById("fecha").className = "error";
                    document.getElementById("fecha").title = "Debe ingresar una fecha";
                    bool = false;
                }
                else{
                    document.getElementById("fecha").className = "";
                    document.getElementById("fecha").title = "";
                }
                if(obtener("hora") === ""){
                    document.getElementById("hora").className = "error";
                    document.getElementById("hora").title = "Debe ingresar una hora";
                    bool = false;
                }
                else 
                    if(revisar_hora() === false){
                        document.getElementById("hora").className = "error";
                        document.getElementById("hora").title = "Hora incorrecta, ejemplo de hora: 13:35";
                        bool = false;
                    }
                    else{
                        document.getElementById("hora").className = "";
                        document.getElementById("hora").title = "";
                    }
                if(obtener("descripcion") === ""){
                    document.getElementById("descripcion").className = "error";
                    document.getElementById("descripcion").title = "Debe digitar una descripción";
                    bool = false;
                }
                else{
                    document.getElementById("descripcion").className = "";
                    document.getElementById("descripcion").title = "";
                }
                return bool;
            }
        </script>
    </body>
</html>
