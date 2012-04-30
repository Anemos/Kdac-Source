/*
Exec sp_piss280i_01 @ps_custcode       = 'D00001'
*/

/****** Object:  Stored Procedure dbo.sp_s_0010    Script Date: 02-08-26  ******/
CREATE PROCEDURE sp_piss280i_01
	      @ps_custcode            char(06)    --거래처코드

AS

BEGIN
Create Table #Tmp_tmsteditno
(
	shipeditno	Int,
	ShiparriveTime	datetime
)
Declare	@li_i		Int,
        @ls_shiparrivetime datetime

select @li_i = 1

While @li_i < 26
begin
      select @ls_shiparrivetime = ''
--      select @ls_shiparrivetime = convert(char(5),shiparrivetime , 108)
      select @ls_shiparrivetime = shiparrivetime
       from tmsteditno
      where custcode = @ps_custcode
        and shipeditno = @li_i
     insert into #tmp_tmsteditno
        values(@li_i,@ls_shiparrivetime)
     select @li_i = @li_i + 1
end 
select * from #tmp_tmsteditno

drop table #tmp_tmsteditno
        
END 


GO
