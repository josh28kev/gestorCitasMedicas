  function Medico(codigo,cedula,nombre,telefono,email) {
    this.Medico(codigo,cedula,nombre,telefono,email);
  }
  
  Medico.prototype={
  	codigo: -1,
        cedula: "",
        nombre: "",
        telefono: -1,
        email: "",
	Medico: function(codigo,cedula,nombre,telefono,email){
		this.codigo=codigo;
                this.cedula = cedula;
                this.nombre=nombre;
                this.telefono=telefono;
                this.email=email;
	},
	toString:function(){
	  return this.codigo+": "+this.nombre;
	}
  };
  
  Medico.from= function(plain){
    med = new Medico(plain.codigo,plain.cedula,plain.nombre,plain.telefono,plain.email);
	return med;
  };
  
    Medico.to= function(med){
    return {
        _class : 'Medico',
        codigo : med.codigo,
        cedula: med.cedula,
        nombre : med.nombre,
        telefono : med.telefono,
        email : med.email
    };	
  };