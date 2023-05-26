

DROP TABLE tbl_memo;

CREATE TABLE tbl_memo(

m_seq	NUMBER		PRIMARY KEY,
m_writer	nVARCHAR2(20),		
m_date	VARCHAR2(20),		
m_subject	VARCHAR2(10),		
m_content	nVARCHAR2(10)		



);

insert into tbl_memo( m_seq, m_writer, m_date,m_subject,m_content)
VALUES('1111111111','홍길동','20230525','제목','내용');

insert into tbl_memo( m_seq, m_writer, m_date,m_subject,m_content)
VALUES('2222222222','홍길동','20230525','제목','내용');

insert into tbl_memo( m_seq, m_writer, m_date,m_subject,m_content)
VALUES('3333333333','홍길동','20230525','제목','내용');

insert into tbl_memo( m_seq, m_writer, m_date,m_subject,m_content)
VALUES('4444444444','홍길동','20230525','제목','내용');

select * from tbl_memo;


commit;