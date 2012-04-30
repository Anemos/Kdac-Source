/*
	File Name	: sp_pisp251u_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp251u_01
	Description	: 간판 상태 전환 - 전환 저장한 간판 정보
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 10
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp251u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp251u_01]
GO

/*
Execute sp_pisp251u_01
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '4201',
	@ps_linecode		= 'A',
	@ps_itemcode		= '511513',
	@ps_kbactivegubun	= 'A'

select * from tcalendarwork
select * from tplanday


dbcc opentran

*/

Create Procedure sp_pisp251u_01
	@ps_areacode		char(1),		-- 지역 코드
	@ps_divisioncode	char(1),		-- 공장 코드
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1),
	@ps_itemcode		varchar(12),
	@ps_kbactivegubun	char(1)
As
Begin

Select	AreaCode		= A.AreaCode,		-- 지역코드
	DivisionCode		= A.DivisionCode,		-- 공장
	WorkCenter		= A.WorkCenter,		-- Work Center
	LineCode		= A.LineCode,		-- 라인
	ItemCode		= A.ItemCode,		-- 품번
	KBNo			= A.KBNo,
	KBStatusCode		= A.KBStatusCode,
	KBStatusCodeName	= Case	When A.KBActiveGubun = 'A'	Then
						Case	When A.KBStatusCode = 'A'	Then '지시'
							When A.KBStatusCode = 'B'	Then '착수'
							When A.KBStatusCode = 'C'	Then '완료'
							When A.KBStatusCode = 'D'	Then '입고'
							When A.KBStatusCode = 'E'	Then '출하'
							When A.KBStatusCode = 'F'	Then '회수'
						Else ''
						End
				   Else ''
				   End,
	TempGubun		= A.TempGubun,
	TempGubunName	= Case	When A.TempGubun = 'N'	Then '정규'
					Else '임시'
				   End,
	RackQty			= A.RackQty
From	tkb	A
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode	And
	A.WorkCenter	= @ps_workcenter	And
	A.LineCode	= @ps_linecode		And
	A.ItemCode	= @ps_itemcode		And
	A.KBActiveGubun	= @ps_kbactivegubun

Return

End		-- Procedure End
Go
