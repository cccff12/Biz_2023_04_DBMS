use bbsdb;

show tables;

desc tbl_bbs;
desc tbl_images;
desc tbl_user;

select * from tbl_bbs;

-- AUTO_INCREMENT 로 설정된 칼럼의 가장 
-- 마지막 INSERT 된 데이터 가져오기
insert into tbl_bbs (b_username) value('callor');
select LAST_INSERT_ID();

insert into tbl_bbs (b_username) 
value
('callor1')
,('callor2')
,('callor3')
,('callor4')
,('callor5');

select * from tbl_bbs;

select * from tbl_images;
drop table tbl_images;

create table tbl_images(
i_seq	bigint		PRiMARY KEY AUTO_INCREMENT,
i_bseq	bigint	NOT NULL,	
i_originalName	VARCHAR(125),		
i_uploadName	VARCHAR(255)		

);


TRUNCATE tbl_bbs;
TRUNCATE tbl_images;


select * from tbl_bbs;
select * from tbl_images;

commit;


create database testdb;
use testdb;

create table tbl_t(
t1 int primary key AUTO_INCREMENT,
t2 varchar(10) not null 


);
 
DESC tbl_t;
 
insert into tbl_t (t2) value('민수');
 
select * from tbl_t;

delete from tbl_t
where t2='ds';

delete from tbl_t
where t2 = '민수';






 
 
 
 
