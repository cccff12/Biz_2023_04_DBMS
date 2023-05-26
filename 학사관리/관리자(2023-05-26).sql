-- 관리자로 로그인 한 화면
-- 관리하는 sysdba권한을 가진 사용자
-- sysdba 사용자는 데이터베이스 시스템을 생성 제거 파괴할수 있는 권한을 가진 사용자

-- 오라클에서 관리자로 로그인하여 수행할 작업은 크게 2가지다
-- tablespace 생성 user생성

-- talblespace: 데이터를 저장할 물리적 저장소(파일)를 만드는 것, 데이터를 저장하기 위하여 
--              가장 먼저 생성해야할 객체 
--user : DBMS서버에 로그인을 하고 자신이 관리할 데이터들과 연결
--       오라클에서USER는 데이터 저장소의 개념이다. 이 개념은 다른 DBMS와는 다르다
--       저장소 SCHEME 라고 표현한다

-- C:/app/data--: (역슬래쉬를 슬래쉬로 바꿈) TABLESPACE가 저장될 폴더

-- TABLESPACE생성(CREATE 키워드)

CREATE TABLESPACE student -- 저장소의 이름을 student라는 이름으로 사용하겠다
DATAFILE 'C:/app/data/student.dbf' -- 저장소 폴더에 student.dbg라는 이름으로 생성