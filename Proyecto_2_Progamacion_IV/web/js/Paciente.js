function Paciente(cedula,nombre,fecha_nacimiento,direccion,numero_telefono,correo) {
    this.Paciente(cedula,nombre,fecha_nacimiento,direccion,numero_telefono,correo);
  }
  
  Paciente.prototype={
  	cedula: "",
        nombre: "",
        fecha_nacimiento: "",
        direccion: "",
        numero_telefono:0,
        correo: "",
	Paciente: function(cedula,nombre,fecha_nacimiento,direccion,numero_telefono,correo){
		this.cedula=cedula;
                this.nombre=nombre;
                this.fecha_nacimiento=fecha_nacimiento;
                this.direccion=direccion;
                this.numero_telefono = numero_telefono;
                this.correo = correo;
	},
	toString:function(){
	  return this.cedula+": "+this.nombre;
	}
  };
  
  Paciente.from= function(plain){
    pal = new Paciente(plain.cedula,plain.nombre,plain.fecha_nacimiento,plain.direccion,plain.numero_telefono,plain.correo);
	return pal;
  };
  
    Paciente.to= function(pac){
    return {
        _class : 'Paciente',
        cedula : pac.cedula,
        nombre : pac.nombre,
        fecha_nacimiento : pac.fecha_nacimiento,
        direccion : pac.direccion,
        numero_telefono :pac.numero_telefono,
        correo : pac.correo
    };	
  };