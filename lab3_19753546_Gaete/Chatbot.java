import java.util.*;

public class Chatbot{
	private List<List<List<String>>> responses;
	private int seed;
	private Random generator;
	private boolean confirmed;
	private String rate;

	public Chatbot(){
		this.seed = 0;
		this.generator = new Random(this.seed);
		this.confirmed = false;
		this.rate = null;
		this.responses = Arrays.asList( Arrays.asList(//Personalidad 1;
										              Arrays.asList("Hola, bienvenido al chat, ¿cuál es tu nombre?", "Buenos días, ¿cuál es su nombre?"), //Respuestas bienvenida
										              Arrays.asList("cuéntame, ¿a dónde quieres viajar? Recuerda que por el momento sólo ofrecemos viajes a capitales regionales del país.", "¿a qué capital regional deseas viajar? Puedes hacerlo a cualquier región de Chile. Yo te recomiendo el norte."),
										              Arrays.asList(" es un lugar ideal en ésta época del año!. Te cuento que los pasajes tienen un valor de ", " es ideal en esta época del año, no te arrepentirás. Viajar hacia allá cuesta "),
										              Arrays.asList("Excelente. Ahora sólo debes confirmar tus datos y pasajes en nuestra página web.", "Bien, ahora para confirmar la cantidad y la fecha de los pasajes, debe ingresar a nuestro sitio web"),
										              Arrays.asList("Entonces, ¿a qué lugar te gustaría viajar?", "Entonces, ¿podrías decirme un destino al que te gustaría ir?"),
										              Arrays.asList("Disculpa, no he logrado entenderte del todo. ¿Podrías ser un poco más claro?", "No te he logrado entender lo que me has dicho. ¿Podrías ser más claro?"),
										              Arrays.asList("Adiós, espero haber sido de ayuda.", "¡Nos vemos! Espero que disfrutes tu viaje.")
													  ),
										Arrays.asList(//Personalidad 2;
													  Arrays.asList("Hola amigo, soy un Chatbot, y te quiero ayudar. Partamos por tu nombre", "Hola, ¿Cómo estás? Yo bien, soy un chatbot, siempre estoy bien. ¿Cuál es tu nombre?") //Respuestas bienvenida
											         )
										);
	}

	public Chatbot(int seed){
		this.seed = seed % 2;
		this.generator = new Random(seed);
		this.confirmed = false;
		this.responses = Arrays.asList( Arrays.asList(//Personalidad 1;
										              Arrays.asList("Hola, bienvenido al chat, ¿cuál es tu nombre?", "Buenos días, ¿cuál es su nombre?"), //Respuestas bienvenida
										              Arrays.asList("cuéntame, ¿a dónde quieres viajar? Recuerda que por el momento sólo ofrecemos viajes a capitales regionales del país.", "¿a qué capital regional deseas viajar? Puedes hacerlo a cualquier región de Chile. Yo te recomiendo el norte."),
										              Arrays.asList(" es un lugar ideal en ésta época del año!. Te cuento que los pasajes tienen un valor de ", " es ideal en esta época del año, no te arrepentirás. Viajar hacia allá cuesta "),
										              Arrays.asList("Excelente. Ahora sólo debes confirmar tus datos y pasajes en nuestra página web.", "Bien, ahora para confirmar la cantidad y la fecha de los pasajes, debe ingresar a nuestro sitio web"),
										              Arrays.asList("Entonces, ¿a qué lugar te gustaría viajar?", "Entonces, ¿podrías decirme un destino al que te gustaría ir?"),
										              Arrays.asList("Disculpa, no he logrado entenderte del todo. ¿Podrías ser un poco más claro?", "No te he logrado entender lo que me has dicho. ¿Podrías ser más claro?"),
										              Arrays.asList("Adiós, espero haber sido de ayuda.", "¡Nos vemos! Espero que disfrutes tu viaje.")
													  ),
										Arrays.asList(//Personalidad 2;
													  Arrays.asList("Hola amigo, soy un Chatbot, y te quiero ayudar. Partamos por tu nombre", "Hola, ¿Cómo estás? Yo bien, soy un chatbot, siempre estoy bien. ¿Cuál es tu nombre?") //Respuestas bienvenida
											         )
										);
	}

