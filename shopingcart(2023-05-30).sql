--DROP TABLE tbl_;

CREATE TABLE tbl_buyer(

buId	VARCHAR2(10)		PRIMARY KEY,
buName	nVARCHAR2(20),		
buTel	VARCHAR2(10),		
buAddr	nVARCHAR2(125)		
);

create table tbl_product(
pCode	VARCHAR2(13)		PRIMARY KEY,
pName	nVARCHAR2(30),		
pItem	VARCHAR2(10),		
pIPrice	NUMBER,		
pOPrice	NUMBER	
);


create table tbl_iolist(
ioSEQ	NUMBER		PRIMARY KEY,
ioDate	VARCHAR2(10),		
ioTime	VARCHAR2(10),		
ioBuId	VARCHAR2(10),		
ioPCode	NUMBER,		
ioQuan	NUMBER,		
ioPrice	NUMBER		
);

INSERT INTO tbl_buyer(buId, buName, buTel, buAddr)
values('1','홍길동','0101111111','서울');


INSERT INTO tbl_buyer(buId, buName, buTel, buAddr)
values('2','성춘향','0102222222','서울');

select * from tbl_buyer;

commit;

select * from tbl_product;