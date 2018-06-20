import java.util.*;
public class User{
	private String name;

	public Message sendMessage(){
		Scanner sc = new Scanner(System.in);
		System.out.print("Usuario [>]: ");
		String userEntry = sc.nextLine();

		while (userEntry.length() == 0){
			System.out.println("Sistema [!]: No se ha ingresado texto. Envie nuevamente su mensaje.");
			System.out.print("Usuario [>]: ");
			userEntry = sc.nextLine();
		}

		Message msg = new Message(new Date(), this.name, userEntry);

		return msg;
	}

	public void setName(String name){
		this.name = name;
	}

	// public Message createMessage(String content){
	// 	Date date = new Date();
	// } 
}