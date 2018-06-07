import java.util.*;

public class Chatbot{
	private List<List<List<String>>> responses;
	private int seed;

	public Chatbot(){
		this.seed = 0;
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