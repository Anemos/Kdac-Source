/*
	File Name	: sp_piso_generate_timecode.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piso_generate_timecode
	Description	: Time Code 을 계산하자.
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 17
	Author		: Kim Jin-Su
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piso_generate_timecode]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piso_generate_timecode]
GO

/*
Execute sp_piso_generate_timecode
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'M',
	@ps_applydate		= '2002.10.01',
	@pi_applytime		= 60,
	@ps_empno		= 'SYSTEM'

select * from tmstflag
select * from tmsttimeapply
select * from tmsttime

select * from tmstdivision

delete tmsttimeapply
delete tmsttime
delete tmstflag
*/

Create Procedure sp_piso_generate_timecode
	@ps_areacode		char(1),		-- 지역
	@ps_divisioncode	char(1),		-- 공장
	@ps_applydate		char(10),	-- 시간대 코드 적용 시작일자
	@pi_applytime		Int,		-- 시간대 분할 기준 시각(5,10,15,20,30,40,45,60)
	@ps_empno		varchar(6)	-- 시간대 코드 생성 작업자 사번

As
Begin

Declare	@ls_before_applyfrom	Char(10),
	@ls_before_applyto	Char(10),
	@ls_applyto		Char(10),
	@ls_starttime		Char(8),
	@ls_timecode		Char(5),
	@ld_starttime		DateTime,
	@ld_endtime		DateTime,
	@i			Int,
	@li_loopcount		Int

Begin Tran

If Exists(Select * From tmsttimeapply
	   Where AreaCode	= @ps_areacode		And
		DivisionCode	= @ps_divisioncode	And
		ApplyFrom	<= @ps_applydate	And
		ApplyTo		> @ps_applydate)
Begin
	Select	@ls_before_applyfrom	= Max(ApplyFrom),
		@ls_before_applyto	= Convert(Char(10), DateAdd(DD, -1, Convert(DateTime, @ps_applydate)), 102)
	  From	tmsttimeapply
	 Where	AreaCode	= @ps_areacode		And
		DivisionCode	= @ps_divisioncode	And
		ApplyFrom	< @ps_applydate

	Update	tmsttimeapply
	   Set	ApplyTo		= @ls_before_applyto,
		LastEmp		= @ps_empno,
		LastDate		= GetDate()
	 Where	AreaCode	= @ps_areacode		And
		DivisionCode	= @ps_divisioncode	And
		ApplyFrom	= @ls_before_applyfrom

	If @@Error <> 0
	Begin
		RollBack Tran
		Return
	End

	Update	tmsttime
	   Set	ApplyTo		= @ls_before_applyto,
		LastEmp		= 'Y',--@ps_empno,
		LastDate	= GetDate()
	 Where	AreaCode	= @ps_areacode		And
		DivisionCode	= @ps_divisioncode	And
		ApplyFrom	= @ls_before_applyfrom

	If @@Error <> 0
	Begin
		RollBack Tran
		Return
	End
End

Select	@ls_applyto	= '9999.12.31'

Insert Into tmsttimeapply	(AreaCode,	DivisionCode,		ApplyFrom,	ApplyTo,		ApplyTime,	LastEmp,	LastDate)
Values			(@ps_areacode,	@ps_divisioncode,	@ps_applydate,	@ls_applyto,	@pi_applytime,	'Y',		GetDate())

If @@Error <> 0
Begin
	RollBack Tran
	Return
End

If Exists (Select	*
	From	tmstflag
	Where	AreaCode	= @ps_areacode		And
		DivisionCode	= @ps_divisioncode	And
		FlagCode	 = 'CHANGE_DATE')
Begin
	Select	@ls_starttime	= FlagGubun
	From	tmstflag
	Where	AreaCode	= @ps_areacode		And
		DivisionCode	= @ps_divisioncode	And
		FlagCode	= 'CHANGE_DATE'
	Group By FlagGubun
End
Else
Begin
	Select	@ls_starttime	= '08:00:00'

	Insert Into tmstflag	(AreaCode,	DivisionCode,		FlagCode,	FlagDate,
				FlagGubun,	FlagDesc,		LastEmp,	LastDate)
	Values			(@ps_areacode,	@ps_divisioncode,	'CHANGE_DATE',	'2002.01.01',
				@ls_starttime,	'일자 변경 시간',		@ps_empno,	GetDate())
	
	If @@Error <> 0
	Begin
		RollBack Tran
		Return
	End
End


Select 	@i		= 0,
	@li_loopcount	= (60 * 24) / @pi_applytime,
	@ls_timecode	= @ls_starttime,
	@ld_starttime	= Convert(DateTime, @ps_applydate + ' ' + @ls_starttime),
	@ld_endtime	= Convert(DateTime, @ps_applydate + ' ' + Convert(Char(8), DateAdd(S, -1, DateAdd(MI, @pi_applytime, Convert(datetime, @ls_starttime))), 108))

While @i < @li_loopcount
Begin
	Select	@i		= @i + 1

	Insert Into tmsttime	(AreaCode,	DivisionCode,		ApplyFrom,	TimeCode,	ApplyTo,
				TimeOrder,	TimeStart,		TimeEnd,	LastEmp,	LastDate)
	Values			(@ps_areacode,	@ps_divisioncode,	@ps_applydate,	@ls_timecode,	@ls_applyto,
				@i,		@ld_starttime,		@ld_endtime,	'Y'	,	GetDate())

	If @@Error <> 0
	Begin
		RollBack Tran
		Return
	End

	Select 	@ls_timecode	= Convert(Char(5), DateAdd(MI, @pi_applytime, Convert(DateTime, @ls_timecode)), 108),
		@ld_starttime	= DateAdd(MI, @pi_applytime, @ld_starttime),
		@ld_endtime	= DateAdd(MI, @pi_applytime, @ld_endtime)
End

Commit Tran

Return

End		-- Procedure End
Go
