/*
	File Name	: sp_pisi_d_tmstbomdata.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tmstbomdata
	Description	: Download tmstbomdata(원단위 DB - 공수) - 월초 1회
			  여주전자 서버추가 : 2004.04.19
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tmstbomdata]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tmstbomdata]
GO

/*
Execute sp_pisi_d_tmstbomdata '200303'
*/

Create Procedure sp_pisi_d_tmstbomdata
	@ps_month		char(6)		-- 이번달
	
As
Begin

set xact_abort off

declare	@ls_month	char(7)

select @ls_month = substring(@ps_month,1,4)+'.'+substring(@ps_month,5,2)

-- 대구전장
If Exists (select * from tmisbomdata	where mplant	=	'D'	and
					mdiv		in	('A')	and
					mdate		=	@ps_month)

Begin
	Delete From [ipisele_svr\ipis].ipis.dbo.tmstbomdata
	Where	applymonth	=	@ls_Month

	if @@error	=	0
	Begin
		insert into [ipisele_svr\ipis].ipis.dbo.tmstbomdata
			(AreaCode,	DivisionCode,	
			ApplyMonth,	
			BMDCD,		BMDNO,		BSERNO,		BPRNO,		BCHNO,
			BLEV,		BUM,		BWOCT,		BPRQT,		
			BPRQT1,		
			BFMDT,		
			BTODT,		
			BALCD,		LastEmp)	
		select	MPLANT,		MDIV,		
			substring(MDATE,1,4)+'.'+substring(MDATE,5,2),
			MDCD,		MDNO,		MSERIAL,	MPRNO,		MCHNO,
			MLEVEL,		MUNIT,		MWKCT,		MQTYSUM,
			MQTY,		
			substring(MFMDT,1,4)+'.'+substring(MFMDT,5,2)+'.'+substring(MFMDT,7,2),
			substring(MTODT,1,4)+'.'+substring(MTODT,5,2)+'.'+substring(MTODT,7,2),
			MOPTION,	'SYSTEM'
		from	tmisbomdata	
		where	mplant = 'D'
		and	mdiv in ('A')
		and	mdate = @ps_month
		
		if @@error	=	0
		Begin
			Delete	From	tmisbomdata
			Where	mplant+mdiv+mdate in 
			(select	areacode+Divisioncode+substring(applymonth,1,4)+substring(applymonth,6,2)	From	[ipisele_svr\ipis].ipis.dbo.tmstbomdata)
		End
	End	
End

-- 대구기계
If Exists (select * from tmisbomdata	where mplant	=	'D'	and
					mdiv		in	('M','S')	and
					mdate		=	@ps_month)

Begin
	Delete From [ipismac_svr\ipis].ipis.dbo.tmstbomdata
	Where	applymonth	=	@ls_Month

	if @@error	=	0
	Begin
		insert into [ipismac_svr\ipis].ipis.dbo.tmstbomdata
			(AreaCode,	DivisionCode,	
			ApplyMonth,	
			BMDCD,		BMDNO,		BSERNO,		BPRNO,		BCHNO,
			BLEV,		BUM,		BWOCT,		BPRQT,		
			BPRQT1,		
			BFMDT,		
			BTODT,		
			BALCD,		LastEmp)	
		select	MPLANT,		MDIV,		
			substring(MDATE,1,4)+'.'+substring(MDATE,5,2),
			MDCD,		MDNO,		MSERIAL,	MPRNO,		MCHNO,
			MLEVEL,		MUNIT,		MWKCT,		MQTYSUM,
			MQTY,		
			substring(MFMDT,1,4)+'.'+substring(MFMDT,5,2)+'.'+substring(MFMDT,7,2),
			substring(MTODT,1,4)+'.'+substring(MTODT,5,2)+'.'+substring(MTODT,7,2),
			MOPTION,	'SYSTEM'
		from	tmisbomdata	
		where	mplant = 'D'
		and	mdiv in ('M','S')
		and	mdate = @ps_month
		
		if @@error	=	0
		Begin
			Delete	From	tmisbomdata
			Where	mplant+mdiv+mdate in 
			(select	areacode+Divisioncode+substring(applymonth,1,4)+substring(applymonth,6,2)	From	[ipismac_svr\ipis].ipis.dbo.tmstbomdata)
		End
	End	
End

-- 대구공조
If Exists (select * from tmisbomdata	where	((mplant		=	'D'		and
						mdiv		in	('H','V'))	or
						Mplant	= 'K')	and
						mdate		=	@ps_month)
