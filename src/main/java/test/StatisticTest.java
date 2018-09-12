package test;

import java.util.List;

import javax.servlet.ServletConfig;

import org.junit.Test;

import bean.Statistic;
import dao.DatabaseDao;
import dao.StatisticDao;
import service.StatisticService;
import servlet.InitServlet;

public class StatisticTest {
	@Test
	//测试近一年、近一个月、全部，新闻发布员发布的新闻情况，返回统计类集合并打印集合长度
	public void testStatisticsByDate(){
		try {
			DatabaseDao.drv = "com.mysql.jdbc.Driver";
			DatabaseDao.url = "jdbc:mysql://localhost:3306/news";
			DatabaseDao.usr = "root";
			DatabaseDao.pwd = "123456";
			StatisticService statisticService=new StatisticService();
			List<Statistic> statisticsByDateList1=statisticService.statisticsByDate("newsAuthor","nearYear");
			System.out.println(statisticsByDateList1.size());
			List<Statistic> statisticsByDateList2=statisticService.statisticsByDate("newsAuthor","nearMonth");
			System.out.println(statisticsByDateList2.size());
			List<Statistic> statisticsByDateList3=statisticService.statisticsByDate("newsAuthor","all");
			System.out.println(statisticsByDateList3.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	// 统计近一年内每个月总新闻件数、总评论数据。 
	@Test
	public void testStatisticsTotal(){
		try {
			DatabaseDao.drv = "com.mysql.jdbc.Driver";
			DatabaseDao.url = "jdbc:mysql://localhost:3306/news";
			DatabaseDao.usr = "root";
			DatabaseDao.pwd = "123456";
			StatisticService statisticService=new StatisticService();
			List<Statistic> statisticsByDateList=statisticService.statisticsTotal();
			System.out.println(statisticsByDateList.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
}
