  function Palabra(texto) {
    this.Palabra(texto);
  }
  
  Palabra.prototype={
  	texto: "",
	Palabra: function(texto){
		this.texto=texto;
	},
	toString:function(){
	  return this.texto;
	}
  };
  
  Palabra.from= function(plain){
    pal = new Palabra(plain.texto);
	return pal;
  };
  
    Palabra.to= function(pal){
    return {
        _class : 'Palabra',
        texto : pal.texto
    };	
  };