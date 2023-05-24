-- 여기는 myuser (C##myuser) 로 접

select acNum, acacdiv, acbuid, acbalance
from tbl_acc
order by acnum;

select *
from tbl_acc
where acNum= '2023052301';

select * from tbl_acc;

insert into tbl_acc(acNum, acDiv, acBuid, acBalance)
values('2023052401','1','0001','10000');

insert into tbl_acc(acNum, acDiv, acBuid, acBalance)
values('2023052402','2','0002','10000');

insert into tbl_acc(acNum, acDiv, acBuid, acBalance)
values('2023052403','3','0001','10000');



COMMIT;




-- 잔액순으로 정렬, 오름차순 정렬
-- 오름차순 정렬(ASCENDING)
SELECT *
from tbl_acc
WHERE acbuid= '0001'
ORDER BY acbalance ASC;

-- 고객 ID가 0001 인 고객의 계좌정보를 잔액 큰 것 부터 순서대로 
-- 정렬하여 보이기
-- 내림차순(DESENDING)
SELECT *
from tbl_acc
WHERE acbuid= '0001'
ORDER BY acbalance DESC;

--고객 아이디가 0001이거나 0003이거나 조회
SELECT *
FROM tbl_acc
WHERE acbuid= '0001' OR acBuid ='0003';

SELECT *
from tbl_acc
where acbalance >= 20000;

-- 1개의 칼럼에 다수의 조건 검색이 필요한 경우
-- or 연산일 경우 in 키워드를 사용할 수 있다.
select *
from tbl_acc
where acbuid in ('0001','0003');

-- 잔액이 10000~20000 인 데이터 조회
-- 자바의 && = and
select *
from tbl_acc
where acbalance >= 10000 and acbalance<=20000;

-- 각각의 범위 값이 포함관계 일 경우 between으로 검색 가능
select *
from tbl_acc
where acbalance BETWEEN 10000 and 20000;

-- acacbuid 가 0001 or 0003 의 반대인 경우
-- acacbuid 에 0001도 0003도 아닌 값의 조건 검색
select *
from tbl_acc
where not acbuid in('0001','0003');

-- 위와 같은 결과의 코드
-- acbuid가 0001이 아니고  acbuid가 0003이 아닐때
select *
from tbl_acc
where acbuid !='0001' and acbuid<> '0003'; 

SELECT *FROM tbl_acc;

DESCRIBE tbl_acc;

-- table의 구조 변경(DDL명령 사용)
-- table의 구조를 변경하는 것은 상당히 많은 비용이 소요된다.
-- 초기에 설계가 잘못된 경우 구조변경을 실시하는데 상당한 주의를 기울여야 한다.
-- 구조변경 과정에서 문제가 발생하면 데이터가 손상되는 문제가 있다.
-- 구조변경을 할 때 칼럼의 크기는 절대 줄여서 변경하면 안된다.

-- tbl_acc 의 acNum칼럼의 길이가 VARCHAR2(10)인데
-- 이 칼럼의 길이을 VARCHAR2(20)으로 변경

alter TABLE tbl_acc MODIFY (acNum VARCHAR2(20)); -- 칼럼의 길이를 20으로 변경시키는 코드
desc tbl_acc;

select *from tbl_acc;

-- sql에는 기본적으로 여러 기능을 수행하는 함수들이 내장되어 있다.
-- substr(칼럼, 시작, 개수): 갈럼의 문자열을 시작 위치부터 개수 만큼 잘라내기
-- max (칼럼): 전체 리스트(조건에 맞는 값 중에서) 중에서 가장 큰 값을 찾기
-- min: 전체 리스트(조건에 맞는 값 중에서) 중에서 가장 작은 값 찾기

select substr(max(acNum))
from tbl_acc
where substr(acNum,0,8)= '20230524';






