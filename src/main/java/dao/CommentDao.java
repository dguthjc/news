package dao;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import bean.Comment;
import bean.User;

public class CommentDao {

	public boolean addComment(Comment comment, DatabaseDao databaseDao) throws SQLException {
		String sqlComment="insert into comment(userName,newsId,content,commentData) value('"+comment.getUserName()+"',"
				+ "'"+comment.getNewsId()+"','"+comment.getContent()+"','"+comment.getCommentData()+"')";
		String sqlNews="update news set commentnumber=commentnumber+1 where newsId='"+comment.getNewsId()+"'";
		return (databaseDao.update(sqlComment)>0 && databaseDao.update(sqlNews)>0)?true:false;
	}

	public List<Comment> seachAllComment(Integer newsId, DatabaseDao databaseDao) throws SQLException {
		List<Comment> comments=new ArrayList<Comment>();
		String selectSql="select commentData,content,modifyAvalible,userName,newsId,commentId,headimg"
				+ " from comment,user where newsId="+newsId+" and userName=name";
		String updateSql="update comment set modifyAvalible='no' "
				+ "where TIMESTAMPDIFF(MINUTE,commentData,DATE_FORMAT(NOW(),'%Y-%m-%d %H:%i:%s'))>5";
		databaseDao.update(updateSql);
		databaseDao.query(selectSql);
		while (databaseDao.next()) {
			Comment comment=new Comment();
			comment.setCommentData(databaseDao.getTimestamp("commentData"));
			comment.setContent(databaseDao.getString("content"));
			comment.setModifyAvalible(databaseDao.getString("modifyAvalible"));
			comment.setUserName(databaseDao.getString("userName"));
			comment.setNewsId(databaseDao.getInt("newsId"));
			comment.setCommentId(databaseDao.getInt("commentId"));
			comment.setUserhead(databaseDao.getString("headimg"));
			comments.add(comment);	
		}		
		return comments;
	}

	public boolean modifyComment(Comment comment, DatabaseDao databaseDao) throws SQLException {
		String sql="update comment set content='"+comment.getContent()+"',commentData='"+comment.getCommentData()
			+"',modifyAvalible='"+comment.getModifyAvalible()+"' where commentId="+comment.getCommentId()+"";
		return databaseDao.update(sql)>0?true:false;
	}

}
