<%@page contentType="text/html;charset=GB2312"%>
<%@include file="common.jsp"%>
<%@page import="java.util.*"%>
<jsp:useBean id="cart" class="bookshop.CartBean" scope="session"/>
<html>
<head><title></title></head>
<body>
<jsp:include page="additem.jsp"/>
<%
String strKeyword=request.getParameter("keyword");
if(null==strKeyword||"".equals(strKeyword))
{
  response.sendRedirect("catalog.jsp");
  return;
  }
  Collection<BookBean> cl=bookdb.searchBook(strKeyword);
  if(cl.size()<=0)
  {
    out.println("�Բ���û����Ҫ�ҵ��飡");
    out.println("<a href=\"indexes.jsp\">����</a>");
    return;
    }
 %>
 <table>
   <tr>
     <th>����</th>
     <th>�۸�</th>
     <th>�鿴</th>
     <th>����</th>
     </tr>
     <%
     Iterator<BookBean> it=cl.iterator();
     while(it.hasNext())
     {
       BookBean book=(BookBean)it.next();
       String title=book.getTitle();
       int bookId=book.getId();
       float price=book.getPrice();
      %>
      <tr>
        <td><a href="bookinfo.jsp?id=<%=bookId %>">��<%=title %>��</a></td>
        <td><%=price %></td>
        <td><a href="bookinfo.jsp?id=<%=bookId %>">��ϸ��Ϣ</a></td>
        <td><a href="search.jsp?keyword=<%=strKeyword %>&add=<%=bookId %>">���빺�ﳵ</a></td>
        <%
        }
         %>
         </tr>
         </table>
</body>
</html>