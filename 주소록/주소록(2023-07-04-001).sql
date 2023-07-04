-- addr 사용자 화면

-- 주소록 + 취미정보가 있는 데이터를 정규화 하여 Relation 설정하기

CREATE TABLE tbl_temp_hb(
hb_aid	VARCHAR2(5),
hb_name1	nVARCHAR2(30),
hb_name2	nVARCHAR2(30),
hb_name3	nVARCHAR2(30)
);

select * from tbl_temp_hb;
-- 테이블의 총 갯수
select COUNT(*) from tbl_temp_hb;

/*
가로로 나열된 데이터를 세로로 배치하기
제 1 정규화가 된 취미 데이터는 취미1, 취미2, 취미3 칼럼이
만들어진 테이블이다. 
이 테이블에 만약 4 번째 취미를 추가하고 싶으면 , 새로운 칼럼을 추가하거나
4번쟤 취미를 다른 취미 항목으로 교체해야 한다

만약 취미 항목이 늘어나 칼럼을 추가하게 되면 
table 구조를 변경해야 하고, 상당히 많은 비용이 요구된다.(시간 등)
또한 테이블 구조를 변경하는 것은 매우 신중하게 처리 해야 한다.
다른 어플리케이션과 연동되는 테이블의 구조를 변경하면 아주 많은 부분에서 변경을 
해야하는 경우도 있다.

만약 취미항목이 3개 미만인 경우는 데이터가 저장되지 않는 
칼럼이 발생하고 이 칼럼들은 보통 null값으로 채워진다.
table의 칼럼에 null값이 많은 것은 별로 좋은 현상이 아니다.

*/
select hb_aid, hb_name1 from tbl_temp_hb
UNION all
select hb_aid, hb_name2 from tbl_temp_hb
where hb_name2 is not null
UNION ALL
select hb_aid, hb_name2 from tbl_temp_hb
where hb_name3 is not null
order by hb_aid;



CREATE TABLE tbl_hobby(
hb_seq	NUMBER		PRIMARY KEY,
hb_aid	VARCHAR2(5)	NOT NULL,
hb_name	nVARCHAR2(30)	NOT NULL	
);

select * from tbl_hobby;
select count(*) from tbl_hobby;

-- 취미정보 제 3 정규화

/*
DDL명령: DBA가 사용하는 명령들, 물리적 객체 생성, 제거, 변경을 수행하는 명령
CREATE : 객체 생성= 최초 프로젝트를 시작할때 
DROP: 객체 제거= 최초 프로젝트 시작할때 잘 못 생성된 객체를 다시 만들고자 할 때
ALTER: 객체 변경= 사용중에 중요한 변경사항이 발생했을때 구조변경을 수행하는 명령
        구조변경은 매우 신중하게 수행해야 한다.
*/

/*
주소 취미 Relation Table의 제 3 정규화
제 2 정규화가 되어 있는 tbl_addr_hobby TABLE에는 
주소록의 ID(a_id)와 취미이름(hb_name)이 저장되어 있다.
hb_aid 칼럼은 주소 테이블과 연계되어 있지만 hd_name칼럼은 평범한 문자열로 구성되어있다.
만약 어떤 취미의 명칭을 변경하고자 할 때는 
update tbl_addr_hobby 
set hb_name='변경할이름'
where hb_name='원래이름'

과 같은 SQL을 사용해야 한다
이 SQL은 TABLE 데이터를 다수 변경하는 명령이 된다.
UPDATE명령은 기본적으로 PK를 기준으로 1개의 데이터만 변경되도록 하는 것이 좋다
하지만 이 명령은 이러한 원칙에 위배된다.

이때 업데이트, 삭제를 수행하는 과정에서 이 테이블에는 수정이상, 삭제이상 현상이 발생할 수 있다.

또한 취미정보를 추가하는 과정에서 유사한 취미가 다른 형식으로 등록되는 경우도 있다.

이러한 여러가지 문제를 방지하기 위하여 table을 분리하여 제 3 정규화를 수행한다.


제 3 정규화 방법
1. 기존의 table 에서 일반문자열로 되어있는 부분을 떼어 새로운 table로 옮긴다
2. 기존 table과 새로운 table간에 Relation 설정을 한다.


*/


-- 1. tbl_hobby table 이름 변경: Entity를 Relation으로 이름 변경
ALTER TABLE tbl_hobby
RENAME TO tbl_addr_hobby;

SELECT * FROM tbl_addr_hobby;

