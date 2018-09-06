using System;
using System.Collections.Generic;
namespace ChatbotBackend
{
    /**
    * La clase Chatbot corresponde, como su nombre indica, al chatbot en si. Este es el encargado de entregar respuestas
    * automáticas al usuario en base a un reconocimiento de palabras clave dentro del los mensajes enviados por el usuario.
    * El chatbot cuenta con dos personalidades. Una de estas es una personalidad agradable/formal (siendo posible elegirla 
    * a través de la utilización de una semilla par, o no entregando semilla, puesto que es la personalidad por defecto),
    * mientras que la otra personalidad es agradable/divertida, y un poco más informal (seleccionable mediante la utilización
    * de una semilla impar). La semilla por otra parte, le agrega aleatoriedad a las respuestas que entrega el chatbot frente
    * a diversas situaciones.
    *
    */
    public class Chatbot
    {
        private List<List<List<String>>> responses;
        private int seed;
        private Random generator;
        private Boolean confirmed;
        private String rate;

        /**
        * Constructor que permite la instanciación de un chatbot con la personalidad por defecto. Para utilizar los mismos 
        * algoritmos, independiente del constructor, es que de todas formas se establecen las dos personalidades, a pesar de 
        * necesitar solo una.
        *
        */

        public Chatbot()
        {
            this.seed = 0;
            this.generator = new Random(this.seed);
            this.confirmed = false;
            this.rate = null;
            this.responses = new List<List<List<String>>>();
            this.fillResponses();
        }

        /**
        * Constructor que permite la instanciación de un chatbot con una personalidad elegida por el usuario.
        *
        * seed: Número entero que permite determinar la personalidad del chatbot, además de agregar aleatoriedad a sus respuestas.
        *
        */
        public Chatbot(int seed)
        {
            this.seed = seed % 2;
            this.generator = new Random(this.seed);
            this.confirmed = false;
            this.rate = null;
            this.responses = new List<List<List<String>>>();
            this.fillResponses();
        }

        /**
        * Método que permite darle las posibles respuestas que puede llegar a entregar el chatbot.
        *
        */

