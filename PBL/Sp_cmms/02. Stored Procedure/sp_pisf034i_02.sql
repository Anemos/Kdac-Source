/*
  file name : sp_pisf034i_02.sql
  system    : cmms system
  procedure name  : sp_pisf034i_02
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_pisf034i_02]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_pisf034i_02]
go

------------------------------------------------------------------
--  사급품반출증발행번호별 간판리스트
------------------------------------------------------------------

/*
execute sp_pisf034i_02
*/

create PROCEDURE [dbo].[sp_pisf034i_02]
    @ps_buybackno Char(11)  -- 반출증번호
AS
BEGIN
  SELECT  A.Part_Code,
          B.Part_Name,
          B.Part_Spec,
    B.Part_Unit,
    A.Part_Used,
    A.Out_Date,
    A.Out_Qty
    FROM  PART_OUT    A,
          PART_MASTER B
   WHERE  A.BuyBackNo     = @ps_buybackno and
          A.Area_Code     = B.Area_Code     and
          A.Factory_Code    = B.Factory_Code  and
          A.Part_Code     = B.Part_Code
END