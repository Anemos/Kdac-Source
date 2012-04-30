/*
	File Name	: sp_pisp004u_02_u.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp004u_02_u
	Description	: ���� ����ȭ��ȹ�� ����ϴ� ���ν���
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 18
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp004u_02_u]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp004u_02_u]
GO

/*
Execute sp_pisp004u_02_u
	@ps_plandate		= '2002.12.24',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '421J',
	@ps_linecode		= 'A',
	@ps_maxcyclegubun	= 'N',
	@pi_cyclecount		= 2,
	@ps_empcode		= 'IPIS'


select * from tmstline where workcenter = '732P'

select * from tplanday where plandate = '2002.10.23'

select * from tplanrelease order by cycleorder, releaseorder

dbcc opentran

1	511517	25
2	511513	16
3	511514	1
4	511517	25
5	511513	15

D	A	4201	A	511513	0	1400	28	1400	2002.09.24
D	A	4201	A	511514	0	750	15	750	2002.09.24
D	A	4201	A	511517	0	2850	57	2850	2002.09.24
D	A	4201	B	511513	0	2100	42	2100	2002.09.24
D	A	4201	B	511514	0	700	14	700	

*/

Create Procedure sp_pisp004u_02_u
	@ps_plandate		char(10),
	@ps_areacode		char(1),		-- ���� �ڵ�
	@ps_divisioncode	char(1),		-- ���� �ڵ�
	@ps_workcenter		varchar(5),
	@ps_linecode		char(1),
	@ps_maxcyclegubun	char(1),
	@pi_cyclecount		int,
	@ps_empcode		varchar(6)
As
Begin

--Select	Error		= '00',
--	ErrorText	= ''

Declare	@ls_workgubun		char(1),
	@ls_itemcode		varchar(12),
	@li_max_cycle		Int,
	@i			Int,
	@j			Int,
	@k			Int,
	@li_plan_kbcount		Int,
	@li_loop_count		Int,
	@li_plan_order		Int,
	@li_original_plan		Int,
	@li_plan_sum		Int,
	@li_minus_plan		Int,
	@li_total_kbcount		Int,
	@li_cum_kbcount		Int,
	@li_space		Int,

	@li_tempkbqty		int,
	@li_cycleorder		int,
	@li_releaseorder		int,
	@ls_error		char(2),
	@ls_errortext		varchar(100)

-- �����ȹ���� ���� �ż��� ȯ���� ��ȹ�� �����Ѵ�.
Select	@ls_workgubun	= A.WorkGubun
From	tcalendarwork	A
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode	And
	A.WorkCenter	= @ps_workcenter	And
	A.LineCode	= @ps_linecode		And
	A.ApplyDate	= @ps_plandate
Group By A.WorkGubun

If @ls_workgubun = 'W'
Begin
	Select	Error		= '00',
		ErrorText	= '�۾��ϴ� �����Դϴ�.'
	
End
Else
Begin
	Select	Error		= '00',
		ErrorText	= '�����Ͻ� ���ڴ� �޹� �Դϴ�.'
	Return
End


-- ��ǰ�� ���� �����ȹ ���Ǹż� ���̺�
Create Table #Tmp_Plan_KBCount
(	PlanOrder	Int IDENTITY(1,1)		Not Null,
	ItemCode	VarChar(12)		Not Null,
	PlanKBCount	Int			Not Null,
	NormalKBCount	Int			Not Null,
	NormalKBQty	Int			Not Null,
	TempKBCount	Int			Not Null,
	TempKBQty	Int			Not Null,
	Constraint PK_TMP_PLAN_KBCOUNT Primary Key
	(
		PlanOrder
	)
)

-- ��ǰ�� ����ȭ ���� ���̺�
Create Table #Tmp_Plan
(	PlanOrder	Int IDENTITY(1,1)		Not Null,
	ItemCode	VarChar(12)		Not Null,
	PlanKBCount	Int			Not Null,
	Constraint PK_TMP_PLAN Primary Key
	(
		PlanOrder
	)
)