	public List<String> intersect(String str){
		List<List<String>> cities = Arrays.asList(Arrays.asList("Arica", "$32.200 pesos."), Arrays.asList("Iquique", "$30.100 pesos"), Arrays.asList("Antofagasta", "$21.600 pesos"), Arrays.asList("Copiapó", "$15.000 pesos"), Arrays.asList("La Serena", "$9.100 pesos"), Arrays.asList("Valparaíso", "$6.500 pesos"), Arrays.asList("Rancagua", "$3.000 pesos"), Arrays.asList("Talca", "$6.500 pesos"), Arrays.asList("Concepción", "$13.900 pesos"), Arrays.asList("Temuco", "$14.900 pesos"), Arrays.asList("Puerto Montt", "$19.900 pesos"), Arrays.asList("Coyhaique", "$33.000 pesos"), Arrays.asList("Punta Arenas", "$15.000 pesos"), Arrays.asList("Valdivia", "$17.900 pesos"));
		List<List<String>> positive = Arrays.asList(Arrays.asList("sí"), Arrays.asList("si"));
		List<String> splittedStr = Arrays.asList(str);

		for (List<String> city : cities) {
			if (str.toLowerCase().contains(city.get(0).toLowerCase())){
				return city;
			}
		}

		for (List<String> pos : positive){
			if (str.toLowerCase().contains(pos.get(0).toLowerCase())) {
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
		if (log.size() == 3){
			Date date = new Date();

			int position = (int) ((this.generator.nextDouble() * 20) % 2);
			String response = str + " " + this.responses.get(this.seed).get(1).get(position);
			System.out.println("Chatbot [>]: " + response);
			Message message = new Message(date, "Chatbot", response);

			return message;
		} else {
			if (intersect(str) != null){
				if (intersect(str).size() == 2){
					this.confirmed = true;
					String placeToTravel = intersect(str).get(0);
					String tickets = intersect(str).get(1);
					Date date = new Date();

					int position = (int) ((this.generator.nextDouble() * 20) % 2);
					String response = placeToTravel + " " + this.responses.get(this.seed).get(2).get(position) + " " + tickets + " ¿Deseas confirmar esos pasajes?";
					System.out.println("Chatbot [>]: " + response);
					Message message = new Message(date, "Chatbot", response);
					
					return message;
				} else {
					if (this.confirmed && (intersect(str).get(0).compareTo("sí") == 0 || intersect(str).get(0).compareTo("si") == 0)){
						Date date = new Date();

						int position = (int) ((this.generator.nextDouble() * 20) % 2);
						String response = this.responses.get(this.seed).get(3).get(position);
						System.out.println("Chatbot [>]: " + response);
						Message message = new Message(date, "Chatbot", response);

						return message;
					} else {
						this.confirmed = false;
						Date date = new Date();
						int position = (int) ((this.generator.nextDouble() * 20) % 2);
						String response = this.responses.get(this.seed).get(4).get(position);
						System.out.println("Chatbot [>]: " + response);
						Message message = new Message(date, "Chatbot", response);

						return message;						
					}
				}
			} else {
				Date date = new Date();
				int position = (int) ((this.generator.nextDouble() * 20) % 2);
				String response = this.responses.get(this.seed).get(5).get(position);
				System.out.println("Chatbot [>]: " + response);
				Message message = new Message(date, "Chatbot", response);

				return message;	
			}
		}
	}

	public Message greetings(){
		Date date = new Date();

		int position = (int) ((this.generator.nextDouble() * 20) % 2);
		String response = this.responses.get(this.seed).get(0).get(position);
		System.out.println("Chatbot [>]: " + response);

		Message message = new Message(date, "Chatbot", response);

		return message;
	}

	public Message goodbye(){
		Date date = new Date();

		int position = (int) ((this.generator.nextDouble() * 20) % 2);
		String response = this.responses.get(this.seed).get(6).get(position);
		System.out.println("Chatbot [>]: " + response);

		Message message = new Message(date, "Chatbot", response);

		return message;
	}

	public void setRate(String rate){
		this.rate = rate;
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