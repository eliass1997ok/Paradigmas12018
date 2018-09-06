using System;
namespace ChatbotBackend
{
    /**
    * La clase Usuario corresponde a la clase que permite establecer un usuario dentro del chat. Este usuario es quien
    * mantiene la conversación con el chatbot.
    *
    */
    public class Usuario
    {
        private String name;
        private String rate;

        /**
        * Constructor que permite establecer un nombre inicial al Usuario. Inicialmente, se tiene por defecto 
        * que el nombre será "Usuario". Posteriormente será modificado con el nombre real del usuario.
        *
        */
        public Usuario()
        {
            this.name = "Usuario";
        }

        /**
        * Método que permite obtener el nombre de un usuario. 
        *
        * Retorna un string que representa el nombre del usuario.
        *
        */
        public String getName(){
            return this.name;
        }

        /**
        * setName permite establecer un nombre al usuario.
        *
        * name: corresponde al string que representa el nombre del usuario.
        */
        public void setName(String name){
            this.name = name;
        }

        /**
        * setRate permite establecer un rate al usuario.
        *
        * rate: corresponde al rate que se le entrega al usuario.
        */
        public void setRate(String rate){
            this.rate = rate;
        }
    }
}
