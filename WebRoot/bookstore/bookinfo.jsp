<%@page contentType="text/html;charset=GB2312"%>
<%@include file="common.jsp"%>
<jsp:useBean id="cart" class="bookshop.CartBean" scope="session"/>
<html>
<head><title>������ϸ��Ϣ</title></head>
<body>
<center>
<jsp:include page="additem.jsp"/>
<%String strBookId=request.getParameter("id");
  if(null==strBookId||"".equals(strBookId)){
  response.sendRedirect("catalog.jsp");
  return;
  }
  else{
    int bookId=Integer.parseInt(strBookId);
    BookBean book=bookdb.getBook(bookId);
%>
<table border="1">
  <tr> <th>����</th>
       <th>����</th>
       <th>ժҪ</th>
       <th>��������</th>
       <th>�۸�</th>
   </tr>
   <tr>
   <td>��<%=book.getTitle() %>��</td>
   <td><%=book.getAuthor() %></td>
   <td><%=book.getBookconcern() %></td>
   <td><%=book.getPublish_date()%></td>
   <td><%=book.getPrice() %></td>
   </tr>
   </table>
<% 
  if(cart.isExist(new Integer(bookId))){
   out.println("��ͼ���Ѿ��ڹ��ﳵ��");
   }
   else{
%>
  <a href="bookinfo.jsp?add=<%=bookId %>&id=<%=bookId %>">���빺�ﳵ</a>
  <br/>
  <%
  }
   %>    
   ���ﳵ������<%=cart.getNumOfItems() %>��ͼ��
   <br/>
   <a href="showcart.jsp">�鿴���ﳵ</a>
   <br/>
   <a href="catalog.jsp">�鿴����ͼ��</a>
   <%
   }
    %>
    </center>
 </body>
</html>