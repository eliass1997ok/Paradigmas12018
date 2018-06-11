import java.util.*;

public class Lab{

	public static int determineInstruction(String interaction){
		String[] instruction = interaction.split("!");

		if (instruction[1].compareTo("beginDialog") == 0){
			return 1;
		}

		return -1;
	}

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		List<Message> log = new ArrayList<Message>();
		Chatbot chatbot;
		chatbot = null;
		int seed;

		System.out.println("Sistema [!] Bienvenido al Chatbot de turismo #1 de Santiago. Este Chatbot le permitirá comprar pasajes con destino a cualquier capital regional del país.");
		System.out.print("Usuario [>] ");

		String beginDialog = sc.nextLine();
		String[] splitedString = beginDialog.split(" ");

		boolean startedChat = false;

		while (! startedChat){
			splitedString = beginDialog.split(" ");

			if (splitedString[0].charAt(0) == '!' && determineInstruction(splitedString[0]) == 1){
				if (splitedString.length == 1){
					chatbot = new Chatbot();
				} else {
					chatbot = new Chatbot(Integer.parseInt(splitedString[1]));
				}
				System.out.println("Se ha iniciado correctamente el chat");
				startedChat = true;
			} else {
				System.out.println("Sistema [!] El chat no se ha iniciado correctamente, intente nuevamente.");
				System.out.print("Usuario [>]: ");
				beginDialog = sc.nextLine();
				chatbot = new Chatbot();
			}
		}
		Message greetings = chatbot.greetings();
		log.add(greetings);

		System.out.print("Usuario [>]: ");
		String name = sc.nextLine();

		Message nameMessage = new Message(new Date(), "Usuario", name);
		log.add(nameMessage);

		User user = new User(name);
		Chat chat = new Chat(chatbot, user, log);

		// chat.keepTalking();

	}
}