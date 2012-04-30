/*
	File Name	: sp_pisp241u_03.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp241u_03
	Description	: ���� ��ȣ ���� - �μ��� ���� ���ǹ�ȣ�� ��ȸ
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

Select	AreaCode		= B.AreaCode,		-- �����ڵ�
	AreaName		= B.AreaName,		-- ���� ��
	DivisionCode		= B.DivisionCode,		-- ����
	DivisionName		= B.DivisionName + ' ' + B.WorkCenterName + ' ' + B.WorkCenter,	-- �����
	WorkCenter		= B.WorkCenter,		-- Work Center
	WorkCenterName		= B.WorkCenterName,	-- Work Center ��
	LineCode		= B.LineCode,		-- ����
	LineShortName		= B.LineShortName,	-- ���� ���
	LineFullName		= B.LineFullName,		-- ���� ����
	ItemCode		= B.ItemCode,		-- ǰ��
	ItemName		= B.ItemName,		-- ǰ��
	ModelID			= B.ModelID,		-- ���ȣ
	KBNo			= A.KBNo,
	KBNo_BarCode		= '*' + A.KBNo + '*',
	RackQty			= A.RackQty,
	CarName		= Case	When A.TempGubun = 'N'		Then B.CarName
					Else B.CarName + '  (�ӽ�)'
				   End,
	RackCode		= B.RackCode,
	RackName		= '',
	StockLocation		= B.StockLocation,
	PrintDate		= Convert(char(10), GetDate(), 102),
	PrintCount		= A.PrintCount + 1,

	ProductGubun		= B.ProductGubun,
	ProductGubunName	= Case	When B.ProductGubun = 'P'	Then '��ȹ����ǰ'
					When B.ProductGubun = 'R'	Then '�ĺ������ǰ'
					Else 'OEM����ǰ'
				   End,
	TempGubun		= A.TempGubun,
	TempGubunName	= Case	When A.TempGubun = 'N'	Then '����'
					Else '�ӽ�'
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
