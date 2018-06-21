import java.util.*;

public class Chatbot{
	private List<List<List<String>>> responses;
	private int seed;
	private Random generator;

	public Chatbot(){
		this.seed = 0;
		this.generator = new Random(this.seed);
		this.responses = Arrays.asList( Arrays.asList(//Personalidad 1;
										              Arrays.asList("Hola, bienvenido al chat, ¿cuál es tu nombre?", "Buenos días, ¿cuál es su nombre?"), //Respuestas bienvenida
										              Arrays.asList("cuéntame, ¿a dónde quieres viajar? Recuerda que por el momento sólo ofrecemos viajes a capitales regionales del país.", "¿a qué capital regional deseas viajar? Puedes hacerlo a cualquier región de Chile. Yo te recomiendo el norte.")
													  ),
										Arrays.asList(//Personalidad 2;
													  Arrays.asList("Hola amigo, soy un Chatbot, y te quiero ayudar. Partamos por tu nombre", "Hola, ¿Cómo estás? Yo bien, soy un chatbot, siempre estoy bien. ¿Cuál es tu nombre?") //Respuestas bienvenida
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

	public List<String> intersect(String str){
		List<List<String>> cities = Arrays.asList(Arrays.asList("Arica", "$32.200 pesos."), Arrays.asList("Iquique", "$30.100 pesos"), Arrays.asList("Antofagasta", "$21.600 pesos"), Arrays.asList("Copiapó", "$15.000 pesos"), Arrays.asList("La Serena", "$9.100 pesos"), Arrays.asList("Valparaíso", "$6.500 pesos"), Arrays.asList("Rancagua", "$3.000 pesos"), Arrays.asList("Talca", "$6.500 pesos"), Arrays.asList("Concepción", "$13.900 pesos"), Arrays.asList("Temuco", "$14.900 pesos"), Arrays.asList("Puerto Montt", "$19.900 pesos"), Arrays.asList("Coyhaique", "$33.000 pesos"), Arrays.asList("Punta Arenas", "$15.000 pesos"), Arrays.asList("Valdivia", "$17.900 pesos"));
		List<List<String>> positive = Arrays.asList(Arrays.asList("sí"), Arrays.asList("si"));
		List<String> splittedStr = Arrays.asList(str);

		for (List<String> city : cities) {
			if (city.get(0).toLowerCase().contains(str.toLowerCase())){
				return city;
			}
		}

		for (List<String> pos : positive){
			if (pos.get(0).toLowerCase().contains(str.toLowerCase())){
				return pos;
			}
		}

		if (str.toLowerCase().compareTo("no") == 0){
			return Arrays.asList("no");
		}

		return null;

	}

	public int getSeed(){
		return this.seed;
	} 

	public List<List<List<String>>> getResponses(){
		return this.responses;
	}

	public Message determineAnswer(List<Message> log, String str){
		if (log.size() == 2){
			Date date = new Date();

			int position = (int) ((this.generator.nextDouble() * 20) % 2);
			String response = str + this.responses.get(this.seed).get(1).get(position);
			System.out.println("Chatbot [>]: " + response);
			Message message = new Message(date, "Chatbot", response);

			return message;
		} else {
			if (intersect(str) != null){
				return null;
			} else {
				System.out.println("error.");
			}
		}
		return null;
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