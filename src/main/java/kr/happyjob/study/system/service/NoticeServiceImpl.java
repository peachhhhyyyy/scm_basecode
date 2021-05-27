package kr.happyjob.study.system.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.system.dao.NoticeDao;
import kr.happyjob.study.system.model.ComnGrpCodModel;
import kr.happyjob.study.system.model.NoticeModel;

@Service
public class NoticeServiceImpl implements NoticeService {
	@Autowired
	NoticeDao noticeDao;
  
	// 공지사항 목록 조회
	@Override
	public List<NoticeModel> selectNoticeList(Map<String, Object> param) throws Exception {
	  // TODO Auto-generated method stub
	  return noticeDao.selectNoticeList(param);
	}

	// 공지사항 목록 총 개수 조회
	@Override
	public int countNoticeList(int auth) throws Exception {
	  // TODO Auto-generated method stub
	  return noticeDao.countNoticeList(auth);
	}
	
  // 공지사항 검색 목록 총 개수 조회
	@Override
	public int countConditionList(Map<String, Object> param) throws Exception {
	  // TODO Auto-generated method stub
	  return noticeDao.countConditionList(param);
	}
	
	
  // 공지사항 단건 조회	
	@Override
	public NoticeModel selectNoticeDetail(int notice_id) throws Exception {
	  // TODO Auto-generated method stub
	  return noticeDao.selectNoticeDetail(notice_id);
	}

	// 공지사항 조회수 증가
	@Override
	public int updateViewCount(Map<String, Object> param) throws Exception {
	  // TODO Auto-generated method stub
	  return noticeDao.updateViewCount(param);
	}

	// 공지사항 작성
  @Override
  public int insertNotice(Map<String, Object> param) throws Exception {
    // TODO Auto-generated method stub
    return noticeDao.insertNotice(param);
  }
 
  // 공지사항 수정
  @Override
  public int updateNotice(Map<String, Object> param) throws Exception {
    // TODO Auto-generated method stub
    return noticeDao.updateNotice(param);
  }
  
  // 공지사항 삭제
  @Override
  public int deleteNotice(Map<String, Object> param) throws Exception {
    // TODO Auto-generated method stub
    return noticeDao.deleteNotice(param);
  }
  
  
  // 파일 업로드를 위해  file_no 조회
  @Override
  public int selectFileNo() throws Exception {
    // TODO Auto-generated method stub
    return noticeDao.selectFileNo();
  }
  
}
