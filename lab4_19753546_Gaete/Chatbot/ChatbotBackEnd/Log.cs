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
    }
}
