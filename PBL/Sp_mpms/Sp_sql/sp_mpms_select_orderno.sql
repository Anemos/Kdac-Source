/*
	File Name	: sp_mpms_select_orderno.SQL
	SYSTEM		: 금형공정관리 시스템
	Procedure Name	: sp_mpms_select_orderno
	Description	: Order No 가져오기
	Use DataBase	: MPMS
	Use Program	: @ps_option - '1':진행, '2':완료, '3':불량, '4':Set품
	Use Table	: torder
	Initial		: 2004.03.31
	Author		: Kiss Kim
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_mpms_select_orderno]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_mpms_select_orderno]
GO

/*
Execute sp_mpms_select_orderno '1'
*/

Create Procedure sp_mpms_select_orderno
  @ps_option char(1)

As
Begin

if @ps_option = '1'
  Begin
    Select	OrderNo	= A.OrderNo,
	    ToolName	= A.ToolName,
	    DisplayName	= A.ToolName + '(' + A.OrderNo + ')'
    From	torder		A
    Where	isnull(A.IngStatus,'') <> 'C'
    Order By A.OrderNo Desc
  End
if @ps_option = '2'
  Begin
    Select	OrderNo	= A.OrderNo,
	    ToolName	= A.ToolName,
	    DisplayName	= A.ToolName + '(' + A.OrderNo + ')'
    From	torder		A
    Where	isnull(A.IngStatus,'') = 'C'
    Order By A.OrderNo Desc
  End
if @ps_option = '3'
  Begin
    Select	OrderNo	= A.OrderNo,
	    ToolName	= A.ToolName,
	    DisplayName	= A.ToolName + '(' + A.OrderNo + ')'
    From	torder		A inner join tbadhead B
      on A.OrderNo = B.OrderNo
    Where	isnull(A.IngStatus,'') <> 'C'
    Order By A.OrderNo Desc
  End
if @ps_option = '4'
  Begin
    Select	OrderNo	= A.OrderNo,
	    ToolName	= A.ToolName,
	    DisplayName	= A.ToolName + '(' + A.OrderNo + ')'
    From	torder		A
    Where	isnull(A.IngStatus,'') = 'C' AND A.AssetFlag = 'A'
    Order By A.OrderNo Desc
  End
if @ps_option = '5'
  Begin
    Select	Distinct OrderNo	= A.OrderNo,
	    ToolName	= A.ToolName,
	    DisplayName	= A.ToolName + '(' + A.OrderNo + ')'
    From	torder		A inner join toutprocess B
      on A.OrderNo = B.OrderNo
    Order By A.OrderNo Desc
  End
Return

End		-- Procedure End

Go
