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

