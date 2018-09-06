using System;
namespace ChatbotFrontend
{
    /**
    * Esta clase permite instanciar una ventana desde la cual se le puede asignar una nota
    * tanto al usuario como al chatbot.
    *
    */
    public partial class RateDialog : Gtk.Dialog
    {
        private String userRate;
        private String chatbotRate;

        /**
        * Constructor de la clase. Inicializa por defecto las notas como 0.
        *
        */
        public RateDialog()
        {
            this.Build();
            this.userRate = "0";
            this.chatbotRate = "0";
        }

        /**
        * Método que permite establecer las notas como el usuario determine dentro de los combobox.
        * Esto es ejecutado cuando el usuario hace click en botón OK.
        *
        */
        protected void OnButtonOkClicked(object sender, EventArgs e)
        {
            this.userRate = comboboxUser.ActiveText;
            this.chatbotRate = comboboxChatbot.ActiveText;
        }

        /**
        * Método que permite obtener la nota del usuario.
        *
        */
        public String getUserRate()
        {
            return this.userRate;
        }

        /**
        * Método que permite obtener la nota del chatbot.
        *
        */
        public String getChatbotRate()
        {
            return this.chatbotRate;
        }
    }
}

