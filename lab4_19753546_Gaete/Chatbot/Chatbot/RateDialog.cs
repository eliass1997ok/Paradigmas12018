using System;
namespace ChatbotFrontend
{
    public partial class RateDialog : Gtk.Dialog
    {
        String userRate;
        String chatbotRate;

        public RateDialog()
        {
            this.Build();
        }

        protected void OnButtonOkClicked(object sender, EventArgs e)
        {
            this.userRate = comboboxUser.ActiveText;
            this.chatbotRate = comboboxChatbot.ActiveText;
        }

        public String getUserRate()
        {
            return this.userRate;
        }

        public String getChatbotRate()
        {
            return this.chatbotRate;
        }
    }
}
