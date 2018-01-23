<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Ejemplo</title>
        <%@ include file="../jspf/Imports.jspf" %>
    </head>
    <body>
        <%@ include file="../jspf/Encabezado.jspf" %>
        <table id="hola"></table>
    </body>
    <!--<script>
 document.addEventListener("DOMContentLoaded", pageLoad);

    function pageLoad(){
        retornar_palabra("hola");
    }
        
    function retornar_palabra(t){
        Proxy.ejemplo(t,
                function(palabra){
                   
                    hola = palabra;
                  
                });
    }
    </script>-->
</html>
