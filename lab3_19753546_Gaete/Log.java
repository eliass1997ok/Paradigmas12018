import java.util.*;

/**
* La clase Log permite mantener un registro de lo que son las conversaciones dentro de la clase principal Chat.
*
* @version 1.0
* @since 1.0
*/

public class Log{
	private List<Message> log;

	/**
    * Contructor que permite instanciar un log a partir de otro.
    *
    */

	public Log(List<Message> log){
		this.log = log;
	}

	/**
    * Contructor que permite instanciar un log vacío.
    *
    */

	public Log(){
		this.log = new ArrayList<Message>();
	}

	/**
    * Método que permite agregar un mensaje al log. 
    *
    * @param msg corresponde al mensaje que se añadirá al log
    *
    */

	public void addMessage(Message msg){
		this.log.add(msg);
	}

	/**
    * Método que permite limpiar un log.
    *
    */

	public void clearLog(){
		this.log.clear();
	}

	/**
    * Método que permite obtener el log.
    *
    * @return una lista de mensajes, el cual es la representación del log.
    *
    */

	public List<Message> getLog(){
		return this.log;
	}
}