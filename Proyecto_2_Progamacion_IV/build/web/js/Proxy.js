var Proxy = Proxy || {};

Proxy.ejemplo = function(t, callBack) {
    jsonText = t;
    var AJAX_req = new XMLHttpRequest();
    url = "/Proyecto_2_Progamacion_IV/Servlet_Principal?action=hola";
    AJAX_req.open("POST", url, true);
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    AJAX_req.onreadystatechange = function() {
        if (AJAX_req.readyState === 4 && AJAX_req.status === 200) {
            jsonText = AJAX_req.responseText;
            var object = JSON.parse(jsonText, revive);
            callBack(object);
        }
    };
    AJAX_req.send(jsonText);
};

//-----------------------------------------------------------------------------------------
//------------------------------------- Usuarios ------------------------------------------
//-----------------------------------------------------------------------------------------

Proxy.userLogin = function(user, callBack) {
    jsonText = JSON.stringify(user, replacer);
    var AJAX_req = new XMLHttpRequest();
    url = "/Proyecto_2_Progamacion_IV/Servlet_Principal?action=userLogin";
    AJAX_req.open("POST", url, true);
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    AJAX_req.onreadystatechange = function() {
        if (AJAX_req.readyState === 4 && AJAX_req.status === 200) {
            jsonText = AJAX_req.responseText;
            var object = JSON.parse(jsonText, revive);
            callBack(object);
        }
    };
    AJAX_req.send("user=" + jsonText);
};

Proxy.userLogout = function(callBack) {
    var AJAX_req = new XMLHttpRequest();
    url = "/Proyecto_2_Progamacion_IV/Servlet_Principal?action=userLogout";
    AJAX_req.open("POST", url, true);
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    AJAX_req.onreadystatechange = function() {
        if (AJAX_req.readyState === 4 && AJAX_req.status === 200) {
            callBack();
        }
    };
    AJAX_req.send();
};

Proxy.buscarUsuario = function(id, callBack) {
    jsonText = id;
    var AJAX_req = new XMLHttpRequest();
    url = "/Proyecto_2_Progamacion_IV/Servlet_Principal?action=buscarUsuario";
    AJAX_req.open("POST", url, true);
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    AJAX_req.onreadystatechange = function() {
        if (AJAX_req.readyState === 4 && AJAX_req.status === 200) {
            jsonText = AJAX_req.responseText;
            var object = JSON.parse(jsonText, revive);
            callBack(object);
        }
    };
    AJAX_req.send("id=" + jsonText);
};

Proxy.agregarUsuario = function(usuario, callBack) {
    jsonUsuario = JSON.stringify(usuario, replacer);
    var AJAX_req = new XMLHttpRequest();
    url = "/Proyecto_2_Progamacion_IV/Servlet_Principal?action=agregarUsuario";
    AJAX_req.open("POST", url, true);
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    AJAX_req.onreadystatechange = function() {
        if (AJAX_req.readyState === 4 && AJAX_req.status === 200) {
            jsonText = AJAX_req.responseText;
            var object = JSON.parse(jsonText, revive);
            callBack(object);
        }
    };
    AJAX_req.send("usuario=" + jsonUsuario);
};

Proxy.modificarUsuario = function(usuario, callBack) {
    jsonText = JSON.stringify(usuario, replacer);
    var AJAX_req = new XMLHttpRequest();
    url = "/Proyecto_2_Progamacion_IV/Servlet_Principal?action=modificarUsuario";
    AJAX_req.open("POST", url, true);
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    var callBackConstructor = function(productParameter) {
        return function() {
            if (AJAX_req.readyState === 4 && AJAX_req.status === 200) {
                callBack(productParameter);
            }
        };
    };
    AJAX_req.onreadystatechange = callBackConstructor(usuario);
    AJAX_req.send("usuario=" + jsonText);
};

Proxy.obtenerUsuario = function(callBack) {
    var AJAX_req = new XMLHttpRequest();
    url = "/Proyecto_2_Progamacion_IV/Servlet_Principal?action=retornarSesion";
    AJAX_req.open("POST", url, true);
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    AJAX_req.onreadystatechange = function() {
        if (AJAX_req.readyState === 4 && AJAX_req.status === 200) {
            jsonText = AJAX_req.responseText;
            var object = JSON.parse(jsonText, revive);
            callBack(object);
        }
    };
    AJAX_req.send();
};

