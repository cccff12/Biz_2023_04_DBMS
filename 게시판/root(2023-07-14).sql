-- root 로 접속한 화면
use bbsDB;

DESC tbl_bbs;
-- tbl_bbs 테이블에 대표이미지를 저장하는 칼럼 추가
-- tbl_bbs 테이블에 b_image라는 칼럼을 추가하는데 
-- 데이터 타입은 VARCHAR(125)로 하고
-- b_count 다음에 (b_update 와 b_count 사이에)b_update 앞에 위치하도록
-- alter table 을 사용해 새로운 칼럼을 추가하는 경우
-- 제약사항(not null)을 동시에 추가할수 없다

ALTER TABLE tbl_bbs
add b_image VARCHAR(125)
AFTER b_count;

DESC tbl_bbs;
-- table 을 drop하고 다시 같은 구조로 create table 
TRUNCATE tbl_bbs;

-- fk 삭제
-- alter table tbl_bbs
-- drop CONSTRAINT fk 이름;

-- 칼럼 삭제
alter table tbl_bbs
drop b_nickname;



insert into tbl_bbs(
b_pseq,
b_date,
b_time,
b_username,
b_subject,
b_content,
b_count,
b_image
) values(
1,1,1,1,1,1,1,1
);
select * from tbl_bbs;

create table tbl_images(
i_seq	bigint		PRiMARY KEY	AUTO_INCREMENT,
i_dseq	bigint	NOT NULL,
i_originalName	VARCHAR(125),			
i_uploadName	VARCHAR(255)			
);
desc tbl_images;




create DATABASE carDB; 
USE carDB;

CREATE TABLE tbl_car(
c_seq	BIGINT	AUTO_INCREMENT PRIMARY KEY,
c_type	VARCHAR(10)	NOT NULL,
c_startday	VARCHAR(20),	
c_starttime	VARCHAR(20),	
c_startdistance	VARCHAR(30)	NOT NULL,
c_arrival	VARCHAR(20),	
c_arrivaltime	VARCHAR(50),	
c_arrivaldistance	VARCHAR(50),	
c_place	VARCHAR(20)	NOT NULL,
c_pay	VARCHAR(30)	
);

desc tbl_car;
commit;
-- Insert into TBL_ADDRESS (A_ID,A_NAME,A_TEL,A_ADDR) values ('A0097','기원호','090-7737-7520','울산시 남구 달동 130-3번지');