Begin
	Delete From [ipishvac_svr\ipis].ipis.dbo.tmstbomdata
	Where	applymonth	=	@ls_Month

	if @@error	=	0
	Begin
		insert into [ipishvac_svr\ipis].ipis.dbo.tmstbomdata
			(AreaCode,	DivisionCode,	
			ApplyMonth,	
			BMDCD,		BMDNO,		BSERNO,		BPRNO,		BCHNO,
			BLEV,		BUM,		BWOCT,		BPRQT,		
			BPRQT1,		
			BFMDT,		
			BTODT,		
			BALCD,		LastEmp)	
		select	MPLANT,		MDIV,		
			substring(MDATE,1,4)+'.'+substring(MDATE,5,2),
			MDCD,		MDNO,		MSERIAL,	MPRNO,		MCHNO,
			MLEVEL,		MUNIT,		MWKCT,		MQTYSUM,
			MQTY,		
			substring(MFMDT,1,4)+'.'+substring(MFMDT,5,2)+'.'+substring(MFMDT,7,2),
			substring(MTODT,1,4)+'.'+substring(MTODT,5,2)+'.'+substring(MTODT,7,2),
			MOPTION,	'SYSTEM'
		from	tmisbomdata	
		where	((mplant		=	'D'		and
			  mdiv		in	('H','V'))	or
			  Mplant		in	('K','Y'))	and
			  mdate		=	@ps_month
		
		if @@error	=	0
		Begin
			Delete	From	tmisbomdata
			Where	mplant+mdiv+mdate in 
			(select	areacode+Divisioncode+substring(applymonth,1,4)+substring(applymonth,6,2)	From	[ipishvac_svr\ipis].ipis.dbo.tmstbomdata)
		End
	End	
End

-- 여주전자
If Exists (select * from tmisbomdata	where	Mplant	= 'Y'	and
						mdate		=	@ps_month)
Begin
	Delete From [ipisyeo_svr\ipis].ipis.dbo.tmstbomdata
	Where	applymonth	=	@ls_Month

	if @@error	=	0
	Begin
		insert into [ipisyeo_svr\ipis].ipis.dbo.tmstbomdata
			(AreaCode,	DivisionCode,	
			ApplyMonth,	
			BMDCD,		BMDNO,		BSERNO,		BPRNO,		BCHNO,
			BLEV,		BUM,		BWOCT,		BPRQT,		
			BPRQT1,		
			BFMDT,		
			BTODT,		
			BALCD,		LastEmp)	
		select	MPLANT,		MDIV,		
			substring(MDATE,1,4)+'.'+substring(MDATE,5,2),
			MDCD,		MDNO,		MSERIAL,	MPRNO,		MCHNO,
			MLEVEL,		MUNIT,		MWKCT,		MQTYSUM,
			MQTY,		
			substring(MFMDT,1,4)+'.'+substring(MFMDT,5,2)+'.'+substring(MFMDT,7,2),
			substring(MTODT,1,4)+'.'+substring(MTODT,5,2)+'.'+substring(MTODT,7,2),
			MOPTION,	'SYSTEM'
		from	tmisbomdata	
		where	Mplant	= 'Y'	and
			  mdate		=	@ps_month
		
		if @@error	=	0
		Begin
			Delete	From	tmisbomdata
			Where	mplant+mdiv+mdate in 
			(select	areacode+Divisioncode+substring(applymonth,1,4)+substring(applymonth,6,2)	From	[ipisyeo_svr\ipis].ipis.dbo.tmstbomdata)
		End
	End	
End

--진천
If Exists (select * from tmisbomdata	where	mplant		=	'J'		and
						mdate		=	@ps_month)
Begin
	Delete From [ipisjin_svr].ipis.dbo.tmstbomdata
	Where	applymonth	=	@ls_Month

	if @@error	=	0
	Begin
		insert into [ipisjin_svr].ipis.dbo.tmstbomdata
			(AreaCode,	DivisionCode,	
			ApplyMonth,	
			BMDCD,		BMDNO,		BSERNO,		BPRNO,		BCHNO,
			BLEV,		BUM,		BWOCT,		BPRQT,		
			BPRQT1,		
			BFMDT,		
			BTODT,		
			BALCD,		LastEmp)	
		select	MPLANT,		MDIV,		
			substring(MDATE,1,4)+'.'+substring(MDATE,5,2),
			MDCD,		MDNO,		MSERIAL,	MPRNO,		MCHNO,
			MLEVEL,		MUNIT,		MWKCT,		MQTYSUM,
			MQTY,		
			substring(MFMDT,1,4)+'.'+substring(MFMDT,5,2)+'.'+substring(MFMDT,7,2),
			substring(MTODT,1,4)+'.'+substring(MTODT,5,2)+'.'+substring(MTODT,7,2),
			MOPTION,	'SYSTEM'
		from	tmisbomdata	
		where	mplant		=	'J'		and
						mdate		=	@ps_month
		
		if @@error	=	0
		Begin
			Delete	From	tmisbomdata
			Where	mplant+mdiv+mdate in 
			(select	areacode+Divisioncode+substring(applymonth,1,4)+substring(applymonth,6,2)	From	[ipisjin_svr].ipis.dbo.tmstbomdata)
		End
	End	
End	
End		-- Procedure End
Go