//-----------------------------------------------------------------------------------------
//------------------------------------- Medicos -------------------------------------------
//-----------------------------------------------------------------------------------------

Proxy.agregarMedico = function(medico, callBack) {
    jsonMedico = JSON.stringify(medico, replacer);
    var AJAX_req = new XMLHttpRequest();
    url = "/Proyecto_2_Progamacion_IV/Servlet_Principal?action=agregarMedico";
    AJAX_req.open("POST", url, true);
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    AJAX_req.onreadystatechange = function() {
        if (AJAX_req.readyState === 4 && AJAX_req.status === 200) {
            jsonText = AJAX_req.responseText;
            var status = JSON.parse(jsonText, revive);
            callBack(status);
        }
    };
    AJAX_req.send("medico=" + jsonMedico);

};


Proxy.medicoGet = function(callBack) {
    var AJAX_req = new XMLHttpRequest();
    url = "/Proyecto_2_Progamacion_IV/Servlet_Principal?action=medicoGet";
    AJAX_req.open("POST", url, true);
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    AJAX_req.onreadystatechange = function() {
        if (AJAX_req.readyState === 4 && AJAX_req.status === 200) {
            jsonText = AJAX_req.responseText;
            var object = JSON.parse(jsonText, revive);
            callBack(object);
        }
    };
    AJAX_req.send();
};

Proxy.modificarMedico = function(medico, callBack) {
    jsonText = JSON.stringify(medico, replacer);
    var AJAX_req = new XMLHttpRequest();
    url = "/Proyecto_2_Progamacion_IV/Servlet_Principal?action=modificarMedico";
    AJAX_req.open("POST", url, true);
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    var callBackConstructor = function(productParameter) {
        return function() {
            if (AJAX_req.readyState === 4 && AJAX_req.status === 200) {
                callBack(productParameter);
            }
        };
    };
    AJAX_req.onreadystatechange = callBackConstructor(medico);
    AJAX_req.send("medico=" + jsonText);
};

Proxy.ListaMedicos = function(callBack) {
    var AJAX_req = new XMLHttpRequest();
    url = "/Proyecto_2_Progamacion_IV/Servlet_Principal?action=ListaMedicos";
    AJAX_req.open("POST", url, true);
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    AJAX_req.onreadystatechange = function() {
        if (AJAX_req.readyState === 4 && AJAX_req.status === 200) {
            jsonText = AJAX_req.responseText;
            var object = JSON.parse(jsonText, revive);
            callBack(object);
        }
    };
    AJAX_req.send();
};

Proxy.busquedaNombreMedicos = function(criterio, callBack) {
    jsonText = criterio;
    var AJAX_req = new XMLHttpRequest();
    url = "/Proyecto_2_Progamacion_IV/Servlet_Principal?action=busquedaNombreMedicos";
    AJAX_req.open("POST", url, true);
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    AJAX_req.onreadystatechange = function() {
        if (AJAX_req.readyState === 4 && AJAX_req.status === 200) {
            jsonText = AJAX_req.responseText;
            var object = JSON.parse(jsonText, revive);
            callBack(object);
        }
    };
    AJAX_req.send("criterio=" + jsonText);
};

Proxy.busquedaCodigoMedicos = function(criterio, callBack) {
    jsonText = criterio;
    var AJAX_req = new XMLHttpRequest();
    url = "/Proyecto_2_Progamacion_IV/Servlet_Principal?action=busquedaCodigoMedicos";
    AJAX_req.open("POST", url, true);
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    AJAX_req.onreadystatechange = function() {
        if (AJAX_req.readyState === 4 && AJAX_req.status === 200) {
            jsonText = AJAX_req.responseText;
            var object = JSON.parse(jsonText, revive);
            callBack(object);
        }
    };
    AJAX_req.send("criterio=" + jsonText);
};

//-----------------------------------------------------------------------------------------
//------------------------------------- Pacientes -----------------------------------------
//-----------------------------------------------------------------------------------------

