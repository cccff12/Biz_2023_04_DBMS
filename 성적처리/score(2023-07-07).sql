-- ScoreDB화면
 use scoreDB;
-- 일반 (엑셀) 성적표를 저장하기 위한 테이블 생성

CREATE TABLE tbl_scoreV1(
	sc_stnum	VARCHAR(5)		PRIMARY KEY,
	sc_kor	INT,		
	sc_eng	INT,		
	sc_math	INT,		
	sc_music INT,		
	sc_art	INT,		
	sc_software	INT,		
	sc_database	INT		
);


show tables;
desc tbl_scoreV1;

select * from tbl_scoreV1;

select count(*) from tbl_scoreV1;

-- view 삭제
drop view view_scoreV1;

create view view_scoreV1 as
(
	select *,
	sc_kor + sc_eng 
	+ sc_math + sc_art 
	+ sc_music+ sc_software + sc_database as 총점,
	(
    + sc_kor
	+ sc_eng 
	+ sc_math 
	+ sc_art 
	+ sc_music
	+ sc_software 
	+ sc_database)/7 as 평균
	from tbl_scoreV1
	);
    select * from view_scoreV1;
    
    -- 국어성적이 50점 이상인 학생들 리스트
    -- where selection 
    select * from view_scoreV1
    where sc_kor>=50;

-- 평균 점수가 60점 미만인 학생들
select * from view_scoreV1
where 평균 < 70;

-- sql을 사용한 간이 통계
-- 전체 학생의 각 과목별 성적 총점계산
-- 국어 성적의 총점 계산
-- sum(): ansi sql의 총합계를 계산하는 통계함수
-- avg(): ansi sql 의 평균을 계산하는 통계함수
-- max(), min(): ansi sql의 최대값, 최소값을 계산하는 통계 함수
-- count(): ansi sql의 개수를 계산하는 통계함수
select sum(sc_kor), avg(sc_kor)
from view_scoreV1;

-- view 의 합 계산
select 
sum(sc_kor) as 국어,
sum(sc_eng) as 영어,
sum(sc_math) as 수학,
sum(sc_music) as 음악,
sum(sc_art) as 미술
from view_scoreV1;

-- view 의 평균 계산
select 
avg(sc_kor) as 국어,
avg(sc_eng) as 영어,
avg(sc_math) as 수학,
avg(sc_music) as 음악,
avg(sc_art) as 미술
from view_scoreV1;


-- mysql8의 전용함수
-- over(order by 평균 desc ): 평균을 오름차순한 것을 기준으로
-- rank() 순위를 계산하라
select *,
rank() over(order by 평균 desc) as 랭킹
from view_scoreV1
order by 평균 desc;

-- dense_rank(): 동점자 처리를 하되 석차를 건너뜀 없이
select *,
dense_rank() over(order by 평균 desc) as 랭킹
from view_scoreV1
order by 평균 desc;

-- sub query : sql 결과를 사용하여 다른 sql을 실행하는 방법
select * from
(
select *,
rank() over(order by 평균 desc) as 랭킹
from view_scoreV1
) as sub
where 랭킹 < 5;


select sub.과목코드, sub.과목명 from
(
	select sc_stnum, 'B001' as 과목코드 ,'국어' as 과목명 ,sc_kor from tbl_scoreV1
	union all
	select sc_stnum, 'B002','영어',sc_eng from tbl_scoreV1
	union all
	select sc_stnum, 'B003','수학',sc_math from tbl_scoreV1
	union all
	select sc_stnum, 'B004','음악',sc_music from tbl_scoreV1
	union all
	select sc_stnum, 'B005','미술',sc_art from tbl_scoreV1
	union all
	select sc_stnum, 'B006','소프트웨어',sc_software from tbl_scoreV1
	union all
	select sc_stnum, 'B007','데이터베이스',sc_database from tbl_scoreV1
) as sub
group by sub.과목코드, sub.과목명;

