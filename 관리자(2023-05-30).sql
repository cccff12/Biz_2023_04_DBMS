-- 생성
CREATE TABLESPACE shopingcart 
DATAFILE 'C:/app/data/shopingcart.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;

ALTER SESSION SET "_ORACLE_SCRIPT" = true;
create user shopingcart IDENTIFIED by 12341234
default tablespace shopingcart;

GRANT DBA TO shopingcart;

