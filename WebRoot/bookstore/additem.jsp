<%@include file="common.jsp"%>
<jsp:useBean id="cart" class="bookshop.CartBean" scope="session"/>
<% String strBookId=request.getParameter("add");
   if(strBookId!=null&&!"".equals(strBookId)){
   int bookId=Integer.parseInt(strBookId);
   BookBean book=bookdb.getBook(bookId);
   cart.addItem(new Integer(bookId),book);
   }
   %>