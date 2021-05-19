package kr.happyjob.study.system.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.system.model.NoticeModel;

public interface NoticeDao {
  
  // 공지사항 목록 조회
  public List<NoticeModel> selectNoticeList(Map<String, Object> param);
  
  // 공지사항 목록 총 개수 조회
  public int countNoticeList();
  
  // 공지사항 작성
  public int insertNotice(Map<String, Object> param);

  
}
