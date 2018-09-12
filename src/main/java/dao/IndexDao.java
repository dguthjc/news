package dao;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import bean.News;

public class IndexDao {

	public List<News> latestNews(DatabaseDao databaseDao) throws SQLException {
		String sql="select * from news where status='pass' order by publicdata desc limit 0,18";
		databaseDao.query(sql);
		int count=0;
		List<News> news=new ArrayList<News>();
		while(databaseDao.next()){
			News news1=new News();
			news1.setAuthor(databaseDao.getString("author"));
			news1.setCommentnumber(databaseDao.getInt("commentnumber"));
			news1.setNewsId(databaseDao.getInt("newsId"));
			news1.setPublicdata(databaseDao.getTimestamp("publicdata"));
			news1.setStatus(databaseDao.getString("status"));
			news1.setTitle(databaseDao.getString("title"));
			news1.setType(databaseDao.getString("type"));
			news.add(news1);
			count++;
		}
		return news;
	}

	public List<News> hotNews(DatabaseDao databaseDao) throws SQLException, ParseException{
		String sql="select * from news where status='pass' order by commentnumber desc limit 0,12";
		databaseDao.query(sql);
		int count=0;
		List<News> news=new ArrayList<News>();
		while(databaseDao.next()){
			News news1=new News();
			news1.setAuthor(databaseDao.getString("author"));
			news1.setCommentnumber(databaseDao.getInt("commentnumber"));
			news1.setNewsId(databaseDao.getInt("newsId"));
			news1.setPublicdata(databaseDao.getTimestamp("publicdata"));
			news1.setStatus(databaseDao.getString("status"));
			news1.setTitle(databaseDao.getString("title"));
			news1.setType(databaseDao.getString("type"));
			news.add(news1);
			count++;
		}
		return news;
	}

	public List<News> militaryNews(DatabaseDao databaseDao) throws SQLException {
		String sql="select * from news where type='military' and status='pass' order by commentnumber desc limit 0,7";
		databaseDao.query(sql);
		int count=0;
		List<News> news=new ArrayList<News>();
		while(databaseDao.next()){
			News news1=new News();
			news1.setAuthor(databaseDao.getString("author"));
			news1.setCommentnumber(databaseDao.getInt("commentnumber"));
			news1.setNewsId(databaseDao.getInt("newsId"));
			news1.setPublicdata(databaseDao.getTimestamp("publicdata"));
			news1.setStatus(databaseDao.getString("status"));
			news1.setTitle(databaseDao.getString("title"));
			news1.setType(databaseDao.getString("type"));
			news.add(news1);
			count++;
		}
		return news;
	}

	public List<News> entertainmentNews(DatabaseDao databaseDao) throws SQLException {
		String sql="select * from news where type='entertainment' and status='pass' order by commentnumber desc limit 0,6";
		databaseDao.query(sql);
		int count=0;
		List<News> news=new ArrayList<News>();
		while(databaseDao.next()){
			News news1=new News();
			news1.setAuthor(databaseDao.getString("author"));
			news1.setCommentnumber(databaseDao.getInt("commentnumber"));
			news1.setNewsId(databaseDao.getInt("newsId"));
			news1.setPublicdata(databaseDao.getTimestamp("publicdata"));
			news1.setStatus(databaseDao.getString("status"));
			news1.setTitle(databaseDao.getString("title"));
			news1.setType(databaseDao.getString("type"));
			news.add(news1);
			count++;
		}
		return news;
	}

	public List<News> guessYouLikeNews(DatabaseDao databaseDao) throws SQLException {
		String sql="select * from news where type='military' and status='pass' order by commentnumber desc limit 0,8";
		databaseDao.query(sql);
		int count=0;
		List<News> news=new ArrayList<News>();
		while(databaseDao.next()){
			News news1=new News();
			news1.setAuthor(databaseDao.getString("author"));
			news1.setCommentnumber(databaseDao.getInt("commentnumber"));
			news1.setNewsId(databaseDao.getInt("newsId"));
			news1.setPublicdata(databaseDao.getTimestamp("publicdata"));
			news1.setStatus(databaseDao.getString("status"));
			news1.setTitle(databaseDao.getString("title"));
			news1.setType(databaseDao.getString("type"));
			news.add(news1);
			count++;
		}
		return news;
	}

	public List<News> sportsNews(DatabaseDao databaseDao) throws SQLException {
		String sql="select * from news where type='sports' and status='pass' order by commentnumber desc limit 0,9";
		databaseDao.query(sql);
		int count=0;
		List<News> news=new ArrayList<News>();
		while(databaseDao.next()){
			News news1=new News();
			news1.setAuthor(databaseDao.getString("author"));
			news1.setCommentnumber(databaseDao.getInt("commentnumber"));
			news1.setNewsId(databaseDao.getInt("newsId"));
			news1.setPublicdata(databaseDao.getTimestamp("publicdata"));
			news1.setStatus(databaseDao.getString("status"));
			news1.setTitle(databaseDao.getString("title"));
			news1.setType(databaseDao.getString("type"));
			news.add(news1);
			count++;
		}
		return news;
	}

	public List<News> economicsNews(DatabaseDao databaseDao) throws SQLException {
		String sql="select * from news where type='economics' and status='pass' order by commentnumber desc limit 0,8";
		databaseDao.query(sql);
		int count=0;
		List<News> news=new ArrayList<News>();
		while(databaseDao.next()){
			News news1=new News();
			news1.setAuthor(databaseDao.getString("author"));
			news1.setCommentnumber(databaseDao.getInt("commentnumber"));
			news1.setNewsId(databaseDao.getInt("newsId"));
			news1.setPublicdata(databaseDao.getTimestamp("publicdata"));
			news1.setStatus(databaseDao.getString("status"));
			news1.setTitle(databaseDao.getString("title"));
			news1.setType(databaseDao.getString("type"));
			news.add(news1);
			count++;
		}
		return news;
	}

}
