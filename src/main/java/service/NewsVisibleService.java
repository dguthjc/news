package service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.News;
import dao.DatabaseDao;
import dao.NewsDao;
import dao.NewsVisibleDao;
import tools.PageInformation;

public class NewsVisibleService {

	public List<News> getOnePage(PageInformation pageInformation) {
		List<News> news=new ArrayList<News>();
		try {
			DatabaseDao databaseDao=new DatabaseDao();			
			NewsVisibleDao newsVisibleDao=new NewsVisibleDao();		
			news=newsVisibleDao.getOnePage(pageInformation,databaseDao);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return news;
	}

	public News getOneNews(PageInformation pageInformation) {
		News news=new News();
		try {
			DatabaseDao databaseDao=new DatabaseDao();			
			NewsVisibleDao newsVisibleDao=new NewsVisibleDao();	
			news=newsVisibleDao.getOneNews(pageInformation,databaseDao);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return news;
	}

	public List<Object> searchByWord(String word) {
		DatabaseDao databaseDao=null;
		NewsVisibleDao newsVisibleDao=null;
		try {
			databaseDao = new DatabaseDao();
			newsVisibleDao=new NewsVisibleDao();	
			return newsVisibleDao.searchByWord(word,databaseDao);
		} catch (Exception e1) {
			e1.printStackTrace();
		}			
		return null;
	}

	public News searchBytitle(String title) {
		DatabaseDao databaseDao=null;
		NewsVisibleDao newsVisibleDao=null;
		try {
			databaseDao = new DatabaseDao();
			newsVisibleDao=new NewsVisibleDao();	
			return newsVisibleDao.searchBytitle(title,databaseDao);
		} catch (Exception e1) {
			e1.printStackTrace();
		}			
		return null;
	}

}
