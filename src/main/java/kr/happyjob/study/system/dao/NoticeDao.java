package kr.happyjob.study.system.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.system.model.NoticeModel;

public interface NoticeDao {
  
  // 공지사항 목록 조회
  public List<NoticeModel> selectNoticeList(Map<String, Object> param);
  
  // 공지사항 목록 총 개수 조회
  public int countNoticeList(int auth);
  
  // 공지사항 검색 목록 총 개수 조회
  public int countConditionList(Map<String, Object> param);
  
  // 공지사항 단건 조회
  public NoticeModel selectNoticeDetail(int notice_id);
  
  // 공지사항 조회수 증가
  public int updateViewCount(Map<String, Object> param); 
  
  // 공지사항 작성
  public int insertNotice(Map<String, Object> param);

  // 공지사항 수정
  public int updateNotice(Map<String, Object> param);
  
  // 공지사항 삭제
  public int deleteNotice(Map<String, Object> param);
  
  // 파일 업로드를 위해  file_no 조회
  public int selectFileNo();
  
  // 파일 정보 업로드
  public int insertFile(Map<String, Object> param);
  
  
}