--2. 취미 Relation 에서 취미이름(hb_name) 항목을 중복데이터 없이 추출하기
-- 중복없이 데이터 모으기
-- gb_name 칼럼의 데이터를 같은 데이터끼리 그룹지어 리스트를 만든다.
-- group by: 중보된 데이터 없이 항목 묶기
SELECT hb_name
from tbl_addr_hobby
GROUP by hb_name
order by hb_name;

--3. 제 3 정규화 데이터 import
-- 주의! 기존 제2 정규화 데이터를 엑셀로 보내서 제3정규화 데이터가 완료된 후 
-- 다음을 진행 할 것
-- tbl_addr_hobby table 을 기존 table을 drop하고 새로운 구조로 생성하기
drop table tbl_addr_hobby;
CREATE TABLE tbl_addr_hobby(
ah_seq	NUMBER		PRIMARY KEY,
ah_aid	VARCHAR2(5)	NOT NULL,
ah_hbcode	VARCHAR2(5)	NOT NULL	
);

desc tbl_addr_hobby;

select COunt(*) from tbl_addr_hobby;
select ah_hbcode from tbl_addr_hobby
GROUP BY ah_hbcode
order BY ah_hbcode;

--4. 취미 Entity import 

create table tbl_hobby(
hb_code	VARCHAR2(5)		PRIMARY KEY,
hb_name	nVARCHAR2(30)	NOT NULL,	
hb_descrip	nVARCHAR2(400)		
);

select count(*) from tbl_hobby;

select * from tbl_addr_hobby;

-Table JOIN
-- 정규화 (2,3정규화) 된 Table 의 정보를 Select 하면 단순히 한 개의 table 만으로는
-- 어떤 정보를 보여주고 있는지 알 수가 없다.
-- 2,3 정규화된 Table은 필연적으로 Table 간의 join 이 되어야만 정보를 명확히 알 수 있다.
-- join은 2개 이상의 Table을 서로 연계하여 필요한 정보를 확인하는 것이다.

--
select * from tbl_addr_hobby, tbl_address;

-- tbl_addr_hobby 곱하기 tbl_address
-- 카디션 곱하기
select count(*) from tbl_addr_hobby, tbl_address;

--addr_hobby Relation과 address Entity 테이블을 나열하되 
-- 두 테이블의 칼럼 ah_aid 와 a_id의 데이터가 일치한 정보만 나열하라
-- 이것을 완전조인 => EQ JOIN 이라 한다.
-- EQ JOIN은 모든 JOIN 방식중에 가장 빠르다. 단 참조무결성 제약조건이 
-- 완벽해야 한다.
-- EQ JOIN은 연계하는 TABLE 간에 참조무결성 제약조건이 완벽할때는
-- 아무런 문제가 없이 결과를 조회할 수 있다.
-- 하지만 연계하는 TABLE간에 참조무결성 제약조건이 위배되면 
-- 조회된 데이터를 신뢰할수 없다.
select * from tbl_addr_hobby, tbl_address
where ah_aid = a_id;

-- 필요한 칼럼만 나열하는 것을 프로젝션이라 한다.
select ah_aid, a_name, a_tel, a_addr, ah_hbcode
from tbl_addr_hobby, tbl_address
where ah_aid = a_id;

select count(*)
from tbl_addr_hobby, tbl_address
where ah_aid = a_id;


select count(*)
from tbl_addr_hobby;


/*LEFT JOIN

join을 실행하는 TABLE간에 참조무결성이 의심스럽거나 위배될지 모른다는
전제하에 데이터를 확인하는 JOIN
FROM [TABLE1] LEFT JOIN [TABLE2]
왼쪽(LEFT) 의 table 데이터는 무조건 select 하고
오른족 table2데이터는 on에서 설정한 조건에 맞는 것만 가져오기
오른쪽 table2에 조건에 맞는 데이터가 있으면 보여주고
없으면 null로 표현하라

1. select한 데이터의 누락이 발생하지 않는다.
2. 참조 무결성 제약 조건이 완벽하게 성립하는지 확인하는 용도
*/


select ah_aid, a_name, a_tel, a_addr, ah_hbcode
FROM tbl_addr_hobby
    LEFT JOIN tbl_address
        ON ah_aid=a_id
order by ah_aid;

-- 주소취미 Relation 과 Entity 간의 참조무결성 검사
-- 이 결과에서 list가 한 개도 나오지 않아야 한다.
select ah_aid, a_name, a_tel, a_addr, ah_hbcode
FROM tbl_addr_hobby
    LEFT JOIN tbl_address
        ON ah_aid=a_id
        where a_name is null;
