<%@page contentType="text/html;charset=GB2312"%>
<%@include file="common.jsp"%>
<%@page import="java.util.*"%>
<jsp:useBean id="cart" class="bookshop.CartBean" scope="session"/>
<html>
<head><title>���ﳵ</title></head>
<body>
<% 
 request.setCharacterEncoding("GB2312"); 
 String action=request.getParameter("action"); 
 if(action!=null&&action.equals("modify")) 
 { 
   String strItemNum=request.getParameter("itemnum"); 
   if(null==strItemNum||"".equals(strItemNum)) 
   { 
     throw new ServletException("�Ƿ�����"); 
   } 
   int itemNum=Integer.parseInt(strItemNum); 
   for(int i=0;i<itemNum;i++) 
   { 
     String strNum=request.getParameter("num_"+i); 
     String strBookId=request.getParameter("book_"+i); 
      
     int quantity=Integer.parseInt(strNum); 
     int bookId=Integer.parseInt(strBookId); 
      
     boolean bEnough=false; 
     bEnough=bookdb.isAmountEnough(bookId,quantity);
     if(bEnough) 
     { 
       cart.setItemNum(new Integer(bookId),quantity); 
     } 
     else 
     { 
       BookBean book=bookdb.getBook(bookId); 
       out.println("<font color=\"red\" size=\"4\">"); 
       out.print("��"+book.getTitle()+"��"); 
       out.print("�Ŀ������ֻ��"+book.getAmount()+"�����������������!<p>"); 
       out.println("</font>"); 
     } 
   } 
  } 
 %>

 <%
  Collection<CartItemBean> cl=cart.getItems();
  if(cl.size()<=0)
  {  
    out.println("���ﳵ��û��ͼ��<p>");
 %>
  <a href="indexes.jsp">��������</a>
  <%
  return;
  }
  Iterator<CartItemBean> it=cl.iterator();
     %>
     <form name="theform" action="showcart.jsp" action="post">
       <table border="1">
        <tr> 
          <th>����</th>
          <th>�۸�</th>
          <th>����</th>
          <th>С��</th>
          <th>ȡ��</th>
        </tr>
        <%
        int i=0;
        while(it.hasNext())
        {
          CartItemBean cartItem=(CartItemBean)it.next();
          BookBean book=cartItem.getBook();
          int bookId=book.getId();
          String fieldNum="num_"+i;
          String fieldBook="book_"+i;
         %>  
        <tr>
          <td><%=book.getTitle() %></td>
          <td><%=book.getPrice() %></td>
          <td>
             <input type="text" name="<%=fieldNum %>"  value="<%=cartItem.getQuantity() %>" />
             <input type="hidden" name="<%=fieldBook %>" value="<%=bookId %>" />   
          </td>
          <td><%=cartItem.getItemPrice() %></td>
          <td><a href="delitem.jsp?id=<%=bookId %>">ɾ��</a></td>
          </tr>
        <%
        i++;
        }
         %>  
         <tr>
         <td>�ϼ�</td>
         <td ><%=cart.getTotalPrice() %></td>
         </tr>
         </table><p>
         <input type="hidden" name="itemnum" value="<%=i %>"/>
         <input type="submit" name="action" value="modify" />
         <br/>
         <a href="indexes.jsp">��������</a>
         <br/>
         �����������
         </p>
         </form>
</body>
</html>