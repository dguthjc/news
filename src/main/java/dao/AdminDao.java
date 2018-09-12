package dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import bean.Comment;
import bean.News;
import bean.User;
import tools.PageInformation;
import tools.Tool;

public class AdminDao {

	public List<Comment> findOrderInfoByOid(DatabaseDao databaseDao, String newsId) throws SQLException {
		Integer nId=Integer.valueOf(newsId);
		List<Comment> comments=new ArrayList<Comment>();
		String sql="select commentData,content,modifyAvalible,userName,newsId,commentId,headimg"
				+ " from comment,user where newsId="+nId+" and userName=name";
		databaseDao.query(sql);
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

	public void deleteComment(int nId,String ids, DatabaseDao databaseDao) throws SQLException {
		int rows=0;
		if (ids != null && ids.length() > 0) {
			String sql = "delete from comment where commentId in (" + ids + ")";
			rows=databaseDao.update(sql);
			String commentNum="update news set commentnumber=commentnumber-"+rows+" where newsId="+nId+"";
			databaseDao.update(commentNum);
		} 
	}

	public List<News> getOnePage(PageInformation pageInformation, DatabaseDao databaseDao) throws SQLException {
		List<News> news = new ArrayList<News>();
		String sqlCount = Tool.getSql(pageInformation, "count");
		Integer allRecordCount = databaseDao.getCount(sqlCount);// 符合条件的总记录数
		Tool.setPageInformation(allRecordCount, pageInformation);// 更新pageInformation的总页数等

		String sqlSelect = Tool.getSql(pageInformation, "select");
		databaseDao.query(sqlSelect);
		while (databaseDao.next()) {
			News news1 = new News();
			news1.setAuthor(databaseDao.getString("author"));
			news1.setCommentnumber(databaseDao.getInt("commentnumber"));
			news1.setContent(databaseDao.getString("content"));
			news1.setNewsId(databaseDao.getInt("newsId"));
			news1.setPublicdata(databaseDao.getTimestamp("publicdata"));
			news1.setStatus(databaseDao.getString("status"));
			news1.setTitle(databaseDao.getString("title"));
			news1.setType(databaseDao.getString("Type"));
			news.add(news1);
		}
		return news;
	}

	public User ajaxFindUserDetails(DatabaseDao databaseDao, Integer userId) throws SQLException {
		User user = new User();
		String sql = "select * from user where userId="+userId+"";
		databaseDao.query(sql);
		databaseDao.next();
		user.setEnable(databaseDao.getString("enable"));	
		user.setHeadimg(databaseDao.getString("headimg"));
		user.setHobby(databaseDao.getString("hobby"));
		user.setName(databaseDao.getString("name"));
		user.setRegisterDate(databaseDao.getTimestamp("registerDate"));
		user.setSex(databaseDao.getString("sex"));
		user.setType(databaseDao.getString("type"));
		user.setUserId(databaseDao.getInt("userId"));
		return user;
	}

}
