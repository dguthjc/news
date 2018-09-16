package service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import tools.PageInformation;
import bean.News;
import bean.User;
import dao.AdminDao;
import dao.DatabaseDao;
import dao.NewsDao;
import dao.UserDao;

public class UserService {
	public Integer register(User user){
		int result=-1;//数据库操作失败	
		
		try {
			DatabaseDao databaseDao=new DatabaseDao();
			UserDao UserDao=new UserDao();
			int hasUserName = UserDao.hasUser(user, databaseDao);
			int hasEmail = UserDao.hasEmail(user, databaseDao);
			if(hasUserName==0 && hasEmail==0){//没有同名用户，可以注册
				UserDao.register(user, databaseDao);
				return 1;	//成功
			}else if(hasUserName==1){
				return 2;//失败，用户已存在
			}
			else if(hasEmail==1){
				return 3;//失败，邮箱已存在
			}else return 0;
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return result;
	}
	
	public Integer login(User user){
		int result=-2;	//数据库操作失败	
		try {
			UserDao UserDao=new UserDao();
			return UserDao.login(user);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return result;
	}	
	
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

	public List<User> check(PageInformation pageInformation,String id) {	
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
	//删除多条记录
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
	//修改密码
	public Integer changePassword(String oldPassword, String newPassword) {		
		try {
			DatabaseDao databaseDao=new DatabaseDao();			
			UserDao userDao=new UserDao();
			//userDao.deletes(pageInformation.getIds(),databaseDao);
			//pageInformation.setIds(null);
			//users=userDao.getOnePage(pageInformation,databaseDao);
		} catch (SQLException e) {
			//users=null;
			e.printStackTrace();
		} catch (Exception e) {
			//users=null;
			e.printStackTrace();
		}		
		return 1;
	}

	public int managerLogin(User user) {
		int result=-2;	//数据库操作失败	
		try {
			UserDao UserDao=new UserDao();
			return UserDao.managerLogin(user);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return result;
	}

	public int newsAuthorLogin(User user) {
		int result=-2;	//数据库操作失败	
		try {
			UserDao UserDao=new UserDao();
			return UserDao.newsAuthorLogin(user);
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return result;
	}

	public void modifyDetails(User user) throws Exception {
		UserDao UserDao=new UserDao();
		UserDao.modifyDetails(user);
	}

	public void modifyPwd(User user) throws Exception {
		UserDao UserDao=new UserDao();
		UserDao.modifyPwd(user);
	}

	public void changeRegisterCode(String register_code) throws Exception {
		UserDao UserDao=new UserDao();
		UserDao.changeRegisterCode(register_code);
	}

	public String getPwdByName(String parameter) throws Exception {
		UserDao UserDao=new UserDao();
		return UserDao.getPwdByName(parameter);
	}

}
