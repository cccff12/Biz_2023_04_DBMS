-- 여기는 root 화면
-- 유저 삭제
DROP USER 'todo'@'localhost';
DROP USER 'todo'@'192.168.4.%';
DROP USER 'todo'@'%';

-- 사용자 생성
DROP USER todo@localhost;
create user todo@localhost IDENTIFIED BY '88888888';

-- 권한부여
grant all PRIVILEGES on todoDB.* TO todo@localhost;

-- 권한적용
FLUSH PRIVILEGES;

CREATE DATABASE scoreDB;

grant all PRIVILEGES on scoreDB.* TO todo@localhost;
FLUSH PRIVILEGES;

-- 시험

create database iolistDB;

CREATE USER 'korea'@'192.168.0.%' 
IDENTIFIED by '!Biz8080';

grant all PRIVILEGES on iolistDB.* TO 'korea'@'192.168.0.%';
FLUSH PRIVILEGES;
commit;
 
 use iolistDB;
 
 drop table tbl_iolist;


 CREATE TABLE tbl_iolist(
 io_seq	BIGINT	AUTO_INCREMENT	PRIMARY KEY,
io_date	VARCHAR(10)	NOT NULL,	
io_time	VARCHAR(10)	NOT NULL,	
io_pcode	VARCHAR(5)	NOT NULL,	
io_dcode	VARCHAR(4)	NOT NULL,	
io_inout	VARCHAR(1)	NOT NULL,	
io_qty	BIGINT	NOT NULL,	
io_iprice	BIGINT,		
io_oprice	BIGINT		
 );
 create table tbl_dept(
 d_code	VARCHAR(4)		PRimary key,
d_name	VARCHAR(125)	NOT NULL,	
d_ceo	VARCHAR(50)	NOT NULL,	
d_tel	VARCHAR(20)	NOT NULL,	
d_address	VARCHAR(125)		
 );
  
  create table tbl_product(
  p_code	VARCHAR(5)		PRIMARY KEY,
p_name	VARCHAR(50)	NOT NULL,	
p_iprice	BIGINT,		
p_oprice	BIGINT		
  );
 
 DESC tbl_iolist;
 DESC tbl_dept;
 DESC tbl_product;
 
 
 /*
 SELECT *
FROM tbl_bbs B
left join tbl_user U
ON B.b_username= U.username
where U.nickname IS NULL;
 */
 
 select 
 * from tbl_iolist A
 LEFT JOIN tbl_dept B
 ON A.io_dcode = B.d_code;
 
 select 
 * from tbl_iolist A
 LEFT JOIN tbl_product B
 ON A.io_pcode = B.p_code;

 
 
 ALTER TABLE tbl_iolist
 add CONSTRAINT fd_code
 FOREIGN KEY(io_dcode)
 REFERENCES tbl_dept(d_code);
 
 ALTER table tbl_iolist
 add CONSTRAINT fp_code
 FOREIGN KEY(io_pcode)
 REFERENCES tbl_product(p_code);
 
 
 
select * from tbl_iolist
where io_date <= '2023-03-31' and io_date >='2023-03-01';

select * from tbl_iolist
where io_inout=1 and io_qty>60 and io_qty<70;



 select io_seq, io_date, io_dcode as 거래처코드, d_name as 거래처명,
 io_pcode as 상품코드, p_name as 상품명, io_inout, io_qty, 
 io_price as 매입단가, io_oprice as 매출단가
 from tbl_iolist, tbl_dept, tbl_product;
 
 DESC tbl_iolist;
 
 
 select io_seq, io_date, io_dcode as 거래처코드, d_name 거래처명, io_pcode as 상품코드, 
 io_inout, io_qty, io_iprice 매입단가,io_oprice as 매출단가
 from tbl_iolist, tbl_product, tbl_dept;
 

select p_code 상품코드, p_name 상품명 , count(*) 레코드
from tbl_product
GROUP BY p_code, p_name;


select io_inout 구분, p_code 상품코드, p_name 상품명, io_iprice 수량합계
from tbl_iolist, tbl_product
GROUP BY 구분, 상품코드, 상품명, 수량합계;

select p_code 상품코드, p_name  상품명, count(*) 레코드
from tbl_iolist, tbl_product
where io_pcode = p_code
GROUP BY io_pcode, p_name;

select io_input 구분, p_code 상품코드 ,p_name 상품명, count(*) 수량합계
from tbl_iolist, tbl_product
where io_pcode = p_code
group BY io_input, p_code, p_name, io_qty;







create table tbl_user(
username VARCHAR(125) PRIMARY KEY,
nickname varchar(125) not null,
tel varchar(20)
);
 
 insert into tbl_user(username,nickname,tel) VALUES('hong','홍길동','010-1111-1111');
 insert into tbl_user(username,nickname,tel) VALUES('lee','이몽룡','010-2222-2222');
 insert into tbl_user(username,nickname,tel) VALUES('leem','임꺽정','010-3333-3333');
  
  select * from tbl_user
  where username='hong';
  
update tbl_user
set tel ='010-1111-5555'
where username='hong';
 
 
 select * from tbl_user
  where username='leem';
  
 delete from tbl_user
 where username='leem';
 
 SELECT * from tbl_user
 where nickname like '%길%';
 
 