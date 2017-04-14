package control.tracker;

public class Test extends Thread{
	public static int i=0;
	public void run(){
		System.out.println("changing");
		Test t = new Test();
		i=t.change()+1;
	}
	
	public void start(){
		i++;
	}
	
	public int change(){
		System.out.println("change i");
		return i++;
	}
	
	public static void main(String [] args){
		Test t1= new Test();
		t1.run();
		System.out.println("main: "+i);
	}	
}
