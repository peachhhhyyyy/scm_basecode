package kr.happyjob.study.system.model;

import java.util.Date;

public class NoticeModel extends FileModel{
	
	// 게시판 글 번호
  private int notice_id; // 게시판 번호
  private String title; // 게시판 제목
  private String content; // 글 내용
  private String date; // 글 작성일
  private int view_cnt; // 글 조회수
  private int auth; // 권한(전체, 고객, 직원)
  
  
  public int getNotice_id() {
    return notice_id;
  }
  public void setNotice_id(int notice_id) {
    this.notice_id = notice_id;
  }
  public String getTitle() {
    return title;
  }
  public void setTitle(String title) {
    this.title = title;
  }
  public String getContent() {
    return content;
  }
  public void setContent(String content) {
    this.content = content;
  }
  public String getDate() {
    return date;
  }
  public void setDate(String date) {
    this.date = date;
  }
  public int getView_cnt() {
    return view_cnt;
  }
  public void setView_cnt(int view_cnt) {
    this.view_cnt = view_cnt;
  }
  public int getAuth() {
    return auth;
  }
  public void setAuth(int auth) {
    this.auth = auth;
  }
	
	
	
	
}
