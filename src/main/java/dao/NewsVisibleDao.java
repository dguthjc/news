package dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.News;
import tools.PageInformation;
import tools.Tool;

public class NewsVisibleDao {

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

	public News getOneNews(PageInformation pageInformation, DatabaseDao databaseDao) throws SQLException {
		News news = new News();
		String sqlSelect = Tool.getSqlById(pageInformation);
		databaseDao.query(sqlSelect);
		databaseDao.next();
		news.setAuthor(databaseDao.getString("author"));
		news.setCommentnumber(databaseDao.getInt("commentnumber"));
		news.setContent(databaseDao.getString("content"));
		news.setNewsId(databaseDao.getInt("newsId"));
		news.setPublicdata(databaseDao.getTimestamp("publicdata"));
		news.setStatus(databaseDao.getString("status"));
		news.setTitle(databaseDao.getString("title"));
		news.setType(databaseDao.getString("Type"));
		return news;
	}

	public List<Object> searchByWord(String word, DatabaseDao databaseDao) throws SQLException {
		String sql="select title from news where status='pass' and title like '%"+word+"%' limit 0,8";
		List<Object> titles=new ArrayList<Object>();
		databaseDao.query(sql);
		while(databaseDao.next()){
			String title=null;
			title=databaseDao.getString("title");
			titles.add(title);
		}
		return titles;
	}

	public News searchBytitle(String title, DatabaseDao databaseDao) throws SQLException {
		String sql="select * from news where status='pass' and title='"+title+"'";
		News news=new News();
		databaseDao.query(sql);
		while(databaseDao.next()){
			news.setAuthor(databaseDao.getString("author"));
			news.setCommentnumber(databaseDao.getInt("commentnumber"));
			news.setContent(databaseDao.getString("content"));
			news.setNewsId(databaseDao.getInt("newsId"));
			news.setPublicdata(databaseDao.getTimestamp("publicdata"));
			news.setStatus(databaseDao.getString("status"));
			news.setTitle(databaseDao.getString("title"));
			news.setType(databaseDao.getString("type"));
		}
		return news;
	}

}
