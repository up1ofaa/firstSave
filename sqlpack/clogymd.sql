select
*
from ad01clog;


select
a.stdd_ymd
,substr(a.stdd_ymd,0,4) yyyy
,substr(a.stdd_ymd,5,2) mm
,(select t.clog_dd      
        from 
        (select clog_ymd
              ,clog_yyyy
              ,clog_mm
              ,clog_dd
              ,rank() over(partition by clog_yyyy, clog_mm
                            order by clog_ymd desc ) rk
         from ad01clog 
          where clog_yyyy= substr( '20210301',0,4)
          and clog_mm =substr( '20210301',5,2)
          and clog_ymd <= '20210301'  
          ) t
         where 1=1   
         and t.rk=1 )  dd
,(select t.clog_dd      
        from 
        (select clog_ymd
              ,clog_yyyy
              ,clog_mm
              ,clog_dd
              ,rank() over(partition by clog_yyyy, clog_mm
                            order by clog_ymd desc ) rk
         from ad01clog 
          where clog_yyyy= substr( '20210301',0,4)
          and clog_mm =substr( '20210301',5,2)
          and clog_ymd <= '20210301'  
          ) t
         where 1=1   
         and t.rk=2 )  befo_dd         
from (select '20210301' as stdd_ymd
      from dual ) a
;     
       
       
       select t.clog_dd      
        from 
        (select clog_ymd
              ,clog_yyyy
              ,clog_mm
              ,clog_dd
              ,rank() over(partition by clog_yyyy, clog_mm
                            order by clog_ymd desc ) rk
         from ad01clog 
         where clog_yyyy='2021'
         and clog_mm ='03'
         and clog_ymd <=  '20210321'   
          ) t
         where 1=1 
         and t.rk=1 
         ;
         
         select clog_ymd
              ,clog_yyyy
              ,clog_mm
              ,clog_dd
              ,rank() over(partition by clog_yyyy, clog_mm
                            order by clog_ymd desc ) rk
         from ad01clog;