Proxy.pacienteGet = function(callBack) {
    var AJAX_req = new XMLHttpRequest();
    url = "/Proyecto_2_Progamacion_IV/Servlet_Principal?action=pacienteGet";
    AJAX_req.open("POST", url, true);
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    AJAX_req.onreadystatechange = function() {
        if (AJAX_req.readyState === 4 && AJAX_req.status === 200) {
            jsonText = AJAX_req.responseText;
            var object = JSON.parse(jsonText, revive);
            callBack(object);
        }
    };
    AJAX_req.send();
};

Proxy.modificarPaciente = function(paciente, callBack) {
    jsonText = JSON.stringify(paciente, replacer);
    var AJAX_req = new XMLHttpRequest();
    url = "/Proyecto_2_Progamacion_IV/Servlet_Principal?action=modificarPaciente";
    AJAX_req.open("POST", url, true);
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    var callBackConstructor = function(productParameter) {
        return function() {
            if (AJAX_req.readyState === 4 && AJAX_req.status === 200) {
                callBack(productParameter);
            }
        };
    };
    AJAX_req.onreadystatechange = callBackConstructor(paciente);
    AJAX_req.send("paciente=" + jsonText);
};

Proxy.agregarPaciente = function(paciente, callBack) {
    jsonPaciente = JSON.stringify(paciente, replacer);
    var AJAX_req = new XMLHttpRequest();
    url = "/Proyecto_2_Progamacion_IV/Servlet_Principal?action=agregarPaciente";
    AJAX_req.open("POST", url, true);
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    AJAX_req.onreadystatechange = function() {
        if (AJAX_req.readyState === 4 && AJAX_req.status === 200) {
            jsonText = AJAX_req.responseText;
            var status = JSON.parse(jsonText, revive);
            callBack(status);
        }
    };
    AJAX_req.send("paciente=" + jsonPaciente);
};

Proxy.eliminarPaciente = function(paciente, callBack) {
    jsonText = JSON.stringify(paciente, replacer);
    var AJAX_req = new XMLHttpRequest();
    url = "/Proyecto_2_Progamacion_IV/Servlet_Principal?action=eliminarPaciente";
    AJAX_req.open("POST", url, true);
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    var callBackConstructor = function(productParameter) {
        return function() {
            if (AJAX_req.readyState === 4 && AJAX_req.status === 200) {
                callBack(productParameter);
            }
        };
    };
    AJAX_req.onreadystatechange = callBackConstructor(paciente);
    AJAX_req.send("paciente=" + jsonText);
};

Proxy.busquedaNombrePacientes = function(criterio, callBack) {
    jsonText = criterio;
    var AJAX_req = new XMLHttpRequest();
    url = "/Proyecto_2_Progamacion_IV/Servlet_Principal?action=busquedaNombrePaciente";
    AJAX_req.open("POST", url, true);
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    AJAX_req.onreadystatechange = function() {
        if (AJAX_req.readyState === 4 && AJAX_req.status === 200) {
            jsonText = AJAX_req.responseText;
            var object = JSON.parse(jsonText, revive);
            callBack(object);
        }
    };
    AJAX_req.send("criterio=" + jsonText);
};

Proxy.busquedaCodigoPacientes = function(criterio, callBack) {
    jsonText = criterio;
    var AJAX_req = new XMLHttpRequest();
    url = "/Proyecto_2_Progamacion_IV/Servlet_Principal?action=busquedaCodigoPaciente";
    AJAX_req.open("POST", url, true);
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    AJAX_req.onreadystatechange = function() {
        if (AJAX_req.readyState === 4 && AJAX_req.status === 200) {
            jsonText = AJAX_req.responseText;
            var object = JSON.parse(jsonText, revive);
            callBack(object);
        }
    };
    AJAX_req.send("criterio=" + jsonText);
};

Proxy.ListaPacientes = function(callBack) {
    var AJAX_req = new XMLHttpRequest();
    url = "/Proyecto_2_Progamacion_IV/Servlet_Principal?action=ListaPacientes";
    AJAX_req.open("POST", url, true);
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    AJAX_req.onreadystatechange = function() {
        if (AJAX_req.readyState === 4 && AJAX_req.status === 200) {
            jsonText = AJAX_req.responseText;
            var object = JSON.parse(jsonText, revive);
            callBack(object);
        }
    };
    AJAX_req.send();
};

