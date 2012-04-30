/*
	File Name	: sp_pisp211u_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp211u_01
	Description	: 간판 마스터 추가 및 변경 - 등록 가능 제품 조회
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 03
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp211u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp211u_01]
GO

/*
Execute sp_pisp211u_01
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '4201',
	@ps_linecode		= 'A'

select * from tplanrelease
where prdflag = 'E'

dbcc opentran

*/

Create Procedure sp_pisp211u_01
	@ps_areacode		char(1),		-- 지역 코드
	@ps_divisioncode	char(1),		-- 공장 코드
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1)

As
Begin

Select	ItemCode	= A.ItemCode,
	ItemName	= A.ItemName,
	PossibleFlag	= 'Y'
Into	#tmp_item
From	vmstmodel	A
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode	And
	A.ItemCode	Not In(Select	ItemCode	= A.ItemCode
				From	tmstkb		A
				Where	A.AreaCode	= @ps_areacode		And
					A.DivisionCode	= @ps_divisioncode	And
					A.WorkCenter	= @ps_workcenter	And
					A.LineCode	= @ps_linecode
				Group By A.ItemCode)
Group By A.ItemCode, A.ItemName

Insert	#tmp_item
Select	ItemCode	= A.ItemCode,
	ItemName	= B.ItemName,
	PossibleFlag	= 'N'
From	tmstkb		A,
	tmstitem		B
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode	And
	A.WorkCenter	= @ps_workcenter	And
	A.LineCode	= @ps_linecode		And
	A.ItemCode	= B.ItemCode
Group By A.ItemCode, B.ItemName

Select	SortOrder		= 0,
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	PossibleFlag		= A.PossibleFlag,
	ModelID			= B.ModelID,
	ProductGubun		= B.ProductGubun,
	ProductGubunName	= Case	When B.ProductGubun = 'P'	Then '계획생산'
					When B.ProductGubun = 'R'	Then '후보충생산'
					When B.ProductGubun = 'O'	Then '후보충생산'
					Else ''
				   End,
	RackQty			= IsNull(B.RackQty, 0)
From	#tmp_item	A,
	tmstkb		B
Where	A.ItemCode	*= B.ItemCode
Group By A.PossibleFlag, A.ItemCode, A.ItemName, B.ModelID, B.ProductGubun, B.RackQty
Order By A.PossibleFlag Desc, A.ItemCode

Drop Table #tmp_item
--Drop Table #tmp_kb

Return

End		-- Procedure End
Go
