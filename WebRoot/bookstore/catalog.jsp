<%@page contentType="text/html;charset=GB2312"%>
<%@page import="java.util.*" %>
<%@ include file="common.jsp" %>
<jsp:useBean id="cart" class="bookshop.CartBean" scope="session"/>

<html>
<head><title>��ӭ��½�������</title></head>
<body>
<jsp:include page="additem.jsp" ></jsp:include>
<center>
<h1>��ӭ�����������</h1><p>
<% Collection<BookBean> cl=bookdb.getBooks();
   Iterator<BookBean> it=cl.iterator();
%>
<table>
  <tr>
    <th>����</th>
    <th>�۸�</th>
    <th>����</th>
  </tr>
<% while(it.hasNext()){
   BookBean book=(BookBean)it.next();
   String title=book.getTitle();
   int bookId=book.getId();
   float price=book.getPrice();
%>
  <tr>
    <td><a href="bookinfo.jsp?id=<%=bookId %>">��<%=title %>��</a></td>
    <td><%=price %></td>
    <td><a href="catalog.jsp?add=<%=bookId %>">���빺�ﳵ</a></td>
   </tr>
 <%  } 
 %>
   </table><p>
   ���ﳵ������<%=cart.getNumOfItems() %>��ͼ��
   <br/>
   <a href="showcart.jsp">�鿴���ﳵ</a>
 </center>
</body>
</html>