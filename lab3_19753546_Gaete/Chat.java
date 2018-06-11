import java.util.*;

public class Chat{
	private Chatbot chatbot;
	private User user;
	private List<Message> log;

	public Chat(Chatbot chatbot, User user, List<Message> log){
		this.chatbot = chatbot;
		this.user = user;
		this.log = log;
	}

	// public void keepTalking(){

	// }
}