package bean;

import java.sql.Timestamp;
import java.util.Date;

public class Comment {
	Integer commentId;
	String userName;
	Integer newsId;
	String content;
	Timestamp commentData;
	String modifyAvalible;
	String userhead;
	
	public String getUserhead() {
		return userhead;
	}
	public void setUserhead(String userhead) {
		this.userhead = userhead;
	}
	public Integer getCommentId() {
		return commentId;
	}
	public void setCommentId(Integer commentId) {
		this.commentId = commentId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Integer getNewsId() {
		return newsId;
	}
	public void setNewsId(Integer newsId) {
		this.newsId = newsId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String cintent) {
		this.content = cintent;
	}
	public Timestamp getCommentData() {
		return commentData;
	}
	public void setCommentData(Timestamp commentData) {
		this.commentData = commentData;
	}
	public String getModifyAvalible() {
		return modifyAvalible;
	}
	public void setModifyAvalible(String modifyAvalible) {
		this.modifyAvalible = modifyAvalible;
	}
	
}
