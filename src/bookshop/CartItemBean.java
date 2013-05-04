package bookshop;
//import java.io.Serializable;
public class CartItemBean {
   private BookBean book=null;
   private int quantity=0;
   public CartItemBean(){
	   
   }
   public CartItemBean(BookBean book){
	   this.book=book;
	   this.quantity=1;
   }
   public BookBean getBook(){
	   return book;
   }
   public void setBook(BookBean book){
	   this.book=book;
   }
   public void setQuantity(int quantity){
	   this.quantity=quantity;
   }
   public int getQuantity(){
	   return quantity;
   }
   public float getItemPrice(){
	   float price=book.getPrice()*quantity;
	   long val=Math.round(price*100);
	   return val/100.0f;
   }
}
