using System;
using Gtk;
using System.IO;
using ChatbotBackend;

public partial class MainWindow : Gtk.Window
{
    private Chatbot chatbot;
    private Usuario user;
    private Log log;
    private bool startedDialog;
    private bool endedDialog;

    public MainWindow() : base(Gtk.WindowType.Toplevel)
    {
        Build();
        this.chatbot = null;
        this.user = new Usuario();
        this.log = new Log();
        textview1.Buffer.Text = "Sistema [!]: Bienvenido al Chatbot de turismo #1 de Santiago.\nEste Chatbot le permitirá comprar pasajes con destino a cualquier capital regional del país.\n";
    }

    protected void OnDeleteEvent(object sender, DeleteEventArgs a)
    {
        Application.Quit();
        a.RetVal = true;
    }

    protected void OnSendButtonClicked(object sender, EventArgs e)
    {
        if (this.chatbot == null){
            textview3.Buffer.Text = "";
            textview1.Buffer.Text += "Sistema [!]: La conversación no ha sido inicializada. Por favor, inicie el chatbot mediante el botón correspondiente\n";
        } else {
            if (textview3.Buffer.Text == ""){
                textview1.Buffer.Text += "Sistema [!]: No ha ingresado texto. Por favor, envíe un mensaje con texto.\n";
            }
            else {
                String msg;
                msg = textview3.Buffer.Text;
                textview3.Buffer.Text = "";

                if (this.log.getLog().Count == 1){
                    this.user.setName(msg);
                    Message msgUser;
                    msgUser = new Message(DateTime.Now, "Usuario [>]: ", msg);
                    this.log.addMessage(msgUser);
                    textview1.Buffer.Text += msgUser.toString();
                    Message msgChatbot;
                    msgChatbot = this.chatbot.determineAnswer(this.log.getLog(), msg);
                    textview1.Buffer.Text += msgChatbot.toString();
                } else {
                    Message msgUser;
                    msgUser = new Message(DateTime.Now, this.user.getName() + " [>]: ", msg);
                    this.log.addMessage(msgUser);
                    textview1.Buffer.Text += msgUser.toString();
                    Message msgChatbot;
                    msgChatbot = this.chatbot.determineAnswer(this.log.getLog(), msg);
                    textview1.Buffer.Text += msgChatbot.toString();
                }

            }
        }
    }

    protected void OnClearChatClicked(object sender, EventArgs e)
    {
        textview1.Buffer.Text = "";
    }

    protected void clickedBegin(object sender, EventArgs e)
    {
        int seed = 0;
        this.log.clearLog();

        if (seedview.Buffer.Text != "" && int.TryParse(seedview.Buffer.Text, out seed))
        {
            this.chatbot = new Chatbot(seed);
            seedview.Buffer.Text = "";
        } else {
            this.chatbot = new Chatbot();
        }
        Message msg = this.chatbot.greetings();

        textview1.Buffer.Text += msg.toString();
        this.log.addMessage(msg);
    }

    protected void OnEndDialogClicked(object sender, EventArgs e)
    {
        if (this.chatbot != null){
            Message msg = this.chatbot.goodbye();
            this.log.addMessage(msg);
            textview1.Buffer.Text += msg.toString();
            this.chatbot = null;
        } else {
            textview1.Buffer.Text += "Sistema [!]: No se puede finalizar una conversación no iniciada!. Por favor, inicie una conversación.\n";
        }

    }

    protected void OnSaveLogClicked(object sender, EventArgs e)
    {
        if (this.log.getLog().Count != 0){
            FileChooserDialog fcd = new FileChooserDialog("Guardar Historial", this, FileChooserAction.Save,
"Seleccionar Directorio", ResponseType.Ok, "Cancelar", ResponseType.Close);
            fcd.SelectMultiple = false;
            fcd.Run(); // This opens the window and waits for the response
            String[] messages = this.log.messagesToStrings();
            File.WriteAllLines(fcd.Filename, messages);
            fcd.Destroy();
            textview1.Buffer.Text += "Sistema [!]: Archivo log escrito satisfactoriamente.\n";
        } else {
            textview1.Buffer.Text += "Sistema [!]: El log no contiene mensajes. Por favor, inicie una conversación.\n";
        }

    }
}
