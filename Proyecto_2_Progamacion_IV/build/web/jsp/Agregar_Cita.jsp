<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@ include file="../jspf/Imports.jspf" %>
        <link rel="stylesheet" type="text/css" href="../css/Calendar.css"/>
        <script type="text/javascript" src="../js/Calendar.js"></script>
        <title>Agregar Cita</title>
    </head>
    <body>
        <%@ include file="../jspf/Encabezado.jspf" %>
        <%@ include file="../jspf/Sub_Encabezado_Medico.jspf" %>
        <form>
            <table>
                <tr>
                    <td>Agregar nueva cita:</td><td></td>
                </tr>
                <tr>
                    <td>Código del paciente:</td><td><input type="text" id="cod_paciente"></td>
                </tr>
                <tr>
                    <td>Fecha de la cita:</td>
                    <td><input type="text" id="fecha" oninput="vaciar();" onclick="event.cancelBubble=true;cal.showCalendar(this);"></td>
                </tr>
                <tr>
                    <td>Hora:</td><td><input type="text" id="hora" maxlength="5"></td>
                </tr>
                <tr>
                    <td>Descripción:</td><td><input type="text" id="descripcion"></td>
                </tr>
                <tr><td colSpan="2"><input type="button" value="Listo" onClick="enviar();"></td></tr>
                <tr>
                    <td colSpan="2" id="resultado"></td>
                </tr>
            </table>
        </form>
        <script>
        function prueba(){
            poner("cod_paciente",123456789);
                poner("fecha","13/5/2016");
                poner("hora","12:29");
                poner("descripcion","asd");
        }
    
            function enviar(){
                td = document.getElementById("resultado");
                limpiar_msj(td);
                if(validar() === false)
                    return;
                
                cita = new Cita(0,obtener("cod_paciente"),obtener("fecha"),obtener("hora"),obtener("descripcion"),-1);
                Proxy.agregar_cita(cita,
                    function(res){
                        if(res.texto !== "0"){
                            td.appendChild(document.createTextNode("Cita agregada correctamente."));
                            limpiar_campos();
                        }
                        else{
                            td.appendChild(document.createTextNode("Error: no se ha podido agregar la cita."));
                        }
                    });
            }
            
            function validar(){
                var bool = true, listo = false;
                if (obtener("cod_paciente") === "" || isNaN(obtener("cod_paciente"))){
                    document.getElementById("cod_paciente").className = "error";
                    document.getElementById("cod_paciente").title = "Debe digitar sólo números y el campo no puede estar vacío";
                    bool = false;
                }
                else{
                    listo = existe(obtener("cod_paciente"));
                    if(listo && document.getElementById("cod_paciente").className === "error"){
                           bool = false; listo = false;
                    }
                    else{
                       document.getElementById("cod_paciente").className = "";
                       document.getElementById("cod_paciente").title = "";
                    }
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
            
            function vaciar(){
                poner("fecha","");
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
            
            function existe(cod){
                c = cod;
                Proxy.existe_paciente(c,
                    function(res){
                        if (res.texto === "false"){
                            document.getElementById("cod_paciente").className = "error";
                            document.getElementById("cod_paciente").title = "No hay ningún paciente con ese código";
                        }
                        else{
                            document.getElementById("cod_paciente").className = "";
                            document.getElementById("cod_paciente").title = "";
                        }
                    });
                return true;
            }
            
            function limpiar_msj(td){
                while(td.firstChild)
                    td.removeChild(td.firstChild);
            }
            
            function limpiar_campos(){
                poner("cod_paciente","");
                poner("fecha","");
                poner("hora","");
                poner("descripcion","");
            }
        </script>
    </body>
</html>