-- 학생정보 제 3 정규화 데이터 테이블
-- 학번과 과목코드를 복합키(슈퍼키) pk 생성
CREATE TABLE tbl_score(
sc_stnum	VARCHAR(5)	NOT NULL,
sc_bcode	VARCHAR(4)	NOT NULL,
sc_score	INT	NOT NULL,
	PRIMARY KEY(sc_stnum, sc_bcode)	
);

select * from tbl_subject;

create table tbl_subject(
b_code	VARCHAR(4)		PRIMARY KEY,
b_name	VARCHAR(20)		
);

-- 과목정보 excel 데이터를 tbl_subject에 insert 해보기
-- Insert into TBL_ADDR_HOBBY (AH_SEQ,AH_AID,AH_HBCODE) values (351,'A0180','H0105');
insert into tbl_subject (b_code,b_name) value('B001','국어');
insert into tbl_subject (b_code,b_name) value('B002','영어') ; 
insert into tbl_subject (b_code,b_name) value('B003','수학') ; 
insert into tbl_subject (b_code,b_name) value('B004','음악') ; 
insert into tbl_subject (b_code,b_name) value('B005','미술') ; 
insert into tbl_subject (b_code,b_name) value('B006','소프트웨어') ; 
insert into tbl_subject (b_code,b_name) value('B007','데이터베이스') ;

select * from tbl_subject;
select count(*) from tbl_subject;
desc tbl_score;

select * from tbl_score;
select count(*) from tbl_score;

-- 성적표와 과목정보를 join하여 학번, 과목코드, 과목명, 점수를 projection 하여 출력
select sc_stnum, sc_bcode, b_name, sc_score
from tbl_score
	left join tbl_subject
		on sc_bcode= b_code;
        
        
        -- 완전 참조관계 확인
	-- left join에서 결과가 없다면 완전 참조관계이다.
        select sc_stnum, sc_bcode, b_name, sc_score
from tbl_score
	left join tbl_subject
		on sc_bcode= b_code
        where b_name is null;
        
        
        -- 성적표와 과목정보가 완전 참조 관계일때는 EQ JOIN 을 사용할수 있다
        select sc_stnum, sc_bcode, b_name, sc_score
        from tbl_score, tbl_subject
        where sc_bcode = b_code;
        
        
        -- 성적표와 과목정보가 앞으로도 계속 완전참조 관계가 되도록 
        -- fk를 설정한다. (완전 참조 무결성 관계 설정)
        -- ansi sql
        alter table tbl_score
        add CONSTRAINT F_SUBJECT FOREIGN KEY(sc_bcode)
        REFERENCES tbl_subject(b_code);
        
        -- my sql
        alter table tbl_score
        add FOREIGN KEY F_SUBJECT (sc_bcode)
        REFERENCES tbl_subject(b_code);
        
        alter table tbl_score
        drop FOREIGN KEY tbl_score_ibfk_1;
        
        -- 삭제시
        -- alter table tbl_score
        -- drop foreign key;
        
        
        -- ansi 표준 <=이거 추천 
         alter table tbl_score
        add CONSTRAINT F_SUBJECT FOREIGN KEY(sc_bcode)
        REFERENCES tbl_subject(b_code);
        
        
        -- on delete, on update
        -- on delete :  master(tbl_subject) table키가 삭제될때
        -- on update :  master(tbl_subject) table키가 변경될때
        
        /*  
        CASCADE: master 삭제 - > sub도 같이 모두 삭제 @@@@@@@@@@@@@@@@@@@@@@@@@@@@게시판을 삭제하면 댓글도 삭제되는 것과 같음
        set null : master 삭제 -> sub 는 null,
					만약 SUB 칼럼이 NOT NULL 이면 오류 발생
        No ACTION : Master 삭제 - > Sub 에는 변화 없다
        SET DEFAULT : Master 삭제하면 -> Sub Table 생성할 때
						DEFAULT 옵션으로 지정한 값으로 세팅
        RESTRICT: 아무것도 하지말고 삭제하지마
        
        */
        
        
        
              alter table tbl_score
        add FOREIGN KEY F_SUBJECT (sc_bcode)
        REFERENCES tbl_subject(b_code)
        ON DELETE CASCADE;
        
        SELECT sc_stnum, sc_bcode,b_name, sc_score
        from tbl_score, tbl_subject
        where sc_bcode=b_code and sc_stnum='S0001';
        
        
        SELECT sc_stnum, sc_bcode,b_name, sc_score
        from tbl_score, tbl_subject
        where sc_bcode=b_code and b_name ='국어';
        
        -- 학생별 총점 계산
        select sc_stnum,sum(sc_score)
        from tbl_score
        GROUP BY sc_stnum;
        
        -- 과목별 총점 계산하기 
        select sc_bcode , sum(sc_score) 총점, avg(sc_score) 평균
        from tbl_score
        GROUP BY sc_bcode;
        
        -- 제 3 정규화가 완료된 데이터를 pivot 으로 펼쳐서 보고서 형식으로 출력
        -- 세로 방향으로 펼쳐진 데이터를 가로 방향으로 펼쳐서 보기
        select
		sum(if(sc_bcode = 'B001', sc_score , 0))	 as 국어,
        sum(if(sc_bcode = 'B002', sc_score , 0))	 as 영어,
        sum(if(sc_bcode = 'B003', sc_score , 0))	 as 수학,
        sum(if(sc_bcode = 'B004', sc_score , 0))	 as 음악,
        sum(if(sc_bcode = 'B005', sc_score , 0))	 as 미술,
        sum(if(sc_bcode = 'B006', sc_score , 0))	 as 소프트웨어,
        sum(if(sc_bcode = 'B007', sc_score , 0))	 as 데이터베이스
            from tbl_score;
            
            -- 제 3 정규화가 되어 있는 데이터를 pivot 보고서 형식으로 출력
