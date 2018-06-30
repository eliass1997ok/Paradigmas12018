import java.util.*;
import java.lang.*;
import java.text.*;

/**
* La clase Message corresponde a la clase que permite establecer un orden a la hora de generar mensajes dentro del 
* chat. Los Mensajes son una combinación de fecha, emitidos por un autor, con cierto contenido.
*
* @version 1.0
* @since 1.0
*/

public class Message{
	private Date date;
	private String autor;
	private String content;

    /**
    * Constructor que permite crear el mensaje. 
    *
    * @param date corresponde a la fecha y hora de emisión del mensaje.
    * @param autor correponde a quien emite el mensaje.
   	* @param content corresponde al contenido del mensaje. 
    *
    */

	public Message(Date date, String autor, String content){
		this.date = date;
		this.autor = autor;
		this.content = content;
	}

    /**
    * getContent correponde a un método que permite obtener el contenido de un mensaje. 
    *
    * @return string con el contenido del mensaje.
    *
    */	

	public String getContent(){
		return this.content;
	}

    /**
    * toString correponde a un método que permite obtener los atributos de la clase de manera ordenada 
    * en un String.
    *
    * @return string con los datos de forma ordenada, con la fecha manteniendo una estructura dada, posteriormente
    * 		  el autor, para terminar con el contenido del mensaje.
    *
    */	

	public String toString(){
		DateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");

		return "[" + df.format(this.date) + "] " + this.autor + ": " + this.content;
	}
}