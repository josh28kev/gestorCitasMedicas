package proyecto.modelo;

import java.io.Serializable;

public class Palabra implements Serializable, Jsonable{
    String texto;

   public Palabra(){
       this("");
   }
   
   public Palabra(String texto){
        this.texto=texto;
   }
   
   public void setTexto(String texto) {
       this.texto=texto;
   }
   
   public String getTexto() {
        return texto;
    }
}
