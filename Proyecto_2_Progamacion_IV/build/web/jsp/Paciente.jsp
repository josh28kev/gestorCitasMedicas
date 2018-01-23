<%-- 
    Document   : Paciente
    Created on : 19/05/2016, 08:55:46 PM
    Author     : Pablo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Pacientes</title>
         <%@ include file="../jspf/Imports.jspf" %>
         <link rel="stylesheet" type="text/css" href="../css/Calendar.css"/>
        <script type="text/javascript" src="../js/Calendar.js"></script>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <%@ include file="../jspf/Encabezado.jspf" %>
        <!--<input type="button" onclick="obtener_citas();" value="PRESIONAME"></input>-->
        <br><div class="busquedadepaciente">Busqueda de Citas
        <input type="text" id="busquedadepaciente" onclick="onclickBusqueda(this);" oninput="oninputBusqueda();"></input>
        <a href="javascript:obtenerCitasCriterio();"><img src="../imagenes/lupa.png"></img></a>
        <input type="radio" name="criterio" id="rfecha" onclick="oninputBusqueda();" checked>Búsqueda por fecha</input>
        <input type="radio" name="criterio" id="rmedico">Búsqueda por médico</input>
        </div>
        <br>
        <table border="0"  id="tabladecitas" class="tabladecitas">
            <tr>
                <td style="width:10%"><b>Médico</b></td>
                <td style="width:5%"><b>Fecha</b></td>
                <td style="width:5%"><b>Hora</b></td>
                <td style="width:50%"><b>Descripción</b></td>
                <td style="width:7%"><b>N° Cita</b></td>
                <td style="width:5%"></td>
            </tr>
        </table>
        <div id="sinresultados" align="center">No se encontraron resultados</div>
        <div id="popuppaciente" class="popuppaciente"></div>
        <div id="overlay" class="overlay"></div>
    </body>
    
    <script>
        document.addEventListener("DOMContentLoaded", pageLoad);

        function pageLoad(){
            //debería de redirigirse al usuario si este no se ha logueado
            obtenerCitas();
        }
        
        function obtenerCitas() {
            Proxy.busquedaCitasPaciente(
                function(lista) {
                    l = new Lista();
                    l.items = lista;
                    c = new Cita();
                    if(l.size()===0) document.getElementById("sinresultados").style.display='block';
                    i = 0;
                    while(i<l.size()) {
                       c = l.get(i);
                       construccionHilera(c,i+1);
                       i++;
                    }
            });
        }
        
        function obtenerCitasCriterio() {
            var tipo;
            if(document.getElementById("rfecha").checked == true) tipo = 1;
            else tipo = 2;
            Proxy.busquedaCitasCriterioPaciente(tipo,document.getElementById("busquedadepaciente").value,
                function(lista) {
                    destruccionTabla();
                    construccionEncabezadoResultados();
                    l = new Lista();
                    l.items = lista;
                    c = new Cita();
                    if(l.size()===0) document.getElementById("sinresultados").style.display='block';
                    i = 0;
                    while(i<l.size()) {
                       c = l.get(i);
                       construccionHilera(c,i+1);
                       i++;
                    }
                });
        }
        
        function destruccionTabla() {
            tabla = document.getElementById("tabladecitas");
            while(tabla.firstChild) tabla.removeChild(tabla.firstChild);
            document.getElementById("sinresultados").style.display='none';
        }
        
        function construccionEncabezadoResultados() {
            tabla = document.getElementById("tabladecitas");
            tr = document.createElement("tr");
            tdMed = document.createElement("td");
            tdFec = document.createElement("td");
            tdHor = document.createElement("td");
            tdDes = document.createElement("td");
            tdCod = document.createElement("td");
            tdBot = document.createElement("td");
            tdMed.appendChild(document.createTextNode("Medico"));
            tdFec.appendChild(document.createTextNode("Fecha"));
            tdHor.appendChild(document.createTextNode("Hora"));
            tdDes.appendChild(document.createTextNode("Descripcion"));
            tdCod.appendChild(document.createTextNode("N° cita"));
            tdMed.style = "width:10%;";
            tdFec.style = "width:5%;";
            tdHor.style = "width:5%;";
            tdDes.style = "width:50%;";
            tdCod.style = "width:10%;";
            tdBot.style = "width:7%;";
            tdMed.style.fontWeight = 'bold';
            tdFec.style.fontWeight = 'bold';
            tdHor.style.fontWeight = 'bold';
            tdDes.style.fontWeight = 'bold';
            tdCod.style.fontWeight = 'bold';
            tr.appendChild(tdMed);
            tr.appendChild(tdFec);
            tr.appendChild(tdHor);
            tr.appendChild(tdDes);
            tr.appendChild(tdCod);
            tr.appendChild(tdBot);
            tabla.appendChild(tr);
        }
        
        function construccionHilera(c,i) {
            tabla = document.getElementById("tabladecitas");
            tr = document.createElement("tr");
            tdMed = document.createElement("td");
            tdFec = document.createElement("td");
            tdHor = document.createElement("td");
            tdDes = document.createElement("td");
            tdCod = document.createElement("td");
            tdBot = document.createElement("td");
            tdMed.appendChild(document.createTextNode(c.medico));
            tdFec.appendChild(document.createTextNode(c.fecha));
            tdHor.appendChild(document.createTextNode(c.hora));
            tdDes.appendChild(document.createTextNode(c.descripcion));
            tdCod.appendChild(document.createTextNode(c.codigo_cita));
            tdMed.row = i;tdMed.id = "m"+i;
            tdFec.row = i;tdFec.id = "f"+i;
            tdHor.row = i;tdHor.id = "h"+i;
            tdDes.row = i;tdDes.id = "d"+i;
            tdCod.row = i;tdCod.id = "c"+i;
            tdBot.row = i;tdBot.id = "b"+i;
            boton = document.createElement("input");
            boton.type = "button";
            boton.addEventListener("click",function(e){ mostrarInformacionCompleta(e.target);});
            boton.value = "Información";
            boton.row = i;
            tdBot.appendChild(boton);
            tr.appendChild(tdMed);
            tr.appendChild(tdFec);
            tr.appendChild(tdHor);
            tr.appendChild(tdDes);
            tr.appendChild(tdCod);
            tr.appendChild(tdBot);
            tabla.appendChild(tr);
        }
        
        function onclickBusqueda(t) {
            if(document.getElementById("rfecha").checked == true) {
                event.cancelBubble=true;
                cal.showCalendar(t);
            }
        }
        
        function oninputBusqueda() {
            if(document.getElementById("rfecha").checked == true) {
                document.getElementById("busquedadepaciente").value = "";
            }
        }
        
        function mostrarInformacionCompleta(target) {
            popuppaciente = document.getElementById("popuppaciente");
            document.getElementById("overlay").style.display = "block"; 
            popuppaciente.style.display = "block";
            boton = document.createElement("img");
            boton.src = "../imagenes/regresar.png";
            boton.addEventListener("click",function(e) {
               document.getElementById("overlay").style.display = "none"; 
               popuppaciente.style.display = "none";
               while(popuppaciente.firstChild)
                   popuppaciente.removeChild(popuppaciente.firstChild);
            });
            popuppaciente.appendChild(boton);
            popuppaciente.appendChild(document.createElement("br"));
            construccionPopup(target);
            popuppaciente.appendChild(document.createElement("br"));
        }
        
        function construccionPopup(target) {
            //CITA MÉDICA
            pretable = document.createElement("table");
            pretable.border = 0;
            ptr = document.createElement("tr");
            ptd = document.createElement("td");
            ptd.style = "font-size:20px;fontWeight:bold";
            ptd.innerHTML = "CITA MÉDICA";
            ptr.appendChild(ptd);pretable.appendChild(ptr);
            document.getElementById("popuppaciente").appendChild(pretable);
            document.getElementById("popuppaciente").appendChild(document.createElement("hr"));
            //Detalles de cita
            table = document.createElement("table");
            table.border = 0;
            table.id = 'tablapopup';table.class = 'tablapopup';
            trM = document.createElement("tr");
            tdM1 = document.createElement("td");
            tdM1.innerHTML = "Médico:";tdM1.align = "right";
            tdM1.style.fontWeight = 'bold';
            tdM2 = document.createElement("td");
            tdM2.innerHTML = document.getElementById("m"+target.row).innerHTML;
            trM.appendChild(tdM1);trM.appendChild(tdM2);table.appendChild(trM);
            trF = document.createElement("tr");
            tdF1 = document.createElement("td");
            tdF1.innerHTML = "Fecha:";tdF1.align = "right";
            tdF1.style.fontWeight = 'bold';
            tdF2 = document.createElement("td");
            tdF2.innerHTML = document.getElementById("f"+target.row).innerHTML;
            trF.appendChild(tdF1);trF.appendChild(tdF2);table.appendChild(trF);
            trH = document.createElement("tr");
            tdH1 = document.createElement("td");
            tdH1.innerHTML = "Hora:";tdH1.align = "right";
            tdH1.style.fontWeight = 'bold';
            tdH2 = document.createElement("td");
            tdH2.innerHTML = document.getElementById("h"+target.row).innerHTML;
            trH.appendChild(tdH1);trH.appendChild(tdH2);table.appendChild(trH);
            trD = document.createElement("tr");
            tdD1 = document.createElement("td");
            tdD1.innerHTML = "Descripción:";tdD1.align = "right";
            tdD1.style.fontWeight = 'bold';
            tdD2 = document.createElement("td");
            tdD2.innerHTML = document.getElementById("d"+target.row).innerHTML;
            trD.appendChild(tdD1);trD.appendChild(tdD2);table.appendChild(trD);
            trN = document.createElement("tr");
            tdN1 = document.createElement("td");
            tdN1.innerHTML = "N° Cita:";tdN1.align = "right";
            tdN1.style.fontWeight = 'bold';
            tdN2 = document.createElement("td");
            tdN2.innerHTML = document.getElementById("c"+target.row).innerHTML;
            trN.appendChild(tdN1);trN.appendChild(tdN2);table.appendChild(trN);
            document.getElementById("popuppaciente").appendChild(table);
            popuppaciente.appendChild(document.createElement("hr"));
            t2 = document.createElement('table');
            t2.border = 0;tr = document.createElement("tr");
            td = document.createElement("td");
            td.style.fontWeight = 'bold';td.innerHTML = "Observaciones:";
            tr.appendChild(td);t2.appendChild(tr);popuppaciente.appendChild(t2);
            //Observaciones de cita
            construccionObservaciones(target);
        }
        
        function construccionObservaciones(target) {
            cita = document.getElementById("c"+target.row).innerHTML;
            Proxy.obtenerObservaciones(cita,
                function(lista) {
                    l = new Lista();
                    l.items = lista;
                    c = new Observacion();
                    if(l.size() === 0) 
                        document.getElementById("popuppaciente").appendChild(document.createTextNode("-Sin observaciones"));
                    i = 0;
                    while(i<l.size()) {
                       c = l.get(i);
                       construccionObservacion(c);
                       i++;
                    }
                });
        }
        
        function construccionObservacion(c) {
            document.getElementById("popuppaciente").appendChild(document.createTextNode("("+c.fecha+"): "+c.observacion));
            document.getElementById("popuppaciente").appendChild(document.createElement("br"));
        }
    </script>
</html>
