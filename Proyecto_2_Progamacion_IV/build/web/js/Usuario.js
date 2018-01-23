  function Usuario(id,clave,tipo) {
    this.Usuario(id,clave,tipo);
  }
  
  Usuario.prototype={
  	id: "",
	clave: "",
	tipo: 0,
	Usuario: function(id,clave,tipo){
		this.id=id;
		this.clave=clave;
		this.tipo=tipo;
	},
	toString:function(){
	  return this.id;
	}
  };
  
  Usuario.from= function(plain){
    usuario = new Usuario(plain.id,plain.clave,plain.tipo);
	return usuario;
  };
  
    Usuario.to= function(usuario){
    return {
        _class : 'Usuario',
        id : usuario.id,
        clave : usuario.clave,
	tipo : usuario.tipo
    };	
  };
 