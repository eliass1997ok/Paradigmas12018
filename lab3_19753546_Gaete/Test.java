public class Test{
	public static class Robot{
		private int edad;

		public Robot(int edad){
			this.edad = edad;
		}

		public int get_edad(){
			return this.edad;
		}
	}
	public static void main(String[] args){
		Robot robot = new Robot(6);
		System.out.println("La edad de mi robot es: " + robot.get_edad());
	}
}