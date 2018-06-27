import java.util.*;
public class Usuario{
	private String name;
	private String rate;

	public Usuario(){
		this.name = "Usuario";
	}

	public Message sendMessage(){
		Scanner sc = new Scanner(System.in);
		System.out.print(this.name + " [>]: ");
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

	public void setRate(String rate){
		this.rate = rate;
	}
}