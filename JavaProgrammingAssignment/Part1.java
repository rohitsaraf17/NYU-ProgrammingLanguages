import java.util.*;

class ComparableList<T extends Comparable<T>> extends ArrayList implements Comparable<ComparableList<T>>{
    
    public ComparableList(){
    }
    
    
	public int compareTo(ComparableList<T> ob){
	    Iterator<T> i = this.iterator();
	    Iterator<T> j = ob.iterator();
	    while(i.hasNext() && j.hasNext()){
	        int cmp = i.next().compareTo(j.next());
	        if( cmp !=0 ){
	            return cmp;
	        }
	    }
        return Integer.compare(this.size(),ob.size());
	}
}

class A implements Comparable<A>{
	Integer value1;
	public A(Integer x){
		value1 = x;
	}
	
	public Integer getValue(){
	    return value1;
	}

	public int compareTo(A obj){
		return getValue().compareTo(obj.getValue());
	}
	
  @Override
  public String toString() {
    return String.format("A<%s>", value1);
  }
}

class B extends A{
	Integer value2;
	public B(Integer x, Integer y){
	    super(x);
		 value2= y;
	}
	
	@Override
	public Integer getValue(){
	    return value1+value2;
	}

    @Override
	public int compareTo(A obj){
		return getValue().compareTo(obj.getValue());
	}
	

  @Override
  public String toString() {
    return String.format("B<%s,%s>", value1,value2);
  } 
}

class Part1{
    
   public static <T extends Comparable<T>> void addToCList(T z, ComparableList<T> L){
        L.add(z);
    }
    
    static void test() {
	    ComparableList<A> c1 = new ComparableList<A>();
	    ComparableList<A> c2 = new ComparableList<A>();
	    for(int i = 0; i < 10; i++) {
	        addToCList(new A(i), c1);
	        addToCList(new A(i), c2);
	    }
	
    	addToCList(new A(12), c1);
    	addToCList(new B(6,6), c2);
    	
    	addToCList(new B(7,11), c1);
    	addToCList(new A(13), c2);

    	System.out.print("c1: ");
    	System.out.println(c1);
	
    	System.out.print("c2: ");
    	System.out.println(c2);

	    switch (c1.compareTo(c2)) {
    	case -1: 
    	    System.out.println("c1 < c2");
    	    break;
    	case 0:
    	    System.out.println("c1 = c2");
    	    break;
    	case 1:
    	    System.out.println("c1 > c2");
	        break;
	    default:
	        System.out.println("Uh Oh");
	     break;
	    } 

    }
    
	public static void main(String[] args){
	    test();
	}
}