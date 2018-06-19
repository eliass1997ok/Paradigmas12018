import java.util.*;

public class Lab{

	public static int determineInstruction(String interaction){
		String[] instruction = interaction.split("!");

		if (instruction[1].compareTo("beginDialog") == 0){
			return 1;
		} else if (instruction[1].compareTo("endDialog") == 0){
			return 9;
		}

		return -1;
	}

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		List<Message> log = new ArrayList<Message>();
		Chatbot chatbot;
		User user;
		Chat chat;
		user = null;
		chat = null;
		chatbot = null;
		int seed;

		System.out.println("Sistema [!] Bienvenido al Chatbot de turismo #1 de Santiago. Este Chatbot le permitirá comprar pasajes con destino a cualquier capital regional del país.");

		boolean endedDialog = false;

		while (! endedDialog){
			System.out.print("Usuario [>]: ");
			String userEntry = sc.nextLine();
			String[] splitedString = userEntry.split(" ");

			if (chatbot == null && chat == null && user == null){ // Se comprueba si lo ingresado corresponde a una instrucción.
				if (splitedString[0].charAt(0) == '!' && determineInstruction(splitedString[0]) == 1){
					if (splitedString.length == 1){
							chatbot = new Chatbot();

						} else {
							chatbot = new Chatbot(Integer.parseInt(splitedString[1]));
						}

						System.out.println("Se ha iniciado correctamente el chat");

						Message greetings = chatbot.greetings();
						log.add(greetings);

						System.out.print("Usuario [>]: ");
						String name = sc.nextLine();

						Message nameMessage = new Message(new Date(), "Usuario", name);
						log.add(nameMessage);

						user = new User(name);
						chat = new Chat(chatbot, user, log);
						

				} else {
					System.out.println("Sistema [!] El chat no se ha iniciado correctamente, intente nuevamente.");
					// System.out.print("Usuario [>]: ");
					// userEntry = sc.nextLine();	
				}

			} else {
				if (splitedString[0].charAt(0) == '!'){
					if (determineInstruction(splitedString[0]) == 9){ // Se determina el tipo de instrucción que se ha ingresado. Cambiar a switch/case
						endedDialog = true;
					} //Por cada nueva instrucción que se quiera realizar, determinar si existe chat.
				}
			}
		}
	}
}