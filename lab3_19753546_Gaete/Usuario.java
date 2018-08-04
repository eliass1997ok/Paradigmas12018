import java.util.*;

/**
* La clase Usuario corresponde a la clase que permite establecer un usuario dentro del chat. Este usuario es quien
* mantiene la conversación con el chatbot.
*
* @version 1.0
* @since 1.0
*/

public class Usuario{
    private String name;
    private String rate;
    
    /**
    * Constructor que permite establecer un nombre inicial al Usuario. Inicialmente, se tiene por defecto 
    * que el nombre será "Usuario". Posteriormente será modificado con el nombre real del usuario.
    *
    */

    public Usuario(){
        this.name = "Usuario";
    }

    /**
    * sendMessage permite al usuario iniciar el proceso de intercambiar mensajes con el Chatbot, generando un mensaje.
    *
    * @return Mensaje que posteriomente será enviado al log, y procesado por el Chatbot.
    */

    public Message sendMessage(){
        Scanner sc = new Scanner(System.in);
        System.out.print(this.name + " [>]: ");
        String userEntry = sc.nextLine();

        while (userEntry.length() == 0){
            System.out.println("Sistema [!]: No se ha ingresado texto. Envie nuevamente su mensaje.");
            System.out.print(this.name + " [>]: ");
            userEntry = sc.nextLine();
        }

        Message msg = new Message(new Date(), this.name, userEntry);

        return msg;
    }

    /**
    * setName permite establecer un nombre al usuario.
    *
    * @param name corresponde al string que representa el nombre del usuario.
    */

    public void setName(String name){
        this.name = name;
    }

    /**
    * setRate permite establecer un rate al usuario.
    *
    * @param rate corresponde al rate que se le entrega al usuario.
    */

    public void setRate(String rate){
        this.rate = rate;
    }
}
