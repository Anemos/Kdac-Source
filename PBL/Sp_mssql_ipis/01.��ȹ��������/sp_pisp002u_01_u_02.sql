/*
	File Name	: sp_pisp002u_01_u_02.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp002u_01_u_02
	Description	: ���� ���� ��ȹ ��� - 02 ��°
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
	    Where id = object_id(N'[dbo].[sp_pisp002u_01_u_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp002u_01_u_02]
GO


/*
Declare	@ls_error		varchar(2),	-- Transaction ���� ���� ��
	@ls_errortext		varchar(30)	-- Transaction ���� ���� ����

Execute sp_pisp002u_01_u_02
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


Create Procedure sp_pisp002u_01_u_02
	@ps_option		char(1),		-- Scheduling Option('F' : First, 'S' : After First)
	@ps_planmonth		char(7),		-- ��ȹ�� ('YYYY.MM')
	@ps_plandate		char(10),
	@ps_areacode		char(1),		-- ���� �ڵ�
	@ps_divisioncode	char(1),		-- ���� �ڵ�
	@ps_workcenter		varchar(5),
	@ps_linecode		char(1),
	@ps_itemcode		varchar(12),	-- ǰ��
	@pi_planqty		int,
	@pi_changeqty		int,
	@ps_last_workday	char(10),
	@pi_work_count		int,
	@ps_empcode		varchar(6),	-- ���������۾���
	@ps_error		varchar(2)	output,		-- ����
	@ps_errortext		varchar(100)	output		-- ���� ����

As
Begin

Declare	@ls_plandate		char(10),	-- ��� ������('YYYY.MM.DD')
	@li_scheduling_plan	Integer,		-- Scheduling Plan
	@ls_lastday		char(10),	-- Scheduling End Date('YYYY.MM.DD')
	@ls_workgubun		char(1),		-- Loop Date �۾�����(W/H)
	@li_rackqty		int,		-- ���� �����
	@li_planqty		Int,		-- ���ذ�ȹ����
	@li_changeqty		Int,		-- ���ȹ����
	@li_lot_tot		Int,		-- �� ���� Lot ��
	@ln_lot_day		Numeric(5,1),	-- ���� ���� Lot ��(�Ҽ��� ����)
	@li_lot_day		Int,		-- ���� ���� Lot ��(����)
	@li_lot_insert		Int,		-- ���� ���� Lot ��(����) : Table Modify Value
	@li_lot_sum		Int,		-- Cummlative Sum of ���� ���� Lot 
	@ln_minus_lot		Numeric(5,1),	-- ���� ���� Lot ��(�Ҽ��� �Ʒ�)
	@ln_minus_loop		Numeric(5,1),	-- Cumulative Sum of ���� ���� Lot ��(�Ҽ��� �Ʒ�)
	@li_devide		Int,		-- ������ Check
	@li_count		int,
	@ls_error		varchar(2),	-- Transaction ���� ���� ��
	@ls_errortext		varchar(100)	-- Transaction ���� ���� ����

--select '03 ����'

-- ù��° Scheduling �̰ų�, ����(1��)���� �����ȹ�� ���� �Ұ�쿡 Scheduling�� ��ȹ������ ���ȹ���� Setting�Ѵ�.
-- �� ���� ���� ���ȹ - ��������� �������� Scheduling�� �����Ѵ�.
Select	@li_scheduling_plan	= Case	When @ps_option = 'F' Or Right(@ps_plandate, 2) = '01' Then @pi_changeqty
					Else @pi_changeqty - Sum(IsNull(ChangeQty, 0))
				  End
  From	tplanday
 Where	PlanDate	Like @ps_planmonth + '.__'	And
	PlanDate	< @ps_plandate			And
	DivisionCode	= @ps_divisioncode		And
	WorkCenter	= @ps_workcenter		And
	LineCode	= @ps_linecode			And
	ItemCode	= @ps_itemcode


If @li_scheduling_plan is Null
	Select @li_scheduling_plan = @pi_changeqty


If @li_scheduling_plan < 0
Begin
	Select	@ps_error	= '00',
		@ps_errortext	= '���ϻ����ȹ�� ����Ϸ��� ��������� 0 ���� ���� ���Դϴ�.'
	Return
End

--select '����' = @li_scheduling_plan


-- ���� Rack ����� ���ϱ�
Select	@li_rackqty	= IsNull(RackQty, 1)
  From	tmstkb
 Where	AreaCode	= @ps_areacode		And
	DivisionCode	= @ps_divisioncode	And
	WorkCenter	= @ps_workcenter	And
	LineCode	= @ps_linecode		And
	ItemCode	= @ps_itemcode		

-- ���� ���� ��ȹ �ʱ�ȭ
Update	tplanday
   Set	ChangeQty	= 0,
	NormalKBCount	= 0,
	NormalKBQty	= 0,
	TempKBCount	= 0,
	TempKBQty	= 0,
	LastEmp		= 'Y', --@ps_empcode,
	LastDate		= GetDate()
  From	tplanday		A
 Where	A.PlanDate	Like @ps_planmonth + '.__'	And
	A.PlanDate	>= @ps_plandate			And
	A.AreaCode	= @ps_areacode			And
	A.DivisionCode	= @ps_divisioncode		And
	A.WorkCenter	= @ps_workcenter		And
	A.LineCode	= @ps_linecode			And
	A.ItemCode	= @ps_itemcode

If @@Error <> 0
Begin
	Select	@ps_error	= '00',
		@ps_errortext	= '���ϻ����ȹ�� �ʱ�ȭ �ϴ� ���߿� ������ �߻��Ͽ����ϴ�.'
	Return
End


-- �� ���� Lot�� ���(DataType��ȯ�� ���Ͽ� 1.0�� ���Ѵ�.)
-- select Ceiling(6/5) = 1,	select Ceiling(6 * 1.0/5) = 2
-- �����ȹ�� Rack ������� ����� �ƴҰ�쿡 Lot���� �ø�ó���Ѵ�.
Select	@li_lot_tot	= Ceiling((@li_scheduling_plan * 1.0) / @li_rackqty)

-- ���� ���� Lot�� ���
Select	@ln_lot_day	= (@li_lot_tot * 1.0) / @pi_work_count

Select	@li_lot_day	= Floor(@ln_lot_day),
	@li_lot_insert	= Floor(@ln_lot_day),
	@li_lot_sum	= 0,
	@ln_minus_lot	= @ln_lot_day - Floor(@ln_lot_day),
	@ln_minus_loop	= @ln_lot_day - Floor(@ln_lot_day)


Select	@ls_plandate	= @ps_plandate,
	@ls_lastday	= Convert(Char(10), DateAdd(Day, -1, Convert(DateTime, Convert(Char(7), 
				  DateAdd(Month, 1, Convert(DateTime, @ps_plandate)), 102) + '.01')), 102)

-- ���� ���ȭ �����ȹ Generate
While @ls_plandate <= @ls_lastday
Begin
	-- �۾������� 'W'�� ������ �����ȹ Assign
	-- Work Calendar ���� �ٹ��ϼ� ���� ������.
	Select	@ls_workgubun	= WorkGubun,
		@li_count	= Count(WorkGubun)
	  From	tcalendarwork
	 Where	AreaCode		= @ps_areacode		And
		DivisionCode		= @ps_divisioncode	And
		WorkCenter		= @ps_workcenter	And
		LineCode		= @ps_linecode		And
		ApplyMonth		= @ps_planmonth		And
		ApplyDate		= @ls_plandate
	Group By WorkGubun		
	If @li_count = 0-- Work Calendar�� ������ Shop Calendar �� �̿�����.
	Begin				
		Select	@ls_workgubun	= WorkGubun,
			@li_count	= Count(WorkGubun)
		  From	tcalendarshop
		 Where	AreaCode		= @ps_areacode		And
			DivisionCode		= @ps_divisioncode	And
			ApplyMonth		= @ps_planmonth		And
			ApplyDate		= @ls_plandate
		Group By WorkGubun
		If @li_count = 0 -- ���.. Shop Calendar �� ����..���� ������...�׳� ��������..����
		Begin
			GoTo Proc_No_Item
		End
	End

--select	@ls_plandate, @ls_workgubun, @ps_last_workday, @li_scheduling_plan, @pi_work_count

	If @ls_workgubun = 'W'
	Begin
		If @ln_minus_loop >= 1.0
		Begin
			Select	@li_lot_insert	= @li_lot_day + 1,
				@ln_minus_loop	= @ln_minus_loop - 1.0
		End

		-- ������ �ٹ��� ������ �п� ���Ͽ� �ø�ó���Ͽ� ��ȹ�� �ݿ��Ѵ�.
		If @ls_plandate = @ps_last_workday
		Begin
			Select	@li_lot_sum	= @li_lot_sum + @li_lot_insert

			If @li_lot_sum > @li_lot_tot
			Begin
				While @li_lot_sum > @li_lot_tot
				Begin
					Select	@li_lot_sum	= @li_lot_sum - 1,
						@li_lot_insert	= @li_lot_insert - 1
				End
			End
			Else
			Begin
				While @li_lot_sum < @li_lot_tot
				Begin
					Select	@li_lot_sum	= @li_lot_sum + 1,
						@li_lot_insert	= @li_lot_insert + 1
				End
			End
		End				-- ������ �۾����� ��� End
		Else
		Begin
			Select	@li_lot_sum	= @li_lot_sum + @li_lot_insert
			If @li_lot_sum > @li_lot_tot
			Begin
				While @li_lot_sum > @li_lot_tot
				Begin
					Select	@li_lot_sum	= @li_lot_sum - 1,
						@li_lot_insert	= @li_lot_insert - 1
				End
			End
		End

		If @ps_option = 'F'
			Select	@li_planqty	= Case When @ls_workgubun = 'W' Then @li_lot_insert * @li_rackqty Else 0 End,
				@li_changeqty	= Case When @ls_workgubun = 'W' Then @li_lot_insert * @li_rackqty Else 0 End
		Else
		Begin
		-- ����� �����ȹ�� �߰��� ��� ���
			If Exists( 
				Select	PlanQty
				  From	tplanday
				 Where	PlanDate	= @ls_plandate		And
					AreaCode	= @ps_areacode		And
					DivisionCode	= @ps_divisioncode	And
					WorkCenter	= @ps_workcenter	And
					LineCode	= @ps_linecode		And
					ItemCode	= @ps_itemcode
				)
			-- ������ �����ȹ�� ����� ��� �������ȭ �����ȹ���� Select
				Select	@li_planqty	= PlanQty,
					@li_changeqty	= Case When @ls_workgubun = 'W' Then @li_lot_insert * @li_rackqty Else 0 End
				  From	tplanday
				 Where	PlanDate	= @ls_plandate		And
					AreaCode	= @ps_areacode		And
					DivisionCode	= @ps_divisioncode	And
					WorkCenter	= @ps_workcenter	And
					LineCode	= @ps_linecode		And
					ItemCode	= @ps_itemcode
			Else
			-- �����ȹ�� �߰��� ��� ���ذ�ȹ�� 0 ���� Insert
				Select	@li_planqty	= 0,
					@li_changeqty	= Case When @ls_workgubun = 'W' Then @li_lot_insert * @li_rackqty Else 0 End
		End
	End
	Else
	Begin
		If @ps_option = 'F'
			Select	@li_planqty	= 0,
				@li_changeqty	= 0
		Else
		Begin
		-- ����� �����ȹ�� �߰��� ��� ���
			If Exists( 
				Select	PlanQty
				  From	tplanday
				 Where	PlanDate	= @ls_plandate		And
					AreaCode	= @ps_areacode		And
					DivisionCode	= @ps_divisioncode	And
					WorkCenter	= @ps_workcenter	And
					LineCode	= @ps_linecode		And
					ItemCode	= @ps_itemcode
				)
			-- ������ �����ȹ�� ����� ��� �������ȭ �����ȹ���� Select
				Select	@li_planqty	= PlanQty,
					@li_changeqty	= 0
				  From	tplanday
				 Where	PlanDate	= @ls_plandate		And
					AreaCode	= @ps_areacode		And
					DivisionCode	= @ps_divisioncode	And
					WorkCenter	= @ps_workcenter	And
					LineCode	= @ps_linecode		And
					ItemCode	= @ps_itemcode
			Else
			-- �����ȹ�� �߰��� ��� ���ذ�ȹ�� 0 ���� Insert
				Select	@li_planqty	= 0,
					@li_changeqty	= 0
		End
	End

	-- ���� ���ȭ �����ȹ Update
	Execute sp_pisp002u_01_u_03
		@ls_plandate,
		@ps_areacode,
		@ps_divisioncode,
		@ps_workcenter,
		@ps_linecode,
		@ps_itemcode,
		@li_planqty,
		@li_changeqty,
		@ps_empcode,
		@ls_error		output,		-- ����
		@ls_errortext		output		-- ���� ����

	If @ls_error = '00'
	Begin
		Select	@ls_error	= '00'
	End
	Else
	Begin
		GoTo Proc_Exit
	End

	Proc_No_Item:	-- �����ͳ� ��Ÿ �����Ͱ� ��� ����� �� �� ��� �Ϸ� ����..����

	Select	@ls_plandate	= Convert(Char(10), DateAdd(Day, 1, Convert(DateTime, @ls_plandate)),102)

	If @ls_workgubun = 'W' And @li_lot_sum <> @li_lot_tot
	Begin
		Select	@ln_minus_loop	= @ln_minus_loop + @ln_minus_lot,
			@li_lot_insert	= @li_lot_day
	End
End							-- While Loop End

/*
-- ���� � ��ȹ(@pi_changeqty)�� Rack ������� ����� �ƴҰ�� 
-- TMONTHPLAN�� ChangeQty�� Shcduling�� �Ϻ����ȹ�� Sum���� Update�Ѵ�.
Select	@li_devide	= @pi_changeqty / @li_rackqty

If @li_devide * @li_rackqty <> @pi_changeqty
Begin
	Update	TMONTHLYPLAN
	   Set	ChangeQty	= (
				Select	Sum(ChangeQty)
				  From	TDAILYPLAN30
				 Where	PlanMonth	= @ls_planmonth
				   And	DivisionCode	= @ps_divisioncode
				   And	ItemCode	= @ps_itemcode
				  ),
		LastEmp		= @ps_empcode,
		LastDate	= GetDate()
	 Where	PlanMonth	= @ls_planmonth
	   And	DivisionCode	= @ps_divisioncode
	   And	ItemCode	= @ps_itemcode

	Select	@ri_error	= @@Error

	If @ri_error <> 0 Return @ri_error
End
*/

Proc_Exit:

Select	@ps_error	= @ls_error,
	@ps_errortext	= @ls_errortext

Return
End