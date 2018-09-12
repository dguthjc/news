package tools;

import javax.servlet.http.HttpServletRequest;

public class SearchTool {
	//增加一个字符型与查询条件:模糊查询
	private static String addStringFuzzyAnd(String fieldName,String searchSql,HttpServletRequest request){
		String param=request.getParameter(fieldName);
		if(param!=null && !param.isEmpty()&& !param.equals("all")){
			if(searchSql.length()>1){//已经有一个条件，需要用  and
				searchSql+=" and "+fieldName +" like '%"+param+"%' ";
			}else{
				searchSql+=" "+fieldName +" like '%"+param+"%' ";
			}				
		}
		return  searchSql;
	}
	
	//增加一个字符型与查询条件:精确查询
	private static String addStringAnd(String fieldName,String searchSql,HttpServletRequest request){
		String param=request.getParameter(fieldName);
		if(param!=null && !param.isEmpty()&& !param.equals("all")){
			if(searchSql.length()>1){//已经有一个条件，需要用  and
				searchSql+=" and "+fieldName +"='"+param+"' ";
			}else{
				searchSql+=" "+fieldName +"='"+param+"' ";
			}				
		}
		return  searchSql;
	}	
	private static String addStatus(String searchSql,HttpServletRequest request){
		if(searchSql.length()>1){//已经有一个条件，需要用  and
			searchSql+=" and status='pass'";
		}else{
			searchSql+=" status='pass'";
		}				
		return  searchSql;
	}
	private static String addCommentNunber(String searchSql,HttpServletRequest request){
		if(searchSql.length()>1){//已经有一个条件，需要用  and
			searchSql+=" and commentnumber>0";
		}else{
			searchSql+=" commentnumber>0";
		}				
		return  searchSql;
	}	
	//按整型Id查找
		private static String SeachById(String fieldName,String searchSql,HttpServletRequest request){
			Integer param=Integer.valueOf(request.getParameter(fieldName));
			searchSql+=" "+fieldName +"="+param;
			return  searchSql;
		}	
	//增加一个日期与查询条件:>=lowDate  and <upDate
	private static String addDateAnd(String fieldName,String lowDateName,String upDateName,String searchSql,HttpServletRequest request){
		String lowDate=request.getParameter(lowDateName);
		String upDate=request.getParameter(upDateName);
		
		if(lowDate!=null && !lowDate.isEmpty()){
			if(searchSql.length()>1){//已经有一个条件，需要用  and
				searchSql+=" and "+fieldName +">='"+lowDate+"' ";
			}else{
				searchSql+=" "+fieldName +">='"+lowDate+"' ";
			}				
		}
		
		if(upDate!=null && !upDate.isEmpty()){
			if(searchSql.length()>1){//已经有一个条件，需要用  and
				searchSql+=" and "+fieldName +"<'"+upDate+"' ";
			}else{
				searchSql+=" "+fieldName +"<'"+upDate+"' ";
			}				
		}		
		return  searchSql;
	}		
	//用户表的查询条件
	public static String user(HttpServletRequest request){
		String searchSql="";
		searchSql=addStringAnd("type",searchSql,request);		
		searchSql=addStringFuzzyAnd("name",searchSql,request);
		searchSql=addStringAnd("enable",searchSql,request);
		searchSql=addDateAnd("registerDate","lowDate","upDate",searchSql,request);
		String a;
		return searchSql;
	}
	//新闻表的模糊查询条件
	public static String news(HttpServletRequest request){
		String searchSql="";
		searchSql=addStringAnd("type",searchSql,request);
		searchSql=addStringFuzzyAnd("title",searchSql,request);
		searchSql=addStringAnd("status",searchSql,request);
		searchSql=addStringAnd("author",searchSql,request);
		searchSql=addDateAnd("publicdata","lowDate","upDate",searchSql,request);
		return searchSql;
	}
	public static String newsToUser(HttpServletRequest request){
		String searchSql="";
		searchSql=addStringAnd("type",searchSql,request);
		searchSql=addStringFuzzyAnd("title",searchSql,request);
		searchSql=addStatus(searchSql,request);
		searchSql=addStringAnd("author",searchSql,request);
		searchSql=addDateAnd("publicdata","lowDate","upDate",searchSql,request);
		return searchSql;
	}
	public static String newsWithCommentToManager(HttpServletRequest request){
		String searchSql="";
		searchSql=addStringAnd("type",searchSql,request);
		searchSql=addStringFuzzyAnd("title",searchSql,request);
		searchSql=addCommentNunber(searchSql,request);
		searchSql=addStringAnd("author",searchSql,request);
		searchSql=addDateAnd("publicdata","lowDate","upDate",searchSql,request);
		return searchSql;
	}
	//新闻表的根据Id精确查询
	public static String newsDetails(HttpServletRequest request){
		String searchSql="";
		searchSql=SeachById("newsId",searchSql,request);
		return searchSql;
		}
}
