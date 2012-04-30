/*
  File Name : sp_pisf034i_02.sql
  SYSTEM    : CMMS System
  Procedure Name  : sp_pisf034i_02
  Description : 사급품반출증발행번호별 간판리스트
  Use DataBase  : CMMS
  Use Program :
  Parameter : 
  Use Table :
  Initial   : 2005.05
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_pisf034i_02]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_pisf034i_02]
GO

/*
Execute sp_pisf034i_02 ' '
*/

Create Procedure sp_pisf034i_02
  @ps_buybackno	Char(11)	-- 반출증번호

As
Begin

SELECT 	A.Part_Code,   
         	B.Part_Name,   
         	B.Part_Spec,
		B.Part_Unit,
		A.Part_Used,
		A.Out_Date,
		A.Out_Qty
    FROM 	PART_OUT		A,   
         	PART_MASTER	B
   WHERE 	A.BuyBackNo 		= @ps_buybackno	and  
         	A.Area_Code 		= B.Area_Code 		and  
         	A.Factory_Code 		= B.Factory_Code 	and    
         	A.Part_Code 		= B.Part_Code

End   -- Procedure End
Go
