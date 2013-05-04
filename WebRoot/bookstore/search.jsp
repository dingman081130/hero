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
    out.println("对不起，没有你要找的书！");
    out.println("<a href=\"indexes.jsp\">返回</a>");
    return;
    }
 %>
 <table>
   <tr>
     <th>书名</th>
     <th>价格</th>
     <th>查看</th>
     <th>购买</th>
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
        <td><a href="bookinfo.jsp?id=<%=bookId %>">《<%=title %>》</a></td>
        <td><%=price %></td>
        <td><a href="bookinfo.jsp?id=<%=bookId %>">详细信息</a></td>
        <td><a href="search.jsp?keyword=<%=strKeyword %>&add=<%=bookId %>">加入购物车</a></td>
        <%
        }
         %>
         </tr>
         </table>
</body>
</html>