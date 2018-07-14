import java.util.*;

/**
* La clase Chatbot corresponde, como su nombre indica, al chatbot en si. Este es el encargado de entregar respuestas
* automáticas al usuario en base a un reconocimiento de palabras clave dentro del los mensajes enviados por el usuario.
* El chatbot cuenta con dos personalidades. Una de estas es una personalidad agradable/formal (siendo posible elegirla 
* a través de la utilización de una semilla par, o no entregando semilla, puesto que es la personalidad por defecto),
* mientras que la otra personalidad es agradable/divertida, y un poco más informal (seleccionable mediante la utilización
* de una semilla impar). La semilla por otra parte, le agrega aleatoriedad a las respuestas que entrega el chatbot frente
* a diversas situaciones.
*
* @version 1.0
* @since 1.0
*/

public class Chatbot{
    private List<List<List<String>>> responses;
    private int seed;
    private Random generator;
    private boolean confirmed;
    private String rate;

    /**
    * Constructor que permite la instanciación de un chatbot con la personalidad por defecto. Para utilizar los mismos 
    * algoritmos, independiente del constructor, es que de todas formas se establecen las dos personalidades, a pesar de 
    * necesitar solo una.
    *
    */

    public Chatbot(){
        this.seed = 0;
        this.generator = new Random(this.seed);
        this.confirmed = false;
        this.rate = null;
        this.responses = Arrays.asList( Arrays.asList(
                                                      Arrays.asList("Hola, bienvenido al chat, ¿cuál es tu nombre?", "Buenos días, ¿cuál es su nombre?"),
                                                      Arrays.asList("cuéntame, ¿a dónde quieres viajar? Recuerda que por el momento sólo ofrecemos viajes a capitales regionales del país.", "¿a qué capital regional deseas viajar? Puedes hacerlo a cualquier región de Chile. Yo te recomiendo el norte."),
                                                      Arrays.asList(" es un lugar ideal en ésta época del año!. Te cuento que los pasajes tienen un valor de ", " es ideal en esta época del año, no te arrepentirás. Viajar hacia allá cuesta "),
                                                      Arrays.asList("Excelente. Ahora sólo debes confirmar tus datos y pasajes en nuestra página web.", "Bien, ahora para confirmar la cantidad y la fecha de los pasajes, debe ingresar a nuestro sitio web"),
                                                      Arrays.asList("Entonces, ¿a qué lugar te gustaría viajar?", "Entonces, ¿podrías decirme un destino al que te gustaría ir?"),
                                                      Arrays.asList("Disculpa, no he logrado entenderte del todo. ¿Podrías ser un poco más claro?", "No te he logrado entender lo que me has dicho. ¿Podrías ser más claro?"),
                                                      Arrays.asList("Adiós, espero haber sido de ayuda.", "¡Nos vemos! Espero que disfrutes tu viaje.")
                                                      ),
                                        Arrays.asList(
                                                      Arrays.asList("Hola amigo, soy un Chatbot, y te quiero ayudar. Partamos por tu nombre", "Hola, ¿Cómo estás? Yo bien, soy un chatbot, siempre estoy bien. ¿Cuál es tu nombre?"),
                                                      Arrays.asList("y dime, ¿a dónde te quieres pegar un pique? Yo viajaría al sur, pero no sé tú.", "y bueno, ¿dónde nos vamos de paseo? a mi me gusta el norte, pero soy un bot, así que no puedo ir muy lejos que digamos :("),
                                                      Arrays.asList(" es un muy lindo lugar para viajar. Los pasajes eso si están a ", "es muy buen lugar! Si tan sólo yo pudiera viajar, lo haría hacia allá. Los pasajes cuestan "),
                                                      Arrays.asList("¡Bien! Ahora sólo debes confimar los pasajes en nuestro sitio web.", "Excelente, ahora puedes confirmar cantidad de pasajes en nuestro sitio web. Recuerda que soy un bot, así que no me incluyas en tu viaje."),
                                                      Arrays.asList("Entonces amigo, ¿tienes algún otro lugar en mente? dímelo, con confianza.", "¿A qué lugar quieres viajar entonces?"),
                                                      Arrays.asList("Uf, creo que la persona que me programó no tenía en cuenta tu mensaje. ¿Podrías intentar ser un poquito más claro?", "No entendí bien lo que me dijiste, ¿podrías intentar ser más claro?"),
                                                      Arrays.asList("Adiós amigo, fue un gusto hablar contigo, espero que disfrutes tu viaje tanto como yo disfruté esta conversación.", "¡Éxito en tu viaje! Espero que te vaya excelente.")
                                                     )
                                        );
    }

    /**
    * Constructor que permite la instanciación de un chatbot con una personalidad elejida por el usuario.
    *
    * @param seed correponde al número de semilla que determina la personalidad del chatbot. También le agrega
    * aleatoriedad a las respuestas dadas por el chatbot frente a determinados mensajes.
    *
    */   

