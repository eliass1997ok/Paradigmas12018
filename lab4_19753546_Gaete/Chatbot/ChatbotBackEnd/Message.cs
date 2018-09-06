using System;
namespace ChatbotBackend
{
    /**
    * La clase Message corresponde a la clase que permite establecer un orden a la hora de generar mensajes dentro del 
    * chat. Los Mensajes son una combinación de fecha, emitidos por un autor, con cierto contenido.
    *
    */
    public class Message
    {
        private DateTime date;
        private String author;
        private String content;

        /**
        * Constructor que permite crear el mensaje. 
        *
        * date: corresponde a la fecha y hora de emisión del mensaje.
        * autor: correponde a quien emite el mensaje.
        * content: corresponde al contenido del mensaje. 
        *
        */
        public Message(DateTime date, String author, String content)
        {
            this.date = date;
            this.author = author;
            this.content = content;
        }

        /**
        * getContent correponde a un método que permite obtener el contenido de un mensaje. 
        *
        * Retorna string con el contenido del mensaje.
        *
        */  
        public String getContent(){
            return this.content;
        }

        /**
        * toString correponde a un método que permite obtener los atributos de la clase de manera ordenada 
        * en un String.
        *
        * Retorna string con los datos de forma ordenada, con la fecha manteniendo una estructura dada, posteriormente
        *         el autor, para terminar con el contenido del mensaje.
        *
        */  
        public String toString(){
            return date.ToString("[dd/MM/yyyy, H:mm:ss] ") + this.author + this.content + "\n";
        }
    }
}
