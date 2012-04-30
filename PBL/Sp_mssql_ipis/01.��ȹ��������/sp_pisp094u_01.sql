/*
	File Name	: sp_pisp094u_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp094u_01
	Description	: 조립 지시 -  임시간판 발행
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 25
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp094u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp094u_01]
GO

/*
Execute sp_pisp094u_01

select * from tplanrelease
where prdflag = 'E'

dbcc opentran

*/

Create Procedure sp_pisp094u_01

As
Begin

Select	AreaCode		= '',
	AreaName		= '',
	DivisionCode		= '',
	DivisionName		= '',
	WorkCenter		= '',
	WorkCenterName		= '',
	LineCode		= '',
	LineShortName		= '',
	LineFullName		= '',
	ItemCode		= '',
	ItemName		= '',
	ModelID			= '',
	ProductGubun		= '',
	ProductGubunName	= '',
	RackQty			= 0,
	TempKBSN		= ''

Return

End		-- Procedure End
Go
