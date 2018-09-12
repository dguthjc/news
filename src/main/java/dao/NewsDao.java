package dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.News;
import bean.User;
import tools.PageInformation;
import tools.Tool;

public class NewsDao {

	public int hasTitle(News news, DatabaseDao databaseDao) throws SQLException {
		String sql = "select * from news where author='" + news.getTitle() + "'";
		databaseDao.query(sql);
		while (databaseDao.next()) {
			return 1;
		}
		return 0;
	}

	public void addNews(News news, DatabaseDao databaseDao) throws SQLException {
		String sql = "insert into news(title,author,content,commentnumber,status,type) values('" + news.getTitle()
				+ "','" + news.getAuthor() + "','" + news.getContent() + "','" + news.getCommentnumber() + "','"
				+ news.getStatus() + "','" + news.getType() + "')";
		databaseDao.update(sql);
	}

	public static List<News> getOnePage(PageInformation pageInformation, DatabaseDao databaseDao) throws SQLException {
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

	public Integer deleteNews(String ids, DatabaseDao databaseDao) throws SQLException {
		if (ids != null && ids.length() > 0) {
			String sql = "delete from news where newsId in (" + ids + ")";
			return databaseDao.update(sql);
		} else
			return -1;
	}

	public boolean modifyNews(Integer newsId1, String newsType, String newsTitle, String newsContent,DatabaseDao databaseDao) throws SQLException {
		String sql1 = "update news set type='"+newsType+"',title='"+newsTitle+"',commentnumber=0,content='"+newsContent+"',"
				+ "status='refuse' where newsId="+newsId1+"";
		String sql2="delete from comment where newsId="+newsId1+"";
		databaseDao.update(sql2);
		return databaseDao.update(sql1)>0?true:false;
	}


}
