
// This file has been generated by the GUI designer. Do not modify.
namespace ChatbotFrontend
{
	public partial class RateDialog
	{
		private global::Gtk.HBox hbox3;

		private global::Gtk.VBox vbox8;

		private global::Gtk.ScrolledWindow GtkScrolledWindow1;

		private global::Gtk.TextView textview7;

		private global::Gtk.ComboBox comboboxChatbot;

		private global::Gtk.VBox vbox6;

		private global::Gtk.ScrolledWindow GtkScrolledWindow;

		private global::Gtk.TextView textview5;

		private global::Gtk.ComboBox comboboxUser;

		private global::Gtk.Button buttonOk;

		protected virtual void Build()
		{
			global::Stetic.Gui.Initialize(this);
			// Widget ChatbotFrontend.RateDialog
			this.Name = "ChatbotFrontend.RateDialog";
			this.WindowPosition = ((global::Gtk.WindowPosition)(4));
			// Internal child ChatbotFrontend.RateDialog.VBox
			global::Gtk.VBox w1 = this.VBox;
			w1.Name = "dialog1_VBox";
			w1.BorderWidth = ((uint)(2));
			// Container child dialog1_VBox.Gtk.Box+BoxChild
			this.hbox3 = new global::Gtk.HBox();
			this.hbox3.Name = "hbox3";
			this.hbox3.Spacing = 6;
			// Container child hbox3.Gtk.Box+BoxChild
			this.vbox8 = new global::Gtk.VBox();
			this.vbox8.Name = "vbox8";
			this.vbox8.Spacing = 6;
			// Container child vbox8.Gtk.Box+BoxChild
			this.GtkScrolledWindow1 = new global::Gtk.ScrolledWindow();
			this.GtkScrolledWindow1.Name = "GtkScrolledWindow1";
			this.GtkScrolledWindow1.ShadowType = ((global::Gtk.ShadowType)(1));
			// Container child GtkScrolledWindow1.Gtk.Container+ContainerChild
			this.textview7 = new global::Gtk.TextView();
			this.textview7.Buffer.Text = global::Mono.Unix.Catalog.GetString("Nota del\nChatbot");
			this.textview7.CanFocus = true;
			this.textview7.Name = "textview7";
			this.textview7.Editable = false;
			this.GtkScrolledWindow1.Add(this.textview7);
			this.vbox8.Add(this.GtkScrolledWindow1);
			global::Gtk.Box.BoxChild w3 = ((global::Gtk.Box.BoxChild)(this.vbox8[this.GtkScrolledWindow1]));
			w3.Position = 0;
			// Container child vbox8.Gtk.Box+BoxChild
			this.comboboxChatbot = global::Gtk.ComboBox.NewText();
			this.comboboxChatbot.AppendText(global::Mono.Unix.Catalog.GetString("0"));
			this.comboboxChatbot.AppendText(global::Mono.Unix.Catalog.GetString("1"));
			this.comboboxChatbot.AppendText(global::Mono.Unix.Catalog.GetString("2"));
			this.comboboxChatbot.AppendText(global::Mono.Unix.Catalog.GetString("3"));
			this.comboboxChatbot.AppendText(global::Mono.Unix.Catalog.GetString("4"));
			this.comboboxChatbot.AppendText(global::Mono.Unix.Catalog.GetString("5"));
			this.comboboxChatbot.Name = "comboboxChatbot";
			this.comboboxChatbot.Active = 0;
			this.vbox8.Add(this.comboboxChatbot);
			global::Gtk.Box.BoxChild w4 = ((global::Gtk.Box.BoxChild)(this.vbox8[this.comboboxChatbot]));
			w4.Position = 1;
			w4.Expand = false;
			w4.Fill = false;
			this.hbox3.Add(this.vbox8);
			global::Gtk.Box.BoxChild w5 = ((global::Gtk.Box.BoxChild)(this.hbox3[this.vbox8]));
			w5.Position = 0;
			w5.Expand = false;
			w5.Fill = false;
			// Container child hbox3.Gtk.Box+BoxChild
			this.vbox6 = new global::Gtk.VBox();
			this.vbox6.Name = "vbox6";
			this.vbox6.Spacing = 6;
			// Container child vbox6.Gtk.Box+BoxChild
			this.GtkScrolledWindow = new global::Gtk.ScrolledWindow();
			this.GtkScrolledWindow.Name = "GtkScrolledWindow";
			this.GtkScrolledWindow.ShadowType = ((global::Gtk.ShadowType)(1));
			// Container child GtkScrolledWindow.Gtk.Container+ContainerChild
			this.textview5 = new global::Gtk.TextView();
			this.textview5.Buffer.Text = global::Mono.Unix.Catalog.GetString("Nota del\nUsuario");
			this.textview5.CanFocus = true;
			this.textview5.Name = "textview5";
			this.textview5.Editable = false;
			this.GtkScrolledWindow.Add(this.textview5);
			this.vbox6.Add(this.GtkScrolledWindow);
			global::Gtk.Box.BoxChild w7 = ((global::Gtk.Box.BoxChild)(this.vbox6[this.GtkScrolledWindow]));
			w7.Position = 0;
			// Container child vbox6.Gtk.Box+BoxChild
			this.comboboxUser = global::Gtk.ComboBox.NewText();
			this.comboboxUser.AppendText(global::Mono.Unix.Catalog.GetString("0"));
			this.comboboxUser.AppendText(global::Mono.Unix.Catalog.GetString("1"));
			this.comboboxUser.AppendText(global::Mono.Unix.Catalog.GetString("2"));
			this.comboboxUser.AppendText(global::Mono.Unix.Catalog.GetString("3"));
			this.comboboxUser.AppendText(global::Mono.Unix.Catalog.GetString("4"));
			this.comboboxUser.AppendText(global::Mono.Unix.Catalog.GetString("5"));
			this.comboboxUser.Name = "comboboxUser";
			this.comboboxUser.Active = 0;
			this.vbox6.Add(this.comboboxUser);
			global::Gtk.Box.BoxChild w8 = ((global::Gtk.Box.BoxChild)(this.vbox6[this.comboboxUser]));
			w8.Position = 1;
			w8.Expand = false;
			w8.Fill = false;
			this.hbox3.Add(this.vbox6);
			global::Gtk.Box.BoxChild w9 = ((global::Gtk.Box.BoxChild)(this.hbox3[this.vbox6]));
			w9.Position = 1;
			w9.Expand = false;
			w9.Fill = false;
			w1.Add(this.hbox3);
			global::Gtk.Box.BoxChild w10 = ((global::Gtk.Box.BoxChild)(w1[this.hbox3]));
			w10.Position = 0;
			// Internal child ChatbotFrontend.RateDialog.ActionArea
			global::Gtk.HButtonBox w11 = this.ActionArea;
			w11.Name = "dialog1_ActionArea";
			w11.Spacing = 10;
			w11.BorderWidth = ((uint)(5));
			w11.LayoutStyle = ((global::Gtk.ButtonBoxStyle)(4));
			// Container child dialog1_ActionArea.Gtk.ButtonBox+ButtonBoxChild
			this.buttonOk = new global::Gtk.Button();
			this.buttonOk.CanDefault = true;
			this.buttonOk.CanFocus = true;
			this.buttonOk.Name = "buttonOk";
			this.buttonOk.UseStock = true;
			this.buttonOk.UseUnderline = true;
			this.buttonOk.Label = "gtk-ok";
			this.AddActionWidget(this.buttonOk, -5);
			global::Gtk.ButtonBox.ButtonBoxChild w12 = ((global::Gtk.ButtonBox.ButtonBoxChild)(w11[this.buttonOk]));
			w12.Expand = false;
			w12.Fill = false;
			if ((this.Child != null))
			{
				this.Child.ShowAll();
			}
			this.DefaultWidth = 142;
			this.DefaultHeight = 149;
			this.Show();
			this.buttonOk.Clicked += new global::System.EventHandler(this.OnButtonOkClicked);
		}
	}
}
