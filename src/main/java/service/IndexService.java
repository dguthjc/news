package service;

import java.util.List;

import bean.News;
import dao.DatabaseDao;
import dao.IndexDao;

public class IndexService {

	public List<News> latestNews() {
		try {
			DatabaseDao databaseDao=new DatabaseDao();
			IndexDao indexDao=new IndexDao();
			return indexDao.latestNews(databaseDao);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<News> hotNews() {
		try {
			DatabaseDao databaseDao=new DatabaseDao();
			IndexDao indexDao=new IndexDao();
			return indexDao.hotNews(databaseDao);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<News> militaryNews() {
		try {
			DatabaseDao databaseDao=new DatabaseDao();
			IndexDao indexDao=new IndexDao();
			return indexDao.militaryNews(databaseDao);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<News> economicsNews() {
		try {
			DatabaseDao databaseDao=new DatabaseDao();
			IndexDao indexDao=new IndexDao();
			return indexDao.economicsNews(databaseDao);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<News> sportsNews() {
		try {
			DatabaseDao databaseDao=new DatabaseDao();
			IndexDao indexDao=new IndexDao();
			return indexDao.sportsNews(databaseDao);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<News> guessYouLikeNews() {
		try {
			DatabaseDao databaseDao=new DatabaseDao();
			IndexDao indexDao=new IndexDao();
			return indexDao.guessYouLikeNews(databaseDao);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<News> entertainmentNews() {
		try {
			DatabaseDao databaseDao=new DatabaseDao();
			IndexDao indexDao=new IndexDao();
			return indexDao.entertainmentNews(databaseDao);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}
