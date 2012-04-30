/*
	File Name	: sp_pisp002u_01_u.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp002u_01_u
	Description	: ���� ���� ��ȹ ���
			  ���������ȹ(tplanmonth) �� ���ϻ����ȹ���� ����Ѵ�.
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 16
	Author		: Kim Jin-Su
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp002u_01_u]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp002u_01_u]
GO

/*
Execute sp_pisp002u_01_u
	@ps_option		= 'S',
	@ps_planmonth		= '2002.11',
	@ps_areacode		= 'J',
	@ps_divisioncode	= 'M',
	@ps_productgroup	= '%',
	@ps_modelgroup		= '%',
	@ps_itemcode		= '%',
	@ps_empcode		= 'KJS'

select * from tplanday
delete tplanday
select * from tplanmonth

2002.09.02 D    A    4201  A    511513       600         600         IPIS

update tplanday
set changeqty = 100
where itemcode in ('10456266A', '10456267A')

select *
from tsrorder
where itemcode in ('10456266A',
'10456267A',
'511513',
'511514',
'511517')
*/

Create Procedure sp_pisp002u_01_u
	@ps_option		char(1),		-- Scheduling Option('F' : First, 'S' : After First)
	@ps_planmonth		char(7),		-- ��ȹ�� ('YYYY.MM')
	@ps_areacode		char(1),		-- ���� �ڵ�
	@ps_divisioncode	char(1),		-- ���� �ڵ�
	@ps_productgroup	varchar(2),	-- ��ǰ��
	@ps_modelgroup		varchar(3),	-- �𵨱�
	@ps_itemcode		varchar(12),	-- ǰ��
	@ps_empcode		varchar(6)	-- ���������۾���

As
Begin

Declare	@ls_tomorrow		char(10),	-- ����
	@ls_divisioncode		char(1),		-- ����
	@i			Int,
	@li_loop_count		Int,
	@ls_error		varchar(2),	-- Transaction ���� ���� ��
	@ls_errortext		varchar(100)	-- Transaction ���� ���� ����

Select	@ls_tomorrow	= Convert(char(10), DateAdd(Day, 1, GetDate()), 102)
				
 -- ������ ��ȹ�� ���� �� �ʿ� ����.
If Left(@ls_tomorrow, 7) > @ps_planmonth
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '���� ���� ���ϻ����ȹ�� ����Ͻ� �� �����ϴ�.'

	Select	Error		= @ls_error,
		ErrorText	= @ls_errortext

	Return
End

-- ���� ���� ���ϻ����ȹ�� ���ϴ� ���� ����...
If @ps_option = 'F'
Begin
	Select	@ps_empcode		= 'IPIS'
End
Else
Begin
	Select	@ps_empcode		= @ps_empcode
End

Select	AreaCode,
	DivisionCode
Into	#tmp_division
From	tmstdivision
Where	AreaCode	= @ps_areacode		And
	DivisionCode	Like @ps_divisioncode
Order By AreaCode, DivisionCode

Select @i = 0, @li_loop_count = @@RowCount, @ls_divisioncode = ''

--select * from #tmp_division

-- Transaction ����
--Begin Tran

While @i < @li_loop_count
Begin
	Select	Top 1
		@ls_error	= '11',
		@i		= @i + 1,
		@ls_divisioncode	= DivisionCode
	From	#tmp_division
	Where	AreaCode	= @ps_areacode		And
		DivisionCode	> @ls_divisioncode


	Execute sp_pisp002u_01_u_01
		@ps_option,				-- Scheduling Option('F' : First, 'S' : After First)
		@ps_planmonth,				-- ��ȹ�� ('YYYY.MM')
		@ps_areacode,				-- ���� �ڵ�
		@ls_divisioncode,			-- ���� �ڵ�
		@ps_productgroup,			-- ��ǰ��
		@ps_modelgroup,			-- �𵨱�
		@ps_itemcode,				-- ǰ��
		@ps_empcode,				-- ���������۾���
		@ls_error		output,		-- ����
		@ls_errortext		output		-- ���� ����

-- Error ���� ���� Transaction ����	
	If @ls_error = '00'
	Begin
		Select @ls_error	= '00'
	End
	Else
	Begin
		GoTo Proc_Exit
	End
End			-- While Loop End

Proc_Exit:

/*
If @ls_error = '00'
	Commit Tran
Else
Begin
	RollBack Tran
End
*/

Drop Table #tmp_division

Select	Error		= @ls_error,
	ErrorText	= @ls_errortext

Return
End