        public void fillResponses(){
            List<List<String>> personality1;
            personality1 = new List<List<String>>();
            List<String> greetingsP1;
            greetingsP1 = new List<String>();
            greetingsP1.Add("Hola, bienvenido al chat, ¿cuál es tu nombre?");
            greetingsP1.Add("Buenos días, ¿cuál es su nombre?");
            personality1.Add(greetingsP1);
            List<String> afterGreetingsP1;
            afterGreetingsP1 = new List<String>();
            afterGreetingsP1.Add("cuéntame, ¿a dónde quieres viajar? Recuerda que por el momento sólo ofrecemos viajes a capitales regionales del país.");
            afterGreetingsP1.Add("¿a qué capital regional deseas viajar? Puedes hacerlo a cualquier región de Chile. Yo te recomiendo el norte.");
            personality1.Add(afterGreetingsP1);
            List<String> afterGetCityP1;
            afterGetCityP1 = new List<string>();
            afterGetCityP1.Add(" es un lugar ideal en ésta época del año!. Te cuento que los pasajes tienen un valor de ");
            afterGetCityP1.Add(" es ideal en esta época del año, no te arrepentirás. Viajar hacia allá cuesta ");
            personality1.Add(afterGetCityP1);
            List<String> yesToTravelP1;
            yesToTravelP1 = new List<String>();
            yesToTravelP1.Add("Excelente. Ahora sólo debes confirmar tus datos y pasajes en nuestra página web.");
            yesToTravelP1.Add("Bien, ahora para confirmar la cantidad y la fecha de los pasajes, debe ingresar a nuestro sitio web");
            personality1.Add(yesToTravelP1);
            List<String> noToTravelP1;
            noToTravelP1 = new List<String>();
            noToTravelP1.Add("Entonces, ¿a qué lugar te gustaría viajar?");
            noToTravelP1.Add("Entonces, ¿podrías decirme un destino al que te gustaría ir?");
            personality1.Add(noToTravelP1);
            List<String> noUnderstoodP1;
            noUnderstoodP1 = new List<String>();
            noUnderstoodP1.Add("Disculpa, no he logrado entenderte del todo. ¿Podrías ser un poco más claro?");
            noUnderstoodP1.Add("No te he logrado entender lo que me has dicho. ¿Podrías ser más claro?");
            personality1.Add(noUnderstoodP1);
            List<String> goodbyeP1;
            goodbyeP1 = new List<String>();
            goodbyeP1.Add("Adiós, espero haber sido de ayuda.");
            goodbyeP1.Add("¡Nos vemos! Espero que disfrutes tu viaje.");
            personality1.Add(goodbyeP1);
            this.responses.Add(personality1);

            List<List<String>> personality2;
            personality2 = new List<List<String>>();
            List<String> greetingsP2;
            greetingsP2 = new List<String>();
            greetingsP2.Add("Hola amigo, soy un Chatbot, y te quiero ayudar. Partamos por tu nombre");
            greetingsP2.Add("Hola, ¿Cómo estás? Yo bien, soy un chatbot, siempre estoy bien. ¿Cuál es tu nombre?");
            personality2.Add(greetingsP2);
            List<String> afterGreetingsP2;
            afterGreetingsP2 = new List<String>();
            afterGreetingsP2.Add("y dime, ¿a dónde te quieres pegar un pique? Yo viajaría al sur, pero no sé tú.");
            afterGreetingsP2.Add("y bueno, ¿dónde nos vamos de paseo? a mi me gusta el norte, pero soy un bot, así que no puedo ir muy lejos que digamos :(");
            personality2.Add(afterGreetingsP2);
            List<String> afterGetCityP2;
            afterGetCityP2 = new List<string>();
            afterGetCityP2.Add(" es un muy lindo lugar para viajar. Los pasajes eso si están a ");
            afterGetCityP2.Add("es muy buen lugar! Si tan sólo yo pudiera viajar, lo haría hacia allá. Los pasajes cuestan ");
            personality2.Add(afterGetCityP2);
            List<String> yesToTravelP2;
            yesToTravelP2 = new List<String>();
            yesToTravelP2.Add("¡Bien! Ahora sólo debes confimar los pasajes en nuestro sitio web.");
            yesToTravelP2.Add("Excelente, ahora puedes confirmar cantidad de pasajes en nuestro sitio web. Recuerda que soy un bot, así que no me incluyas en tu viaje.");
            personality2.Add(yesToTravelP2);
            List<String> noToTravelP2;
            noToTravelP2 = new List<String>();
            noToTravelP2.Add("Entonces amigo, ¿tienes algún otro lugar en mente? dímelo, con confianza.");
            noToTravelP2.Add("¿A qué lugar quieres viajar entonces?");
            personality2.Add(noToTravelP2);
            List<String> noUnderstoodP2;
            noUnderstoodP2 = new List<String>();
            noUnderstoodP2.Add("Uf, creo que la persona que me programó no tenía en cuenta tu mensaje. ¿Podrías intentar ser un poquito más claro?");
            noUnderstoodP2.Add("No entendí bien lo que me dijiste, ¿podrías intentar ser más claro?");
            personality2.Add(noUnderstoodP2);
            List<String> goodbyeP2;
            goodbyeP2 = new List<String>();
            goodbyeP2.Add("Adiós amigo, fue un gusto hablar contigo, espero que disfrutes tu viaje tanto como yo disfruté esta conversación.");
            goodbyeP2.Add("¡Éxito en tu viaje! Espero que te vaya excelente.");
            personality2.Add(goodbyeP2);
            this.responses.Add(personality2);
        }

        /**
        * Método que permite la intersección de palabras de un string, con una lista de palabras clave, con el fin de
        * deteminar el tipo de mensaje que entrega el usuario.
        *
        * str: correponde al string ingresado por el usuario.
        * 
        * Se retorna una lista con las palabras claves encontradas dentro del mensaje del usuario.
        *
        */ 

        public List<String> intersect(String str){
            List<List<String>> cities;
            List<List<String>> positive;
            List<String> splittedString;
            splittedString = new List<String>();
            positive = new List<List<String>>();
            cities = new List<List<String>>();
            splittedString.Add(str);
            positive.Add(new List<String>(new String[] { "sí"}));
            positive.Add(new List<String>(new String[] { "si"}));
            cities.Add(new List<String>(new String[] {"Arica", "$32.000 pesos."}));
            cities.Add(new List<String>(new String[] { "Iquique", "$30.100 pesos." }));
            cities.Add(new List<String>(new String[] { "Antofagasta", "$21.600 pesos." }));
            cities.Add(new List<String>(new String[] { "Copiapó", "$15.000 pesos." }));
            cities.Add(new List<String>(new String[] { "La Serena", "$9.100 pesos." }));
            cities.Add(new List<String>(new String[] { "Valparaíso", "$6.500 pesos." }));
            cities.Add(new List<String>(new String[] { "Rancagua", "$3.000 pesos." }));
            cities.Add(new List<String>(new String[] { "Concepción", "$13.900 pesos." }));
            cities.Add(new List<String>(new String[] { "Puerto Montt", "$19.900 pesos." }));
            cities.Add(new List<String>(new String[] { "Coyhaique", "$33.000 pesos." }));
            cities.Add(new List<String>(new String[] { "Punta Arenas", "$15.000 pesos." }));
            cities.Add(new List<String>(new String[] { "Valdivia", "$17.900 pesos." }));

            foreach (List<String> city in cities){
                if (str.ToLower().Contains(city[0].ToLower())){
                    return city;
                }
            }

            foreach (List<String> pos in positive){
                if (str.ToLower().Contains(pos[0].ToLower())){
                    return pos;
                }
            }

            if (str.ToLower().Contains("no")){
                return new List<String>(new String[] { "no" });
            }

            return null;
        }