order by ah_aid;


select ah_aid, ah_hbcode, hb_name
from tbl_addr_hobby
left join tbl_hobby
on ah_hbcode= hb_code;

-- 주소취미Relation과 취미 Entity 간의 참조무결성 검사
-- 이 결과도 리스트가 한 개도 나오지 않아야 한다.
select ah_aid, ah_hbcode, hb_name
from tbl_addr_hobby
left join tbl_hobby
on ah_hbcode= hb_code
where hb_name is null;

/*현재 tbl_address Table 의 데이터가 테스트 과정에서 문제가 생겼다
저장된 데이터를 모두 클리어하고 엑셀의 데이터로 다시 import하자
*/
-- 기존의 테이블을 드롭하고 다시 CREATE TABLE하라
--truncate table tbl_address;
SELECT * FROM tbl_address;

select ah_aid, ah_hbcode, a_name, a_tel, a_addr
from tbl_addr_hobby
left join tbl_address
on a_id= ah_aid
where ah_aid <= 'A0010';

select ah_aid, ah_hbcode, hb_name, hb_descrip
from tbl_addr_hobby
left join tbl_hobby
on ah_hbcode=hb_code;
/*
view 생성
물리적 table에 SQL을 적용하여 작성하였더니 다소 복잡한 SQL이 완성되었다,
이후 이 SQL을 사용할 일이 많을 거 같다.
그래서 이 SQL을 view로 생성하였다
view 는 일반적으로 read only만 가능(SELECT)
*/
create view view_addr_hobby
as (
select ah_aid, ah_hbcode, hb_name ,a_name, a_tel, a_addr
    from tbl_addr_hobby
        left join tbl_address
            on a_id= ah_aid
        LEFT JOIN tbl_hobby
            on ah_hbcode=hb_code
);

SELECT * FROM view_addr_hobby;

SELECT * FROM view_addr_hobby 
where ah_aid='A0002';

DROP VIEW view_addr_hobby;
create view view_addr_hobby
as (
select ah_aid AS 아이디,
    ah_hbcode AS 취미코드,
    hb_name AS 취미 ,  
    a_name AS 이름,
    a_tel AS 전화번호,
    a_addr AS 주소
    
    from tbl_addr_hobby
        left join tbl_address
            on a_id= ah_aid
        LEFT JOIN tbl_hobby
            on ah_hbcode=hb_code
);


SELECT * FROM view_addr_hobby;

-- 참조 무결성 설정하기: FOREIGN KEY 설정하기
/*
연계된 Entity, Relation 간에 참조관계가 잘 유지되도록,
Table 의 제약조건을 설정하는것

1. FK는 Relation Table 에 설정한다.
2. FK는 1:N 관계 Table 에서 N의 Table 에 설정한다
*/

-- addr_hobby와 address간의 FK설정
ALTER TABLE tbl_addr_hobby -- tbl_addr_hobby 의 table에  
add CONSTRAINT f_addr-- f_addr 이름으로 제약조건을 추가하겠다.
foreign key(ah_aid) -- tbl_addr_hobby의 ah_aid 칼럼을
REFERENCES tbl_address(a_id);-- tbl_address table 의 a_id칼럼과 연계

DELETE FROM tbl_address where a_id='A0001';

-- addr_hobby와 hobby 간의 FK 설정
ALTER TABLE tbl_addr_hobby -- tbl_addr_hobby 의 table에  
add CONSTRAINT f_hobby-- f_hobby 이름으로 제약조건을 추가하겠다.
foreign key(ah_hbcode) -- tbl_addr_hobby의 ah_hbcode 칼럼을
REFERENCES tbl_hobby(hb_code);-- tbl_hobby table 의 hb_code칼럼과 연계

/*
table 의 FK 연계조건
-------------------------------------------------------------
tbl_address         tbl_hobby           tbl_addr_hobby
-------------------------------------------------------------
코드가 있다 >>                           코드가 있을 수 있다.
                    코드가 있다 >>       코드가 있을 수 있다.
-------------------------------------------------------------
코드가 없다 >>                           절대 코드가 없다.
                    코드가 없다 >>       절대 코드가 없다.
-------------------------------------------------------------
반드시 있어야 한다                       << 코드가 있다                                        
                    반드시 있어야 한다   << 코드가 있다.
-------------------------------------------------------------
삭제 할 수 없다.                          << 코드가 있다.
                    삭제 할 수 없다.      << 코드가 있다.
-------------------------------------------------------------                    




*/

