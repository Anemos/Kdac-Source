/*
	File Name	: sp_pisp002u_01_u_03.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp002u_01_u_03
	Description	: ���� ���� ��ȹ ��� - 03 ��°
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
	    Where id = object_id(N'[dbo].[sp_pisp002u_01_u_03]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp002u_01_u_03]
GO

/*
Declare	@ls_error		varchar(2),	-- Transaction ���� ���� ��
	@ls_errortext		varchar(30)	-- Transaction ���� ���� ����

Execute sp_pisp002u_01_u_03
	@ps_option		= 'F',
	@ps_planmonth		= '2002.09',
	@ps_plandate		= '2002.09.06',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '4201',
	@ps_linecode		= 'A',
	@ps_itemcode		= '%',
	@pi_rackqty		= 20,
	@pi_planqty		= 3000,
	@pi_changeqty		= 3000,
	@ps_last_workday	= '2002.09.18',
	@pi_work_count		= 10,
	@ps_empcode		= 'KJS',
	@ps_error		= @ls_error	output,
	@ps_errortext		= @ls_errortext	output

Select	@ls_error, @ls_errortext

select * from tplanmonth

select dividerate from tmstkb

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

Create Procedure sp_pisp002u_01_u_03
	@ps_plandate		char(10),
	@ps_areacode		char(1),		-- ���� �ڵ�
	@ps_divisioncode	char(1),		-- ���� �ڵ�
	@ps_workcenter		varchar(5),
	@ps_linecode		char(1),
	@ps_itemcode		varchar(12),	-- ǰ��
	@pi_planqty		int,
	@pi_changeqty		int,
	@ps_empcode		varchar(6),	-- ���������۾���
	@ps_error		varchar(2)	output,		-- ����
	@ps_errortext		varchar(100)	output		-- ���� ����

As
Begin

Declare	@li_rackqty		int,		-- ���� �����
	@li_normalkbcount	int,		-- ���� ���� �ż�
	@li_normalkbqty		int,		-- ���� ���� ����� �հ�
	@li_tempkbcount		int,		-- �ӽ� ���� �ż�
	@li_tempkbqty		int,		-- �ӽ� ���� ����� �հ�
	@ls_error		varchar(2),	-- Transaction ���� ���� ��
	@ls_errortext		varchar(100)	-- Transaction ���� ���� ����

Select	@li_rackqty	= IsNull(RackQty, 1)
  From	tmstkb
 Where	AreaCode	= @ps_areacode		And
	DivisionCode	= @ps_divisioncode	And
	WorkCenter	= @ps_workcenter	And
	LineCode	= @ps_linecode		And
	ItemCode	= @ps_itemcode

If @pi_changeqty > 0
Begin
	Select	@li_normalkbcount	= @pi_changeqty / @li_rackqty
	Select	@li_normalkbqty		= @li_normalkbcount * @li_rackqty

	If (@pi_changeqty % @li_rackqty) > 0
	Begin
		Select	@li_tempkbcount	= 1
	End
	Else
	Begin
		Select	@li_tempkbcount	= 0
	End

	Select	@li_tempkbqty		= @pi_changeqty - @li_normalkbqty

End
Else
Begin
	Select	@li_normalkbcount	= 0,
		@li_normalkbqty		= 0,
		@li_tempkbcount		= 0,
		@li_tempkbqty		= 0
End

If Exists (
	Select	PlanDate
	From	tplanday
	Where	PlanDate	= @ps_plandate		And
		AreaCode	= @ps_areacode		And
		DivisionCode	= @ps_divisioncode	And
		WorkCenter	= @ps_workcenter	And
		LineCode	= @ps_linecode		And
		ItemCode	= @ps_itemcode)
Begin
	Update	tplanday
	   Set	PlanQty		= @pi_planqty,
		ChangeQty	= @pi_changeqty,
		NormalKBCount	= @li_normalkbcount,
		NormalKBQty	= @li_normalkbqty,
		TempKBCount	= @li_tempkbcount,
		TempKBQty	= @li_tempkbqty,
		LastEmp		= 'Y', --@ps_empcode,
		LastDate		= GetDate()
	From	tplanday
	Where	PlanDate	= @ps_plandate		And
		AreaCode	= @ps_areacode		And
		DivisionCode	= @ps_divisioncode	And
		WorkCenter	= @ps_workcenter	And
		LineCode	= @ps_linecode		And
		ItemCode	= @ps_itemcode

	If @@Error = 0
	Begin
		Select	@ls_error	= '00',
--			@ls_errortext	= @ps_plandate + ' ������ ���ϻ����ȹ�� �����Ͽ����ϴ�.'
			@ls_errortext	= '���ϻ����ȹ�� �����Ͽ����ϴ�.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
--			@ls_errortext	= @ps_plandate + ' ������ ���ϻ����ȹ�� �����ϴ� ���߿� ������ �߻� �Ͽ����ϴ�.'
			@ls_errortext	= '���ϻ����ȹ�� �����ϴ� ���߿� ������ �߻� �Ͽ����ϴ�.'
		Return
	End
End
Else
Begin
	Insert Into tplanday	(PlanDate,
				AreaCode,		DivisionCode,
				WorkCenter,		LineCode,
				ItemCode,
				PlanQty,			ChangeQty,
				NormalKBCount,		NormalKBQty,
				TempKBCount,		TempKBQty,
				LastEmp,		LastDate)
		Values		(@ps_plandate,
				@ps_areacode,		@ps_divisioncode,
				@ps_workcenter,		@ps_linecode,
				@ps_itemcode,
				@pi_planqty,		@pi_changeqty,
				@li_normalkbcount,	@li_normalkbqty,
				@li_tempkbcount,		@li_tempkbqty,
				'Y',			GetDate())
	If @@Error = 0
	Begin
		Select	@ls_error	= '00',
--			@ls_errortext	= @ps_plandate + ' ������ ���ϻ����ȹ�� ���Ӱ� �߰��Ͽ����ϴ�.'
			@ls_errortext	= '���ϻ����ȹ�� ���Ӱ� �߰��Ͽ����ϴ�.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
--			@ls_errortext	= @ps_plandate + ' ������ ���ϻ����ȹ�� ���Ӱ� �߰��ϴ� ���߿� ������ �߻� �Ͽ����ϴ�.'
			@ls_errortext	= '���ϻ����ȹ�� ���Ӱ� �߰��ϴ� ���߿� ������ �߻� �Ͽ����ϴ�.'
		Return
	End
End


Select	@ps_error	= @ls_error,
	@ps_errortext	= @ls_errortext

Return
End