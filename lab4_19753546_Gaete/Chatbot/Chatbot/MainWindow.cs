using System;
using Gtk;
using ChatbotBackend;

public partial class MainWindow : Gtk.Window
{
    private Chatbot chatbot;
    public MainWindow() : base(Gtk.WindowType.Toplevel)
    {
        Build();
    }

    protected void OnDeleteEvent(object sender, DeleteEventArgs a)
    {
        Application.Quit();
        a.RetVal = true;
    }

    protected void OnSendButtonClicked(object sender, EventArgs e)
    {

    }

    protected void OnBeginButtonClicked(object sender, EventArgs e)
    {
        chatbot = new Chatbot();
        Message m = chatbot.greetings();
        
        textview1.Buffer.Text += m.toString();
    }

    protected void OnClearChatClicked(object sender, EventArgs e)
    {
        textview1.Buffer.Text = "";
    }
}
