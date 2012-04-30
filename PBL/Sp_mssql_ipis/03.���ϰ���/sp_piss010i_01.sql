/*
	File Name	: sp_piss010i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss010i_01
	Description	: 입고대기현황
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss010i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss010i_01]
GO

/*
Exec sp_piss010i_01 @ps_areacode       = 'D',
		    @ps_divisioncode   = 'A',
                    @ps_workcenter     = '%',
                    @ps_linecode       = '%'
*/


CREATE PROCEDURE sp_piss010i_01
              @ps_areacode            char(1),        --지역
              @ps_divisioncode        char(1),         --공장
              @ps_workcenter          varchar(05),
              @ps_linecode            char(01)

AS

BEGIN
  select areacode,divisioncode,itemcode,itemname,modelid
    into #tmp_vmstmodel
    from vmstmodel
   where areacode = @ps_areacode
     and divisioncode = @ps_divisioncode

  SELECT PrdDate	= convert(char(20),A.kbendtime,120),   
         WorkCenter	= A.WorkCenter,   
         ItemCode	= A.ItemCode,   
         ItemName	= C.ItemName,   
         ModelId	= B.ModelID,   
         KBNo		= A.KBNo,   
         KBQty		= A.RackQty,
         DivisionCode   = A.Divisioncode,
         kbreleasetime  = convert(char(20),a.kbreleasetime,120),
         lincode        = a.linecode
    FROM TKB A,   
         #tmp_vmstmodel B,
         TMSTITEM C
   WHERE (A.KBStatusCode = 'C') 
     and (A.AreaCode 	 = @ps_areacode) 
     and (A.DivisionCode like @ps_divisioncode)
     and (A.AreaCode     = B.AreaCode)
     and (A.DivisionCode = B.DivisionCode)
     and (A.ItemCode     = B.ItemCode) 
     AND (A.ITEMCODE     = C.ITEMCODE)
     and ((A.inspectgubun = 'Y') or (a.stockgubun = 'Y'))
     and (a.workcenter   like @ps_workcenter)
     and (a.linecode     like @ps_linecode)
order by a.kbreleasetime

drop table #tmp_vmstmodel

END 


GO
