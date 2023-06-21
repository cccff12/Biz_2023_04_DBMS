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
-- student tablespace를 생성하고 
-- 저장소는 student.dbf로 하라
-- 초기 용량은 1mbyte로 성정하고 1kbyte씩 자동증가하도록 설정하라
CREATE TABLESPACE student -- 저장소의 이름을 student라는 이름으로 사용하겠다
DATAFILE 'C:/app/data/student.dbf' -- 저장소 폴더에 student.dbg라는 이름으로 생성
SIZE 1M AUTOEXTEND ON NEXT 1K;-- 초기에 저장소 공간을 1M 확보하고 혹시 부족하면 1K 씩 자동으로 증가하라


--2 . 사용자 생성(CREATE 키워드)
-- STUDENT라는 사용자를 생성하고 비밀번호를 12341234로 설정하고 
-- 기본 저장소 연결을 STUDENT로 설정하라

-- 오라클 12C 이후 버전에서는 사용자 이름을 등록하는 정책이 변경되었다
-- 만약 STUDENT라는 사용자를 생성하고 싶으면 C##student라는 이름으로 생성을 하야 한다.
-- 이러한 정책은 보안적인 면에서는 권장하지만 때로는 불편할때가 있다.
-- 일부 프로그래밍 언어에서 DB에 접속할때 ##와 같은 특수문자가 있으면 
-- 접속에 문제를 일으키는 경우가 있다.
-- 오라클에서는 12C 이후에 사용자 생성 정책을 예전 방식으로 사용할수 있도록 하는 
-- 설정을 제공한다.

-- 이 설정 명령은 유저를 생성하기 전에 항상 실행해 주어야 한다.
ALTER SESSION SET "_ORACLE_SCRIPT" = true;
create user student IDENTIFIED by 12341234
default tablespace student;

--3 . 생성한 사용자에게 권한을 부여
-- 사용자 (studnet)는 DBMS에 소프트웨어 로그인을 하고
-- SQL을 사용하여 데이터 TABLE을 생성하고
-- CRUD 명령을 수행하여 데이터를 관리한다
-- 오라클에서 사용자를 생성(CREATE) 한 직후에는 아무런 권한이 없다
--  심지어 DBMS 소프트웨어 로그인할 수도 없다
-- 사용자에게 권한을 부여하여 기능을 활성화시켜야한다.
-- 권한부여는 원칙적으로 각각 항목별로 부여해야 하지만
-- 학습적 편리성을 위하여 모든 권한을 한번에 부여 할 것이다.

-- student 사용자에게 DBA(데이터 관리자) 권한을 부여하라
GRANT DBA TO student;



CREATE TABLESPACE MEMO 
DATAFILE 'C:/app/data/MEMO.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;

ALTER SESSION SET "_ORACLE_SCRIPT" = true;
create user MEMO IDENTIFIED by 12341234
default tablespace MEMO;

GRANT DBA TO MEMO;


-- 생성
CREATE TABLESPACE shopingcart 
DATAFILE 'C:/app/data/shopingcart.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;

ALTER SESSION SET "_ORACLE_SCRIPT" = true;
create user shopingcart IDENTIFIED by 12341234
default tablespace shopingcart;

GRANT DBA TO MEMO;
