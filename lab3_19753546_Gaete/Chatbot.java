import java.util.*;

public class Chatbot{
	private List<List<List<String>>> responses;
	private int seed;
	private Random generator;

	public Chatbot(){
		this.seed = 0;
		this.generator = new Random(this.seed);
		this.responses = Arrays.asList( Arrays.asList(//Personalidad 1;
										              Arrays.asList("Hola, bienvenido al chat, cual es tu nombre", "Buenos días, cuál es su nombre?")
													  ),
										Arrays.asList(//Personalidad 2;
													  Arrays.asList("Wena amigo, bienveni3", "wena shoro") //Respuestas bienvenida
											         )
										);
	}

	public Chatbot(int seed){
		this.seed = seed % 2;
		this.generator = new Random(seed);
		this.responses = Arrays.asList( Arrays.asList(//Personalidad 1;
										              Arrays.asList("Hola, bienvenido al chat, cual es tu nombre", "Buenos días, cuál es su nombre?")
													  ),
										Arrays.asList(//Personalidad 2;
													  Arrays.asList("Wena amigo, bienveni3", "wena shoro") //Respuestas bienvenida
											         )
										);
	}

	public int getSeed(){
		return this.seed;
	} 

	public List<List<List<String>>> getResponses(){
		return this.responses;
	}

	public Message greetings(){
		Date date = new Date();

		int position = (int) ((this.generator.nextDouble() * 20) % 2);
		String response = this.responses.get(this.seed).get(0).get(position);
		System.out.println("Chatbot [>]: " + response);

		Message message = new Message(date, "Chatbot", response);

		return message;
	}

	public void showResponses(){
		System.out.println("Semilla del chatbot: " + this.seed);
		for (List<List<String>> listOfList : this.responses) {
			for (List<String> list : listOfList) {
				for (String str : list) {
					System.out.println(str);					
				}
			}
		}
	}

}