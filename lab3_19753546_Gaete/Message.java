import java.util.*;

public class Message{
	private Date date;
	private String autor;
	private String content;

	public Message(Date date, String autor, String content){
		this.date = date;
		this.autor = autor;
		this.content = content;
	}

	public Date getDate(){
		return this.date;
	}

	public String getAutor(){
		return this.autor;
	}

	public String getContent(){
		return this.content;
	}

	public void setDate(Date date){
		this.date = date;
	}

	public void setAutor(String autor){
		this.autor = autor;
	}

	public void setContent(String content){
		this.content = content;
	}
}