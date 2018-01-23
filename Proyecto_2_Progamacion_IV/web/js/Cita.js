  function Cita(medico,paciente,fecha,hora,descripcion,codigo_cita) {
    this.Cita(medico,paciente,fecha,hora,descripcion,codigo_cita);
  }
  
  Cita.prototype={
  	medico: "",
        paciente: 0,
        fecha: "",
        hora: "",
        descripcion: "",
        codigo_cita: "",
	Cita: function(medico,paciente,fecha,hora,descripcion,codigo_cita){
		this.medico=medico;
                this.paciente=paciente;
                this.fecha=fecha;
                this.hora=hora;
                this.descripcion=descripcion;
                this.codigo_cita=codigo_cita;
	},
	toString:function(){
	  return this.medico+" "+this.paciente+" "+this.fecha+" "+this.hora;
	}
  };
  
  Cita.from= function(plain){
    cita = new Cita(plain.medico,plain.paciente,plain.fecha,plain.hora,plain.descripcion,plain.codigo_cita);
	return cita;
  };
  
    Cita.to= function(cita){
    return {
        _class : 'Cita',
        medico : cita.medico,
        paciente: cita.paciente,
        fecha: cita.fecha,
        hora: cita.hora,
        descripcion: cita.descripcion,
        codigo_cita: cita.codigo_cita
    };	
  };