

  function Observacion(codigo,fecha,observacion) {
    this.Observacion(codigo,fecha,observacion);
  }
  
  Observacion.prototype={
  	codigo: 0,
        fecha: "",
        observacion: "",
	Observacion: function(codigo,fecha,observacion){
		this.codigo=codigo;
                this.fecha=fecha;
                this.observacion=observacion;
	},
	toString:function(){
	  return this.codigo+": "+this.observacion;
	}
  };
  
  Observacion.from= function(plain){
    obs = new Observacion(plain.codigo,plain.fecha,plain.observacion);
	return obs;
  };
  
    Observacion.to= function(obs){
    return {
        _class : 'Observacion',
        codigo : obs.codigo,
        fecha : obs.fecha,
        observacion : obs.observacion
    };	
  };