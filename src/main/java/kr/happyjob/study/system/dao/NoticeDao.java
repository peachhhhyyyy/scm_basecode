package kr.happyjob.study.system.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.system.model.NoticeModel;

public interface NoticeDao {

  // 공지사항 작성
  public int writeNotice(NoticeModel noticeModel);
	
	}
