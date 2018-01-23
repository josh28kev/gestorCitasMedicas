function Lista() {
    this.Lista();
  };
  
  Lista.prototype={
  	items: [],
	Lista: function(){
	  this.items=new Array();
	},
	add: function(objeto){
	  this.items.push(objeto);
	},
	remove: function(idx){
	  this.items.splice(idx, 1);
	},
	get: function(i){
	  return this.items[i];
	},
	last: function(){
	  return this.items[this.items.length - 1];
	},
	size:function(){
	  return this.items.length;
	}
  };
  
  Lista.from= function(plain){
    list = new Lista ();
	list.items=plain.items;
	return list;
  }
  
    Lista.to= function(list){
    return {
        _class : 'Lista',
        items : list.items
    };
  }
