select * from tmstmodel where areacode ='D' and divisioncode ='A'
/*
	File Name	: sp_piss310i_02.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss310i_02
	Description	: 현품표재발행
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss310i_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss310i_02]
GO
/*
exec sp_piss310i_02 @ps_areacode      = 'D',         -- 지역구분
                    @ps_divisioncode  = 'A',         -- 공장코드
	            @ps_kbno          = 'DAZ02100009'    -- 간판번호

*/
CREATE PROCEDURE sp_piss310i_02
	@ps_areacode       char(01),  -- 지역구분
        @ps_divisioncode   char(01),  -- 공장코드
        @ps_kbno           char(11)   -- 간펀번호
AS

BEGIN

 SELECT areacode     = a.areacode,
        areaname     = c.areaname,
        divisioncode = a.divisioncode,
        divisionname = d.divisionname,
        kbno         = A.kbno,
        itemcode     = a.itemcode,
        itemname     = case isnull(e.itemname,'') when '' then (select itemname from tmstitem where itemcode = a.itemcode) 
                                                  else e.itemname end ,
        modelid      = b.modelid,
        rackqty      = a.rackqty,
        kbstatuscode = case a.invgubunflag when 'N' then '정품'
                                           when 'R' then '요수리'
                                           when 'D' then '폐품'
                                           else ''
                       end ,
        RePrint      = 0
    FROM tkb   A,
	 vmstmodel B,
         tmstarea c,
         tmstdivision d,
         tmstitem e
   Where A.tempgubun = 'T'
     and A.AreaCode     = @ps_areacode
     and A.DivisionCode = @ps_divisioncode
     and A.kbno = @ps_kbno
     and a.areacode  *= b.areacode
     and a.divisioncode *= b.divisioncode
     and a.itemcode  *= b.itemcode
     and a.areacode = c.areacode
     and a.areacode = d.areacode
     and a.divisioncode = d.divisioncode
     and a.itemcode *= e.itemcode

end




GO
