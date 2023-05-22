-- 여기는 DBA 권한을 갖는 myUser 화면입니다

-- TABLE 생성하기
CREATE TABLE tbl_buyer (
    buId	VARCHAR2(5)	NOT NULL	PRIMARY KEY,
    buName	nVARCHAR2(20)	NOT NULL,
    buTel	VARCHAR2(20),
    buAddr	nVARCHAR2(125),
    buBirth	VARCHAR2(10),
    buJob	nVARCHAR2(20)
);

INSERT INTO tbl_buyer(buid, buName, butel, buaddr, bubirth, bujob)
VALUES('0001','이몽룡','010-111-1111','서울특별시','1991-01-01','직장인');
SELECT * FROM tbl_buyer;-- tbl바이어로부터 데이터를 가져와서 보여달라

INSERT INTO tbl_buyer(buid,buname)
VALUES('0002','성춘향');

SELECT * FROM tbl_buyer;

UPDATE tbl_buyer--데이터 추가
SET butel='010-222-2222'--butel의 데이터에 010-222-2222를 입력하라
WHERE buid= '0002';-- 0002인 데이터를 찾아서
--만약 where 를 안하고 그냥 set 으로 입력하면 모든 butel이 010-222-2222가 되어버린다
-- 진짜 큰일남

SELECT * FROM tbl_buyer;

UPDATE tbl_buyer
SET buaddr= '전라북도 남원시'
WHERE buname= '성춘향';-- 전라북도 남원시라는 데이터를 buaddr를 
--성춘향이라는 데이터를 찾아서 추가하라
SELECT * FROM tbl_buyer;