Proxy.existe_paciente = function(cod,callBack){
    jsoncodigo = cod;
    var AJAX_req = new XMLHttpRequest();
    url="/Proyecto_2_Progamacion_IV/Servlet_Principal?action=Existe_Paciente";
    AJAX_req.open( "POST", url, true );
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    AJAX_req.onreadystatechange = function(){
        if( AJAX_req.readyState === 4 && AJAX_req.status === 200 ){
            jsonText=AJAX_req.responseText;
            var object = JSON.parse( jsonText,revive );
            callBack(object);
        }
    };
    AJAX_req.send("codigo="+jsoncodigo);
};
//-----------------------------------------------------------------------------------------
//-------------------------------------   Citas   -----------------------------------------
//-----------------------------------------------------------------------------------------
Proxy.busquedaCitasPaciente = function(callBack){
    var AJAX_req = new XMLHttpRequest();
    url="/Proyecto_2_Progamacion_IV/Servlet_Principal?action=busquedaCitasPaciente";
    AJAX_req.open( "POST", url, true );
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    AJAX_req.onreadystatechange = function(){
        if( AJAX_req.readyState === 4 && AJAX_req.status === 200 ){
            jsonText=AJAX_req.responseText;
            var object = JSON.parse( jsonText,revive );
            callBack(object);
        }
    };
    AJAX_req.send();   
};

Proxy.busquedaCitasCriterioPaciente = function(tipo,criterio,callBack){
    var AJAX_req = new XMLHttpRequest();
    var url;
    if(tipo == 1) url="/Proyecto_2_Progamacion_IV/Servlet_Principal?action=busquedaCitasCFecha";
    else url="/Proyecto_2_Progamacion_IV/Servlet_Principal?action=busquedaCitasCMedico";
    AJAX_req.open( "POST", url, true );
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    AJAX_req.onreadystatechange = function(){
        if( AJAX_req.readyState === 4 && AJAX_req.status === 200 ){
            jsonText=AJAX_req.responseText;
            var object = JSON.parse( jsonText,revive );
            callBack(object);
        }
    };
    AJAX_req.send("cri="+criterio);   
};

Proxy.obtenerObservaciones = function(criterio,callBack) {
    var AJAX_req = new XMLHttpRequest();
    jsonText = criterio;
    url="/Proyecto_2_Progamacion_IV/Servlet_Principal?action=obtener_observaciones";
    AJAX_req.open( "POST", url, true );
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    AJAX_req.onreadystatechange = function(){
        if( AJAX_req.readyState === 4 && AJAX_req.status === 200 ){
            jsonText=AJAX_req.responseText;
            var object = JSON.parse( jsonText,revive );
            callBack(object);
        }
    };
    AJAX_req.send("criterio="+jsonText);  
};

Proxy.agregar_cita = function(cita,callBack){
    jsonCita = JSON.stringify(cita,replacer);
    var AJAX_req = new XMLHttpRequest();
    url="/Proyecto_2_Progamacion_IV/Servlet_Principal?action=Agregar_Cita";
    AJAX_req.open( "POST", url, true );
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    AJAX_req.onreadystatechange = function(){
        if( AJAX_req.readyState === 4 && AJAX_req.status === 200 ){
            jsonText=AJAX_req.responseText;
            var object = JSON.parse( jsonText,revive );
            callBack(object);
        }
    };
    AJAX_req.send("cita="+jsonCita);
};

Proxy.buscar_citas_fecha = function(fecha,callBack){
    jsonFecha = fecha;
    var AJAX_req = new XMLHttpRequest();
    url="/Proyecto_2_Progamacion_IV/Servlet_Principal?action=Buscar_Citas_Fecha";
    AJAX_req.open( "POST", url, true );
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    AJAX_req.onreadystatechange = function(){
        if( AJAX_req.readyState === 4 && AJAX_req.status === 200 ){
            jsonText=AJAX_req.responseText;
            var object = JSON.parse( jsonText,revive );
            callBack(object);
        }
    };
    AJAX_req.send("fecha="+jsonFecha);
};

