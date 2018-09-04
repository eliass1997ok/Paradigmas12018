using System;
using Gtk;
namespace ChatbotFrontend
{
    public partial class RateWindow : Gtk.Window
    {
        String userRate;
        String chatbotRate;

        public RateWindow() :
                base(Gtk.WindowType.Toplevel)
        {
            this.Build();
        }

        protected void OnSubmitClicked(object sender, EventArgs e)
        {
            this.userRate = combobox3.ActiveText;
            this.chatbotRate = combobox1.ActiveText;
        }

        public String getUserRate(){
            return this.userRate;
        }

        public String getChatbotRate(){
            return this.chatbotRate;
        }
    }
}
