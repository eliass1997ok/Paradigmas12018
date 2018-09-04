using System;
namespace ChatbotBackend
{
    public class Usuario
    {
        private String name;
        private String rate;

        public Usuario()
        {
            this.name = "Usuario";
        }

        public Message sendMessage(String msg)
        {
            if (msg.Length == 0)
            {
                return new Message(DateTime.Now, "Sistema [!]: ", "No se ha ingresado texto.");
            }

            return new Message(DateTime.Now, this.name, msg);
        }

        public String getName(){
            return this.name;
        }

        public void setName(String name){
            this.name = name;
        }

        public void setRate(String rate){
            this.rate = rate;
        }
    }
}
