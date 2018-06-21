import java.util.*;

public class Lab{

	public static int determineInstruction(String interaction){
		String[] instruction = interaction.split("!");

		if (instruction[1].compareTo("beginDialog") == 0){
			return 1;
		} else if (instruction[1].compareTo("saveLog") == 0){
			return 2;
		} else if (instruction[1].compareTo("loadLog") == 0){
			return 3;
		} else if (instruction[1].compareTo("rate") == 0){
			return 4;
		} else if (instruction[1].compareTo("endDialog") == 0){
			return 9;
		}

		return -1;
	}

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		List<Message> log = new ArrayList<Message>();
		Chatbot chatbot;
		chatbot = null;
		User user = new User();		
		int seed;

		System.out.println("Sistema [!] Bienvenido al Chatbot de turismo #1 de Santiago. Este Chatbot le permitirá comprar pasajes con destino a cualquier capital regional del país.");

		boolean endedDialog = false;
		boolean startedDialog = false;

		while (! endedDialog){
			Message msg = user.sendMessage();
			String[] splitedString = msg.getContent().split(" ");

			if (startedDialog) log.add(msg);

			if (chatbot == null){
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
						user.setName(name);

						Message nameMessage = new Message(new Date(), "Usuario", name);
						log.add(nameMessage);
						chatbot.determineAnswer(log, nameMessage.getContent());
						startedDialog = true;						

				} else {
					System.out.println("Sistema [!] El chat no se ha iniciado correctamente, intente nuevamente.");	
				}

			} else {
				if (splitedString[0].charAt(0) == '!'){
					switch(determineInstruction(splitedString[0])){
						case(1):
							if (splitedString.length == 1)
								chatbot = new Chatbot();
							else 
								chatbot = new Chatbot(Integer.parseInt(splitedString[1]));

							System.out.println("Se ha iniciado correctamente el chat");

							log.clear();

							Message greetings = chatbot.greetings();
							log.add(greetings);

							System.out.print("Usuario [>]: ");
							String name = sc.nextLine();
							user.setName(name);

							Message nameMessage = new Message(new Date(), "Usuario", name);
							log.add(nameMessage);

							break;

						case(9):
							endedDialog = true;
							break;

						default:
							System.out.println("\nSistema [!]: La instrucción especificada no existe. Por favor, ingrese nuevamente.\n");
					}					
				} else {
					chatbot.determineAnswer(log, msg.getContent());
				}
			}
		}

		for (Message msg : log) {
			System.out.println(msg.toString());			
		}
	}
}