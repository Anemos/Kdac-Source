SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr050p_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr050p_01]
GO



------------------------------------------------------------------
--        		외주간판출력
------------------------------------------------------------------
CREATE  PROCEDURE sp_pisr050p_01
 	@ps_partkbNo1	 	Char(11),   	-- 간판번호
 	@ps_partkbNo2	 	Char(11),   	-- 간판번호
 	@ps_partkbNo3	 	Char(11),   	-- 간판번호
 	@ps_partkbNo4	 	Char(11)   	-- 간판번호
AS
BEGIN

Set NoCount ON

Declare	@ls_MaxDate		char(10)		-- 년도 Type 의 최대치

select 	@ls_MaxDate = '9999.12.31'

SELECT  	A.PartKBNo ,
           		A.AreaCode ,
           		C.AreaName ,
           		A.DivisionCode ,
           		D.DivisionName ,
           		A.SupplierCode ,
           		E.SupplierKorName ,
           		H.ProductGroup ,
           		I.ProductGroupName ,
           		A.ItemCode ,
           		G.ItemName ,
           		G.ItemSpec ,
           		F.SupplyTerm ,
           		F.SupplyEditNo ,
           		F.SupplyCycle ,
           		B.PartType ,
           		B.MailBoxNo ,
           		B.ReceiptLocation ,
           		Case When A.PartKBGubun = 'T' Then A.RackQty Else B.RackQty End  As RackQty,
           		B.PartModelID ,
           		B.RackCode ,
           		A.RePrintFlag ,
           		A.RePrintCount ,
           		A.PartKBPrintDate ,
           		A.LastEmp ,
           		A.LastDate     
  FROM 	TPARTKBSTATUS 	A,
           		TMSTPARTKB	 	B,
           		TMSTAREA 		C,
           		TMSTDIVISION 	D,
           		TMSTSUPPLIER 	E,
           		TMSTPARTCYCLE 	F,
           		TMSTITEM 		G,
		TMSTMODEL		H,
		TMSTPRODUCTGROUP	I
WHERE	A.PartKBNo		In( @ps_partkbNo1, @ps_partkbNo2, @ps_partkbNo3, @ps_partkbNo4 )	And

		A.AreaCode		= B.AreaCode		And
		A.DivisionCode		= B.DivisionCode	And
		A.SupplierCode		= B.SupplierCode	And
		A.ItemCode		= B.ItemCode		And

		A.AreaCode		= C.AreaCode		And

		A.AreaCode		= D.AreaCode		And
		A.DivisionCode		= D.DivisionCode	And

		A.SupplierCode		= E.SupplierCode	And

		A.AreaCode		= F.AreaCode		And
		A.DivisionCode		= F.DivisionCode	And
		A.SupplierCode		= F.SupplierCode	And
		F.ApplyTo		= @ls_MaxDate		And

		A.ItemCode		= G.ItemCode		And

		A.AreaCode		= H.AreaCode		And
		A.DivisionCode		= H.DivisionCode	And
		A.ItemCode		= H.ItemCode		And

		A.AreaCode		= I.AreaCode		And
		A.DivisionCode		= I.DivisionCode		And
		H.ProductGroup		= I.ProductGroup	

Set NoCount Off

End
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

