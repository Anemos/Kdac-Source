/*
  File Name : sp_pisf034u_01.sql
  SYSTEM    : CMMS System
  Procedure Name  : sp_pisf034u_01
  Description : 공부자재반출증작성 리스트 ( new : 2003.07.15 )
  Use DataBase  : CMMS
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2005.05
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_pisf034u_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_pisf034u_01]
GO

/*
Execute sp_pisf034u_01 ' '
*/

Create Procedure sp_pisf034u_01
   @ps_areacode   Char(1),    -- 지역코드
    @ps_divcode   Char(1),    -- 공장코드
    @ps_suppcode    VarChar(7), -- 반출처 코드
    @ps_buybackNo  VarChar(11) -- 반출증 발행번호

As
Begin

 SELECT   A.Area_Code ,
    A.Factory_Code,
    A.Dept_Code,
    A.Part_Code,
    B.Part_Name,
    B.Part_Spec,
    A.Part_Used,
    convert(char(8),A.Out_Date,112) As OutDate,
    A.Out_Qty,
    case A.BuyBackNo when @ps_buybackNo then 1 else 0 end  As SelectChk,
      A.BuyBackFlag ,
      A.Part_Tag,
      A.BuyBackNo
FROM  PART_OUT    A,  PART_MASTER   B
WHERE A.Area_Code   = @ps_areacode  And
    A.Factory_Code    = @ps_divcode And
    ( A.Part_Used = '04' or A.Part_Used = '07' )  And
    A.Dept_Code   like @ps_suppcode And
    ( isNull(A.BuyBackNo, '')   = ''  Or A.BuyBackNo = @ps_buybackNo ) And
    A.Area_Code   = B.Area_Code   And
    A.Factory_Code    = B.Factory_Code  And
    A.Part_Code = B.Part_Code

End   -- Procedure End
Go