        /**
        * Método que permite al chatbot identificar la respuesta que se le debe entregar al usuario, en base a los mensajes
        * que existen dentro del log como en el mensaje entregado por el usuario.
        *
        * log: correponde al historial de mensajes intercambiados por el usuario y el chatbot en el actual chat.
        * str: correponde al último string ingresado por el usuario.
        * 
        * Retorna un mensaje de respuesta frente al mensaje ingresado por el usuario.
        *
        */ 
        public Message determineAnswer(List<Message> log, String str){
            if (log.Count == 2){
                DateTime date = DateTime.Now;
                int position = (int)((this.generator.NextDouble() * 20) % 2);
                String response = str + " " + this.responses[this.seed][1][position];

                return new Message(date, "Chatbot [>]: ", response);
            } else {
                if (this.intersect(str) != null){
                    if (this.intersect(str).Count == 2){
                        this.confirmed = true;
                        String placeToTravel = this.intersect(str)[0];
                        String tickets = this.intersect(str)[1];
                        DateTime date = DateTime.Now;
                        int position = (int)((this.generator.NextDouble() * 20) % 2);
                        String response = placeToTravel + " " + this.responses[this.seed][2][position] + " " + tickets + "¿Desea confirmar esos pasajes?";

                        return new Message(date, "Chatbot [>]: ", response);
                    } else {
                        if (this.confirmed && (this.intersect(str)[0] == "sí" || this.intersect(str)[0] == "sí")){
                            DateTime date = DateTime.Now;

                            int position = (int)((this.generator.NextDouble() * 20) % 2);
                            String response = this.responses[this.seed][3][position];

                            return new Message(date, "Chatbot [>]: ", response);
                        } else {
                            this.confirmed = false;
                            DateTime date = DateTime.Now;
                            int position = (int)((this.generator.NextDouble() * 20) % 2);
                            String response = this.responses[this.seed][4][position];

                            return new Message(date, "Chatbot [>]: ", response);
                        }
                    }
                } else {
                    DateTime date = DateTime.Now;
                    int position = (int)((this.generator.NextDouble() * 20) % 2);
                    String response = this.responses[this.seed][5][position];

                    return new Message(date, "Chatbot [>]: ", response);
                }
            }
        }

        /**
        * Método que permite al chatbot entregar un mensaje con el cual saludar al usuario.
        *
        * Retorna un mensaje saludando al usuario.
        *
        */ 
        public Message greetings(){
            DateTime date = DateTime.Now;
            this.generator = new Random();
            int position = (int)((this.generator.NextDouble() * 20) % 2);
            String response = this.responses[this.seed][0][position];

            return new Message(date, "Chatbot [>]: ", response);
        }

        /**
        * Método que permite al chatbot entregar un mensaje con el cual despedirse del usuario.
        *
        * Retorna un mensaje despidiéndose del usuario.
        *
        */ 
        public Message goodbye(){
            DateTime date = DateTime.Now;
            int position = (int)((this.generator.NextDouble() * 20) % 2);
            String response = this.responses[this.seed][6][position];

            return new Message(date, "Chatbot [>]:", response);
        }

        /**
        * Método que permite obtener el rate del Chatbot.
        *
        * Retorna un String que representa el rate del chatbot.
        *
        */ 
        public String getRate(){
            return this.rate;
        }

        /**
        * Método que permite establecer el rate del Chatbot.
        *
        */ 
        public void setRate(String rate){
            this.rate = rate;
        }

        /**
        * Método que permite obtener la semilla del Chatbot.
        *
        * Retorna un entero que representa la semilla del chatbot.
        *
        */ 
        public int GetSeed()
        {
            return this.seed;
        }
    }
}
