/*
	File Name	: sp_pisp211u_03_u.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp211u_03_u
	Description	: 간판 마스터 추가 및 변경 - 변경 저장 프로시저
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 07
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp211u_03_u]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp211u_03_u]
GO

/*
Execute sp_pisp211u_03_u
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '4201',
	@ps_linecode		= 'A',
	@ps_itemcode		= '511513',
	@ps_applyfrom		= '2002.10.04',
	@ps_modelid		= '',
	@ps_lineid		= '',
	@ps_kbid		= '',
	@ps_normalkbsn		= '',
	@ps_tempkbsn		= '',
	@ps_productgubun	= '',
	@ps_stockgubun		= '',
	@ps_prdstopgubun	= '',
	@ps_rackcode		= '',
	@pi_rackqty		= 50,
	@pi_lotsize		= 0,
	@ps_mainlinegubun	= '',
	@pi_dividerate		= 100,
	@pi_pcsperhour		= 0,
	@pi_safetyinvqty		= 10,
	@pn_kbfactor		= 1,
	@pn_safetyfactor		= 1,
	@ps_stocklocation	= '',
	@pi_sortorder		= 1,
	@ps_empcode		= 'IPIS'

select * from tmstkb
select * from tmstkbhis where itemcode = 'K96297624'

dbcc opentran
*/

Create Procedure sp_pisp211u_03_u
	@ps_areacode		char(1),		-- 지역 코드
	@ps_divisioncode	char(1),		-- 공장 코드
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1),
	@ps_itemcode		varchar(12),
	@ps_applyfrom		varchar(10),
	@ps_modelid		varchar(4),
	@ps_lineid		varchar(2),
	@ps_kbid		varchar(4),
	@ps_normalkbsn		varchar(11),
	@ps_tempkbsn		varchar(11),
	@ps_productgubun	char(1),
	@ps_stockgubun		char(1),
	@ps_prdstopgubun	char(1),
	@ps_rackcode		varchar(5),
	@pi_rackqty		int,
	@pi_lotsize		int,
	@ps_carname		varchar(50),
	@ps_mainlinegubun	char(1),
	@pi_dividerate		int,
	@pi_pcsperhour		int,
	@pi_safetyinvqty		int,
	@pn_kbfactor		numeric(3,1),
	@pn_safetyfactor		numeric(3,1),
	@ps_stocklocation	varchar(3),
	@pi_sortorder		int,
	@ps_empcode		varchar(6)

As
Begin

Declare	@ldt_nowtime		datetime,	-- 지준일을 구하기 위한 현재 일시
	@ls_error		char(2),
	@ls_errortext		varchar(100)

Select	@ldt_nowtime	= GetDate()

-- 간판마스터 변경
Update	tmstkb
Set	ModelID			= @ps_modelid,
	ProductGubun		= @ps_productgubun,
	ApplyFrom		= @ps_applyfrom,
	LineID			= @ps_lineid,
	KBID			= @ps_kbid,
	NormalKBSN		= @ps_normalkbsn,
	TempKBSN		= @ps_tempkbsn,
	StockGubun		= @ps_stockgubun,
	PrdStopGubun		= @ps_prdstopgubun,
	RackCode		= @ps_rackcode,
	RackQty			= @pi_rackqty,
	LotSize			= @pi_lotsize,
	CarName		= @ps_carname,
	MainLineGubun		= @ps_mainlinegubun,
	DivideRate		= @pi_dividerate,
	PCSPerHour		= @pi_pcsperhour,
	SafetyInvQty		= @pi_safetyinvqty,
	KBFactor		= @pn_kbfactor,
	SafetyFactor		= @pn_safetyfactor,
	StockLocation		= @ps_stocklocation,
	SortOrder		= @pi_sortorder,
	LastEmp			= 'Y',--@ps_empcode,
	LastDate			= @ldt_nowtime
Where	AreaCode		= @ps_areacode		And
	DivisionCode		= @ps_divisioncode	And
	WorkCenter		= @ps_workcenter	And
	LineCode		= @ps_linecode		And
	ItemCode		= @ps_itemcode
