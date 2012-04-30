/*
	File Name	: sp_pisp241u_03.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp241u_03
	Description	: 간판 번호 발행 - 인쇄을 위한 간판번호별 조회
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 10
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp241u_03]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp241u_03]
GO

/*
Execute sp_pisp241u_03
	@ps_kbno_1	= 'DA010001001',
	@ps_kbno_2	= 'DA010001002',
	@ps_kbno_3	= 'DA010001X01'

select * from tcalendarwork
select * from tplanday


dbcc opentran

*/

Create Procedure sp_pisp241u_03
	@ps_kbno_1		varchar(11),
	@ps_kbno_2		varchar(11),
	@ps_kbno_3		varchar(11)

As
Begin

Select	AreaCode		= B.AreaCode,		-- 지역코드
	AreaName		= B.AreaName,		-- 지역 명
	DivisionCode		= B.DivisionCode,		-- 공장
	DivisionName		= B.DivisionName + ' ' + B.WorkCenterName + ' ' + B.WorkCenter,	-- 공장명
	WorkCenter		= B.WorkCenter,		-- Work Center
	WorkCenterName		= B.WorkCenterName,	-- Work Center 명
	LineCode		= B.LineCode,		-- 라인
	LineShortName		= B.LineShortName,	-- 라인 약명
	LineFullName		= B.LineFullName,		-- 라인 전명
	ItemCode		= B.ItemCode,		-- 품번
	ItemName		= B.ItemName,		-- 품명
	ModelID			= B.ModelID,		-- 배번호
	KBNo			= A.KBNo,
	KBNo_BarCode		= '*' + A.KBNo + '*',
	RackQty			= A.RackQty,
	CarName		= Case	When A.TempGubun = 'N'		Then B.CarName
					Else B.CarName + '  (임시)'
				   End,
	RackCode		= B.RackCode,
	RackName		= '',
	StockLocation		= B.StockLocation,
	PrintDate		= Convert(char(10), GetDate(), 102),
	PrintCount		= A.PrintCount + 1,

	ProductGubun		= B.ProductGubun,
	ProductGubunName	= Case	When B.ProductGubun = 'P'	Then '계획생산품'
					When B.ProductGubun = 'R'	Then '후보충생산품'
					Else 'OEM생산품'
				   End,
	TempGubun		= A.TempGubun,
	TempGubunName	= Case	When A.TempGubun = 'N'	Then '정규'
					Else '임시'
				   End
From	tkb		A,
	vmstkb_line	B
Where	KBNo		In (@ps_kbno_1, @ps_kbno_2, @ps_kbno_3)	And
	A.AreaCode	= B.AreaCode				And
	A.DivisionCode	= B.DivisionCode				And
	A.WorkCenter	= B.WorkCenter				And
	A.LineCode	= B.LineCode				And
	A.ItemCode	= B.ItemCode

Return

End		-- Procedure End
Go
