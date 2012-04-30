/*
	File Name	: sp_piss310i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss310i_01
	Description	: 현품표재발행
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss310i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss310i_01]
GO
/*
exec sp_piss310i_01 @ps_areacode      = 'D',            -- 지역구분
                    @ps_divisioncode  = '%',            -- 공장코드
	            @ps_date          = '2002.10.01',    -- 발행년월
	            @ps_date1         = '2002.10.01',    -- 발행년월

*/
CREATE PROCEDURE sp_piss310i_01
	@ps_areacode       char(01),  -- 지역구분
        @ps_divisioncode   char(01),  -- 공장코드
	@ps_date	   char(10),   -- 발행년월
	@ps_date1          char(10)   -- 발행년월
AS

BEGIN

 SELECT divisioncode = a.divisioncode,
        kbno         = A.kbno,
        itemcode     = a.itemcode,
        itemname     = c.itemname,
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
         tmstitem c
   Where A.tempgubun = 'T'
     and A.AreaCode     = @ps_areacode
     and A.DivisionCode LIKE @ps_divisioncode
     and A.applyfrom    >= @ps_date
     and A.applyfrom    <= @ps_date1
     and substring(A.kbno,3,1) = 'Z'
     AND a.kbstatuscode = 'D'
     and a.areacode  *= b.areacode
     and a.divisioncode *= b.divisioncode
     and a.itemcode  *= b.itemcode
     and a.itemcode  = c.itemcode
end




GO
