package bookshop;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Collection;
//import java.io.Serializable;
public class CartBean {
	private HashMap<Integer,CartItemBean> items=null;
	private int numOfItems=0;
	public CartBean(){
		items=new HashMap<Integer,CartItemBean>();
	}
	public synchronized void addItem(Integer bookId,BookBean book){
		if(!items.containsKey(bookId)){
			CartItemBean item=new CartItemBean(book);
			items.put(bookId, item);
			numOfItems++;
		}
	}
	public synchronized void deleteItem(Integer bookId){
		if(items.containsKey(bookId)){
			items.remove(bookId);
			numOfItems--;
		}
	}
	public synchronized void clear(){
		items.clear();
		numOfItems=0;
	}
	public synchronized int getNumOfItems(){
		return numOfItems;
	}
	public synchronized void setItemNum(Integer bookId,int quantity){
		if(items.containsKey(bookId)){
			CartItemBean item=(CartItemBean)items.get(bookId);
			if(quantity<=0)items.remove(bookId);
			else item.setQuantity(quantity);
		}
	}
	public synchronized float getTotalPrice(){
		float amount=0.0f;
		Iterator<CartItemBean> it=items.values().iterator();
		while(it.hasNext()){
			CartItemBean item=(CartItemBean)it.next();
			amount+=item.getItemPrice();
		}
		return amount;
	}
	public synchronized Collection<CartItemBean> getItems(){
		return items.values();
	}
	public synchronized boolean isExist(Integer bookId){
		if(items.containsKey(bookId)) return true;
		else return false;
	}

}
