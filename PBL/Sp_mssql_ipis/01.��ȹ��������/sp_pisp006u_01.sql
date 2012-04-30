/*
	File Name	: sp_pisp006u_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp006u_01
	Description	: 간판 발행을 위한 간판 정보 조회
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 17
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp006u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp006u_01]
GO

/*
Execute sp_pisp006u_01
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '4201',
	@ps_linecode		= 'A',
	@ps_itemcode		= '001',
	@ps_tempgubun		= 'T'

select * from tmstkb where itemcode = '001'
select * from tkb where itemcode = '001'

delete tkb where itemcode = '511513' and tempgubun = 'T'

Update	tmstline
Set	MaxCycleGubun	= 'N',
	CycleCount	= 1
*/

Create Procedure sp_pisp006u_01
	@ps_areacode		char(1),		-- 지역 코드
	@ps_divisioncode	char(1),		-- 공장 코드
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1),
	@ps_itemcode		varchar(12),
	@ps_tempgubun		char(1)
As
Begin


Select	AreaCode		= A.AreaCode,		-- 지역코드
	DivisionCode		= A.DivisionCode,		-- 공장
	WorkCenter		= A.WorkCenter,		-- Work Center
	LineCode		= A.LineCode,		-- 라인
	ItemCode		= A.ItemCode,		-- 품번
	ItemName		= C.ItemName,		-- 품명
	ModelID			= A.ModelID,		-- 배번호
	ApplyFrom		= A.ApplyFrom,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= Case	When A.ProductGubun = 'P'	Then '계획생산'
					When A.ProductGubun = 'R'	Then '후보충생산'
					Else 'OEM생산'
				   End,
	KBNo			= B.KBNo,
	RackQty			= Case	When B.KBNo Is Null	Then A.RackQty
					Else B.RackQty
				   End,
	NormalKBSN		= A.NormalKBSN,
	TempKBSN		= A.TempKBSN,
	KBCount			= Case	When B.KBNo Is Null	Then 0
					Else 1
				   End,
	KBStatusCode		= B.KBStatusCode,
	KBStatusCodeName	= Case	When B.KBActiveGubun = 'A'	Then
						Case	When B.KBStatusCode = 'A'	Then '지시'
							When B.KBStatusCode = 'B'	Then '착수'
							When B.KBStatusCode = 'C'	Then '완료'
							When B.KBStatusCode = 'D'	Then '입고'
							When B.KBStatusCode = 'E'	Then '출하'
							When b.KBStatusCode = 'F'	Then '회수'
						Else ''
						End
				   Else ''
				   End
From	tmstkb		A,
	tkb		B,
	tmstitem		C
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode	And
	A.WorkCenter	= @ps_workcenter	And
	A.LineCode	= @ps_linecode		And
	A.ItemCode	= @ps_itemcode		And
	A.PrdStopGubun	= 'N'			And
	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.WorkCenter	*= B.WorkCenter		And
	A.LineCode	*= B.LineCode		And
	A.ItemCode	*= B.ItemCode		And
	A.ItemCode	*= C.ItemCode		And
	B.TempGubun	= @ps_tempgubun

Return

End		-- Procedure End
Go
