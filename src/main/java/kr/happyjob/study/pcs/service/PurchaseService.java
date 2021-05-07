package kr.happyjob.study.pcs.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.pcs.model.PurchaseModel;

public interface PurchaseService {
  List<PurchaseModel> purchaseList(Map<String, Object> paramMap);
}