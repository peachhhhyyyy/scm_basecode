# 🚚 Supply Chain Maker(SCM) Spring Project
 
## 5<sup>th</sup> Seoul New Deal Java Web Developer Training Course

## 🥅 프로젝트 선정이유

1. 날로 커지는 SCM의 중요성
2. 실무와 밀접한 프로젝트
3. 체계적인 로직에 대한 깊은 탐구 가능
4. 복잡한 로직 속에서 다양한 기능 구현 가능
5. 실력 향상에 최적화된 프로젝트

## 👬 팀구성

- PM
  - 박상수 [Github](https://github.com/sangsu9701)
- PL
  - (SCM) 손진수 [Github](https://github.com/Rhange)
  - (구매) 김지혜 [Github](https://github.com/KimJihyeDev)
  - (배송) 김혁 [Github](https://github.com/wold21)
- Dev
  - (SCM) 이근상 [Github](https://github.com/LEEKEUNSANG)
  - (구매) 박영후 [Github](https://github.com/peachhhhyyyy)
  - (배송) 성진희 [Github](https://github.com/sjinicd)

## 🦼 기술 스택

- 메인 환경
  - JDK (1.8.0_181)
  - Spring (4.3.0)
  - MySQL (5.1.30)
  - JSP (2.2)
  - Servlet(3.0.1)
  - Tomcat(8.0.53)
  - Maven (4.0.0)
  - SVN (1.14.0)
  - Collaboration Tool
    - Slack
    - Git, Github
    - Notion
    - SourceTree
  - HTML5
  - CSS3
  - jQuery (1.11.2)
  - Bootstrap (3.3.5)
  - Mybatis (3.0.6)
  - SLF4J (1.6.6)
  - SweetAlert (0.7.2)
  - Vue.js (3.0.11)
  - Datetimepicker (2.5.21)
  - Tingle.js (1.0)

## 📅 프로젝트 기간

- 4월 22일 ~ 6월 1일 (5주)

## 산출물 체크리스트

- [노션 보러가기 ▶️](https://www.notion.so/3fa5d9d0a0c447bf90ce61d13a082de4)

## 🔍 분석

- [요구사항 분석 회의록](https://www.notion.so/a36977750f4d4b50b3fd56d652e1767d)
- [요구사항 변경 기록](https://www.notion.so/821d558f10b94a9ca02264f71f6c8052)

1. 모델 분석
  - 주문 처리 flow
    ![주문처리](https://user-images.githubusercontent.com/46353755/120425446-31f59700-c3a9-11eb-8aa5-750acefe5b82.png)
  - 반품 처리 flow
    ![반품처리](https://user-images.githubusercontent.com/46353755/120425458-3752e180-c3a9-11eb-9112-375dd9b586cb.png)
2. 메뉴 분석
  - 메뉴 구성도
    ![메뉴구성도](https://user-images.githubusercontent.com/46353755/120425510-4fc2fc00-c3a9-11eb-821f-e303c7c26ee3.png)
  - [메뉴 분배 엑셀 시트](https://drive.google.com/file/d/18ESviVPlBGmbFSp0f9Qea4YL6BMrv5TY/view?usp=sharing)
  - [코드 명명규칙](https://www.notion.so/0c355022a01f4024a99f92d6f217fd61?v=a3d057f7ece24f86bfe40ea3cddc065f)
  - [용어 사전](https://www.notion.so/84d7b17dd9584471b33632da5488b669?v=e2724827f1324f3ca263c31d99a3ef35)

## 🗺️ 설계

### ERD

![SCM_ERD](https://user-images.githubusercontent.com/46353755/120425531-58b3cd80-c3a9-11eb-8045-d1429de25ab8.png)

## 🎇 구현

1. 고객 주문
![1고객주문](https://user-images.githubusercontent.com/46353755/120425926-0fb04900-c3aa-11eb-9a9c-9adbf505df0f.png)

2. 고객 장바구니
![2고객장바구니](https://user-images.githubusercontent.com/46353755/120425944-19d24780-c3aa-11eb-8331-a3f738fbcc0a.png)

3. 고객 입금 처리
![3고객입금](https://user-images.githubusercontent.com/46353755/120425945-1b037480-c3aa-11eb-9b6d-d10c0fac0e54.png)

4. SCM 수주내역 조회
![4SCM수주내역조회2](https://user-images.githubusercontent.com/46353755/120425948-1ccd3800-c3aa-11eb-957a-a2c0e9e8156c.png)

5. SCM 재고 확인, 배송 및 발주
![5SCM수주내역조회3](https://user-images.githubusercontent.com/46353755/120425951-1dfe6500-c3aa-11eb-970f-c170c6ca823a.png)

6. 배송팀 배송지시서 작성
![6배송지시서작성](https://user-images.githubusercontent.com/46353755/120425953-1f2f9200-c3aa-11eb-91ac-75a797deed63.png)

7. 배송팀 출하 계획
![7배송출하계획](https://user-images.githubusercontent.com/46353755/120425955-2060bf00-c3aa-11eb-87f4-653872cb1ed1.png)

8. 배송팀 배송완료 처리
![8배송완료처리](https://user-images.githubusercontent.com/46353755/120425960-2191ec00-c3aa-11eb-958f-e41fc84b3509.png)

9. 고객 반품 또는 구매확정 처리
![9고객구매확정](https://user-images.githubusercontent.com/46353755/120425964-235baf80-c3aa-11eb-89b2-b0b782ed917f.png)


## 📏 시험

- [통합 테스트 엑셀 시트](https://docs.google.com/spreadsheets/d/1_EmPDuLTuiag4LUDp5i0E2phSHPpELlY0QBcchVDymU/edit?usp=sharing)

> [5th_Newdeal_SCM_보고서.pdf](https://github.com/SCMPJ/scm_basecode/files/6581359/SCM_MatchingDay_.pdf)