-- ��ǰ�� ����ȭ ������ ����ϱ� ���� �ӽ� ���̺�
Create Table #Tmp_Leveling_Plan
(	PlanOrder	Int 		Not Null,
	ItemCode	VarChar(12)	Not Null,
	PlanKBCount	Int		Not Null
	Constraint PK_TMP_LEVELING_PLAN Primary Key
	(
		PlanOrder
	)
)

-- �����ȹ���� ���� �ż��� ȯ���� ��ȹ�� �����Ѵ�.
Insert	Into #Tmp_Plan_KBCount (ItemCode, PlanKBCount, NormalKBCount, NormalKBQty, TempKBCount, TempKBQty)
Select	ItemCode	= A.ItemCode,
	PlanKBCount	= A.PlanKBCount,
	NormalKBCount	= A.NormalKBCount,
	NormalKBQty	= A.NormalKBQty,
	TempKBCount	= A.TempKBCount,
	TempKBQty	= A.TempKBQty
From	(Select	ItemCode	= A.ItemCode,
	--	PlanKBCount	= A.PlanKBCount,
	--	NormalKBCount	= A.NormalKBCount,
	--	NormalKBQty	= A.NormalKBQty / (Case When A.NormalKBCount < 1 Then 1 Else A.NormalKBCount End),
		PlanKBCount	= Round(A.ChangeQty / B.RackQty, 0) + A.TempKBCount,
		NormalKBCount	= Round(A.ChangeQty / B.RackQty, 0),
		NormalKBQty	= B.RackQty,
		TempKBCount	= Case When A.ChangeQty%B.RackQty = 0 Then 0 Else 1 End ,
		TempKBQty	= A.ChangeQty - (Round(A.ChangeQty / B.RackQty, 0) * B.RackQty)
	From	(Select	AreaCode	= A.AreaCode,
			DivisionCode	= A.DivisionCode,
			WorkCenter	= A.WorkCenter,
			LineCode	= A.LineCode,
			ItemCode	= A.ItemCode,
			ChangeQty	= A.ChangeQty,
			NormalKBCount	= A.NormalKBCount,
			NormalKBQty	= A.NormalKBQty,
			TempKBCount	= A.TempKBCount,
			TempKBQty	= A.TempKBQty
		From	tplanday		A
		Where	A.PlanDate	= @ps_plandate		And
			A.AreaCode	= @ps_areacode		And
			A.DivisionCode	= @ps_divisioncode	And
			A.WorkCenter	= @ps_workcenter	And
			A.LineCode	= @ps_linecode		And
			A.ChangeQty	> 0
		Group By A.AreaCode, A.DivisionCode, A.WorkCenter, A.LineCode, A.ItemCode, 
			A.ChangeQty, A.NormalKBCount, A.NormalKBQty, A.TempKBCount, A.TempKBQty)	A,
		tmstkb	B
	Where	A.ChangeQty	> 0			And
		A.AreaCode	= B.AreaCode		And
		A.DivisionCode	= B.DivisionCode		And
		A.WorkCenter	= B.WorkCenter		And
		A.LineCode	= B.LineCode		And
		A.ItemCode	= B.ItemCode)	A
Order By A.PlanKBCount Desc

Insert	#Tmp_Plan	(ItemCode,	PlanKBCount)
Select	A.ItemCode,
	A.PlanKBCount
From	#tmp_plan_kbcount	A
Order By A.PlanOrder

-- Loop Ƚ��(Item ����) �� �ִ� Cycle ���� ������ ���Ѵ�.
Select	@li_loop_count	= @@RowCount,
	@li_max_cycle 	= Max(PlanKBCount)
  From	#Tmp_Plan

If @li_loop_count < 1
Begin
	Select	Error		= '00',
		ErrorText	= '����ȭ ���� ��ȹ�� ������ ���ϻ����ȹ�� �������� �ʽ��ϴ�.'

	Drop Table #Tmp_Plan_KBCount
	Drop Table #Tmp_Plan
	Drop Table #Tmp_Leveling_Plan

	Return
End

