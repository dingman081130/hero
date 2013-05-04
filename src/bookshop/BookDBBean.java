package bookshop;
import java.util.*;
import java.sql.*;
public class BookDBBean {
    public Connection getConnection(){
	  Connection conn=null;
//	  String driver="com.microsoft.sqlserver.jdbc.SQLServerDriver";
//	  String url="jdbc:sqlserver://localhost:1433;DatabaseName=图书销售";
//	  String driver="org.gjt.mm.mysql.Driver";
	  String driver="com.mysql.jdbc.Driver";
	  String url="jdbc:mysql://localhost:3306/library?user=root&password=chen&useUnicode=true&characterEncoding=gbk";

	  try{
	  Class.forName(driver);
	  conn=DriverManager.getConnection(url);
	  }
	  catch (ClassNotFoundException e){
		  System.out.println("数据库连接失败");
	  }
	  catch(SQLException se){
		  System.out.println("error");
	  }
	  
	  return conn;
	}
	public void closeConnection(Connection conn){
		if(conn!=null){
			try{
				conn.close();
				conn=null;
			}
			catch(SQLException ex){
				ex.printStackTrace();
			}
		}
	}
	public void closeStatement(Statement stmt){
		if(stmt!=null){
			try{
				stmt.close();
				stmt=null;
			}
			catch(SQLException ex){
				ex.printStackTrace();
			}
		}
	}
	public void closeResultSet(ResultSet rs){
		if(rs!=null){
			try{
				rs.close();
				rs=null;
			}
			catch(SQLException ex){
				ex.printStackTrace();
			}
		}
	}
	public void closePreparedStatement(PreparedStatement pstmt){
		if(pstmt!=null){
			try{
				pstmt.close();
				pstmt=null;
			}
			catch(SQLException ex){
				ex.printStackTrace();
			}
		}
	}
	public Collection<BookBean> getBooks() throws SQLException{
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
	//	PreparedStatement pstmt=null;
		ArrayList<BookBean> bookList=new ArrayList<BookBean>();
		try{
			conn=getConnection();
			stmt=conn.createStatement();
			rs=stmt.executeQuery("select * from bookinfo");
			while(rs.next()){
				BookBean book=new BookBean(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),
						rs.getString(5),rs.getFloat(6),rs.getInt(7));
				bookList.add(book);
			}
			return bookList;
		}
		finally{
			closeResultSet(rs);
			
			closeStatement(stmt);
			closeConnection(conn);
		}
	}
	public BookBean getBook(int bookId) throws SQLException{
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try{
			conn=getConnection();
			pstmt=conn.prepareStatement("select * from bookinfo where id=?");
			pstmt.setInt(1,bookId);
			rs=pstmt.executeQuery();
			BookBean book=null;
			if(rs.next()){
				book=new BookBean(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),
						rs.getString(5),rs.getFloat(6),rs.getInt(7));
			}
			return book;
		}
		finally{
			closeResultSet(rs);
			closePreparedStatement(pstmt);
			closeConnection(conn);
		}
	}
	public Collection<BookBean> searchBook(String keyword) throws SQLException{
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		ArrayList<BookBean> bookList=new ArrayList<BookBean>();
		try
		{
			conn=getConnection();
			stmt=conn.createStatement();
			String sql="select * from bookinfo where title like '%"+keyword+"%'";
			rs=stmt.executeQuery(sql);
			while(rs.next())
			{
				BookBean book=new BookBean(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),
						rs.getString(5),rs.getFloat(6),rs.getInt(7));
				bookList.add(book);
			}
			return bookList;
		}
		finally
		{
			closeResultSet(rs);
			closeStatement(stmt);
			closeConnection(conn);
		}
	}
	public boolean isAmountEnough(int bookId,int quantity) throws SQLException{
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		boolean bEnough=false;
		try
		{
			conn=getConnection();
			stmt=conn.createStatement();
			rs=stmt.executeQuery("select amount from bookinfo where id="+bookId);
			while(rs.next())
			{
				int amount=rs.getInt("amount");
				if(amount>=quantity)
				{
					bEnough=true;
				}
			}
		}
		finally{
			closeResultSet(rs);
			closeStatement(stmt);
			closeConnection(conn);
		}
		return bEnough;
	 }
	public synchronized void buyBooks(CartBean cart) throws SQLException{
		Connection conn=null;
		PreparedStatement pstmt=null;
		Iterator<CartItemBean> it=cart.getItems().iterator();
		try
		{
		conn=getConnection();
		String sql="update bookinfo set amount=amount-? where id=?";
		pstmt=conn.prepareStatement(sql);
		
		while(it.hasNext())
		{
		   CartItemBean item=(CartItemBean)it.next();
		   BookBean book=item.getBook();
		   int bookId=book.getId();
		   int quantity=item.getQuantity();
		   
		   pstmt.setInt(1, quantity);
		   pstmt.setInt(2, bookId);
		   pstmt.addBatch();
		   
		}
		pstmt.executeBatch();
		}
	finally
	{
		closePreparedStatement(pstmt);
		closeConnection(conn);
	}
  }
}
