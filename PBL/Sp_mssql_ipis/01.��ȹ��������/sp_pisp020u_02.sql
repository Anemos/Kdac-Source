/*
	File Name	: sp_pisp020u_02.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp020u_02
	Description	: Work Calendar �� ���� �۾����ں� �ٹ� ���� ��ȸ
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 19. 03
	Author		: Kim Jin-Su
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp020u_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp020u_02]
GO

/*
Execute sp_pisp020u_02 '2002.09', 'D', 'A', '4201', 'A'
*/

Create Procedure sp_pisp020u_02
	@ps_applymonth		char(7),		-- ��ȹ�� ('YYYY.MM')
	@ps_areacode		char(1),		-- ���� �ڵ�
	@ps_divisioncode	char(1),		-- ���� �ڵ�
	@ps_workcenter		varchar(5),	-- �� �ڵ�
	@ps_linecode		varchar(1)	-- ���� �ڵ�
As
Begin

Select	ApplyDate	= A.ApplyDate,
	DayNo		= A.DayNo,
	WorkGubun	= A.WorkGubun
From	tcalendarwork	A
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode	And
	A.WorkCenter	= @ps_workcenter	And
	A.LineCode	= @ps_linecode		And
	A.ApplyMonth	= @ps_applymonth
Group By A.ApplyDate, A.DayNo, A.WorkGubun
Order By A.ApplyDate

Return

End		-- Procedure End
Go
