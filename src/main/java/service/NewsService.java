package service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.News;
import bean.User;
import dao.DatabaseDao;
import dao.NewsDao;
import dao.UserDao;
import tools.PageInformation;

public class NewsService {

	public int addNews(News news) {
		int result=-1;//数据库操作失败	
		
		try {
			DatabaseDao databaseDao=new DatabaseDao();
			NewsDao newsDao=new NewsDao();
			
			if(newsDao.hasTitle(news, databaseDao)==0){//没有相同标题，可以提交
				newsDao.addNews(news, databaseDao);
				return 1;	//成功
			}else{
				return 0;//失败，标题已存在
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return result;
	}

	public List<News> getOnePage(PageInformation pageInformation) {
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

	public News getOneNews(PageInformation pageInformation) {
		News news=new News();
		try {
			DatabaseDao databaseDao=new DatabaseDao();			
			NewsDao newsDao=new NewsDao();		
			news=newsDao.getOneNews(pageInformation,databaseDao);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return news;
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

	public boolean modifyNews(Integer newsId, String newsType, String newsTitle, String newsContent) {
		boolean modifySucess=false;
		try {
			DatabaseDao databaseDao=new DatabaseDao();
			NewsDao newsDao=new NewsDao();
			modifySucess=newsDao.modifyNews(newsId,newsType,newsTitle,newsContent,databaseDao);
		} catch (Exception e) {
			e.printStackTrace();
		}			
		return modifySucess;
	}	
	
}
