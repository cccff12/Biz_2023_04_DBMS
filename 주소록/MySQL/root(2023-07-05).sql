--  이 화면은 root 화면
/*
mysql은 database라는 schema를 통해 물리적인 db를 관리한다.
oracle은 tablespace라는 물리적 저장소와 연결한 사용자를 통하여 db를
관리한다.

현업에서 가장 많이 사용하는 2가지의 dbms를 서로 비교함으로써 데이터베이스에 대한 이론을
정리해보기 바란다

oracle에서는 사용자가 schema가 되며 
mysql 사용자는 dbms, 물리적 저장소 등에 
접근하는 권한을 가진 사용자개념이다

*/
-- 프로젝트 시작을 하기 위해 database를 생성
create database addrDB;
show databases;
-- mysql에서는 사용자로 로그인한 후 
-- Schema(database)에 접속하는 절차가 필요하다
USE addrDB;
-- addrDB에 접속한 상태가 된다

CREATE TABLE tbl_address(
a_id	VARCHAR(5)		PRIMARY KEY,
a_name	nVARCHAR(20)	NOT NULL,	
a_tel	VARCHAR(15)	NOT NULL,	
a_addr	nVARCHAR(125)	NOT NULL	
);

DESC tbl_address;
/*
BIGINT type의 PK칼럼
	보통 기본 데이터로 PK를 생성할 수 없을 경우
    별도의 칼럼을 생성하고 그 칼럼의 일련번호 속성을 부여하여 
    PK로 만든다 이때 PK의 값은 무한히 커질 수 있음으로
    INT형보다 큰 BIGINT type로 설정한다

AUTO_INCREMENT 속성
	MY SQL 에서는 일련번호 칼럼에 대하여 자동값 증가 속성이 있다.
    PK칼럼에만 이 속성을 부여할 수 있고
	이 속성을 가진 PK칼럼은 INSERT가 수행될 때 자동으로 
    1씩 증가되는 일련번호를 생성하여 칼럼 데이터에 주입한다
    

*/

CREATE TABLE tbl_addr_hobby(
ah_seq	BIGINT	AUTO_INCREMENT	PRIMARY KEY,
ah_aid	VARCHAR(5)	NOT NULL,	
ah_hbcode	VARCHAR(5)	NOT NULL	
);

INSERT tbl_addr_hobby (ah_aid, ah_hbcode)
VALUES('A0001','H0001');
select * from tbl_addr_hobby;


CREATE TABLE tbl_hobby(
hb_code	VARCHAR(5)		PRIMARY KEY,
hb_name	VARCHAR(30)	NOT NULL,	
hb_descrip	VARCHAR(400)		
);
-- 현재 시스템에 Database (SCHEMA)리스트 확인
SHOW DATABASES;
 -- 현재 DB(addDB)에 생성된 Table 리스트 확인
 show tables;
 -- 테이블의 구조 확인
 DESC tbl_address;
 
 