If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '간판마스터를 변경하였습니다.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '간판마스터를 변경하는 중에 오류가 발생하였습니다.'
	GoTo Proc_Exit
End


-- 만약 오늘 날짜에 변경했던 간판 이력이 존재하면
-- 새롭게 추가 하지 말고,,그냥 업데이트 하자..
-- tkbhis 의 KEY 가 이상하게 설정되어 있다...ㅅㅂ
If Exists (	Select	*
		From	tmstkbhis
		Where	AreaCode	= @ps_areacode		And
			DivisionCode	= @ps_divisioncode	And
			WorkCenter	= @ps_workcenter	And
			LineCode	= @ps_linecode		And
			ItemCode	= @ps_itemcode		And
			ApplyFrom	= @ps_applyfrom		And
			ApplyTo		= '9999.12.31')
Begin
	--간판마스터 이력 추가
	Update	tmstkbhis
	Set	--AreaCode		= @ps_areacode,
--		DivisionCode		= @ps_divisioncode,
--		WorkCenter		= @ps_workcenter,
--		LineCode		= @ps_linecode,
--		ItemCode		= @ps_itemcode,
		ApplyFrom		= @ps_applyfrom,
		ApplyTo			= '9999.12.31',
		ModelID			= @ps_modelid,
		LineID			= @ps_lineid,
		KBID			= @ps_kbid,
		NormalKBSN		= @ps_normalkbsn,
		TempKBSN		= @ps_tempkbsn,
		ProductGubun		= @ps_productgubun,
		StockGubun		= @ps_stockgubun,
		PrdStopGubun		= @ps_prdstopgubun,
		RackCode		= @ps_rackcode,
		RackQty			= @pi_rackqty,
		LotSize			= @pi_lotsize,
		CarName		= @ps_carname,
		MainLineGubun		= @ps_mainlinegubun,
		DivideRate		= @pi_dividerate,
		PCSPerHour		= @pi_pcsperhour,
		SafetyInvQty		= @pi_safetyinvqty,
		KBFactor		= @pn_kbfactor,
		SafetyFactor		= @pn_safetyfactor,
		StockLocation		= @ps_stocklocation,
		SortOrder		= @pi_sortorder,
		LastEmp			= 'Y',--@ps_empcode,
		LastDate			= @ldt_nowtime
	Where	AreaCode		= @ps_areacode		And
		DivisionCode		= @ps_divisioncode	And
		WorkCenter		= @ps_workcenter	And
		LineCode		= @ps_linecode		And
		ItemCode		= @ps_itemcode		And
		ApplyFrom		= @ps_applyfrom		And
		ApplyTo			= '9999.12.31'

	If @@Error = 0
	Begin
		Select	@ls_error	= '00',
			@ls_errortext	= '간판마스터 이력을 변경하였습니다.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '간판마스터 이력을 변경하는 중에 오류가 발생하였습니다.'
		GoTo Proc_Exit
	End
