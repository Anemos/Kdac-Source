/*
  File Name : sp_pisr135i_02.sql
  SYSTEM    : 외주간판 System
  Procedure Name  : sp_pisr135i_02
  Description : 사급품반출증발행번호별 간판리스트
  Use DataBase  : IPIS
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2005.05
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_pisr135i_02]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_pisr135i_02]
GO

/*
Execute sp_pisr135i_02
*/

Create Procedure sp_pisr135i_02
 		@ps_buybackno	Char(11),	-- 반출증번호
 		@ps_applydate		Char(10)	-- 반출일자
AS
BEGIN
  SELECT 	PartKBNo = A.PartKBNo,
    ItemCode = A.ItemCode,
    PartType = A.PartType,
    RackQty = A.RackQty,
    ItemName = C.ItemName,
    ItemSpec = C.ItemSpec,
    ItemUnit = C.ItemUnit,
    CostGubun = B.CostGubun,
	  PartOrderTime = A.PartOrderTime
  FROM 	TPARTKBHIS		A,
    TMSTPARTKBHIS	B,
    TMSTITEM		C
  WHERE A.BuyBackNo = @ps_buybackno	and
		A.PartKBStatus 	= 'C'			and
    A.AreaCode 		= B.AreaCode 		and
    A.DivisionCode 		= B.DivisionCode 	and
    A.SupplierCode 		= B.SupplierCode 	and
    A.ItemCode 		= B.ItemCode 		and
    @ps_applydate 		>= B.ApplyFrom 		and
    @ps_applydate 		<= B.ApplyTo 		and
    A.ItemCode 		= C.ItemCode
END