    public Chatbot(int seed){
        this.seed = seed % 2;
        this.generator = new Random(seed);
        this.confirmed = false;
        this.responses = Arrays.asList( Arrays.asList(
                                                      Arrays.asList("Hola, bienvenido al chat, ¿cuál es tu nombre?", "Buenos días, ¿cuál es su nombre?"),
                                                      Arrays.asList("cuéntame, ¿a dónde quieres viajar? Recuerda que por el momento sólo ofrecemos viajes a capitales regionales del país.", "¿a qué capital regional deseas viajar? Puedes hacerlo a cualquier región de Chile. Yo te recomiendo el norte."),
                                                      Arrays.asList(" es un lugar ideal en ésta época del año!. Te cuento que los pasajes tienen un valor de ", " es ideal en esta época del año, no te arrepentirás. Viajar hacia allá cuesta "),
                                                      Arrays.asList("Excelente. Ahora sólo debes confirmar tus datos y pasajes en nuestra página web.", "Bien, ahora para confirmar la cantidad y la fecha de los pasajes, debe ingresar a nuestro sitio web"),
                                                      Arrays.asList("Entonces, ¿a qué lugar te gustaría viajar?", "Entonces, ¿podrías decirme un destino al que te gustaría ir?"),
                                                      Arrays.asList("Disculpa, no he logrado entenderte del todo. ¿Podrías ser un poco más claro?", "No te he logrado entender lo que me has dicho. ¿Podrías ser más claro?"),
                                                      Arrays.asList("Adiós, espero haber sido de ayuda.", "¡Nos vemos! Espero que disfrutes tu viaje.")
                                                      ),
                                        Arrays.asList(
                                                      Arrays.asList("Hola amigo, soy un Chatbot, y te quiero ayudar. Partamos por tu nombre", "Hola, ¿Cómo estás? Yo bien, soy un chatbot, siempre estoy bien. ¿Cuál es tu nombre?"),
                                                      Arrays.asList("y dime, ¿a dónde te quieres pegar un pique? Yo viajaría al sur, pero no sé tú.", "y bueno, ¿dónde nos vamos de paseo? a mi me gusta el norte, pero soy un bot, así que no puedo ir muy lejos que digamos :("),
                                                      Arrays.asList(" es un muy lindo lugar para viajar. Los pasajes eso si están a ", "es muy buen lugar! Si tan sólo yo pudiera viajar, lo haría hacia allá. Los pasajes cuestan "),
                                                      Arrays.asList("¡Bien! Ahora sólo debes confimar los pasajes en nuestro sitio web.", "Excelente, ahora puedes confirmar cantidad de pasajes en nuestro sitio web. Recuerda que soy un bot, así que no me incluyas en tu viaje."),
                                                      Arrays.asList("Entonces amigo, ¿tienes algún otro lugar en mente? dímelo, con confianza.", "¿A qué lugar quieres viajar entonces?"),
                                                      Arrays.asList("Uf, creo que la persona que me programó no tenía en cuenta tu mensaje. ¿Podrías intentar ser un poquito más claro?", "No entendí bien lo que me dijiste, ¿podrías intentar ser más claro?"),
                                                      Arrays.asList("Adiós amigo, fue un gusto hablar contigo, espero que disfrutes tu viaje tanto como yo disfruté esta conversación.", "¡Éxito en tu viaje! Espero que te vaya excelente.")
                                                     )
                                        );
    }

    /**
    * Método que permite la intersección de palabras de un string, con una lista de palabras clave, con el fin de
    * deteminar el tipo de mensaje que entrega el usuario.
    *
    * @param str correponde al string ingresado por el usuario.
    * 
    * @return una lista con las palabras claves encontradas dentro del mensaje del usuario.
    *
    */ 

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

    /**
    * Método que permite al chatbot identificar la respuesta que se le debe entregar al usuario, en base a los mensajes
    * que existen dentro del log como en el mensaje entregado por el usuario.
    *
    * @param log correponde al historial de mensajes intercambiados por el usuario y el chatbot en el actual chat.
    * @param str correponde al último string ingresado por el usuario.
    * 
    * @return un mensaje de respuesta frente al mensaje ingresado por el usuario.
    *
    */ 

    public Message determineAnswer(List<Message> log, String str){
        if (log.size() == 3){
            Date date = new Date();

            int position = (int) ((this.generator.nextDouble() * 20) % 2);
            String response = str + " " + this.responses.get(this.seed % 2).get(1).get(position);
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

    /**
    * Método que permite al chatbot entregar un mensaje con el cual saludar al usuario.
    *
    * @return un mensaje saludando al usuario.
    *
    */ 

    public Message greetings(){
        Date date = new Date();

        int position = (int) ((this.generator.nextDouble() * 20) % 2);
        String response = this.responses.get(this.seed).get(0).get(position);
        System.out.println("Chatbot [>]: " + response);

        Message message = new Message(date, "Chatbot", response);

        return message;
    }

    /**
    * Método que permite al chatbot entregar un mensaje con el cual despedirse del usuario.
    *
    * @return un mensaje despidiéndose del usuario.
    *
    */ 

    public Message goodbye(){
        Date date = new Date();

        int position = (int) ((this.generator.nextDouble() * 20) % 2);
        String response = this.responses.get(this.seed).get(6).get(position);
        System.out.println("Chatbot [>]: " + response);

        Message message = new Message(date, "Chatbot", response);

        return message;
    }

    /**
    * Método que permite darle una nota al chatbot. La nota es almacenada junto a la fecha en un string.
    *
    * @param rate string que contiene tanto la fecha como el rate que se le ha dado al chatbot
    *
    */ 

    public void setRate(String rate){
        this.rate = rate;
    }
}