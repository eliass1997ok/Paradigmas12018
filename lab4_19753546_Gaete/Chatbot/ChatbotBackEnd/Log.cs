using System;
using System.Collections.Generic;
using ChatbotBackend;
namespace ChatbotBackend
{
    public class Log
    {
        private List<Message> log;

        public Log(List<Message> log)
        {
            this.log = log;
        }

        public Log(){
            this.log = new List<Message>();
        }

        public void addMessage(Message message){
            this.log.Add(message);
        }

        public void clearLog(){
            this.log.Clear();
        }

        public List<Message> getLog(){
            return this.log;
        }

        public String[] messagesToStrings(){
            List<String> listOfStrings;
            listOfStrings = new List<String>();

            foreach (Message msg in this.log){
                listOfStrings.Add(msg.toString());
            }

            return listOfStrings.ToArray();
        }

        public Message[] logToArrayMessages(){
            return this.log.ToArray();
        }
    }
}
