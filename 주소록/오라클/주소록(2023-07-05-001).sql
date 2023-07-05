-- addr User

select * from tbl_addr_hobby;
-- addr_hobby Relation Table 과 hobby Entity Table 을 Left Join 하여
-- 주소 ID, 취미코드, 취미이름,취미설명 항목을 Projection 하도록

select ah_seq, ah_aid, ah_hbcode, hb_name, hb_descrip
from tbl_addr_hobby 
        LEFT join tbl_hobby
        on ah_hbcode=hb_code
            WHERE AH_AID='A0001';

-- 특별한 주소 ID가 지정되었을 때 해당 주소의 ID 값만 SELECTION하기










