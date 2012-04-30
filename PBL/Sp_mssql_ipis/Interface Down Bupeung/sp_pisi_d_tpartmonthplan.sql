/*
	File Name	: sp_pisi_d_tpartmonthplan.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tpartmonthplan
	Description	: Download Part Monthly Plan(월간자재소요계획) - 월 1회
			  tpartmonthplan
			  여주전자 서버추가 : 2004.04.19
			  부평물류 서버추가 : 2005.10
			  군산물류 서버추가 : 2005.10
			  
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tpartmonthplan]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tpartmonthplan]
GO

/*
Execute sp_pisi_d_tpartmonthplan
*/

Create Procedure sp_pisi_d_tpartmonthplan
	@ps_month		char(6)		-- 다음달
	
As
Begin

set xact_abort off

declare	@ls_month	char(7)

select @ls_month = substring(@ps_month,1,4)+'.'+substring(@ps_month,5,2)

If Not Exists (select * from tmispartmonthplan)
	Begin
	Return
	End

-- 대구전장
If Exists (select * from tmispartmonthplan	where	xplant	=	'D'	and
							div	in	('A')	and
							Extd	=	@ps_month)
Begin
	Delete From [ipisele_svr\ipis].ipis.dbo.tpartmonthplan
	Where	applymonth	=	@ls_Month

	if @@error	=	0
	Begin
		insert into [ipisele_svr\ipis].ipis.dbo.tpartmonthplan
			(ApplyMonth,	AreaCode,		DivisionCode,
			 ItemCode,	PartForecastQty,
			 ChangeDate,				LastEmp)
		select	 @ls_month,	XPLANT,			DIV,
			 ITNO,		MADGRSQ+MAEGRSQ+MBDGRSQ+MBEGRSQ,
			 Convert(Char(10),Getdate(),102),	'SYSTEM'
		from	tmispartmonthplan
		where	Xplant	=	'D'	and
			div	in	('A')
		
		if @@error	=	0
		Begin
			Delete	From	TmisPartMonthPlan
			Where	Xplant+div+itno	in	(Select	Areacode+DivisionCode+ItemCode	From	[ipisele_svr\ipis].ipis.dbo.tpartmonthplan
								Where	applymonth	=	@ls_month)
		End
	End
End				

-- 대구기계
If Exists (select * from tmispartmonthplan	where	xplant	=	'D'		and
							div	in	('M','S')	and
							Extd	=	@ps_month)
Begin

	Delete From [ipismac_svr\ipis].ipis.dbo.tpartmonthplan
	Where	applymonth	=	@ls_Month

	if @@error	=	0
	Begin
		insert into [ipismac_svr\ipis].ipis.dbo.tpartmonthplan
			(ApplyMonth,	AreaCode,		DivisionCode,
			 ItemCode,	PartForecastQty,
			 ChangeDate,				LastEmp)
		select	 @ls_month,	XPLANT,			DIV,
			 ITNO,		MADGRSQ+MAEGRSQ+MBDGRSQ+MBEGRSQ,
			 Convert(Char(10),Getdate(),102),	'SYSTEM'
		from	tmispartmonthplan
		where	Xplant	=	'D'	and
			div	in	('M','S')
		
		if @@error	=	0
		Begin
			Delete	From	TmisPartMonthPlan
			Where	Xplant+div+itno	in	(Select	Areacode+DivisionCode+ItemCode	From	[ipismac_svr\ipis].ipis.dbo.tpartmonthplan
								Where	applymonth	=	@ls_month)
		End
	End
End			
-- 대구공조
If Exists (select * from tmispartmonthplan	where	(xplant	=	'D'		and
							 div	in	('H','V'))	and	
							 Extd	=	@ps_month)

Begin

	Delete From [ipishvac_svr\ipis].ipis.dbo.tpartmonthplan
	Where	applymonth	=	@ls_Month

	if @@error	=	0
	Begin
		insert into [ipishvac_svr\ipis].ipis.dbo.tpartmonthplan
			(ApplyMonth,	AreaCode,		DivisionCode,
			 ItemCode,	PartForecastQty,
			 ChangeDate,				LastEmp)
		select	 @ls_month,	XPLANT,			DIV,
			 ITNO,		MADGRSQ+MAEGRSQ+MBDGRSQ+MBEGRSQ,
			 Convert(Char(10),Getdate(),102),	'SYSTEM'
		from	tmispartmonthplan
		where	(xplant	=	'D'		and
			div	in	('H','V'))
		
		if @@error	=	0
		Begin
			Delete	From	TmisPartMonthPlan
			Where	Xplant+div+itno	in	(Select	Areacode+DivisionCode+ItemCode	From	[ipishvac_svr\ipis].ipis.dbo.tpartmonthplan
								Where	applymonth	=	@ls_month)
		End
	End
End			


