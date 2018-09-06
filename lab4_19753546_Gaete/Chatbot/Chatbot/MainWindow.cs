using System;
using Gtk;
using System.IO;
using ChatbotBackend;

namespace ChatbotFrontend
{
    /**
    * Esta clase permite instanciar una ventana principal del chat.
    *
    */
    public partial class MainWindow : Gtk.Window
    {
        private Chatbot chatbot;
        private Usuario user;
        private Log log;

        /**
        * Constructor de la clase. Instancia al usuario y al log, mientras que el chatbot es seteado en null.
        * Se muestra un mensaje en el textview principal
        * 
        */        
        public MainWindow() : base(Gtk.WindowType.Toplevel)
        {
            Build();
            this.chatbot = null;
            this.user = new Usuario();
            this.log = new Log();
            textview1.Buffer.Text = "Sistema [!]: Bienvenido al Chatbot de turismo #1 de Santiago.\nEste Chatbot le permitirá comprar pasajes con destino a cualquier capital regional del país.\n";
        }

        /**
        * Método que permite detener la aplicación en caso de que se cierre la ventana.
        * 
        */
        protected void OnDeleteEvent(object sender, DeleteEventArgs a)
        {
            Application.Quit();
            a.RetVal = true;
        }

        /**
        * Método que permite enviar mensajes al chatbot.
        *
        */
        protected void OnSendButtonClicked(object sender, EventArgs e)
        {
            if (this.chatbot == null)
            {
                textview3.Buffer.Text = "";
                textview1.Buffer.Text += "Sistema [!]: La conversación no ha sido inicializada. Por favor, inicie el chatbot mediante el botón correspondiente\n";
            }
            else
            {
                if (textview3.Buffer.Text == "")
                {
                    textview1.Buffer.Text += "Sistema [!]: No ha ingresado texto. Por favor, envíe un mensaje con texto.\n";
                }
                else
                {
                    String msg;
                    msg = textview3.Buffer.Text;
                    textview3.Buffer.Text = "";

                    if (this.log.getLog().Count == 1)
                    {
                        this.user.setName(msg);
                        Message msgUser;
                        msgUser = new Message(DateTime.Now, "Usuario [>]: ", msg);
                        this.log.addMessage(msgUser);
                        textview1.Buffer.Text += msgUser.toString();
                        Message msgChatbot;
                        msgChatbot = this.chatbot.determineAnswer(this.log.getLog(), msg);
                        textview1.Buffer.Text += msgChatbot.toString();
                    }
                    else
                    {
                        Message msgUser;
                        msgUser = new Message(DateTime.Now, this.user.getName() + " [>]: ", msg);
                        this.log.addMessage(msgUser);
                        textview1.Buffer.Text += msgUser.toString();
                        Message msgChatbot;
                        msgChatbot = this.chatbot.determineAnswer(this.log.getLog(), msg);
                        this.log.addMessage(msgChatbot);
                        textview1.Buffer.Text += msgChatbot.toString();
                    }

                }
            }
        }

        /**
        * Método que permite limpiar el textview principal.
        *
        */
        protected void OnClearChatClicked(object sender, EventArgs e)
        {
            textview1.Buffer.Text = "";
        }

        /**
        * Método que permite dar inicio al chat.
        *
        */        
        protected void clickedBegin(object sender, EventArgs e)
        {
            int seed = 0;
            this.log.clearLog();

            if (seedview.Buffer.Text != "" && int.TryParse(seedview.Buffer.Text, out seed))
            {
                this.chatbot = new Chatbot(seed);
                seedview.Buffer.Text = "";
            }
            else
            {
                this.chatbot = new Chatbot();
            }
            Message msg = this.chatbot.greetings();

            textview1.Buffer.Text += msg.toString();
            this.log.addMessage(msg);
        }

        /**
        * Método que permite finalizar el chat.
        *
        */
        protected void OnEndDialogClicked(object sender, EventArgs e)
        {
            if (this.chatbot != null)
            {
                Message msg = this.chatbot.goodbye();
                this.log.addMessage(msg);
                this.chatbot = null;
                textview1.Buffer.Text += msg.toString();

                RateDialog rateDialog = new RateDialog();
                rateDialog.Run();

                this.log.addMessage(new Message(DateTime.Now, "Sistema [!]: ", "Nota del Usuario: " + rateDialog.getUserRate()));
                this.log.addMessage(new Message(DateTime.Now, "Sistema [!]: ", "Nota del Chatbot: " + rateDialog.getChatbotRate()));

                textview1.Buffer.Text += "Sistema [!]: Nota del Usuario -> " + rateDialog.getUserRate() + "\n";
                textview1.Buffer.Text += "Sistema [!]: Nota del Chatbot -> " + rateDialog.getChatbotRate() + "\n";
                textview1.Buffer.Text += "Sistema [!]: Notas puestas de manera satisfactoria. Esto se verá reflejado en el log.\n";
            }
            else
            {
                textview1.Buffer.Text += "Sistema [!]: No se puede finalizar una conversación no iniciada!. Por favor, inicie una conversación.\n";
            }
        }

        /**
        * Método que permite guardar un log.
        *
        */
        protected void OnSaveLogClicked(object sender, EventArgs e)
        {
            if (this.log.getLog().Count != 0)
            {
                FileChooserDialog fcd = new FileChooserDialog("Guardar Historial", this, FileChooserAction.Save,
                "Seleccionar Directorio", ResponseType.Ok, "Cancelar", ResponseType.Close);
                fcd.SelectMultiple = false;
                fcd.CurrentName = "filename_historial";
                fcd.Run();
                String[] messages = this.log.messagesToStrings();

                if (fcd.Filename != null){
                    File.WriteAllLines(fcd.Filename + ".log", messages);
                    textview1.Buffer.Text += "Sistema [!]: Archivo log escrito satisfactoriamente.\n";
                }

                fcd.Destroy();
            }
            else
            {
                textview1.Buffer.Text += "Sistema [!]: El log no contiene mensajes. Por favor, inicie una conversación.\n";
            }
        }

        /**
        * Método que permite cargar un log.
        *
        */        
        protected void OnCargarLogClicked(object sender, EventArgs e)
        {
            FileChooserDialog fcd = new FileChooserDialog("Leer Historial", this, FileChooserAction.Open,
            "Seleccionar Archivo", ResponseType.Ok, "Cancelar", ResponseType.Close);
            fcd.Run();

            if (fcd.Filename != null && fcd.Filename.Contains(".log"))
            {
                textview1.Buffer.Text += "Sistema [!]: Archivo log cargado satisfactoriamente.\n";
                String[] lines = File.ReadAllLines(fcd.Filename);
                foreach (String str in lines)
                {
                    if (str != "\n")
                        textview1.Buffer.Text += str + "\n";
                }
            }
            else
            {
                textview1.Buffer.Text += "Sistema [!]: No se ha proporcionado un archivo log.\n";
            }

            fcd.Destroy();
        }
    }
}
