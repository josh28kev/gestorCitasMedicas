function store(id, lista){
	sessionStorage.setItem(id, JSON.stringify(lista,replacer));
}

function retrieveCarritoFromUrl(url,callBack){
    var AJAX_req = new XMLHttpRequest();
    AJAX_req.open( "GET", url, true );
    AJAX_req.setRequestHeader("Content-type", "application/json");
 
    AJAX_req.onreadystatechange = function(){
        if( AJAX_req.readyState === 4 && AJAX_req.status === 200 ){
            jsonText=AJAX_req.responseText;
            var object = JSON.parse( jsonText,revive );
            callBack(object);
        }
    };
    AJAX_req.send();
}

function retrieve(id){
  var jsonLista = sessionStorage.getItem(id);
  if(jsonLista === null){
	return new Lista ();
  }
  else{
	return JSON.parse(jsonLista,revive);
  }
}

function revive(k,v) {
	if (v instanceof Object && v._class == 'Usuario') {
		return Usuario.from(v);
	}    
	if (v instanceof Object && v._class == 'Medico') {
		return Medico.from(v);
        }
        if (v instanceof Object && v._class == 'Paciente') {
		return Paciente.from(v);
        }
        if (v instanceof Object && v._class == 'Lista') {
		return Lista.from(v);
	}
        if (v instanceof Object && v._class == 'Cita') {
		return Cita.from(v);
	}
        if (v instanceof Object && v._class == 'Observacion') {
		return Observacion.from(v);
	}
        if (v instanceof Object && v._class === 'Palabra') {
		return Palabra.from(v);
        }
    return v;
}

function replacer(k,v) {
	if (v instanceof Usuario) {
		return Usuario.to(v);
	}
        if (v instanceof Medico) {
		return Medico.to(v);
	}
         if (v instanceof Paciente) {
		return Paciente.to(v);
	}
        if (v instanceof Lista) {
		return Lista.to(v);
	}
        if (v instanceof Cita) {
		return Cita.to(v);
	}
        if (v instanceof Observacion) {
		return Observacion.to(v);
	}
        if (v instanceof Palabra) {
                return Palabra.to(v);
        }
	return v;
}

function guardar_citas(lista_citas){
	sessionStorage.setItem("lista_citas", JSON.stringify(lista_citas,replacer));
}

function cargar_citas(){
  var json = sessionStorage.getItem("lista_citas");
  if(json === null){
	return new Lista();
  }
  else{
	return JSON.parse(json,revive);
  }
}

function guardar_observaciones(lista_obs){
	sessionStorage.setItem("lista_obs", JSON.stringify(lista_obs,replacer));
}

function cargar_observaciones(){
  var json = sessionStorage.getItem("lista_obs");
  if(json === null){
	return new Lista();
  }
  else{
	return JSON.parse(json,revive);
  }
}

function guardar_string(id,string){
	sessionStorage.setItem(id,string);
}

function cargar_string(id){
  var json = sessionStorage.getItem(id);
  return json;
}