package bean;

import java.sql.Timestamp;

public class News {
	private Integer newsId;
	private String title;
	private String author;
	private String content;
	private Timestamp publicdata;
	private Integer commentnumber;
	private String status;
	private String type;
	public Integer getNewsId() {
		return newsId;
	}
	public void setNewsId(Integer newsId) {
		this.newsId = newsId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getPublicdata() {
		return publicdata;
	}
	public void setPublicdata(Timestamp publicdata) {
		this.publicdata = publicdata;
	}
	public Integer getCommentnumber() {
		return commentnumber;
	}
	public void setCommentnumber(Integer commentnumber) {
		this.commentnumber = commentnumber;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
}
