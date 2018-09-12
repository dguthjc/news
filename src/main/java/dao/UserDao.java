package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import tools.PageInformation;
import tools.Tool;
import bean.News;
import bean.User;

public class UserDao {
	public Integer hasUser(User user,DatabaseDao databaseDao) throws SQLException{
		String sql="select * from user where name='"+user.getName()+"'";
		databaseDao.query(sql);
		while(databaseDao.next()){
			return 1;
		}
		return 0;
	}
	
	public void register(User user,DatabaseDao databaseDao) throws SQLException{
		String sql="insert into user(type,name,password,enable,headimg,sex,hobby) values('"+
				user.getType()+"','"+user.getName()+"','"+
				user.getPassword()+"','"+user.getEnable()+"','"+user.getHeadimg()+"','"+
				user.getSex()+"','"+user.getHobby()+"')";
		databaseDao.update(sql);
	}
	
	public Integer login(User user) throws SQLException, Exception{
		DatabaseDao databaseDao=new DatabaseDao();
		String sql="select * from user where name='" + user.getName()+
						"' and password='"+ user.getPassword()+"'";
		databaseDao.query(sql);
		while(databaseDao.next()){
			String enable=databaseDao.getString("enable");
			user.setEnable(databaseDao.getString("enable"));
			user.setHeadimg(databaseDao.getString("headimg"));
			user.setHobby(databaseDao.getString("hobby"));
			user.setName(databaseDao.getString("name"));
			user.setSex(databaseDao.getString("sex"));
			user.setRegisterDate(databaseDao.getTimestamp("registerDate"));
			user.setType(databaseDao.getString("type"));
			user.setUserId(databaseDao.getInt("userId"));
			if( ("use").equals(enable)  ){
				user.setType(databaseDao.getString("type"));
				return 1;//可以登录
			}			
			return 0;//用户存在，但被停用
		}
		return -1;//该用户不存在或密码错误
	}	
	
	public List<User> getOnePage(PageInformation pageInformation,DatabaseDao databaseDao) throws SQLException{
		List<User> users=new ArrayList<User>(); 
		String sqlCount=Tool.getSql(pageInformation,"count");
		Integer allRecordCount=databaseDao.getCount(sqlCount);//符合条件的总记录数
		Tool.setPageInformation(allRecordCount, pageInformation);//更新pageInformation的总页数等
		
		String sqlSelect=Tool.getSql(pageInformation,"select");
		databaseDao.query(sqlSelect);
		while (databaseDao.next()) {
			User user=new User();
			user.setSex(databaseDao.getString("sex"));
			user.setHeadimg(databaseDao.getString("headimg"));
			user.setHobby(databaseDao.getString("hobby"));
			user.setEnable(databaseDao.getString("enable"));
			user.setName(databaseDao.getString("name"));
			user.setRegisterDate(databaseDao.getTimestamp("registerDate"));
			user.setType(databaseDao.getString("type"));
			user.setUserId(databaseDao.getInt("userId"));
			users.add(user);	
		}		
		return users;
	}	

	//切换用户的可用性
	public Integer changeEnable(String id,DatabaseDao databaseDao)throws SQLException{//查询失败返回-1
		String sql = "select * from user where userId in ("+id+")";
		databaseDao.query(sql);
		while (databaseDao.next()) {
			String enable=databaseDao.getString("enable");
			if("use".equals(enable))
				enable="stop";
			else
				enable="use";
			sql = "update user set enable='"+enable+"' where userId in ("+id+")";
			databaseDao.update(sql);
			return 1;
		}		
		return 0;
	}
	
	//删除多个用户
	public Integer deletes(String ids,DatabaseDao databaseDao)throws SQLException{//查询失败返回-1
		if(ids!=null && ids.length()>0){
			String sql = "delete from user where userId in ("+ids+")";
			return databaseDao.update(sql);
		}else
			return -1;
	}

	public Integer changeNewsStatus(String id, DatabaseDao databaseDao) throws SQLException {
		String sql = "select * from news where newsId in ("+id+")";
		databaseDao.query(sql);
		while (databaseDao.next()) {
			String status=databaseDao.getString("status");
			if("pass".equals(status))
				status="refuse";
			else
				status="pass";
			sql = "update news set status='"+status+"' where newsId in ("+id+")";
			databaseDao.update(sql);
			return 1;
		}		
		return 0;
	}

	public int managerLogin(User user)  throws Exception {
		DatabaseDao databaseDao=new DatabaseDao();
		String sql="select * from user where name='" + user.getName()+
						"' and password='"+ user.getPassword()+"'";
		databaseDao.query(sql);
		while(databaseDao.next()){
			String enable=databaseDao.getString("enable");
			user.setEnable(databaseDao.getString("enable"));
			user.setHeadimg(databaseDao.getString("headimg"));
			user.setHobby(databaseDao.getString("hobby"));
			user.setName(databaseDao.getString("name"));
			user.setSex(databaseDao.getString("sex"));
			user.setRegisterDate(databaseDao.getTimestamp("registerDate"));
			user.setType(databaseDao.getString("type"));
			user.setUserId(databaseDao.getInt("userId"));
			if( ("use").equals(enable)){
				user.setType(databaseDao.getString("type"));
				if("manager".equals(user.getType()))
					return 1;//可以登录
				else return 2;
			}			
			return 0;//用户存在，但被停用
		}
		return -1;//该用户不存在或密码错误
	}

	public int newsAuthorLogin(User user) throws Exception {
		DatabaseDao databaseDao=new DatabaseDao();
		String sql="select * from user where name='" + user.getName()+
						"' and password='"+ user.getPassword()+"'";
		databaseDao.query(sql);
		while(databaseDao.next()){
			String enable=databaseDao.getString("enable");
			user.setEnable(databaseDao.getString("enable"));
			user.setHeadimg(databaseDao.getString("headimg"));
			user.setHobby(databaseDao.getString("hobby"));
			user.setName(databaseDao.getString("name"));
			user.setSex(databaseDao.getString("sex"));
			user.setRegisterDate(databaseDao.getTimestamp("registerDate"));
			user.setType(databaseDao.getString("type"));
			user.setUserId(databaseDao.getInt("userId"));
			if( ("use").equals(enable)){
				user.setType(databaseDao.getString("type"));
				if("newsAuthor".equals(user.getType()) || "manager".equals(user.getType()))
					return 1;//可以登录
				else return 2;
			}			
			return 0;//用户存在，但被停用
		}
		return -1;//该用户不存在或密码错误
	}

	public void modifyDetails(User user) throws Exception {
		DatabaseDao databaseDao=new DatabaseDao();
		String sql="";
		if(user.getHeadimg()!=""){
			sql="update user set headimg='"+user.getHeadimg()+"',hobby='"+user.getHobby()+"',"
					+ "sex='"+user.getSex()+"' where userId="+user.getUserId()+"";
		}else{
			sql="update user set hobby='"+user.getHobby()+"',"
					+ "sex='"+user.getSex()+"' where userId="+user.getUserId()+"";
		}
		databaseDao.update(sql);
	}

	public void modifyPwd(User user) throws Exception {
		DatabaseDao databaseDao=new DatabaseDao();
		String sql="update user set password='"+user.getPassword()+"' where userId="+user.getUserId()+"";
		databaseDao.update(sql);
	}
	
}
