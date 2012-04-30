/*
	File Name	: sp_piss010i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss010i_01
	Description	: 입고확정
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss020u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss020u_01]
GO

/*
Exec sp_piss020u_01 @ps_areacode       = 'D',
		  @ps_divisioncode   = 'H'
*/

/****** Object:  Stored Procedure dbo.sp_s_0010    Script Date: 02-08-26  ******/
CREATE PROCEDURE sp_piss020u_01
              @ps_areacode            char(1),         --지역
              @ps_divisioncode        char(1)         --공장

AS

BEGIN

  SELECT PrdDate	= A.PrdDate,   
         WorkCenter	= A.WorkCenter,   
         ItemCode	= A.ItemCode,   
         ItemName	= B.ItemName,   
         ModelId	= B.ModelID,   
         KBNo		= A.KBNo,   
         KBQty		= A.RackQty,
         DivisionCode   = A.DivisionCode 
    FROM TKB A,   
         vmstkb_model B
   WHERE (A.KBStatusCode = 'C') 
     and (A.AreaCode 	 = @ps_areacode) 
     and (A.DivisionCode like @ps_divisioncode)
     and (A.AreaCode     = B.AreaCode)
     and (A.DivisionCode = B.DivisionCode)
     and (A.ItemCode     = B.ItemCode) 
     and ((A.inspectgubun = 'Y') or (a.stockgubun = 'Y'))
END 


GO
