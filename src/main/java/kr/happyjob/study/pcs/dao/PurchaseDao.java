package kr.happyjob.study.pcs.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.pcs.model.PurchaseModel;

public interface PurchaseDao {
  List<PurchaseModel> purchaseList(Map<String, Object> paramMap);
}
