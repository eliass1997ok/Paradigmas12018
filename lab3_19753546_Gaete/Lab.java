import java.util.*;
import java.io.*;
import java.lang.*;
import java.text.*;

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

	public static void run() {
		Scanner sc = new Scanner(System.in);
		List<Message> log = new ArrayList<Message>();
		Chatbot chatbot;
		chatbot = null;
		Usuario user = new Usuario();		
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

						log.add(new Message(new Date(), "Usuario", msg.getContent()));
						Message greetings = chatbot.greetings();
						log.add(greetings);

						System.out.print("Usuario [>]: ");
						String name = sc.nextLine();
						user.setName(name);

						Message nameMessage = new Message(new Date(), "Usuario", name);
						log.add(nameMessage);
						Message answer = chatbot.determineAnswer(log, nameMessage.getContent());
						log.add(answer);
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
							log.add(new Message(new Date(), "Usuario", msg.getContent()));

							Message greetings = chatbot.greetings();
							log.add(greetings);

							System.out.print("Usuario [>]: ");
							String name = sc.nextLine();
							user.setName(name);

							Message nameMessage = new Message(new Date(), "Usuario", name);

							break;

						case(2):
							Date date = new Date();
							DateFormat df = new SimpleDateFormat("dd-MM-yyyy_HH-mm-ss");
							String fileName = df.format(date);
							fileName = fileName + ".log";

							try {
								PrintWriter writer = new PrintWriter(fileName, "UTF-8");
								for (Message messageInLog : log){
									writer.write(messageInLog.toString() + "\n");
								}

								writer.close();

								System.out.println("Sistema [!]: Archivo log generado satisfactoriamente.");
							}
					        catch(Exception e){
								e.printStackTrace();
							}
							break;

						case(4):
							if (splitedString.length != 3){
								System.out.println("Sistema [!]: A la instrucción especificada le falta un parámetro. Por favor ingrese nuevamente.");
							} else {
								DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
								Date dateToRate = new Date();
								String strDate = dateFormat.format(dateToRate);
								chatbot.setRate(strDate + splitedString[1]);
								user.setRate(strDate + splitedString[2]);

							}
							break;

						case(9):
							endedDialog = true;
							Message goodbye = chatbot.goodbye();
							log.add(goodbye);
							break;

						default:
							System.out.println("Sistema [!]: La instrucción especificada no existe. Por favor, ingrese nuevamente.");
					}					
				} else {
					Message answerOfChatbot = chatbot.determineAnswer(log, msg.getContent());
					
					log.add(answerOfChatbot);
				}
			}
		}
	}
}