Proxy.actualizar_cita = function(cita,callBack){
    jsonCita = JSON.stringify(cita,replacer);
    var AJAX_req = new XMLHttpRequest();
    url="/Proyecto_2_Progamacion_IV/Servlet_Principal?action=Actualizar_Cita";
    AJAX_req.open( "POST", url, true );
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    AJAX_req.onreadystatechange = function(){
        if( AJAX_req.readyState === 4 && AJAX_req.status === 200 ){
            jsonText=AJAX_req.responseText;
            var object = JSON.parse( jsonText,revive );
            callBack(object);
        }
    };
    AJAX_req.send("cita="+jsonCita);
};

Proxy.buscar_citas_nombre = function(nombre,callBack){
    jsonNombre = nombre;
    var AJAX_req = new XMLHttpRequest();
    url="/Proyecto_2_Progamacion_IV/Servlet_Principal?action=Buscar_Citas_Nombre";
    AJAX_req.open( "POST", url, true );
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    AJAX_req.onreadystatechange = function(){
        if( AJAX_req.readyState === 4 && AJAX_req.status === 200 ){
            jsonText=AJAX_req.responseText;
            var object = JSON.parse( jsonText,revive );
            callBack(object);
        }
    };
    AJAX_req.send("nombre="+jsonNombre);
};

Proxy.buscar_citas_cedula = function(cedula,callBack){
    jsonCedula = cedula;
    var AJAX_req = new XMLHttpRequest();
    url="/Proyecto_2_Progamacion_IV/Servlet_Principal?action=Buscar_Citas_Cedula";
    AJAX_req.open( "POST", url, true );
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    AJAX_req.onreadystatechange = function(){
        if( AJAX_req.readyState === 4 && AJAX_req.status === 200 ){
            jsonText=AJAX_req.responseText;
            var object = JSON.parse( jsonText,revive );
            callBack(object);
        }
    };
    AJAX_req.send("cedula="+jsonCedula);
};

Proxy.obtener_observaciones = function(codigo_cita,callBack){
    json = codigo_cita;
    var AJAX_req = new XMLHttpRequest();
    url="/Proyecto_2_Progamacion_IV/Servlet_Principal?action=Obtener_Observaciones";
    AJAX_req.open( "POST", url, true );
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    AJAX_req.onreadystatechange = function(){
        if( AJAX_req.readyState === 4 && AJAX_req.status === 200 ){
            jsonText=AJAX_req.responseText;
            var object = JSON.parse( jsonText,revive );
            callBack(object);
        }
    };
    AJAX_req.send("codigo_cita="+json);
};

Proxy.guardar_observacion = function(observacion,callBack){
    json = JSON.stringify(observacion,replacer);
    var AJAX_req = new XMLHttpRequest();
    url="/Proyecto_2_Progamacion_IV/Servlet_Principal?action=Guardar_Observacion";
    AJAX_req.open( "POST", url, true );
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    AJAX_req.onreadystatechange = function(){
        if( AJAX_req.readyState === 4 && AJAX_req.status === 200 ){
            jsonText=AJAX_req.responseText;
            var object = JSON.parse( jsonText,revive );
            callBack(object);
        }
    };
    AJAX_req.send("observacion="+json);
};

Proxy.ejemplo_hola = function(t,callBack){
    jsonText = t;
    var AJAX_req = new XMLHttpRequest();
    url="/Proyecto_2_Progamacion_IV/Servlet_Principal?action=hola";
    AJAX_req.open( "POST", url, true );
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    AJAX_req.onreadystatechange = function(){
        if( AJAX_req.readyState === 4 && AJAX_req.status === 200 ){
            jsonText=AJAX_req.responseText;
            var object = JSON.parse( jsonText,revive );
            callBack(object);
        }
    };
    AJAX_req.send(jsonText);   
};

Proxy.proximas_citas = function(callBack){
    var AJAX_req = new XMLHttpRequest();
    url="/Proyecto_2_Progamacion_IV/Servlet_Principal?action=Proximas_Citas";
    AJAX_req.open( "POST", url, true );
    AJAX_req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    AJAX_req.onreadystatechange = function(){
        if( AJAX_req.readyState === 4 && AJAX_req.status === 200 ){
            jsonText=AJAX_req.responseText;
            var object = JSON.parse( jsonText,revive );
            callBack(object);
        }
    };
    AJAX_req.send("proximas_citas");
};