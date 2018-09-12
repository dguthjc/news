package service;

import java.util.List;

import bean.Comment;
import dao.CommentDao;
import dao.DatabaseDao;
import dao.NewsDao;

public class CommentService {

	public boolean addComment(Comment comment) {

		try {
			DatabaseDao databaseDao=new DatabaseDao();
			CommentDao commentDao=new CommentDao();
			return commentDao.addComment(comment,databaseDao);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}

	public List<Comment> seachAllComment(Integer newsId) {
		
		try {
			DatabaseDao databaseDao=new DatabaseDao();
			CommentDao commentDao=new CommentDao();
			return commentDao.seachAllComment(newsId,databaseDao);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		return null;
	}

	public boolean modifyComment(Comment comment) {
		
		try {
			DatabaseDao databaseDao=new DatabaseDao();
			CommentDao commentDao=new CommentDao();
			return commentDao.modifyComment(comment,databaseDao);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

}