End
Else
Begin
	-- 간판마스터 이력 변경
	Update	tmstkbhis
	Set	ApplyTo		= @ps_applyfrom,
		LastEmp		= 'Y',--@ps_empcode,
		LastDate		= @ldt_nowtime
	Where	AreaCode	= @ps_areacode		And
		DivisionCode	= @ps_divisioncode	And
		WorkCenter	= @ps_workcenter	And
		LineCode	= @ps_linecode		And
		ItemCode	= @ps_itemcode		And
		ApplyFrom	<= @ps_applyfrom		And
		ApplyTo		> @ps_applyfrom
	If @@Error = 0
	Begin
		Select	@ls_error	= '00',
			@ls_errortext	= '간판마스터 이력을 변경하였습니다.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '간판마스터 이력을 변경하는 중에 오류가 발생하였습니다.'
		GoTo Proc_Exit
	End
	
	--간판마스터 이력 추가
	Insert	tmstkbhis
	Select	AreaCode		= @ps_areacode,
		DivisionCode		= @ps_divisioncode,
		WorkCenter		= @ps_workcenter,
		LineCode		= @ps_linecode,
		ItemCode		= @ps_itemcode,
		ApplyFrom		= @ps_applyfrom,
		ApplyTo			= '9999.12.31',
		ModelID			= @ps_modelid,
		LineID			= @ps_lineid,
		KBID			= @ps_kbid,
		NormalKBSN		= @ps_normalkbsn,
		TempKBSN		= @ps_tempkbsn,
		ProductGubun		= @ps_productgubun,
		StockGubun		= @ps_stockgubun,
		PrdStopGubun		= @ps_prdstopgubun,
		RackCode		= @ps_rackcode,
		RackQty			= @pi_rackqty,
		LotSize			= @pi_lotsize,
		CarName		= @ps_carname,
		MainLineGubun		= @ps_mainlinegubun,
		DivideRate		= @pi_dividerate,
		PCSPerHour		= @pi_pcsperhour,
		SafetyInvQty		= @pi_safetyinvqty,
		KBFactor		= @pn_kbfactor,
		SafetyFactor		= @pn_safetyfactor,
		StockLocation		= @ps_stocklocation,
		SortOrder		= @pi_sortorder,
		LastEmp			= 'Y',--@ps_empcode,
		LastDate			= @ldt_nowtime
	If @@Error = 0
	Begin
		Select	@ls_error	= '00',
			@ls_errortext	= '간판마스터 이력을 추가하였습니다.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '간판마스터 이력을 추가하는 중에 오류가 발생하였습니다.'
		GoTo Proc_Exit
	End
End

-- 동일 제품의 간판 마스터 변경
Update	tmstkb
Set	ModelID		= @ps_modelid,
	ProductGubun	= @ps_productgubun,
	StockGubun	= @ps_stockgubun,
	RackQty		= @pi_rackqty,

	RackCode	= @ps_rackcode,
	CarName	= @ps_carname,

	SafetyInvQty	= @pi_safetyinvqty,
	StockLocation	= @ps_stocklocation,
--	SortOrder	= @pi_sortorder,
	LastEmp		= 'Y',--@ps_empcode,
	LastDate		= @ldt_nowtime
Where	AreaCode	= @ps_areacode		And
	DivisionCode	= @ps_divisioncode	And
--	(WorkCenter	<> :ls_workcenter	Or	LineCode	<> :ls_linecode)	And
	ItemCode	= @ps_itemcode
If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '동일 제품의 간판마스터를 변경하였습니다.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '동일 제품의 간판마스터를 변경하는 중에 오류가 발생하였습니다.'
	GoTo Proc_Exit
End

-- 동일 제품의 간판 마스터 이력 변경
Update	tmstkbhis
Set	ModelID		= @ps_modelid,
	ProductGubun	= @ps_productgubun,
	StockGubun	= @ps_stockgubun,
	RackQty		= @pi_rackqty,

	RackCode	= @ps_rackcode,
	CarName	= @ps_carname,

	SafetyInvQty	= @pi_safetyinvqty,
	StockLocation	= @ps_stocklocation,
--	SortOrder	= @pi_sortorder,
	LastEmp		= 'Y',--@ps_empcode,
	LastDate		= @ldt_nowtime
Where	AreaCode	= @ps_areacode		And
	DivisionCode	= @ps_divisioncode	And
--	(WorkCenter	<> :ls_workcenter	Or	LineCode	<> :ls_linecode)	And
	ItemCode	= @ps_itemcode		And
	ApplyTo		= '9999.12.31'
If @@Error = 0
Begin
	Select	@ls_error	= '00',
--		@ls_errortext	= '동일 제품의 간판마스터 이력을 변경하였습니다.'
		@ls_errortext	= '간판마스터를 변경하였습니다.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '동일 제품의 간판마스터 이력을 변경하는 중에 오류가 발생하였습니다.'
	GoTo Proc_Exit
End


