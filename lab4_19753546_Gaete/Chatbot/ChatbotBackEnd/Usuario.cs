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
