SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr161i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr161i_01]
GO


------------------------------------------------
--    개별간판 이력출력 화면( 간판목록 )
------------------------------------------------

CREATE Procedure sp_pisr161i_01
            @ps_partkbno	Char(11)	--간판번호 
As
Begin

Set NoCount ON

  Select	A.PartKBNo,   
         	A.AreaCode,   
	B.AreaName,
         	A.DivisionCode,   
         	C.DivisionName,   
         	A.SupplierCode,   
         	D.SupplierKorName,   
         	D.SupplierNo,   
        	A.ItemCode,   
        	E.ItemName,   
        	E.ItemSpec,   
         	A.PartKBGubun   
    From 	TPARTKBSTATUS	A,
	TMSTAREA		B,
	TMSTDIVISION   	C,
	TMSTSUPPLIER	D,
	TMSTITEM		E
 Where 	A.PartKBNo 	= @ps_partkbno		And
	A.AreaCode	= B.AreaCode		And
	A.AreaCode	= C.AreaCode		And
	A.DivisionCode	= C.DivisionCode	And
	A.SupplierCode	= D.SupplierCode	And
	A.ItemCode	= E.ItemCode	


Set NoCount Off

End				-- Procedure End
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

