package DAO;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import Database.DBConnection;
import Model.Comment;
import Model.Product;
import Model.User;
import Utils.DynamicPagination;

public class CommentDAO {

	public static List<Comment> getByUserId(int userId) {
		List<Comment> list = new ArrayList<Comment>();

		String sql = "select * from comment_tables where customer_id = ? order by create_date desc";
		try {
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setInt(1, userId);
			ResultSet rs = statement.executeQuery();
			while (rs.next()) {
				int id = rs.getInt("id");
				User user = UserDAO.getById(rs.getInt("customer_id"));
				Product product = ProductDAO.getById(rs.getInt("product_id"));
				String content = rs.getString("content");
				int rate = rs.getInt("rate");

				Timestamp ts = rs.getTimestamp("create_date");
				Date create_date = new Date(ts.getTime());

				Comment comment = new Comment(id, user, product, content, create_date, rate);
				list.add(comment);
			}
			statement.close();
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	public static List<Comment> getByProductId(int productId) {
		List<Comment> list = new ArrayList<Comment>();

		String sql = "select * from comment_tables where product_id = ? order by create_date desc";
		try {
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setInt(1, productId);
			ResultSet rs = statement.executeQuery();
			while (rs.next()) {
				int id = rs.getInt("id");
				User user = UserDAO.getById(rs.getInt("customer_id"));
				Product product = ProductDAO.getById(rs.getInt("product_id"));
				String content = rs.getString("content");
				int rate = rs.getInt("rate");
				Timestamp ts = rs.getTimestamp("create_date");
				Date create_date = new Date(ts.getTime());

				Comment comment = new Comment(id, user, product, content, create_date, rate);
				list.add(comment);
			}
			statement.close();
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	public static List<Comment> getByOffset(List<Comment> list, int offset) {

		int beginIndex = (offset - 1) * DynamicPagination.totalCommentOfPage;
		int endIndex = beginIndex + DynamicPagination.totalCommentOfPage;

		if (endIndex > list.size()) {
			endIndex = list.size();
		}

		return list.subList(beginIndex, endIndex);
	}

}