select
		sum(if(sc_bcode = 'B001', sc_score , 0))	 as 국어,
        sum(if(sc_bcode = 'B002', sc_score , 0))	 as 영어,
        sum(if(sc_bcode = 'B003', sc_score , 0))	 as 수학,
        sum(if(sc_bcode = 'B004', sc_score , 0))	 as 음악,
        sum(if(sc_bcode = 'B005', sc_score , 0))	 as 미술,
        sum(if(sc_bcode = 'B006', sc_score , 0))	 as 소프트웨어,
        sum(if(sc_bcode = 'B007', sc_score , 0))	 as 데이터베이스,
		sum(sc_score) as 총점, 
		avg(sc_score) as 평균
	from tbl_score
 GROUP BY sc_stnum;
            
-- 통계함수로 학생별 총점을 계산하고 
-- 계산된 총점에 대하여 조건을 부여하여 SELECTION하기
select sc_stnum, SUM(sc_score) AS 총점
from tbl_score
GROUP BY sc_stnum
having sum(sc_score) > 600;


select sc_stnum, SUM(sc_score) AS 총점
from tbl_score
GROUP BY sc_stnum
having 총점 > 600;


-- 학번이 S0010보다 작은 학생들의 총점 계산
SELECT sc_stnum 학번, sum(sc_score) as 총점
from tbl_score
GROUP BY sc_stnum
having 학번<'S0010';


SELECT sc_stnum 학번, sum(sc_score) as 총점
from tbl_score
where sc_stnum<'S0010'
GROUP BY sc_stnum
having 학번<'S0010';

-- 총점이 S0010 인 학생보다 작은 학생들 총점 리스트
-- 조건절 (where having )에 sub query 적용하기
-- 조건절에 적용하는 sub query 는 결과가 반드시 한 개 이하여야 한다.
SELECT sc_stnum 학번, sum(sc_score) as 총점
from tbl_score
GROUP BY sc_stnum
having 총점 < 
(SELECT SUM(sc_score) from tbl_score where sc_stnum='S0010');

SELECT SUM(sc_score) 
from tbl_score where sc_stnum='S0010';
