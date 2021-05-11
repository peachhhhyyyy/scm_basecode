<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>주문</title>
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous">
  
</script>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">
  
  
</script>
</head>
<body>
		<form id="myForm" action="" method="post">
				<div id="background_board">
						<div class="login_form shadow" align="center">
								<div class="login-form-right-side"></div>
								<div class="login-form-left-side">
										<fieldset>
												<legend>로그인</legend>
												<p class="id">
														<label for="user_id">아이디</label> <input type="text" id="EMP_ID" name="lgn_Id" placeholder="아이디" onkeypress="if(event.keyCode==13) {fLoginProc(); return false;}" style="ime-mode: inactive;" />
												</p>
												<p class="pw">
														<label for="user_pwd">비밀번호</label> <input type="password" id="EMP_PWD" name="pwd" placeholder="비밀번호" onfocus="this.placeholder=''; return true" onkeypress="if(event.keyCode==13) {fLoginProc(); return false;}" />
												</p>
												<p class="member_info" style="font-size: 15px">
														<input type="checkbox" id="cb_saveId" name="" onkeypress="if(event.keyCode==13) {fLoginProc(); return false;}"> <span class="id_save">ID저장</span> <br>
												</p>
												<a class="btn_login" href="javascript:fLoginProc();" id="btn_login"><strong>Login</strong></a> <br> <a href="javascript:fRegister();" id="RegisterBtn" name="modal"><strong>[회원가입]</strong></a> <a href="javascript:findIdPwd();"><strong>[아이디/비밀번호 찾기]</strong></a>
										</fieldset>
								</div>
						</div>
				</div>
		</form>
		<!-- 모달팝업 -->
		<div id="layer1" class="layerPosition layerPop layerType2" style="width: 600px;">
				<form id="RegisterForm" action="" method="post">
						<input type="hidden" name="action" id="action" value=""> <input type="hidden" name="ckIdcheckreg" id="ckIdcheckreg" value="0" /> <input type="hidden" name="ckEmailcheckreg" id="ckEmailcheckreg" value="0" />
						<dl>
								<dt>
										<br> <br> <strong style="font-size: 120%">&nbsp;&nbsp;&nbsp;&nbsp;회원가입</strong> <br>
								</dt>
								<dd class="content">
										<!-- s : 여기에 내용입력 -->
										<table class="row">
												<caption>caption</caption>
												<colgroup>
														<col width="120px">
														<col width="*">
														<col width="120px">
														<col width="*">
														<col width="120px">
												</colgroup>
												<tbody>
														<tr class="hidden">
																<td><input type="text" name="div_cd" id="div_cd" /></td>
																<td><input type="text" name="del_cd" id="del_cd" /></td>
																<td><input type="text" name="user_type" id="user_type" /></td>
																<td><input type="text" name="approval_cd" id="approval_cd" /></td>
																<td><input type="text" name="active" id="active" /></td>
														</tr>
														<tr>
																<th scope="row">아이디<span class="font_red">*</span></th>
																<td colspan="2"><input type="text" class="inputTxt p100" name="loginID" placeholder="숫자, 영문자 조합으로 6~20자리 " id="registerId" /></td>
																<td><input type="button" value="중복확인" onclick="loginIdCheck()" style="width: 130px; height: 20px;" /></td>
														</tr>
														<tr>
																<th scope="row">비밀번호 <span class="font_red">*</span></th>
																<td colspan="3"><input type="password" placeholder="숫자, 영문자, 특수문자 조합으로 8~15자리 " class="inputTxt p100" name="password" id="registerPwd" /></td>
														</tr>
														<tr>
																<th scope="row" style="padding: 0 0">비밀번호 확인<span class="font_red">*</span></th>
																<td colspan="3"><input type="password" class="inputTxt p100" name="password1" id="registerPwdOk" /></td>
														</tr>
														<tr>
																<th scope="row" id="registerName_th">회사명 <span class="font_red">*</span></th>
																<td><input type="text" class="inputTxt p100" name="name" id="registerName" /></td>
														<tr>
																<th scope="row">담당자명 <span class="font_red">*</span></th>
																<td><input type="text" class="inputTxt p100" name="company_mng" id="company_mng" /></td>															
														</tr>
														<tr>
																<th scope="row">이메일<span class="font_red">*</span></th>
																<td colspan="3"><input type="text" class="inputTxt p100" name="user_email" id="registerEmail" />
																</td>
														</tr>
														<tr>
																<th scope="row">우편번호<span class="font_red">*</span></th>
																<td colspan="2"><input type="text" class="inputTxt p100" name="user_zipcode" id="detailaddr" /></td>
																<td><input type="button" value="우편번호 찾기" onclick="execDaumPostcode()" style="width: 130px; height: 20px;" /></td>
														</tr>
														<tr>
																<th scope="row">주소<span class="font_red">*</span></th>
																<td colspan="3"><input type="text" class="inputTxt p100" name="user_address" id="loginaddr" /></td>
														</tr>
														<tr>
																<th scope="row">상세주소</th>
																<td colspan="3"><input type="text" class="inputTxt p100" name="user_dt_address" id="loginaddr1" /></td>
														</tr>
														<tr>
																<th scope="row">전화번호<span class="font_red">*</span></th>
																<td colspan="3"><input class="inputTxt" style="width: 118px" maxlength="3" type="text" id="tel1" name="user_tel1"> - <input class="inputTxt" style="width: 118px" maxlength="4" type="text" id="tel2" name="user_tel2"> - <input class="inputTxt" style="width: 118px" maxlength="4" type="text" id="tel3" name="user_tel3"></td>
														</tr>
														<tr>
																<th scope="row">계좌번호<span class="font_red">*</span></th>
																<td>
																	<select type="selectbox" style="width:75px; height:25px;" id="bank" name="bank">
																		<template v-for="(item,index) in bank"  v-model="bank">
																			<option :value="item.dtl_cod">{{ item.dtl_cod_nm }}</option>
																		</template>
																	</select></td>
																<td colspan="2"><input type="text" class="inputTxt p100" name="account" id="account" /></td>
														</tr>
														<tr>
																<th scope="row">예금주명<span class="font_red">*</span></th>
																<td><input type="text" class="inputTxt p100" name="account_holder" id="account_holder" /></td>															
														</tr>
										<table class="row">
										<div class="btn_areaC mt30">
												<a href="javascript:CompleteRegister();" class="btnType blue" id="RegisterCom" name="btn"> <span>회원가입 완료</span></a> <a href="javascript:fcancleModal()" class="btnType gray" id="btnCloseLsmCod" name="btn"><span>취소</span></a>
										</div>
										</table>
								</dd>
						</dl>
						<a href="" class="closePop"><span class="hidden">닫기</span></a>
				</form>
		</div>
		<!-- 아이디 비밀번호 찾기 모달 -->
		<form id="sendForm" action="" method="post">
				<input type="hidden" name="authNumId" id="authNumId" value="" /> <input type="hidden" name="authNumPwd" id="authNumPwd" value="" /> <input type="hidden" name="ckIdcheck" id="ckIdcheck" value="" />
				<div id="layer2" class="layerPop layerType2" style="width: 750px;">
						<dl>
								<dt>
										<strong>아이디/비밀번호 찾기</strong>
								</dt>
								<dd>
										<div class="btn_areaC mt30">
												<a href="javascript:fSelectId();" class="btnType gray" id="findId"><span>아이디 찾기</span></a> <a href="javascript:fSelectPwd();" class="btnType gray" id="findPwd"><span>비밀번호 찾기</span></a>
										</div>
								</dd>
								<dd class="content">
										<!-- 아이디/비밀번호 찾기 폼 -->
										<table class="row" id="findForm">
												<tbody>
														<tr>
																<td id="registerEmailId"><input type="text" id="emailText" data-code="I" placeholder="가입하신 이메일을 입력하세요" size="30" style="height: 30px;" /> <a href="javascript:SendEmail();" class="btnType blue" id="findIdSubmit"><span>이메일 전송</span></a></td>
																<td id="confirm"><input type="text" id="emailNum" name="authnum" placeholder="전송된 인증번호를 입력하세요" size="30" style="height: 30px;" /> <a href="javascript:SendComplete();" class="btnType blue" id="sendMail"><span>인증하기</span></a></td>
														</tr>
												</tbody>
										</table>
										<table class="row" id="findPwdForm">
												<tbody>
														<tr>
																<td id="loginRegister"><input type="text" id="emailIdText" placeholder="가입하신 아이디를 입력하세요" size="30" style="height: 30px;" /> <a href="javascript:RegisterIdCheck();" class="btnType blue" id=""><span>아이디 체크</span></a></td>
																<td id="loginEmail"><input type="text" id="emailPwdText" data-code="P" placeholder="가입하신 이메일을 입력하세요" size="30" style="height: 30px;" /> <a href="javascript:SendPwdEmail();" class="btnType blue" id=""><span>이메일 전송</span></a></td>
																<td id="loginPwd"><input type="text" id="emailPwdNum" data-code="P" placeholder="전송된 비밀번호를 입력하세요" size="30" style="height: 30px;" /> <a href="javascript:SendCompletePwd();" class="btnType blue" id="emailOk"><span>인증하기</span></a></td>
														</tr>
												</tbody>
										</table>
								</dd>
						</dl>
						<a href="" class="closePop"><span class="hidden">닫기</span></a>
				</div>
		</form>
</body>
</html>
