package service;

import java.util.List;

import bean.Statistic;
import dao.DatabaseDao;
import dao.StatisticDao;

public class StatisticService {

	public List<Statistic> statisticsByDate(String role, String date) {
		
		try {
			DatabaseDao databaseDao=new DatabaseDao();			
			StatisticDao statisticDao=new StatisticDao();
			return statisticDao.statisticsByDate(role,date,databaseDao);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<Statistic> statisticsTotal() {
		try {
			DatabaseDao databaseDao=new DatabaseDao();			
			StatisticDao statisticDao=new StatisticDao();
			return statisticDao.statisticsTotal(databaseDao);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}


}
