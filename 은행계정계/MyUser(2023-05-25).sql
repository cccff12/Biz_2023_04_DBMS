-- 여기는 my user로 접속한 화면


drop TABLE tbl_accList;
CREATE table tbl_accList (
aioSEQ	NUMBER		PRIMARY KEY,
acNum	VARCHAR2(20)	NOT NULL,	
aioDate	VARCHAR2(10)	NOT NULL,	
aioTime	VARCHAR2(10)	NOT NULL,	
aioDiv	VARCHAR2(1)	NOT NULL,	
aioInput	NUMBER	DEFAULT 0,	
aioOutput	NUMBER	DEFAULT 0,	
aioREM	VARCHAR2(30)		
	
);

desc tbl_acclist;
/*
dbms table의 일련번호 문제
table에 pk를 임의의 일련번호로 설정했을 경우
데이터를 insert 할 때 마다 새로운 일련번호를 생성하여 값을 추가해야 한다.

dbms 엔진에 따라 insert를 할때 자동으로 일련번호를 생성하는 기능이 있는데
오라클에는 없다(11이하 버전), 오라클도 12 이상에서는 자동생성하는 기능이 있는데
다른 dbms에 비하면 상당히 불편하다

오라클에서는 일련번호를 자동으로 생성해주는 도구를 만들어야 한다.-- 이건 전통적인기능
*/

drop SEQUENCE seq_accList;
create SEQUENCE seq_accList
start with 1 INCREMENT by 1;

SELECT seq_accList.nextval from dual;

INSERT into tbl_acclist(aioSEQ, acNum,aioDate, aioTime, aioDiv, aioInput, aioOutput)
VALUES(seq_acclist.nextval, '2023052401','2023-05-24','11:10:00','1',10000,0);

select *from tbl_accList;

select * from tbl_acc;

SELECT *from tbl_acc;

commit;





