/*
// 조회순서가 변경된 경우만...처리하자.
If ll_sortorder <> li_sortorder_old Then
	If ll_sortorder > li_sortorder_old Then
		Update	tmstkb
		Set		SortOrder			= SortOrder - 1,
					LastEmp				= :g_s_empno,
					LastDate				= GetDate()
		Where		AreaCode			= :ls_areacode			And
					DivisionCode	= :ls_divisioncode	And
					WorkCenter		= :ls_workcenter		And
					LineCode			= :ls_linecode			And
					ItemCode			<> :ls_itemcode		And
					(SortOrder		Between :li_sortorder_old And :ll_sortorder)
		Using SQLPIS;
		
		If SQLPIS.sqlcode = 0 Then
			lb_error	= False
		Else
			RollBack Using SQLPIS;
			SQLPIS.AutoCommit = True
			lb_error	= True
			MessageBox("간판 마스터 변경", "간판 마스터의 조회순서를 변경하는 중에 오류가 발생하였습니다.", StopSign!)
			Return
		End If
		
		Update	tmstkbhis
		Set		SortOrder			= SortOrder - 1,
					LastEmp				= :g_s_empno,
					LastDate				= GetDate()
		Where		AreaCode			= :ls_areacode			And
					DivisionCode	= :ls_divisioncode	And
					WorkCenter		= :ls_workcenter		And
					LineCode			= :ls_linecode			And
					ItemCode			<> :ls_itemcode		And
					ApplyTo			= '9999.12.31'			And
					(SortOrder		Between :li_sortorder_old And :ll_sortorder)
		Using SQLPIS;
		
		If SQLPIS.sqlcode = 0 Then
			lb_error	= False
		Else
			RollBack Using SQLPIS;
			SQLPIS.AutoCommit = True
			lb_error	= True
			MessageBox("간판 마스터 변경", "간판 마스터 이력의 조회순서를 변경하는 중에 오류가 발생하였습니다.", StopSign!)
			Return
		End If
	Else
		Update	tmstkb
		Set		SortOrder			= SortOrder + 1,
					LastEmp				= :g_s_empno,
					LastDate				= GetDate()
		Where		AreaCode			= :ls_areacode			And
					DivisionCode	= :ls_divisioncode	And
					WorkCenter		= :ls_workcenter		And
					LineCode			= :ls_linecode			And
					ItemCode			<> :ls_itemcode		And
					(SortOrder		Between :ll_sortorder And :li_sortorder_old)
		Using SQLPIS;
		
		If SQLPIS.sqlcode = 0 Then
			lb_error	= False
		Else
			RollBack Using SQLPIS;
			SQLPIS.AutoCommit = True
			lb_error	= True
			MessageBox("간판 마스터 변경", "간판 마스터의 조회순서를 변경하는 중에 오류가 발생하였습니다.", StopSign!)
			Return
		End If
		
		Update	tmstkbhis
		Set		SortOrder			= SortOrder + 1,
					LastEmp				= :g_s_empno,
					LastDate				= GetDate()
		Where		AreaCode			= :ls_areacode			And
					DivisionCode	= :ls_divisioncode	And
					WorkCenter		= :ls_workcenter		And
					LineCode			= :ls_linecode			And
					ItemCode			<> :ls_itemcode		And
					ApplyTo			= '9999.12.31'			And
					(SortOrder		Between :ll_sortorder And :li_sortorder_old)
		Using SQLPIS;
		
		If SQLPIS.sqlcode = 0 Then
			lb_error	= False
		Else
			RollBack Using SQLPIS;
			SQLPIS.AutoCommit = True
			lb_error	= True
			MessageBox("간판 마스터 변경", "간판 마스터 이력의 조회순서를 변경하는 중에 오류가 발생하였습니다.", StopSign!)
			Return
		End If
	End If
End If
*/

Proc_Exit:

/*
If @ls_error = '00'
Begin
	Commit Tran
End
Else
Begin
	RollBack Tran
End
*/

Select	Error		= @ls_error,
	ErrorText	= @ls_errortext

Return

End		-- Procedure End
Go
