package service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import bean.Comment;
import bean.News;
import bean.User;
import dao.AdminDao;
import dao.DatabaseDao;
import dao.NewsDao;
import dao.UserDao;
import tools.PageInformation;

public class AdminService {

	public List<User> getOnePage(PageInformation pageInformation) {
		List<User> users=new ArrayList<User>();
		try {
			DatabaseDao databaseDao=new DatabaseDao();			
			UserDao userDao=new UserDao();		
			users=userDao.getOnePage(pageInformation,databaseDao);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return users;
	}

	public List<User> check(PageInformation pageInformation, String id) {
		List<User> users=null;
		try {
			DatabaseDao databaseDao=new DatabaseDao();			
			UserDao userDao=new UserDao();
			
			if(id!=null && !id.isEmpty())
				userDao.changeEnable(id,databaseDao);
			
			users=userDao.getOnePage(pageInformation,databaseDao);
			
		} catch (SQLException e) {
			users=null;
			e.printStackTrace();
		} catch (Exception e) {
			users=null;
			e.printStackTrace();
		}		
		return users;
	}

	public List<User> deletes(PageInformation pageInformation) {
		List<User> users=null;
		try {
			DatabaseDao databaseDao=new DatabaseDao();			
			UserDao userDao=new UserDao();
			userDao.deletes(pageInformation.getIds(),databaseDao);
			pageInformation.setIds(null);
			users=userDao.getOnePage(pageInformation,databaseDao);
		} catch (SQLException e) {
			users=null;
			e.printStackTrace();
		} catch (Exception e) {
			users=null;
			e.printStackTrace();
		}		
		return users;
	}

	public List<News> checkNews(PageInformation pageInformation, String id) {
		List<News> news=null;
		try {
			DatabaseDao databaseDao=new DatabaseDao();			
			UserDao userDao=new UserDao();
			
			if(id!=null && !id.isEmpty())
				userDao.changeNewsStatus(id,databaseDao);
			
			news=NewsDao.getOnePage(pageInformation,databaseDao);
			
		} catch (SQLException e) {
			news=null;
			e.printStackTrace();
		} catch (Exception e) {
			news=null;
			e.printStackTrace();
		}		
		return news;
	}

	public List<News> deleteNews(PageInformation pageInformation) {
		List<News> news=null;
		try {
			DatabaseDao databaseDao=new DatabaseDao();			
			NewsDao newsDao=new NewsDao();
			newsDao.deleteNews(pageInformation.getIds(),databaseDao);
			pageInformation.setIds(null);
			news=newsDao.getOnePage(pageInformation,databaseDao);
		} catch (SQLException e) {
			news=null;
			e.printStackTrace();
		} catch (Exception e) {
			news=null;
			e.printStackTrace();
		}		
		return news;
	}

	public List<News> getOnePageNews(PageInformation pageInformation) {
		List<News> news=new ArrayList<News>();
		try {
			DatabaseDao databaseDao=new DatabaseDao();			
			NewsDao newsDao=new NewsDao();		
			news=newsDao.getOnePage(pageInformation,databaseDao);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return news;
	}

	public List<Comment> findOrderInfoByOid(String newsId) {
		try {
			DatabaseDao databaseDao =new DatabaseDao();
			AdminDao adminDao=new AdminDao();
			return adminDao.findOrderInfoByOid(databaseDao,newsId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<News> deleteComment(int nId,PageInformation CommentPageInformation,PageInformation pageInformation) {
		List<News> news=null;
		try {
			DatabaseDao databaseDao=new DatabaseDao();			
			AdminDao adminDao=new AdminDao();
			adminDao.deleteComment(nId,CommentPageInformation.getIds(),databaseDao);
			pageInformation.setIds(null);
			news=adminDao.getOnePage(pageInformation,databaseDao);
		} catch (SQLException e) {
			news=null;
			e.printStackTrace();
		} catch (Exception e) {
			news=null;
			e.printStackTrace();
		}		
		return news;
	}

	public User ajaxFindUserDetails(Integer userId) {
		DatabaseDao databaseDao;
		try {
			databaseDao = new DatabaseDao();
			AdminDao adminDao=new AdminDao();
			return adminDao.ajaxFindUserDetails(databaseDao,userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
