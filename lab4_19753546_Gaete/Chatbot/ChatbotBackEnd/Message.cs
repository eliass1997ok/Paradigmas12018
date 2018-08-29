using System;
namespace ChatbotBackend
{
    public class Message
    {
        private DateTime date;
        private String author;
        private String content;

        public Message(DateTime date, String author, String content)
        {
            this.date = date;
            this.author = author;
            this.content = content;
        }

        public String getContent(){
            return this.content;
        }

        public String toString(){
            return date.ToString("[dd/MM/yyyy, H:mm:ss] ") + this.author + this.content + "\n";
        }
    }
}
