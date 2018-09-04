using System;
using Gtk;
namespace ChatbotFrontend
{
    public partial class RateWindow : Gtk.Window
    {
        String userRate;
        String chatbotRate;

        public RateWindow() :base(Gtk.WindowType.Toplevel) => Build();

        protected void OnSubmitClicked(object sender, EventArgs e)
        {
            this.userRate = combobox3.ActiveText;
            this.chatbotRate = combobox1.ActiveText;
            textview1.Buffer.Text += this.userRate;
        }

        public String getUserRate(){
            return this.userRate;
        }

        public String getChatbotRate(){
            return this.chatbotRate;
        }
    }
}
