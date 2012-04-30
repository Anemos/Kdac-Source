/*
	File Name	: sp_piss280u_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss280u_01
	Description	: 편수마스타관리
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss280u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss280u_01]
GO
/*
Exec sp_piss280u_01 @ps_areacode    = 'D',
                    @ps_divisioncode = 'A',
                    @ps_custcode       = 'D00001'
*/

/****** Object:  Stored Procedure dbo.sp_s_0010    Script Date: 02-08-26  ******/
CREATE PROCEDURE sp_piss280u_01
                 @ps_areacode            char(01),
                 @ps_divisioncode        char(01),
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
        and areacode   = @ps_areacode
        and divisioncode = @ps_divisioncode
     insert into #tmp_tmsteditno
        values(@li_i,@ls_shiparrivetime)
     select @li_i = @li_i + 1
end 
select * from #tmp_tmsteditno

drop table #tmp_tmsteditno
        
END 


GO