-- select Sum(PlanKBCount) From #Tmp_Plan
-- select * From #Tmp_Plan

If @pi_cyclecount > @li_max_cycle Or @pi_cyclecount = 0		
Begin								-- �ִ� Cycle ���� ����
	-- ��� ����� ���� �ӽ� Table
	Create Table #Tmp_Leveling_Temp
	(	RowNum		Int IDENTITY(1,1)	Not Null,
		PlanOrder	Int 			Not Null,
		ItemCode	VarChar(12)		Not Null,
		PlanKBCount	Int			Not Null
		Constraint PK_TMP_LEVELING_TEMP Primary Key
		(
			RowNum
		)
	)

	-- ����ȭ �����ȹ�� ä�� �ӽ� ������ ������ ���Ѵ�.
	Select	@i			= 0,
		@li_total_kbcount	= Sum(PlanKBCount)
	  From	#Tmp_Plan
	
	While @i < @li_total_kbcount			-- ������ �����Ҽ� �ִ� �� ������ ä���. 
	Begin						-- ���� ������ ��(A)�� Setting
		Select	@i = @i + 1
		Insert Into #Tmp_Leveling_Plan
		Values(@i, 'A', 1)
	End
--select * from #Tmp_Leveling_Plan

	-- ��� ����� ���� �ӽ� ���̺� ��� ��ġ�� ���� ������ ���� �����Ѵ�.
	-- ���ʿ��� ���� ������ A�� ���ڰ� ����, Looping�� ���鼭 A�� ���ڰ� �پ���.
	Insert	Into #Tmp_Leveling_Temp(PlanOrder, ItemCode, PlanKBCount)
	Select	PlanOrder, ItemCode, PlanKBCount
	  From	#Tmp_Leveling_Plan
	 Where	ItemCode	= 'A'

	Select	@i 		= 1,		-- Item Loop�� ���� ����
		@k		= 0,		-- �ϳ��� �������� �ѹ��� Loop�� ��į�� ä���� ���Ұ��(Celing ó�� ����)�� ���� Cumulative ����
		@li_cum_kbcount	= 0
	While @i <= @li_loop_count			-- ������� Loop ���鼭 Item ��� ��ġ(@i�� #Tmp_Plan�� Order�� �ȴ�(Indentity �̱� ������)
	Begin						-- Item(Order) Loop ����
		-- Select	Convert(Char(5), @i) + Convert(Char(5), @li_total_kbcount)
		-- If @i = 2 Select * From #Tmp_Leveling_Plan

		Select	@i			= @i + 1,
			@j			= 1,
			@ls_itemcode		= ItemCode,
			@li_space		= Ceiling(@li_total_kbcount * 1.0 / (PlanKBCount - @li_cum_kbcount)),		-- ��� ���
			@li_plan_kbcount		= PlanKBCount									-- ��� ��ġ �Ϸ� Check��
		  From	#Tmp_Plan
		 Where	PlanOrder		= @i
--select @li_total_kbcount, @li_cum_kbcount, @li_space
		While @j <= @li_total_kbcount	-- Item ��ġ Loop
		Begin				-- Item ��ġ Loop ����
			-- ������ ��('A')�� ������ �ӽ� ���̺��� Item�� Update �Ѵ�.
			Update	#Tmp_Leveling_Temp
			   Set	ItemCode	= @ls_itemcode
			 Where	RowNum		= @j

			Select	@j = @j + @li_space,		-- ��� ����
				@k = @k + 1			-- ��ġ�� Item ��
		End				-- Item ��ġ Loop ����

		-- ��� ��ġ�� ���� ���� �ϰ������� Result Set (#Tmp_Leveling_Plan)���� �̵�(Update �̿�)
		Update	#Tmp_Leveling_Plan
		   Set	ItemCode	= B.ItemCode
		  From	#Tmp_Leveling_Plan A,
			#Tmp_Leveling_Temp B
		 Where	A.PlanOrder	= B.PlanOrder
--select * from #Tmp_Leveling_temp
--select * from #Tmp_Leveling_Plan
		-- ���ο� ��ġ�� ���Ͽ� �ӽ� Table �ʱ�ȭ
		Truncate Table #Tmp_Leveling_Temp

		-- ��ġ�� �ȵ� ��('A') �� ����
		Insert	Into #Tmp_Leveling_Temp(PlanOrder, ItemCode, PlanKBCount)
		Select	PlanOrder, ItemCode, PlanKBCount
		  From	#Tmp_Leveling_Plan
		 Where	ItemCode	= 'A'

		Select	@li_total_kbcount = @@RowCount

		-- ��ġ�� Item ���� �ش� Item�� ��ȹ���� ���Ͽ� ������ ���� ���� Item�� ��ġ�� �����ϰ�,
		-- ���� ��� ���� Item ����ŭ ��� ��ġ�� �ٽ� �����Ѵ�.
		-- �̶� ���� ���� Item�� ������ ���� Setting �� @i ���� ���� Item���� �ٲ۴�.
		Select	@li_cum_kbcount	= @li_cum_kbcount + @k
		If @li_cum_kbcount < @li_plan_kbcount
			Select @i = @i - 1
		Else
			-- Item�� ��ġ�� ������ ������ ���, Cumulative ������ Cumulative �������� �ʱ�ȭ �Ѵ�.
			Select @li_cum_kbcount = 0, @k = 0
	End						-- Item(Order) Loop ����

	Drop Table #Tmp_Leveling_Temp

	-- Final Resut Set�� �����ϱ� ���Ͽ� �ӽ� Table�� �ʱ�ȭ �Ѵ�.
	-- ��������� ����� ���� ���� ������ �ִ� Cycle ����� �߱� ������, ���� ������ Item�� ����(������ ������)���� ���� �Ѵ�.
	Truncate Table #Tmp_Plan

	Select	@i		= 1,
		@j		= 0,
		@li_loop_count	= Max(PlanOrder)
	  From	#Tmp_Leveling_Plan

	While @i <= @li_loop_count
	Begin
		Select	@i		= @i + 1,
			@ls_itemcode	= ItemCode
		  From	#Tmp_Leveling_Plan
		 Where	PlanOrder	= @i

		If Exists (	Select * From #Tmp_Plan
				 Where	PlanOrder	= @j
				   And	ItemCode	= @ls_itemcode)
		Begin
			Update	#Tmp_Plan
			   Set	PlanKBCount	= PlanKBCount + 1
			 Where	PlanOrder	= @j
			   And	ItemCode	= @ls_itemcode
		End
		Else
		Begin
			Insert Into	#Tmp_Plan	(ItemCode,	PlanKBCount)
			Values				(@ls_itemcode,	1)

			Select @j = @j + 1
		End
	End
End								-- �ִ� Cycle ���� ����
Else
Begin								-- Line�� ���� Cycle ���� ����
	Select	PlanOrder,
		ItemCode,
		PlanKBCount	= Ceiling(PlanKBCount * 1.0 / @pi_cyclecount)
	  Into	#Tmp_Cycle_Plan
	  From	#Tmp_Plan

	Select	@i		= 0,
		@k		= 0,
		@li_loop_count	= @@RowCount

	While @i < @pi_cyclecount				-- Cycle Loop Start (N Cycle�� ��� N�� Loop)
	Begin
		Select	@i	= @i + 1,
			@j	= 0
		While @j < @li_loop_count
		Begin				-- ��ȹ Model Assign Loop Start
			Select	Top 1
				@j		= @j + 1,
				@k		= @k + 1,
				@ls_itemcode	= ItemCode,
				@li_plan_kbcount	= PlanKBCount
			  From	#Tmp_Cycle_Plan
			 Where	PlanOrder	> @j

			Insert Into #Tmp_Leveling_Plan
			Values(@k, @ls_itemcode, @li_plan_kbcount)
		End				-- ��ȹ Model Assign Loop End
	End						-- Cycle Loop End

	Drop Table #Tmp_Cycle_Plan

	-- Ceiling ó���� ����ȭ ���� ��ȹ�� �����Ѵ�.
	Select	ItemCode	= A.ItemCode, 
		OriginalPlan	= A.PlanKBCount,
		MinusPlan	= Sum(B.PlanKBCount) - A.PlanKBCount,
		PlanOrder	= Max(B.PlanOrder) + 1
	  Into	#Tmp_Minus
	  From	#Tmp_Plan A,
		#Tmp_Leveling_Plan B
	 Where	A.ItemCode	= B.ItemCode
	Group By A.ItemCode, A.PlanKBCount
	Having	Sum(B.PlanKBCount) - A.PlanKBCount > 0
	Order By A.ItemCode

	Select	@i			= 0,
		@li_loop_count		= @@RowCount,
		@ls_itemcode		= ''

	While @i < @li_loop_count
	Begin					-- Total ��ȹ�� ����ȭ ��ȹ Sum �� �ٸ� Item ���� Item Loop ����
		Select	Top 1
			@i			= @i + 1,
			@ls_itemcode		= ItemCode,
			@li_plan_order		= PlanOrder,
			@li_original_plan	= OriginalPlan,
			@li_plan_sum		= OriginalPlan + 1,
			@li_minus_plan		= MinusPlan
		  From	#Tmp_Minus
		 Where	ItemCode		> @ls_itemcode

		While @li_original_plan < @li_plan_sum
		Begin
			Select	Top 1
				@li_plan_order		= PlanOrder
			  From	#Tmp_Leveling_Plan
			 Where	ItemCode	= @ls_itemcode
			   And	PlanOrder	< @li_plan_order
			Order By PlanOrder Desc

			Update	#Tmp_Leveling_Plan
			   Set	PlanKBCount	= Case When PlanKBCount - @li_minus_plan < 0 Then 0 Else PlanKBCount - @li_minus_plan End
			 Where	PlanOrder	= @li_plan_order
			   And	ItemCode	= @ls_itemcode

			Select	@li_plan_sum	= Sum(PlanKBCount)
			  From	#Tmp_Leveling_Plan
			 Where	ItemCode	= @ls_itemcode
		End
	End					-- Total ��ȹ�� ����ȭ ��ȹ Sum �� �ٸ� Item ���� Item Loop ����

	Drop Table #Tmp_Minus

	Truncate Table #Tmp_Plan

	Delete #Tmp_Leveling_Plan
	 Where PlanKBCount	<= 0

	Insert	#Tmp_Plan	(ItemCode,	PlanKBCount)
	Select	A.ItemCode,
		A.PlanKBCount
	From	#Tmp_Leveling_Plan	A
	Order By PlanOrder
End								-- Line�� ���� Cycle ���� ����

-- ����ȭ ������ȹ�� �� ����ߴ�..
-- ������ʹ� ��ǰ�� ������ �ٽ� ���Ǽ����� �ɰ���..
Select	@i		= 0,
	@li_loop_count	= 0,
	@li_plan_kbcount	= 0,
	@li_plan_order	= 0

Select	@li_loop_count	= Count(ItemCode)
From	#tmp_plan

--Begin Tran

-- �ϴ� �ش� ������ ����ȭ ������ȹ�� �ʱ�ȭ ����..����
Delete	tplanrelease
Where	PlanDate		= @ps_plandate		And
	AreaCode		= @ps_areacode		And
	DivisionCode		= @ps_divisioncode	And
	WorkCenter		= @ps_workcenter	And
	LineCode		= @ps_linecode

While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@j			= 1,
		@li_plan_order		= PlanOrder,
		@ls_itemcode		= ItemCode,
		@li_plan_kbcount		= PlanKBCount + 1
	  From	#tmp_plan
	 Where	PlanOrder	> @li_plan_order

	-- ���� �ż� ��ŭ Looping �� ���鼭 ���� ������ ������
	While @j < @li_plan_kbcount
	Begin
		Insert	tplanrelease
		Select	PlanDate		= @ps_plandate,
			AreaCode		= @ps_areacode,
			DivisionCode		= @ps_divisioncode,
			WorkCenter		= @ps_workcenter,
			LineCode		= @ps_linecode,
			CycleOrder		= @li_plan_order,
			ReleaseOrder		= @j,
			ItemCode		= @ls_itemcode,
			KBNo			= 'A',
			KBReleaseDate		= 'A',
			KBReleaseSeq		= 0,
			TempGubun		= 'N',
			ReleaseGubun		= 'C',
			PrdFlag			= 'C',
			PlanKBCount		= 1,
			PlanKBQty		= A.NormalKBQty,
			ReleaseKBCount		= 0,
			ReleaseKBQty		= 0,
			LastEmp			= 'Y', --@ps_empcode,
			LastDate			= GetDate()
		From	#tmp_plan_kbcount	A
		Where	ItemCode	= @ls_itemcode

		If @@Error = 0
		Begin
			Select	@ls_error	= '00',
				@ls_errortext	= '����ȭ ���� ��ȹ�� �����Ͽ����ϴ�.'
		End
		Else
		Begin
			Select	@ls_error	= '11',
				@ls_errortext	= '����ȭ ���� ��ȹ�� �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
			GoTo Proc_Exit
		End

		Select	@j	= @j + 1

	End
End

-- ���� ���ʹ� �ӽð����� ó������.
-- �ӽð����� �� ������ �������� ó���Ѵ�.
Delete	#tmp_plan_kbcount
Where	TempKBCount	< 1

Select	@i		= 0,
	@li_loop_count	= Count(ItemCode),
	@li_plan_order	= 0
From	#tmp_plan_kbcount

While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@li_plan_order		= PlanOrder,
		@ls_itemcode		= ItemCode,
		@li_tempkbqty		= TempKBQty
	  From	#tmp_plan_kbcount
	 Where	PlanOrder	> @li_plan_order

	Select	@li_cycleorder	= Max(CycleOrder)
	From	tplanrelease
	Where	PlanDate		= @ps_plandate		And
		AreaCode		= @ps_areacode		And
		DivisionCode		= @ps_divisioncode	And
		WorkCenter		= @ps_workcenter	And
		LineCode		= @ps_linecode		And
		ItemCode		= @ls_itemcode

	Select	@li_releaseorder	= Max(ReleaseOrder)
	From	tplanrelease
	Where	PlanDate		= @ps_plandate		And
		AreaCode		= @ps_areacode		And
		DivisionCode		= @ps_divisioncode	And
		WorkCenter		= @ps_workcenter	And
		LineCode		= @ps_linecode		And
--		ItemCode		= @ls_itemcode		And
		CycleOrder		= @li_cycleorder

--select @li_cycleorder, @li_releaseorder

	Update	tplanrelease
	Set	TempGubun		= 'T',
		PlanKBCount		= 1,
		PlanKBQty		= @li_tempkbqty,
		LastEmp			= 'Y', --@ps_empcode,
		LastDate			= GetDate()
	From	tplanrelease
	Where	PlanDate		= @ps_plandate		And
		AreaCode		= @ps_areacode		And
		DivisionCode		= @ps_divisioncode	And
		WorkCenter		= @ps_workcenter	And
		LineCode		= @ps_linecode		And
		CycleOrder		= @li_cycleorder		And
		ReleaseOrder		= @li_releaseorder		

	If @@Error = 0
	Begin
		Select	@ls_error	= '00',
			@ls_errortext	= '����ȭ ���� ��ȹ�� �����Ͽ����ϴ�.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '�ӽð����� ����ȭ ���� ��ȹ�� �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
		GoTo Proc_Exit
	End
End

Proc_Exit:

/*
If @ls_error = '00'
	Commit Tran
Else
Begin
	RollBack Tran
End
*/

--select * from #tmp_plan
--select * from #tmp_plan_kbcount

Drop Table #Tmp_Leveling_Plan
Drop Table #Tmp_Plan_KBCount
Drop Table #Tmp_Plan

Select	Error		= @ls_error,
	ErrorText	= @ls_errortext

Return

End		-- Procedure End
Go
