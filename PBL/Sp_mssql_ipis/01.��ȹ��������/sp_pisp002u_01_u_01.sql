/*
	File Name	: sp_pisp002u_01_u_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp002u_01_u_01
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
	    Where id = object_id(N'[dbo].[sp_pisp002u_01_u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp002u_01_u_01]
GO

/*
Declare	@ls_error		varchar(2),	-- Transaction ���� ���� ��
	@ls_errortext		varchar(30)	-- Transaction ���� ���� ����

Execute sp_pisp002u_01_u_01
	@ps_option		= 'F',
	@ps_planmonth		= '2002.09',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_productgroup	= '%',
	@ps_modelgroup		= '%',
	@ps_itemcode		= '%',
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


Create Procedure sp_pisp002u_01_u_01
	@ps_option		char(1),		-- Scheduling Option('F' : First, 'S' : After First)
	@ps_planmonth		char(7),		-- ��ȹ�� ('YYYY.MM')
	@ps_areacode		char(1),		-- ���� �ڵ�
	@ps_divisioncode	char(1),		-- ���� �ڵ�
	@ps_productgroup	varchar(2),	-- ��ǰ��
	@ps_modelgroup		varchar(3),	-- �𵨱�
	@ps_itemcode		varchar(12),	-- ǰ��
	@ps_empcode		varchar(6),	-- ���������۾���
	@ps_error		varchar(2)	output,		-- ����
	@ps_errortext		varchar(100)	output		-- ���� ����

As
Begin

Declare	@ls_plandate		char(10),	-- ��ȹ�� ����Ϸ��� ��������
	@ls_areacode		char(1),
	@ls_divisioncode		char(1),
	@ls_workcenter		varchar(5),	-- Work Center
	@ls_linecode		char(1),		-- ���� �ڵ�
	@ls_itemcode		varchar(12),	-- �� �ڵ�
	@ls_last_workday		char(10),
	@ls_tomorrow		char(10),	-- ����
	@ls_lastday		char(10),	-- Plan Month �� ������ ����
	@li_work_count		Int,
	@li_planqty		Int,		-- ���ذ�ȹ����
	@li_changeqty		Int,		-- ���ȹ����
	@i			Int,
	@j			Int,
	@k			Int,
	@li_count		Int,
	@li_wc_count		Int,
	@li_line_count		Int,
	@li_item_count		Int,
	@li_divide_rate		smallint,
	@li_rackqty		int,
	@li_generate_plan	Int,
	@li_generate_change	Int,
	@ls_error		varchar(2),	-- Transaction ���� ���� ��
	@ls_errortext		varchar(100)	-- Transaction ���� ���� ����

-- SQL 6.5 ������ Ȯ���� ���� �ȵ� ������
-- �ϳ��� Stored Procedure������ 3�� �̻� Create Table/Declare Cursor ���� ����Ҽ� ����.
-- Select Into ���� ����Ͽ� Table�� ����°��� ����� ����.
-- Compile�ÿ��� Error�� �߻����� ������ RunTime�� Error �߻�
-- �׷��� WorkCenter�� LineCode�� Create Table������ �̿��� Table�� �����,
-- ModelCode�� @ls_table_exist�μ� Checking�� Select Into ������ �̿��Ѵ�.

-- 7.0 ������ �������.

Create Table #tmp_rate
(
	AreaCode	char(1),
	DivisionCode	char(1),
	WorkCenter	varchar(5),
	LineCode	char(1),
	DivideRate	smallInt
)

Create Table #tmp_workcenter
(
	WorkCenter	varchar(5)
)

Create Table #tmp_line
(
	LineCode	Char(1)
)


-- Scheduling�� ������ ǰ�� �� ���� Total ���ذ�ȹ, ���ȹ�� ���Ѵ�.
Select	AreaCode	= A.AreaCode,
	DivisionCode	= A.DivisionCode,
	ItemCode	= A.ItemCode,
	PlanQty		= Sum(IsNull(B.PlanQty, 0)),
	ChangeQty	= Sum(IsNull(B.ChangeQty, 0))
Into	#tmp_item_plan
From	(Select	AreaCode	= A.AreaCode,
		DivisionCode	= A.DivisionCode,
		ItemCode	= A.ItemCode
	From	tmstkb		A,
		tmstmodel	B
	Where	B.AreaCode	= @ps_areacode		And
		B.DivisionCode	Like @ps_divisioncode	And
		B.ProductGroup	Like @ps_productgroup	And
		B.ModelGroup	Like @ps_modelgroup	And
		B.ItemCode	Like @ps_itemcode	And
		B.AreaCode	= A.AreaCode		And
		B.DivisionCode	= A.DivisionCode		And
		B.ItemCode	= A.ItemCode		And
		A.PrdStopGubun	= 'N'
	Group By A.AreaCode, A.DivisionCode, A.ItemCode)	A,
	tplanmonth	B
Where	A.AreaCode	= B.AreaCode		And
	A.DivisionCode	= B.DivisionCode		And
	A.ItemCode	= B.ItemCode		And
	B.PlanMonth	= @ps_planmonth		And
	B.ChangeQty	> 0
Group by A.AreaCode, A.DivisionCode, A.ItemCode
Order by A.AreaCode, A.DivisionCode, A.ItemCode

Select	@i = 0, @li_item_count = @@RowCount, @ls_itemcode = ''

--select * from #tmp_item_plan

If @li_item_count < 1
Begin
	Select	Error		= '00',
		ErrorText	= '���ϻ����ȹ�� ����� ���������ȹ�� �������� �ʽ��ϴ�.'
	Return
End

-- select * from #tmp_item_plan

-- ���õ� Item�� ����ŭ Loop
While @i < @li_item_count
Begin
	Select	Top 1
		@i		= @i + 1,
		@ls_areacode	= AreaCode,
		@ls_divisioncode	= DivisionCode,
		@ls_itemcode	= ItemCode,
		@li_planqty	= PlanQty,
		@li_changeqty	= ChangeQty	
	  From	#tmp_item_plan
	Where	AreaCode	= @ps_areacode		And
		DivisionCode	= @ps_divisioncode	And
		ItemCode	> @ls_itemcode

	-- �����ȹ�� �й��� Line �� �й����� ���Ѵ�.
	Insert	#tmp_rate
	Select	AreaCode,
		DivisionCode,
		WorkCenter,
		LineCode,
		DivideRate
	  From	tmstkb
	 Where	AreaCode	= @ls_areacode		And
		DivisionCode	= @ls_divisioncode	And
		ItemCode	= @ls_itemcode
	Order By AreaCode, DivisionCode, WorkCenter, LineCode, DivideRate

--select '#tmp_rate'
--select * from #tmp_rate

--	��ȹ�й����� ���ٴ� ��..
--	��, ���� �����Ϳ� ��ϵǾ� ���� ���� �����̴�..
--	�̹� ������ �ѹ� �ɷ�����, �ٽ� �ѹ� �ɸ���..
	If @@RowCount = 0
	Begin
		Select	@ls_error	= '00',
			@ls_errortext	= '���� �����Ϳ� �ش� ��ǰ ������ �������� �ʽ��ϴ�.'
		GoTo Proc_No_Item
	End

--	WorkCenter�� ������.
	Insert	#tmp_workcenter
	Select	WorkCenter
	From	#tmp_rate
	Group By WorkCenter
	Order By WorkCenter

	Select	@j = 0, @li_wc_count = @@RowCount, @ls_workcenter	= ''

--	�ش� Item �� ������ WorkCenter ��ŭ Loop
	While @j < @li_wc_count
	Begin
		Select	Top 1
			@j		= @j + 1,
			@ls_workcenter	= WorkCenter
		  From	#tmp_workcenter
		 Where	WorkCenter	> @ls_workcenter

		-- Loop�� ������ Line�� �����Ѵ�.
		Insert	#tmp_line
		Select	LineCode
		From	#tmp_rate
		Where	WorkCenter	= @ls_workcenter
		Group By LineCode
		Order By LineCode

		Select	@k = 0, @li_line_count = @@RowCount, @ls_linecode = ''

--	�ش� WorkCenter�� ������ Line ��ŭ Loop
		While @k < @li_line_count
		Begin
			Select	Top 1
				@li_count	= 0,
				@k		= @k + 1,
				@ls_linecode	= LineCode
			  From	#tmp_line
			 Where	LineCode	> @ls_linecode

			-- ��ȹ�� ����Ϸ��� �������� ������.
			If @ps_option = 'F'
			Begin
				Select	@ls_plandate	= @ps_planmonth + '.01'
			End
			Else
			Begin
				Select	@ls_tomorrow	= Convert(char(10), DateAdd(Day, 1, GetDate()), 102),
					@ls_lastday	= Convert(Char(10), DateAdd(Day, -1, Convert(DateTime, Convert(Char(7), 
									  DateAdd(Month, 1, Convert(DateTime, @ps_planmonth + '.01')), 102) + '.01')), 102)
				-- �ϴ� �������ð� �� ���ڱ����� ���ϻ����ȹ�� �ǵ���....�ȵ���..
				-- �ٵ�, ���κ��� �����ؾ� �Ѵ�.
				-- �ֳ��ϸ�, ����ȭ������ȹ�� ���δ����� �����ǹǷ�
				-- ���ο� �ش��ϴ� ��ǰ�� ���ϻ����ȹ�� �ٲ㵵 �� ���ο� ��ǰ �ϳ��� ���� ���ð� �Ǹ�
				-- ����ȭ ������ȹ�� �ٲܼ� ����.
				Select	@ls_plandate	= Max(PlanDate),
					@li_count	= Count(PlanDate)
				From	tplanrelease
				Where	PlanDate	Like @ps_planmonth + '.__'	And
					AreaCode	= @ls_areacode			And
					DivisionCode	= @ls_divisioncode		And
					WorkCenter	= @ls_workcenter			And
					LineCode	= @ls_linecode			And
--					ItemCode	= @ls_itemcode			And
					ReleaseGubun	In ('Y', 'T', 'N')

				Select	@ls_plandate = Convert(Char(10), DateAdd(Day, 1, Convert(DateTime, @ls_plandate)), 102)

				If @li_count > 0
				Begin
					If @ls_plandate > @ls_lastday
					Begin
						Select	@ls_error	= '00',
							@ls_errortext	= '�������� �������ð� ����Ǿ� �ֽ��ϴ�.'
						GoTo Proc_No_Line
					End
					Else
					Begin
						If @ls_plandate	> @ls_tomorrow
						Begin
							Select	@ls_plandate	= @ls_plandate
						End
						Else
						Begin
							If @ls_tomorrow > @ls_lastday
							Begin
								Select	@ls_error	= '00',
									@ls_errortext	= '������ �ش���� ���ϻ����ȹ ������ �Ұ����մϴ�.'
								GoTo Proc_No_Line
							End
							Else
							Begin
								Select	@ls_plandate	= @ls_tomorrow
							End
						End
					End
				End
				Else
				Begin
					If @ps_planmonth + '.01' > @ls_tomorrow
					Begin
						Select	@ls_plandate	= @ps_planmonth + '.01'
					End
					Else
					Begin
						Select	@ls_plandate	= @ls_tomorrow
					End
				End
			End

			Select	@li_work_count	= 0
			-- Work Calendar ���� �ٹ��ϼ� ���� ������.
			Select	@li_work_count		= Count(ApplyDate),
				@ls_last_workday		= Max(ApplyDate)
			  From	tcalendarwork
			 Where	AreaCode		= @ls_areacode		And
				DivisionCode		= @ls_divisioncode	And
				WorkCenter		= @ls_workcenter		And
				LineCode		= @ls_linecode		And
				ApplyMonth		= @ps_planmonth		And
				ApplyDate		>= @ls_plandate		And
				WorkGubun		= 'W'
			If @li_work_count = 0-- Work Calendar�� ������ Shop Calendar �� �̿�����.
			Begin				
				Select	@li_work_count		= Count(ApplyDate),
					@ls_last_workday		= Max(ApplyDate)
				  From	tcalendarshop
				 Where	AreaCode		= @ls_areacode		And
					DivisionCode		= @ls_divisioncode	And
					ApplyMonth		= @ps_planmonth		And
					ApplyDate		>= @ls_plandate		And
					WorkGubun		= 'W'
				If @li_work_count = 0 -- ���.. Shop Calendar �� ����..���� ������...�׳� ��������..����
				Begin
					Select	@ls_error	= '00',
						@ls_errortext	= 'Shop Calendar�� �ٹ����� �����ϴ�.'
					GoTo Proc_No_Line
				End
			End

			If @li_work_count < 1 -- ���.. �ٹ��ϼ��� ����...��ƾ���..
			Begin
				Select	@ls_error	= '00',
					@ls_errortext	= 'Work Calendar�� �ٹ����� �����ϴ�.'
				GoTo Proc_No_Line
			End

			Select	@li_divide_rate	= IsNull(DivideRate, 0)
			  From	#tmp_rate
			 Where	AreaCode	= @ls_areacode		And
				DivisionCode	= @ls_divisioncode	And
				WorkCenter	= @ls_workcenter		And
				LineCode	= @ls_linecode

			If @li_divide_rate = 0 Or @li_divide_rate Is Null
			Begin
				Select	@ls_error	= '00',
					@ls_errortext	= '��ȹ�й����� �������� �ʽ��ϴ�.'
				GoTo Proc_No_Line
			End

			Select	@li_rackqty	= IsNull(RackQty, 0)
			  From	tmstkb
			 Where	AreaCode	= @ls_areacode		And
				DivisionCode	= @ls_divisioncode	And
				WorkCenter	= @ls_workcenter		And
				LineCode	= @ls_linecode		And
				ItemCode	= @ls_itemcode		

			If @li_rackqty = 0 Or @li_rackqty Is Null
			Begin
				Select	@ls_error	= '00',
					@ls_errortext	= '������� �������� �ʽ��ϴ�.'
				GoTo Proc_No_Line
			End

			Select	@li_generate_plan	= Ceiling((@li_planqty * @li_divide_rate * 1.0 / 100) / @li_rackqty) * @li_rackqty,
				@li_generate_change	= Ceiling((@li_changeqty * @li_divide_rate * 1.0 / 100) / @li_rackqty) * @li_rackqty

			-- ���� ���ȭ �����ȹ Compute
			Execute sp_pisp002u_01_u_02
				@ps_option,
				@ps_planmonth,				-- ���ؿ�
				@ls_plandate,				-- ��ȹ ���� ����
				@ls_areacode,
				@ls_divisioncode,
				@ls_workcenter,
				@ls_linecode,
				@ls_itemcode,
				@li_generate_plan,			-- ���� ���ذ�ȹ ����
				@li_generate_change,			-- ���� ���ȹ ����
				@ls_last_workday,
				@li_work_count,				-- ��ȹ ���� ���� ������ �ٹ� �ϼ�
				@ps_empcode,
				@ls_error		output,		-- ����
				@ls_errortext		output		-- ���� ����

			-- Error ���� ���� Transaction ����	
			If @ls_error = '00'
			Begin
				Select	@ls_error	= '00'
			End
			Else
			Begin
				GoTo Proc_Exit
			End

			Proc_No_Line:	-- �����ͳ� ��Ÿ �����Ͱ� ��� ����� �� �� ��� �Ϸ� ����..����
		End				-- Line Loop End
		-- Loop Table �ʱ�ȭ
		Truncate Table #tmp_line
	End					-- Work Center Loop End
	-- Loop Table �ʱ�ȭ
	Truncate Table #tmp_workcenter

	Proc_No_Item:	-- �����ͳ� ��Ÿ �����Ͱ� ��� ����� �� �� ��� �Ϸ� ����..����

	-- Loop Table �ʱ�ȭ
	Truncate Table #tmp_rate
End	-- Item Loop End

Proc_Exit:

Drop Table #tmp_item_plan
Drop Table #tmp_rate
Drop Table #tmp_workcenter
Drop Table #tmp_line

Select	@ps_error	= @ls_error,
	@ps_errortext	= @ls_errortext

Return
End