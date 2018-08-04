import java.util.*;
import java.io.*;
import java.lang.*;
import java.text.*;

/**
* La clase Chat permite la interacción entre usuario y chatbot. Es en esta clase en donde se almacena el log de la 
* conversación, se instancia al usuario, y al respectivo chatbot.
*
* @version 1.0
* @since 1.0
*/

public class Chat{
    private Chatbot chatbot;
    private Usuario user;
    private Log log;
    private boolean endedDialog;
    private boolean startedDialog;

    /**
    * Constructor que permite la instanciación de un chat, inicialmente vacío, en donde se permitirá la interacción entre
    * el usuario y el chatbot. Se mantiene el registro de la conversación en el log, además de una marca que permite
    * determinar si el chat se ha iniciado, y posteriormente si es que ha terminado.
    *
    */

    public Chat(){
        this.chatbot = null;
        this.user = new Usuario();
        this.log = new Log();
    }

    /**
    * Método que permite la identificación de una instrucción ingresada por el usuario. 
    *
    * @param interaction corresponde a la instrucción ingresada por el usuario.
    *
    * @return número entero que identifica a la instrucción ingresada. En caso de ingresar una instrucción no válida, se 
    * retorna un valor negativo, identificador especial para estos casos.
    *
    */

    public int determineInstruction(String interaction){
        String[] instruction = interaction.split("!");

        if (instruction[1].compareTo("beginDialog") == 0){
            return 1;
        } else if (instruction[1].compareTo("saveLog") == 0){
            return 2;
        } else if (instruction[1].compareTo("loadLog") == 0){
            return 3;
        } else if (instruction[1].compareTo("rate") == 0){
            return 4;
        } else if (instruction[1].compareTo("exit") == 0){
            return 8;
        } else if (instruction[1].compareTo("endDialog") == 0){
            return 9;
        }

        return -1;
    }

    /**
    * Método que permite iniciar el programa, es decir, se da la bienvenida al sistema, y comienza la interacción entre
    * usuario y chatbot.
    *
    */    

    public void run() {
        Scanner sc = new Scanner(System.in);

        System.out.println("Sistema [!]: Bienvenido al Chatbot de turismo #1 de Santiago. Este Chatbot le permitirá comprar pasajes con destino a cualquier capital regional del país.");

        this.endedDialog = false;
        this.startedDialog = false;

        boolean finished = false;

        while (! this.endedDialog){
            Message msg = this.user.sendMessage();
            String[] splitedString = msg.getContent().split(" ");

            if (this.startedDialog) this.log.addMessage(msg);

            if (this.chatbot == null || finished){
                if (splitedString.length != 0 && splitedString[0].charAt(0) == '!' && determineInstruction(splitedString[0]) == 1){
                    if (splitedString.length == 1){
                            this.chatbot = new Chatbot();

                        } else {
                            this.chatbot = new Chatbot(Integer.parseInt(splitedString[1]));
                        }

                        finished = false;

                        System.out.println("Sistema [>]: Se ha iniciado correctamente el chat");

                        this.log.addMessage(new Message(new Date(), "Usuario", msg.getContent()));
                        Message greetings = this.chatbot.greetings();
                        this.log.addMessage(greetings);

                        System.out.print("Usuario [>]: ");
                        String name = sc.nextLine();
                        this.user.setName(name);

                        Message nameMessage = new Message(new Date(), "Usuario", name);
                        this.log.addMessage(nameMessage);
                        Message answer = this.chatbot.determineAnswer(this.log.getLog(), nameMessage.getContent());
                        this.log.addMessage(answer);
                        this.startedDialog = true;                       

                } else if (splitedString.length != 0 && splitedString[0].charAt(0) == '!' && determineInstruction(splitedString[0]) == 8){
                    System.out.println("El programa ha finalizado con éxito");
                    this.endedDialog = true;

                } else {
                    System.out.println("Sistema [!] El chat no se ha iniciado correctamente, intente nuevamente."); 
                }

            } else {
                if (splitedString.length != 0 && splitedString[0].charAt(0) == '!'){
                    switch(determineInstruction(splitedString[0])){
                        case(1):
                            if (splitedString.length == 1)
                                this.chatbot = new Chatbot();
                            else 
                                this.chatbot = new Chatbot(Integer.parseInt(splitedString[1]));

                            finished = false;

                            System.out.println("Se ha iniciado correctamente el chat");

                            this.log.clearLog();
                            this.log.addMessage(new Message(new Date(), "Usuario", msg.getContent()));

                            Message greetings = this.chatbot.greetings();
                            this.log.addMessage(greetings);

                            System.out.print("Usuario [>]: ");
                            String name = sc.nextLine();
                            this.user.setName(name);

                            Message nameMessage = new Message(new Date(), "Usuario", name);

                            break;

                        case(2):
                            Date date = new Date();
                            DateFormat df = new SimpleDateFormat("dd-MM-yyyy_HH-mm-ss");
                            String fileName = df.format(date);
                            fileName = fileName + ".log";

                            try {
                                PrintWriter writer = new PrintWriter(fileName, "UTF-8");
                                for (Message messageInLog : this.log.getLog()){
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
                                this.chatbot.setRate(strDate + splitedString[1]);
                                this.user.setRate(strDate + splitedString[2]);

                            }
                            break;
                        case(8):
                            this.endedDialog = true;
                            System.out.println("El programa ha finalizado con éxito");
                            break;

                        case(9):
                            finished = true;
                            this.startedDialog = false;
                            Message goodbye = this.chatbot.goodbye();
                            this.user.setName("Usuario");
                            this.log.addMessage(goodbye);
                            this.log.clearLog();
                            break;

                        default:
                            System.out.println("Sistema [!]: La instrucción especificada no existe. Por favor, ingrese nuevamente.");
                    }                   
                } else {
                    Message answerOfChatbot = this.chatbot.determineAnswer(this.log.getLog(), msg.getContent());
                    
                    this.log.addMessage(answerOfChatbot);
                }
            }
        }
    }
}