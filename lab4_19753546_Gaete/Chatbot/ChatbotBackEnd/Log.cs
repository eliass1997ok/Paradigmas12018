using System;
using System.Collections.Generic;
using ChatbotBackend;
namespace ChatbotBackend
{
    /**
    * La clase Log permite mantener un registro de lo que son las conversaciones dentro de la clase principal Chat.
    *
    */
    public class Log
    {
        private List<Message> log;

        /**
        * Contructor que permite instanciar un log a partir de otro.
        *
        * log: corresponde el log a partir del cual se instancia el nuevo log.
        *
        */
        public Log(List<Message> log)
        {
            this.log = log;
        }

        /**
        * Contructor que permite instanciar un log vacío.
        *
        */
        public Log(){
            this.log = new List<Message>();
        }

        /**
        * Método que permite agregar un mensaje al log. 
        *
        * message: corresponde al mensaje que se añadirá al log
        *
        */
        public void addMessage(Message message){
            this.log.Add(message);
        }

        /**
        * Método que permite limpiar un log. 
        *
        */
        public void clearLog(){
            this.log.Clear();
        }

        /**
        * Método que permite obtener el log.
        *
        * Retorna una lista de mensajes, el cual es la representación del log.
        *
        */
        public List<Message> getLog(){
            return this.log;
        }

        /**
        * Método que permite convertir un log, en un arreglo de strings, donde cada string es un mensaje del log.
        *
        * Retorna un arreglo de mensajes, los cuales vienen en forma de string.
        *
        */
        public String[] messagesToStrings(){
            List<String> listOfStrings;
            listOfStrings = new List<String>();

            foreach (Message msg in this.log){
                listOfStrings.Add(msg.toString());
            }

            return listOfStrings.ToArray();
        }

        /**
        * Método que permite convertir un log en un arreglo de mensajes.
        *
        * Retorna un arreglo de mensajes.
        *
        */
        public Message[] logToArrayMessages(){
            return this.log.ToArray();
        }
    }
}
