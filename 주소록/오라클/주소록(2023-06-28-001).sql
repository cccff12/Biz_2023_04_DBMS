-- 여기는 addr사용자 화면

-- 데이터를 저장할 테이블 생성하기
CREATE TABLE tbl_address(
a_id	VARCHAR2(5)		PRIMARY KEY,
a_name	nVARCHAR2(20)	NOT NULL,	
a_tel	VARCHAR2(15)	NOT NULL,	
a_addr	nVARCHAR2(125)	NOT NULL	
);

-- 엑셀파일에서 데이터 import
-- import 한 후에 데이터가 모두 잘 import되었는지 확인하기

SELECT * from tbl_address;

-- 현재 tbl_address TABLE 에 저장된 데이터가 몇 개이냐?
-- count 함수 : 테이블에 저장된 데이터의 개수를 확인하는 함수
SELECT COUNT(*) FROM tbl_address;

-- 함수에 칼럼이름을 지정해 개수를 확인하기
-- 여기에서는 count (*) count(A_ID) 의 결과가 같다
SELECT COUNT(A_ID) FROM tbl_address;

-- tbl_address TABLE 에 A_ID 값의 최대값, 최고값 확인하기
-- MAX() , MIN() 테이블에 저장된 특정 칼럼의 최대값, 최소값을 찾는 함수
 SELECT MAX(A_ID), MIN(A_ID) FROM tbl_address;

/* SQL(Structure Query Lang): 구조화된 DBMS 핸들링 문법
ANSI SQL: 모든 DBMS SW에 거의 공통으로 구현된 명령 문법
펴준화된 문법으로 DBMS SW가 달라고 사용할 수 있는 문법

특정 SQL: 각 메이커별 DBMS SW의 고유한 기능을 구현한 명령 문법
*/

--주소록 전부를 보여달라
SELECT * FROM tbl_address;

--칼럼의 일부만 표현하게 하는 방법: projection
-- 주소록 중에 id와 name 만 보여달라
SELECT a_id, a_name
FROM tbl_address;

-- 이렇게 필요에 따라 칼럼을 나열하고
-- 보여지는 칼럼의 순서도 바꿀수 있다.
SELECT a_name, a_addr, a_tel
from tbl_address;

-- 모든 칼럼: * 
--모든칼럼으로 조회를 하면, 실제 원하는 칼럼의 순서와 관계없이 데이터가 표현된다.
select *from tbl_address;

-- TABLE의 모든 칼럼을 나열한 projection
-- select 명령에서 모든 칼럼(*) 으로 조회하는 것보다는 ALL Projection 으로 조회를 
-- 하는 것이, 조회 속도면에서 더 유리하다
-- 코딩(java 등)과 연동해 사용할때는 가급적 all project를 사용하는 것이 좋다
select a_id,a_name,a_tel,a_addr
from tbl_address;

-- id가 A0010이하인 데이터들만 보여달라
-- 일반적인 코딩 문법과 달리 SQL에서는 문자열형 칼럼 데이터에 대하여 
-- 부등호 연산이 가능하다.
-- 전체 데이터 중에서 특정 조건을 부여하여
-- 조선에 맞는 데이터만 골라내는 명령 : Selection

select * FROM tbl_address
where a_id <='A0010';

/*
Relation Algebra (관계대수)
DBMS에서 특정 조건을 부여하여 데이터를 SELECT하는 것

PROJECTION : 특정칼럼만 나열하여 데이터를 SELECT 하는 것
: SELECT 절에 칼럼 리스트 나열: EX) SELECT a_id, a_name

SELECTION : 특정조건에 맞는 데이터를 SELECT하는 것
: where 절에 조건식을 부여해 리스트를 제한 하는 것
*/


--전화번호가 이러한 값을 갖는걸 보여달라
SELECT*
FROM tbl_address
WHERE a_tel= '090-3663-2154';

--LIKE 키워드는 중간문자열 조건 검색
 select *
FROM  tbl_address
where a_tel LIKE '090-33%';

-- a_tel 칼럼의 데이터를 5번쨰 위치부터 잘라서 보여라
 select SUBSTR(a_tel,5)
 from tbl_address;
 
 -- a_tel 칼럼의 데이터를 5번째 위치부터 4개만 잘라서 보여라
 select SUBSTR(a_tel,5,4)
 from tbl_address;

--위와 같고
select SUBSTR(a_tel,5,4)
 from tbl_address
--오름차순 정렬
order by a_tel;



/*밑 코드 설명: tbl 테이블에서 a_id 등을 검색해서 a_id<'A0010' 인 조건들을 찾아서 a_tel순으로 오름차순 정렬한다*/

/*1. tbl_address TABLE 이 있는 것을 확인
2. TABLE 이  있으면 데이터를 조회할 준비
3. WHERE 절의 조건대로 데이터 SELECTION
4. SELECT 절의 칼럼대로 데이터 PROJECTION
5. ORDER BY 절의 칼럼을 기준으로 정렬

SELECT FROM은 필수항목
WHERE ORDER BY는 선택항목
*/
SELECT a_id, a_name, a_tel
FROM tbl_address
WHERE a_id<'A0010'
ORDER BY a_tel;

--아래의 두 SELECTION은 같은 결과를 보여주지만
-- 많은 양의 데이터 중에서 SELECTION 을 수행할때 
-- LIKE 키워드를 사용한 WHERE 절 해석은 매우 느리게 작동한다.
-- 상황에 따라 적절하게 사용하자

-- 전화번호 앞에서 6글자를 잘라서
-- 전화번호가 090-33 으로 시작되는 데이터 SELECTION
SELECT *FROM tbl_address
WHERE SUBSTR(a_tel,1,6)='090-33';

--전화번호 6글자가 090-33 으로 시작되는 데이터 SELECTION
select *from tbl_address
where a_tel LIKE '090-33%';

-- 아이디 값이 A0010~ A0020인 데이터만 SELECTION 하라
SELECT *
FROM tbl_address
where a_id<'A0010' AND a_id<='A0020';



/*
SQL 에서 WHERE 조선을 부여하여 SELECTION 할때 
조건문의 순서에 따라 SELECTION 결과의 효율이 달라질수 있다.
범위를 줄이고 시작하라
*/

-- 이건 먼저 범위를 제한해 개수를 제한하고 전화번호를 찾는다. => 10개 찾고 10개 찾음
SELECT *
FROM tbl_address
where a_id<'A0010' AND a_id<='A0020' AND a_tel LIKE '090-33%';

-- 전체 범위에서 전화번호를 찾고 그 중에서 범위를 제한한다. => 200 개 찾고 10개 찾음
SELECT *
FROM tbl_address
where a_tel LIKE '090-33%' AND a_id>'A0010' AND a_id<='A0190' ;



















