package dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.junit.Test;

import bean.Statistic;

public class StatisticDao {
	
	public List<Statistic> statisticsByDate(String role, String date, DatabaseDao databaseDao) throws SQLException {
		String sql=null;
		List<Statistic> statistics=new ArrayList<Statistic>();
		if("newsAuthor".equals(role)){
			if("nearWeek".equals(date)){
				sql="select year(publicdata)年份,month(publicdata)月份,day(publicdata)日期,"
						+ "author,count(newsId)发布总数,sum(commentnumber)获得评论总数 from news where publicdata "
						+ "between subdate(curdate(),date_format(curdate(),'%w')-1) and subdate(curdate(),"
						+ "date_format(curdate(),'%w')-7) GROUP BY author ORDER BY 发布总数 desc";
				databaseDao.query(sql);
				while(databaseDao.next()){
					Statistic statistic=new Statistic();
					statistic.setYear(databaseDao.getString("年份"));
					statistic.setMonth(databaseDao.getString("月份"));
					statistic.setDay(databaseDao.getString("日期"));
					statistic.setAuthor(databaseDao.getString("author"));
					statistic.setSumNews(databaseDao.getString("发布总数"));
					statistic.setSumComment(databaseDao.getString("获得评论总数"));
					statistics.add(statistic);
				}
			}else if("nearMonth".equals(date)){
				sql="select year(publicdata)年份,month(publicdata)月份,"
						+ "author,count(newsId)发布总数,sum(commentnumber)获得评论总数 from news "
						+ "where month(publicdata)=month(SYSDATE()) GROUP BY author ORDER BY 发布总数 desc";
				databaseDao.query(sql);
				while(databaseDao.next()){
					Statistic statistic=new Statistic();
					statistic.setYear(databaseDao.getString("年份"));
					statistic.setMonth(databaseDao.getString("月份"));
					statistic.setAuthor(databaseDao.getString("author"));
					statistic.setSumNews(databaseDao.getString("发布总数"));
					statistic.setSumComment(databaseDao.getString("获得评论总数"));
					statistics.add(statistic);
				}
			}else if("nearYear".equals(date)){
				sql="select year(publicdata)年份,author,count(newsId)发布总数,sum(commentnumber)获得评论总数 from news "
						+ "where year(publicdata)=year(SYSDATE()) GROUP BY author ORDER BY 发布总数 desc";
				databaseDao.query(sql);
				while(databaseDao.next()){
					Statistic statistic=new Statistic();
					statistic.setYear(databaseDao.getString("年份"));
					statistic.setAuthor(databaseDao.getString("author"));
					statistic.setSumNews(databaseDao.getString("发布总数"));
					statistic.setSumComment(databaseDao.getString("获得评论总数"));
					statistics.add(statistic);
				}
			}else if("all".equals(date)){
				sql="select author,count(newsId)发布总数,sum(commentnumber)获得评论总数 from news "
						+ "GROUP BY author ORDER BY 发布总数 desc";
				databaseDao.query(sql);
				while(databaseDao.next()){
					Statistic statistic=new Statistic();
					statistic.setAuthor(databaseDao.getString("author"));
					statistic.setSumNews(databaseDao.getString("发布总数"));
					statistic.setSumComment(databaseDao.getString("获得评论总数"));
					statistics.add(statistic);
				}
			}
		}
		else{
			if("nearWeek".equals(date)){
				sql="select year(commentData)年份,month(commentData)月份,day(commentData)日期,"
						+ "userName,count(userName)发布总数   from comment where commentData "
						+ "between subdate(curdate(),date_format(curdate(),'%w')-1) and subdate(curdate(),"
						+ "date_format(curdate(),'%w')-7) GROUP BY userName ORDER BY 发布总数 desc";
				databaseDao.query(sql);
				while(databaseDao.next()){
					Statistic statistic=new Statistic();
					statistic.setYear(databaseDao.getString("年份"));
					statistic.setMonth(databaseDao.getString("月份"));
					statistic.setDay(databaseDao.getString("日期"));
					statistic.setAuthor(databaseDao.getString("userName"));
					statistic.setSumNews(databaseDao.getString("发布总数"));
					statistics.add(statistic);
				}
			}else if("nearMonth".equals(date)){
				sql="select year(commentData)年份,month(commentData)月份,"
						+ "userName,count(commentId)发布总数  from comment "
						+ "where month(commentData)=month(SYSDATE()) GROUP BY userName ORDER BY 发布总数 desc";
				databaseDao.query(sql);
				while(databaseDao.next()){
					Statistic statistic=new Statistic();
					statistic.setYear(databaseDao.getString("年份"));
					statistic.setMonth(databaseDao.getString("月份"));
					statistic.setAuthor(databaseDao.getString("userName"));
					statistic.setSumNews(databaseDao.getString("发布总数"));
					statistics.add(statistic);
				}
			}else if("nearYear".equals(date)){
				sql="select year(commentData)年份,userName,count(commentId)发布总数  from comment "
						+ "where year(commentData)=year(SYSDATE()) GROUP BY userName ORDER BY 发布总数 desc";
				databaseDao.query(sql);
				while(databaseDao.next()){
					Statistic statistic=new Statistic();
					statistic.setYear(databaseDao.getString("年份"));
					statistic.setAuthor(databaseDao.getString("userName"));
					statistic.setSumNews(databaseDao.getString("发布总数"));
					statistics.add(statistic);
				}
			}else if("all".equals(date)){
				sql="select userName,count(commentId)发布总数  from comment "
						+ "GROUP BY userName ORDER BY 发布总数 desc";
				databaseDao.query(sql);
				while(databaseDao.next()){
					Statistic statistic=new Statistic();
					statistic.setAuthor(databaseDao.getString("userName"));
					statistic.setSumNews(databaseDao.getString("发布总数"));
					statistics.add(statistic);
				}
			}
		}
		return statistics;
	}

	public List<Statistic> statisticsTotal(DatabaseDao databaseDao) throws SQLException {
		String sql="select year(CURRENT_DATE)年份,month(publicdata)月份, count(newsId)新闻总件数,"
				+ "sum(commentnumber)总评论数 from news where year(CURRENT_DATE)=year(publicdata) "
				+ "GROUP BY month(publicdata) ORDER BY month(publicdata) ";
		List<Statistic> statistics=new ArrayList<Statistic>();
		databaseDao.query(sql);
		while(databaseDao.next()){
			Statistic statistic=new Statistic();
			statistic.setYear(databaseDao.getString("年份"));
			statistic.setMonth(databaseDao.getString("月份"));
			statistic.setSumNews(databaseDao.getString("新闻总件数"));
			statistic.setSumComment(databaseDao.getString("总评论数"));
			statistics.add(statistic);
		}
		return statistics;
	}

}
