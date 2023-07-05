-- 여기는 addr USER 화면
/*
현재 tbl_address table 에 대하여 다음 결과를 확인하는 SQL을 작성
1. TABLE 에 저장된 전체 데이터의 개수는 몇 개인가
2. TABLE 에 저장된 전체 리스트를 전화번호 순으로 정렬해 확인하기
3. TABLE에 저장된 저장된 전체리스트를 이름 순으로 정렬하여 확인하기
4. TABLE에 저장된 저장된 전체리스트중에 성씨가 "김"으로 시작되는 리스트 확인하기
5. TABLE에 저장된 저장된 전체리스트중에 전화번호의 국번(090-2222-1234 중에 두번째 구역) 
    이 3으로 시작되는 리스트의 개수른 몇 개인가
*/

--1번
SELECT * FROM tbl_address;

--2번
SELECT * FROM tbl_address
ORDER by a_tel;
--역순정렬
SELECT * FROM tbl_address
ORDER by a_tel desc;



--3번
select *from tbl_address
order by a_name;


-- id 순으로 정렬을 하고 같은 id가 있다면 그 그룹에서 이름순으로 정렬
select *from tbl_address
order by a_id, a_name;

-- id 순으로 정렬 후 같은 id가 있다면 그 그룹에서 이름순으로 내림차순 정렬
select *from tbl_address
order by a_id , a_name desc;




--4번
select * from tbl_address
where a_name like '%이%';

select * from tbl_address
where a_id>'A0001' AND a_id<'A0200' AND a_name LIKE '이%';


5번
-- 중간문자열 검색, 전화번호 중 3이 포함된 모든 전화번호
SELECT * from tbl_address
-- 5번쨰 글자가 3인 데이터
where substr(a_tel,5,1)='3'
order by a_tel;

-- __이런 언더바는 오라클에서만 됨
select * from tbl_address
where a_tel like '____3%'
order by a_tel;

SELECT count(*)  from tbl_address
-- 5번쨰 글자가 3인 데이터
where substr(a_tel,5,1)='3'
order by a_tel;


-- 전화번호 국번이 3으로 시작되는 전화 중에서 
-- id가 가장 큰 데이터와 id가 가장 작은 데이터를 찾으시오

select max(a_id) 최대값, min(a_id) 최소값
from tbl_address
where substr(a_tel,5,1)='3';


SELECT * FROM tbl_address WHERE a_id = 'A0006' ;
UPDATE tbl_address SET a_name = '홍길동' WHERE a_id = 'A0006';
COMMIT;
DESC tbl_address;

UPDATE tbl_address SET a_name='홍길동777', a_tel = '010-1111-1111', a_addr = '서울특별시' WHERE a_id = '00001' ;