-- 부평물류
If Exists (select * from tmispartmonthplan	where	Xplant	= 'B'	and	
							 Extd	=	@ps_month)

Begin

	Delete From [ipisbup_svr\ipis].ipis.dbo.tpartmonthplan
	Where	applymonth	=	@ls_Month

	if @@error	=	0
	Begin
		insert into [ipisbup_svr\ipis].ipis.dbo.tpartmonthplan
			(ApplyMonth,	AreaCode,		DivisionCode,
			 ItemCode,	PartForecastQty,
			 ChangeDate,				LastEmp)
		select	 @ls_month,	XPLANT,			DIV,
			 ITNO,		MADGRSQ+MAEGRSQ+MBDGRSQ+MBEGRSQ,
			 Convert(Char(10),Getdate(),102),	'SYSTEM'
		from	tmispartmonthplan
		where	Xplant	= 'B'
		
		if @@error	=	0
		Begin
			Delete	From	TmisPartMonthPlan
			Where	Xplant+div+itno	in	(Select	Areacode+DivisionCode+ItemCode	From	[ipisbup_svr\ipis].ipis.dbo.tpartmonthplan
								Where	applymonth	=	@ls_month)
		End
	End
End			

-- 군산물류
If Exists (select * from tmispartmonthplan	where	Xplant	= 'K'	and	
							 Extd	=	@ps_month)

Begin

	Delete From [ipiskun_svr\ipis].ipis.dbo.tpartmonthplan
	Where	applymonth	=	@ls_Month

	if @@error	=	0
	Begin
		insert into [ipiskun_svr\ipis].ipis.dbo.tpartmonthplan
			(ApplyMonth,	AreaCode,		DivisionCode,
			 ItemCode,	PartForecastQty,
			 ChangeDate,				LastEmp)
		select	 @ls_month,	XPLANT,			DIV,
			 ITNO,		MADGRSQ+MAEGRSQ+MBDGRSQ+MBEGRSQ,
			 Convert(Char(10),Getdate(),102),	'SYSTEM'
		from	tmispartmonthplan
		where	Xplant	= 'K'
		
		if @@error	=	0
		Begin
			Delete	From	TmisPartMonthPlan
			Where	Xplant+div+itno	in	(Select	Areacode+DivisionCode+ItemCode	From	[ipiskun_svr\ipis].ipis.dbo.tpartmonthplan
								Where	applymonth	=	@ls_month)
		End
	End
End	

-- 여주전자
If Exists (select * from tmispartmonthplan	where	xplant	=	'Y'		and	
							 Extd	=	@ps_month)

Begin

	Delete From [ipisyeo_svr\ipis].ipis.dbo.tpartmonthplan
	Where	applymonth	=	@ls_Month

	if @@error	=	0
	Begin
		insert into [ipisyeo_svr\ipis].ipis.dbo.tpartmonthplan
			(ApplyMonth,	AreaCode,		DivisionCode,
			 ItemCode,	PartForecastQty,
			 ChangeDate,				LastEmp)
		select	 @ls_month,	XPLANT,			DIV,
			 ITNO,		MADGRSQ+MAEGRSQ+MBDGRSQ+MBEGRSQ,
			 Convert(Char(10),Getdate(),102),	'SYSTEM'
		from	tmispartmonthplan
		where	xplant	=	'Y'
		
		if @@error	=	0
		Begin
			Delete	From	TmisPartMonthPlan
			Where	Xplant+div+itno	in	(Select	Areacode+DivisionCode+ItemCode	From	[ipisyeo_svr\ipis].ipis.dbo.tpartmonthplan
								Where	applymonth	=	@ls_month)
		End
	End
End

-- 진천
If Exists (select * from tmispartmonthplan	where	xplant	=	'J'		and
							Extd	=	@ps_month)
Begin

	Delete From [ipisjin_svr].ipis.dbo.tpartmonthplan
	Where	applymonth	=	@ls_Month

	if @@error	=	0
	Begin
		insert into [ipisjin_svr].ipis.dbo.tpartmonthplan
			(ApplyMonth,	AreaCode,		DivisionCode,
			 ItemCode,	PartForecastQty,
			 ChangeDate,				LastEmp)
		select	 @ls_month,	XPLANT,			DIV,
			 ITNO,		MADGRSQ+MAEGRSQ+MBDGRSQ+MBEGRSQ,
			 Convert(Char(10),Getdate(),102),	'SYSTEM'
		from	tmispartmonthplan
		where	Xplant	=	'J'
		
		if @@error	=	0
		Begin
			Delete	From	TmisPartMonthPlan
			Where	Xplant+div+itno	in	(Select	Areacode+DivisionCode+ItemCode	From	[ipisjin_svr].ipis.dbo.tpartmonthplan
								Where	applymonth	=	@ls_month)
		End
	End
End			

 
End		-- Procedure End
Go
