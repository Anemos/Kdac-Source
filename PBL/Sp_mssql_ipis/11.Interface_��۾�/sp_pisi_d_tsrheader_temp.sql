/*
	File Name	: sp_pisi_d_tsrheader_temp.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tsrheader_temp
	Description	: Download SR Header
			  tsrheader - pdsle301
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tsrheader_temp]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tsrheader_temp]
GO

/*
Execute sp_pisi_d_tsrheader_temp
*/

Create Procedure sp_pisi_d_tsrheader_temp
	
	
As
Begin

Declare	@i			Int,
	@li_loop_count		Int,
	@ls_chgcd		char(1),
	@ls_srno		varchar(11),
	@ls_dpdt		varchar(10),	-- 출하요구일자
	@ls_srdt		varchar(10),	-- SR 확정일
	@ls_invoice		varchar(20),
	@ls_indt		varchar(10),	-- invoice 일자
	@ls_mlc			varchar(15),
	@ls_mlcdt		varchar(10),	-- master lc 개설일자
	@ls_llc			varchar(15),
	@ls_llcdt		varchar(10),	-- local lc 개설일자
	@ls_elno1		varchar(15),
	@ls_elno1dt		varchar(10),	-- el date 1
	@ls_elno2		varchar(15),
	@ls_elno2dt		varchar(10),	-- el date 2
	@ls_paycd		char(1),
	@ls_dstn		char(2),
	@ls_date		varchar(30)
	
Select	*
into	#tmp_pdsle301
from	pdsle301
order by chgdate
	
Select @i = 0, @li_loop_count = @@RowCount, @ls_date = ''

While @i < @li_loop_count
Begin
	Select	Top 1
		@i		= @i + 1,
		@ls_chgcd	= chgcd,
		@ls_srno	= rtrim(srno),
		@ls_dpdt	= substring(dpdt,1,4)+substring(dpdt,5,2)+substring(dpdt,7,2),
		@ls_srdt	= substring(srdt,1,4)+substring(srdt,5,2)+substring(srdt,7,2),
		@ls_invoice	= invoice,
		@ls_indt	= substring(indt,1,4)+substring(indt,5,2)+substring(indt,7,2),
		@ls_mlc		= mlc,
		@ls_mlcdt	= substring(mlcdt,1,4)+substring(mlcdt,5,2)+substring(mlcdt,7,2),
		@ls_llc		= llc,
		@ls_llcdt	= substring(llcdt,1,4)+substring(llcdt,5,2)+substring(llcdt,7,2),
		@ls_elno1	= elno1,
		@ls_elno1dt	= substring(elno1dt,1,4)+substring(elno1dt,5,2)+substring(elno1dt,7,2),
		@ls_elno2	= elno2,
		@ls_elno2dt	= substring(elno2dt,1,4)+substring(elno2dt,5,2)+substring(elno2dt,7,2),
		@ls_paycd	= paycd,
		@ls_dstn	= dstn,
		@ls_date	= chgdate
	From	#tmp_pdsle301
	Where	chgdate > @ls_date

	If @ls_chgcd = 'A' 	-- 추가
	Begin
			
	If len(@ls_srno) = 9 		---------------------------
	begin
		-- 대구전장
		insert into [ipisele_svr\ipis].ipis.dbo.tsrorder
			(SRNo,			PCGubun,		PSRNo,			
			KitGubun,
			SRAreaCode, 		SRDivisionCode,		ShipGubun,		SRYear,
			SRMonth,		SRSerial,		SRSplitCount,		AreaCode,	
			DivisionCode,		ProductGroup,		ModelGroup,		ProductCode,
			ItemCode,		CustCode,		
			ApplyFrom,		
			ShipEditNo,
			ShipOrderQty,		ShipRemainQty,		ShipEndGubun,		SRCancelGubun,		
			CustomerItemNo,		ShipUsage,		CheckSRNo,		stcd,
			orderno,		LastEmp)
		select	rtrim(csrno) + 'P00',	'P',			rtrim(csrno) + 'P00',
			'N', 			
			xplant,			div,			substring(srno,2,1),	substring(srno,3,1),
			substring(srno,4,1),	substring(srno,5,3),	substring(srno,8,2),	xplant,
			div,			substring(pdcd,1,2),	substring(pdcd,1,3),	substring(pdcd,1,4),
			itno, 			custcd,			
			substring(frdt, 1, 4)+'.'+substring(frdt, 5, 2)+'.'+substring(frdt, 7,2),
			case dktm	when '' then 1
					when 0 then 1
					else dktm end,
			srqty,			srqty - saqty,		'N',			'N',			
			citno, 			suse,			srno,			'N',			
			ordno,			'SYSTEM'
		from	sle302_temp
		where	srno = @ls_srno
		and	kitcd not in ('P','C')
		and	stcd <> 'C'
		and	xplant = 'D'
		and	div in ('A')

		insert into [ipisele_svr\ipis].ipis.dbo.tsrorder
			(SRNo,			PCGubun,		PSRNo,			
			KitGubun,
			SRAreaCode, 		SRDivisionCode,		ShipGubun,		SRYear,
			SRMonth,		SRSerial,		SRSplitCount,		AreaCode,	
			DivisionCode,		ProductGroup,		ModelGroup,		ProductCode,
			ItemCode,		CustCode,		
			ApplyFrom,		
			ShipEditNo,
			ShipOrderQty,		ShipRemainQty,		ShipEndGubun,		SRCancelGubun,		
			CustomerItemNo,		ShipUsage,		CheckSRNo,		stcd,
			orderno,		LastEmp)
		select	rtrim(csrno) + 'P00',	'P',			rtrim(csrno) + 'P00',
			'Y', 			
			xplant,			div,			substring(srno,2,1),	substring(srno,3,1),
			substring(srno,4,1),	substring(srno,5,3),	substring(srno,8,2),	xplant,
			div,			substring(pdcd,1,2),	substring(pdcd,1,3),	substring(pdcd,1,4),
			itno, 			custcd,			
			substring(frdt, 1, 4)+'.'+substring(frdt, 5, 2)+'.'+substring(frdt, 7,2),
			case dktm	when '' then 1
					when 0 then 1
					else dktm end,
			srqty,			srqty - saqty,		'N',			'N',			
			citno, 			suse,			srno,			'N',			
			ordno,			'SYSTEM'
		from	sle302_temp
		where	srno = @ls_srno
		and	kitcd = 'P'
		and	stcd <> 'C'
		and	xplant = 'D'
		and	div in ('A')

		insert into [ipisele_svr\ipis].ipis.dbo.tsrorder
			(SRNo,			PCGubun,		PSRNo,			
			KitGubun,
			SRAreaCode, 		SRDivisionCode,		ShipGubun,		SRYear,
			SRMonth,		SRSerial,		SRSplitCount,		AreaCode,	
			DivisionCode,		ProductGroup,		ModelGroup,		ProductCode,
			ItemCode,		CustCode,		
			ApplyFrom,		
			ShipEditNo,
			ShipOrderQty,		ShipRemainQty,		ShipEndGubun,		SRCancelGubun,		
			CustomerItemNo,		ShipUsage,		CheckSRNo,		stcd,
			orderno,		LastEmp)
		select	rtrim(b.csrno)+'C00',	'C',			rtrim(b.psrno) + 'P00',
			'Y', 			
			b.xplant,			b.div,			substring(b.srno,2,1),	substring(b.srno,3,1),
			substring(b.srno,4,1),	substring(b.srno,5,3),	substring(b.srno,8,2),	b.xplant,
			b.div,			substring(b.pdcd,1,2),	substring(b.pdcd,1,3),	substring(b.pdcd,1,4),
			b.itno, 			b.custcd,			
			substring(b.frdt, 1, 4)+'.'+substring(b.frdt, 5, 2)+'.'+substring(b.frdt, 7,2),
			case b.dktm	when '' then 1
					when 0 then 1
					else b.dktm end,
			b.srqty,			b.srqty - b.saqty,		'N',			'N',			
			b.citno, 			b.suse,			b.srno,			'N',			
			b.ordno,			'SYSTEM'
		from	sle302_temp a, sle308_temp b
		where	a.srno = @ls_srno
		and	a.csrno = b.psrno
		and	b.xplant = 'D'
		and	b.div in ('A')
		
		insert into [ipisele_svr\ipis].ipis.dbo.tsrheader
			(SRAreaCode,		SRDivisionCode,		ShipGubun, 		SRYear, 		
			SRMonth, 		SRSerial,		SRSplitCount, 
			ShipDate, 		SRConfirmDate,		InvoiceNo, 		InvoiceDate,	
			MasterLCNo, 		MasterDate, 		LocalLCNo, 		LocalLCDate,
			ELNo1, 			ELDate1, 		ELNo2,			ELDate2,		
			CostGubun,		CheckSRNo,		PRTCd,			LastEmp)
		select	distinct b.xplant,		b.div,			substring(@ls_srno,2,1),substring(@ls_srno,3,1),	
			substring(@ls_srno,4,1),substring(@ls_srno,5,3),substring(@ls_srno,8,2), 		
			@ls_dpdt,		@ls_srdt,		invoice,		@ls_indt,
			mlc,			@ls_mlcdt,		llc,			@ls_llcdt,
			elno1,			@ls_elno1dt,		elno2,			@ls_elno2dt,
			paycd,			a.srno,			'N',			'SYSTEM'
		from	pdsle301 a, sle302_temp b
		where	a.srno = @ls_srno
		and	a.srno = b.srno
		and	b.xplant = 'D'
		and	b.div in ('A')

		-- 대구기계
		insert into [ipismac_svr\ipis].ipis.dbo.tsrorder
			(SRNo,			PCGubun,		PSRNo,			
			KitGubun,
			SRAreaCode, 		SRDivisionCode,		ShipGubun,		SRYear,
			SRMonth,		SRSerial,		SRSplitCount,		AreaCode,	
			DivisionCode,		ProductGroup,		ModelGroup,		ProductCode,
			ItemCode,		CustCode,		
			ApplyFrom,		
			ShipEditNo,
			ShipOrderQty,		ShipRemainQty,		ShipEndGubun,		SRCancelGubun,		
			CustomerItemNo,		ShipUsage,		CheckSRNo,		stcd,
			orderno,		LastEmp)
		select	rtrim(csrno) + 'P00',	'P',			rtrim(csrno) + 'P00',
			'N', 			
			xplant,			div,			substring(srno,2,1),	substring(srno,3,1),
			substring(srno,4,1),	substring(srno,5,3),	substring(srno,8,2),	xplant,
			div,			substring(pdcd,1,2),	substring(pdcd,1,3),	substring(pdcd,1,4),
			itno, 			custcd,			
			substring(frdt, 1, 4)+'.'+substring(frdt, 5, 2)+'.'+substring(frdt, 7,2),
			case dktm	when '' then 1
					when 0 then 1
					else dktm end,
			srqty,			srqty - saqty,		'N',			'N',			
			citno, 			suse,			srno,			'N',			
			ordno,			'SYSTEM'
		from	sle302_temp
		where	srno = @ls_srno
		and	kitcd not in ('P','C')
		and	stcd <> 'C'
		and	xplant = 'D'
		and	div in ('M','S')

		insert into [ipismac_svr\ipis].ipis.dbo.tsrorder
			(SRNo,			PCGubun,		PSRNo,			
			KitGubun,
			SRAreaCode, 		SRDivisionCode,		ShipGubun,		SRYear,
			SRMonth,		SRSerial,		SRSplitCount,		AreaCode,	
			DivisionCode,		ProductGroup,		ModelGroup,		ProductCode,
			ItemCode,		CustCode,		
			ApplyFrom,		
			ShipEditNo,
			ShipOrderQty,		ShipRemainQty,		ShipEndGubun,		SRCancelGubun,		
			CustomerItemNo,		ShipUsage,		CheckSRNo,		stcd,
			orderno,		LastEmp)
		select	rtrim(csrno) + 'P00',	'P',			rtrim(csrno) + 'P00',
			'Y', 			
			xplant,			div,			substring(srno,2,1),	substring(srno,3,1),
			substring(srno,4,1),	substring(srno,5,3),	substring(srno,8,2),	xplant,
			div,			substring(pdcd,1,2),	substring(pdcd,1,3),	substring(pdcd,1,4),
			itno, 			custcd,			
			substring(frdt, 1, 4)+'.'+substring(frdt, 5, 2)+'.'+substring(frdt, 7,2),
			case dktm	when '' then 1
					when 0 then 1
					else dktm end,
			srqty,			srqty - saqty,		'N',			'N',			
			citno, 			suse,			srno,			'N',			
			ordno,			'SYSTEM'
		from	sle302_temp
		where	srno = @ls_srno
		and	kitcd = 'P'
		and	stcd <> 'C'
		and	xplant = 'D'
		and	div in ('M','S')

		insert into [ipismac_svr\ipis].ipis.dbo.tsrorder
			(SRNo,			PCGubun,		PSRNo,			
			KitGubun,
			SRAreaCode, 		SRDivisionCode,		ShipGubun,		SRYear,
			SRMonth,		SRSerial,		SRSplitCount,		AreaCode,	
			DivisionCode,		ProductGroup,		ModelGroup,		ProductCode,
			ItemCode,		CustCode,		
			ApplyFrom,		
			ShipEditNo,
			ShipOrderQty,		ShipRemainQty,		ShipEndGubun,		SRCancelGubun,		
			CustomerItemNo,		ShipUsage,		CheckSRNo,		stcd,
			orderno,		LastEmp)
		select	rtrim(b.csrno)+'C00',	'C',			rtrim(b.psrno) + 'P00',
			'Y', 			
			b.xplant,			b.div,			substring(b.srno,2,1),	substring(b.srno,3,1),
			substring(b.srno,4,1),	substring(b.srno,5,3),	substring(b.srno,8,2),	b.xplant,
			b.div,			substring(b.pdcd,1,2),	substring(b.pdcd,1,3),	substring(b.pdcd,1,4),
			b.itno, 			b.custcd,			
			substring(b.frdt, 1, 4)+'.'+substring(b.frdt, 5, 2)+'.'+substring(b.frdt, 7,2),
			case b.dktm	when '' then 1
					when 0 then 1
					else b.dktm end,
			b.srqty,			b.srqty - b.saqty,		'N',			'N',			
			b.citno, 			b.suse,			b.srno,			'N',			
			b.ordno,			'SYSTEM'
		from	sle302_temp a, sle308_temp b
		where	a.srno = @ls_srno
		and	a.csrno = b.psrno
		and	b.xplant = 'D'
		and	b.div in ('M','S')

		insert into [ipismac_svr\ipis].ipis.dbo.tsrheader
			(SRAreaCode,		SRDivisionCode,		ShipGubun, 		SRYear, 		
			SRMonth, 		SRSerial,		SRSplitCount, 
			ShipDate, 		SRConfirmDate,		InvoiceNo, 		InvoiceDate,	
			MasterLCNo, 		MasterDate, 		LocalLCNo, 		LocalLCDate,
			ELNo1, 			ELDate1, 		ELNo2,			ELDate2,		
			CostGubun,		CheckSRNo,		PRTCd,			LastEmp)
		select	distinct b.xplant,		b.div,			substring(@ls_srno,2,1),substring(@ls_srno,3,1),	
			substring(@ls_srno,4,1),substring(@ls_srno,5,3),substring(@ls_srno,8,2), 		
			@ls_dpdt,		@ls_srdt,		invoice,		@ls_indt,
			mlc,			@ls_mlcdt,		llc,			@ls_llcdt,
			elno1,			@ls_elno1dt,		elno2,			@ls_elno2dt,
			paycd,			a.srno,			'N',			'SYSTEM'
		from	pdsle301 a, sle302_temp b
		where	a.srno = @ls_srno
		and	a.srno = b.srno
		and	b.xplant = 'D'
		and	b.div in ('M','S')

		-- 대구공조
		insert into [ipishvac_svr\ipis].ipis.dbo.tsrorder
			(SRNo,			PCGubun,		PSRNo,			
			KitGubun,
			SRAreaCode, 		SRDivisionCode,		ShipGubun,		SRYear,
			SRMonth,		SRSerial,		SRSplitCount,		AreaCode,	
			DivisionCode,		ProductGroup,		ModelGroup,		ProductCode,
			ItemCode,		CustCode,		
			ApplyFrom,		
			ShipEditNo,
			ShipOrderQty,		ShipRemainQty,		ShipEndGubun,		SRCancelGubun,		
			CustomerItemNo,		ShipUsage,		CheckSRNo,		stcd,
			orderno,		LastEmp)
		select	rtrim(csrno) + 'P00',	'P',			rtrim(csrno) + 'P00',
			'N', 			
			xplant,			div,			substring(srno,2,1),	substring(srno,3,1),
			substring(srno,4,1),	substring(srno,5,3),	substring(srno,8,2),	xplant,
			div,			substring(pdcd,1,2),	substring(pdcd,1,3),	substring(pdcd,1,4),
			itno, 			custcd,			
			substring(frdt, 1, 4)+'.'+substring(frdt, 5, 2)+'.'+substring(frdt, 7,2),
			case dktm	when '' then 1
					when 0 then 1
					else dktm end,
			srqty,			srqty - saqty,		'N',			'N',			
			citno, 			suse,			srno,			'N',			
			ordno,			'SYSTEM'
		from	sle302_temp
		where	srno = @ls_srno
		and	kitcd not in ('P','C')
		and	stcd <> 'C'
		and	((xplant = 'D' and div in ('H','V')) or xplant in ('K', 'Y'))

		insert into [ipishvac_svr\ipis].ipis.dbo.tsrorder
			(SRNo,			PCGubun,		PSRNo,			
			KitGubun,
			SRAreaCode, 		SRDivisionCode,		ShipGubun,		SRYear,
			SRMonth,		SRSerial,		SRSplitCount,		AreaCode,	
			DivisionCode,		ProductGroup,		ModelGroup,		ProductCode,
			ItemCode,		CustCode,		
			ApplyFrom,		
			ShipEditNo,
			ShipOrderQty,		ShipRemainQty,		ShipEndGubun,		SRCancelGubun,		
			CustomerItemNo,		ShipUsage,		CheckSRNo,		stcd,
			orderno,		LastEmp)
		select	rtrim(csrno) + 'P00',	'P',			rtrim(csrno) + 'P00',
			'Y', 			
			xplant,			div,			substring(srno,2,1),	substring(srno,3,1),
			substring(srno,4,1),	substring(srno,5,3),	substring(srno,8,2),	xplant,
			div,			substring(pdcd,1,2),	substring(pdcd,1,3),	substring(pdcd,1,4),
			itno, 			custcd,			
			substring(frdt, 1, 4)+'.'+substring(frdt, 5, 2)+'.'+substring(frdt, 7,2),
			case dktm	when '' then 1
					when 0 then 1
					else dktm end,
			srqty,			srqty - saqty,		'N',			'N',			
			citno, 			suse,			srno,			'N',			
			ordno,			'SYSTEM'
		from	sle302_temp
		where	srno = @ls_srno
		and	kitcd = 'P'
		and	stcd <> 'C'
		and	((xplant = 'D' and div in ('H','V')) or xplant in ('K', 'Y'))		

		insert into [ipishvac_svr\ipis].ipis.dbo.tsrorder
			(SRNo,			PCGubun,		PSRNo,			
			KitGubun,
			SRAreaCode, 		SRDivisionCode,		ShipGubun,		SRYear,
			SRMonth,		SRSerial,		SRSplitCount,		AreaCode,	
			DivisionCode,		ProductGroup,		ModelGroup,		ProductCode,
			ItemCode,		CustCode,		
			ApplyFrom,		
			ShipEditNo,
			ShipOrderQty,		ShipRemainQty,		ShipEndGubun,		SRCancelGubun,		
			CustomerItemNo,		ShipUsage,		CheckSRNo,		stcd,
			orderno,		LastEmp)
		select	rtrim(b.csrno)+'C00',	'C',			rtrim(b.psrno) + 'P00',
			'Y', 			
			b.xplant,			b.div,			substring(b.srno,2,1),	substring(b.srno,3,1),
			substring(b.srno,4,1),	substring(b.srno,5,3),	substring(b.srno,8,2),	b.xplant,
			b.div,			substring(b.pdcd,1,2),	substring(b.pdcd,1,3),	substring(b.pdcd,1,4),
			b.itno, 			b.custcd,			
			substring(b.frdt, 1, 4)+'.'+substring(b.frdt, 5, 2)+'.'+substring(b.frdt, 7,2),
			case b.dktm	when '' then 1
					when 0 then 1
					else b.dktm end,
			b.srqty,			b.srqty - b.saqty,		'N',			'N',			
			b.citno, 			b.suse,			b.srno,			'N',			
			b.ordno,			'SYSTEM'
		from	sle302_temp a, sle308_temp b
		where	a.srno = @ls_srno
		and	a.csrno = b.psrno
		and	((b.xplant = 'D' and b.div in ('H','V')) or b.xplant in ('K', 'Y'))

		insert into [ipishvac_svr\ipis].ipis.dbo.tsrheader
			(SRAreaCode,		SRDivisionCode,		ShipGubun, 		SRYear, 		
			SRMonth, 		SRSerial,		SRSplitCount, 
			ShipDate, 		SRConfirmDate,		InvoiceNo, 		InvoiceDate,	
			MasterLCNo, 		MasterDate, 		LocalLCNo, 		LocalLCDate,
			ELNo1, 			ELDate1, 		ELNo2,			ELDate2,		
			CostGubun,		CheckSRNo,		PRTCd,			LastEmp)
		select	distinct b.xplant,		b.div,			substring(@ls_srno,2,1),substring(@ls_srno,3,1),	
			substring(@ls_srno,4,1),substring(@ls_srno,5,3),substring(@ls_srno,8,2), 		
			@ls_dpdt,		@ls_srdt,		invoice,		@ls_indt,
			mlc,			@ls_mlcdt,		llc,			@ls_llcdt,
			elno1,			@ls_elno1dt,		elno2,			@ls_elno2dt,
			paycd,			a.srno,			'N',			'SYSTEM'
		from	pdsle301 a, sle302_temp b
		where	a.srno = @ls_srno
		and	a.srno = b.srno
		and	((b.xplant = 'D' and b.div in ('H','V')) or b.xplant in ('K', 'Y'))

		-- 진천
		insert into [ipisjin_svr].ipis.dbo.tsrorder
			(SRNo,			PCGubun,		PSRNo,			
			KitGubun,
			SRAreaCode, 		SRDivisionCode,		ShipGubun,		SRYear,
			SRMonth,		SRSerial,		SRSplitCount,		AreaCode,	
			DivisionCode,		ProductGroup,		ModelGroup,		ProductCode,
			ItemCode,		CustCode,		
			ApplyFrom,		
			ShipEditNo,
			ShipOrderQty,		ShipRemainQty,		ShipEndGubun,		SRCancelGubun,		
			CustomerItemNo,		ShipUsage,		CheckSRNo,		stcd,
			orderno,		LastEmp)
		select	rtrim(csrno) + 'P00',	'P',			rtrim(csrno) + 'P00',
			'N', 			
			xplant,			div,			substring(srno,2,1),	substring(srno,3,1),
			substring(srno,4,1),	substring(srno,5,3),	substring(srno,8,2),	xplant,
			div,			substring(pdcd,1,2),	substring(pdcd,1,3),	substring(pdcd,1,4),
			itno, 			custcd,			
			substring(frdt, 1, 4)+'.'+substring(frdt, 5, 2)+'.'+substring(frdt, 7,2),
			case dktm	when '' then 1
					when 0 then 1
					else dktm end,
			srqty,			srqty - saqty,		'N',			'N',			
			citno, 			suse,			srno,			'N',			
			ordno,			'SYSTEM'
		from	sle302_temp
		where	srno = @ls_srno
		and	kitcd not in ('P','C')
		and	stcd <> 'C'
		and	xplant = 'J'

		insert into [ipisjin_svr].ipis.dbo.tsrorder
			(SRNo,			PCGubun,		PSRNo,			
			KitGubun,
			SRAreaCode, 		SRDivisionCode,		ShipGubun,		SRYear,
			SRMonth,		SRSerial,		SRSplitCount,		AreaCode,	
			DivisionCode,		ProductGroup,		ModelGroup,		ProductCode,
			ItemCode,		CustCode,		
			ApplyFrom,		
			ShipEditNo,
			ShipOrderQty,		ShipRemainQty,		ShipEndGubun,		SRCancelGubun,		
			CustomerItemNo,		ShipUsage,		CheckSRNo,		stcd,
			orderno,		LastEmp)
		select	rtrim(csrno) + 'P00',	'P',			rtrim(csrno) + 'P00',
			'Y', 			
			xplant,			div,			substring(srno,2,1),	substring(srno,3,1),
			substring(srno,4,1),	substring(srno,5,3),	substring(srno,8,2),	xplant,
			div,			substring(pdcd,1,2),	substring(pdcd,1,3),	substring(pdcd,1,4),
			itno, 			custcd,			
			substring(frdt, 1, 4)+'.'+substring(frdt, 5, 2)+'.'+substring(frdt, 7,2),
			case dktm	when '' then 1
					when 0 then 1
					else dktm end,
			srqty,			srqty - saqty,		'N',			'N',			
			citno, 			suse,			srno,			'N',			
			ordno,			'SYSTEM'
		from	sle302_temp
		where	srno = @ls_srno
		and	kitcd = 'P'
		and	stcd <> 'C'
		and	xplant = 'J'

		insert into [ipisjin_svr].ipis.dbo.tsrorder
			(SRNo,			PCGubun,		PSRNo,			
			KitGubun,
			SRAreaCode, 		SRDivisionCode,		ShipGubun,		SRYear,
			SRMonth,		SRSerial,		SRSplitCount,		AreaCode,	
			DivisionCode,		ProductGroup,		ModelGroup,		ProductCode,
			ItemCode,		CustCode,		
			ApplyFrom,		
			ShipEditNo,
			ShipOrderQty,		ShipRemainQty,		ShipEndGubun,		SRCancelGubun,		
			CustomerItemNo,		ShipUsage,		CheckSRNo,		stcd,
			orderno,		LastEmp)
		select	rtrim(b.csrno)+'C00',	'C',			rtrim(b.psrno) + 'P00',
			'Y', 			
			b.xplant,			b.div,			substring(b.srno,2,1),	substring(b.srno,3,1),
			substring(b.srno,4,1),	substring(b.srno,5,3),	substring(b.srno,8,2),	b.xplant,
			b.div,			substring(b.pdcd,1,2),	substring(b.pdcd,1,3),	substring(b.pdcd,1,4),
			b.itno, 			b.custcd,			
			substring(b.frdt, 1, 4)+'.'+substring(b.frdt, 5, 2)+'.'+substring(b.frdt, 7,2),
			case b.dktm	when '' then 1
					when 0 then 1
					else b.dktm end,
			b.srqty,			b.srqty - b.saqty,		'N',			'N',			
			b.citno, 			b.suse,			b.srno,			'N',			
			b.ordno,			'SYSTEM'
		from	sle302_temp a, sle308_temp b
		where	a.srno = @ls_srno
		and	a.csrno = b.psrno
		and	b.xplant = 'J'

		insert into [ipisjin_svr].ipis.dbo.tsrheader
			(SRAreaCode,		SRDivisionCode,		ShipGubun, 		SRYear, 		
			SRMonth, 		SRSerial,		SRSplitCount, 
			ShipDate, 		SRConfirmDate,		InvoiceNo, 		InvoiceDate,	
			MasterLCNo, 		MasterDate, 		LocalLCNo, 		LocalLCDate,
			ELNo1, 			ELDate1, 		ELNo2,			ELDate2,		
			CostGubun,		CheckSRNo,		PRTCd,			LastEmp)
		select	distinct b.xplant,		b.div,			substring(@ls_srno,2,1),substring(@ls_srno,3,1),	
			substring(@ls_srno,4,1),substring(@ls_srno,5,3),substring(@ls_srno,8,2), 		
			@ls_dpdt,		@ls_srdt,		invoice,		@ls_indt,
			mlc,			@ls_mlcdt,		llc,			@ls_llcdt,
			elno1,			@ls_elno1dt,		elno2,			@ls_elno2dt,
			paycd,			a.srno,			'N',			'SYSTEM'
		from	pdsle301 a, sle302_temp b
		where	a.srno = @ls_srno
		and	a.srno = b.srno
		and	b.xplant = 'J'

	End	-- len(srno) = 9 end
		
	If len(@ls_srno) = 11 		---------------------------------------
	Begin
		-- 대구전장
		insert into [ipisele_svr\ipis].ipis.dbo.tsrorder
			(SRNo,			PCGubun,		PSRNo,			
			KitGubun,
			SRAreaCode, 		SRDivisionCode,		ShipGubun,		SRYear,
			SRMonth,		SRSerial,		SRSplitCount,		AreaCode,	
			DivisionCode,		ProductGroup,		ModelGroup,		ProductCode,
			ItemCode,		CustCode,		
			ApplyFrom,		
			ShipEditNo,
			ShipOrderQty,		ShipRemainQty,		ShipEndGubun,		SRCancelGubun,		
			CustomerItemNo,		ShipUsage,		CheckSRNo,		stcd,
			orderno,		LastEmp)
		select	rtrim(csrno) + 'P00',	'P',			rtrim(csrno) + 'P00',
			'N', 			
			xplant,			div,			substring(srno, 3, 1),	substring(srno, 4, 1),
			srmonth = case substring(srno, 5, 2)
			when '10' then 'A'
			when '11' then 'B'
			when '12' then 'C'
			else substring(srno, 6, 1)
			end,
			substring(srno, 7, 3),	substring(srno, 10, 2),	xplant,
			div,			substring(pdcd,1,2),	substring(pdcd,1,3),	substring(pdcd,1,4),
			itno, 			custcd,			
			substring(frdt, 1, 4)+'.'+substring(frdt, 5, 2)+'.'+substring(frdt, 7,2),
			case dktm	when '' then 1
					when 0 then 1
					else dktm end,
			srqty,			srqty - saqty,		'N',			'N',			
			citno, 			suse,			srno,			'N',			
			ordno,			'SYSTEM'
		from	sle302_temp
		where	srno = @ls_srno
		and	kitcd not in ('P','C')
		and	stcd <> 'C'
		and	xplant = 'D'
		and	div in ('A')

		insert into [ipisele_svr\ipis].ipis.dbo.tsrorder
			(SRNo,			PCGubun,		PSRNo,			
			KitGubun,
			SRAreaCode, 		SRDivisionCode,		ShipGubun,		SRYear,
			SRMonth,		SRSerial,		SRSplitCount,		AreaCode,	
			DivisionCode,		ProductGroup,		ModelGroup,		ProductCode,
			ItemCode,		CustCode,		
			ApplyFrom,		
			ShipEditNo,
			ShipOrderQty,		ShipRemainQty,		ShipEndGubun,		SRCancelGubun,		
			CustomerItemNo,		ShipUsage,		CheckSRNo,		stcd,
			orderno,		LastEmp)
		select	rtrim(csrno) + 'P00',	'P',			rtrim(csrno) + 'P00',
			'Y', 			
			xplant,			div,			substring(srno, 3, 1),	substring(srno, 4, 1),
			srmonth = case substring(srno, 5, 2)
			when '10' then 'A'
			when '11' then 'B'
			when '12' then 'C'
			else substring(srno, 6, 1)
			end,
			substring(srno, 7, 3),	substring(srno, 10, 2),	xplant,
			div,			substring(pdcd,1,2),	substring(pdcd,1,3),	substring(pdcd,1,4),
			itno, 			custcd,			
			substring(frdt, 1, 4)+'.'+substring(frdt, 5, 2)+'.'+substring(frdt, 7,2),
			case dktm	when '' then 1
					when 0 then 1
					else dktm end,
			srqty,			srqty - saqty,		'N',			'N',			
			citno, 			suse,			srno,			'N',			
			ordno,			'SYSTEM'
		from	sle302_temp
		where	srno = @ls_srno
		and	kitcd = 'P'
		and	stcd <> 'C'
		and	xplant = 'D'
		and	div in ('A')

		insert into [ipisele_svr\ipis].ipis.dbo.tsrorder
			(SRNo,			PCGubun,		PSRNo,			
			KitGubun,
			SRAreaCode, 		SRDivisionCode,		ShipGubun,		SRYear,
			SRMonth,		SRSerial,		SRSplitCount,		AreaCode,	
			DivisionCode,		ProductGroup,		ModelGroup,		ProductCode,
			ItemCode,		CustCode,		
			ApplyFrom,		
			ShipEditNo,
			ShipOrderQty,		ShipRemainQty,		ShipEndGubun,		SRCancelGubun,		
			CustomerItemNo,		ShipUsage,		CheckSRNo,		stcd,
			orderno,		LastEmp)
		select	rtrim(b.csrno)+'C00',	'C',			rtrim(b.psrno) + 'P00',
			'Y', 			
			b.xplant,			b.div,		substring(b.srno,3,1),	substring(b.srno, 4, 1),
			srmonth = case substring(b.srno, 5, 2)
			when '10' then 'A'
			when '11' then 'B'
			when '12' then 'C'
			else substring(b.srno, 6, 1)
			end,
			substring(b.srno,7,3),	substring(b.srno, 10, 2),	b.xplant,
			b.div,			substring(b.pdcd,1,2),	substring(b.pdcd,1,3),	substring(b.pdcd,1,4),
			b.itno, 			b.custcd,			
			substring(b.frdt, 1, 4)+'.'+substring(b.frdt, 5, 2)+'.'+substring(b.frdt, 7,2),
			case b.dktm	when '' then 1
					when 0 then 1
					else b.dktm end,
			b.srqty,			b.srqty - b.saqty,		'N',			'N',			
			b.citno, 			b.suse,			b.srno,			'N',			
			b.ordno,			'SYSTEM'
		from	sle302_temp a, sle308_temp b
		where	a.srno = @ls_srno
		and	a.csrno = b.psrno
		and	b.xplant = 'D'
		and	b.div in ('A')
		
		insert into [ipisele_svr\ipis].ipis.dbo.tsrheader
			(SRAreaCode,		SRDivisionCode,		ShipGubun, 		SRYear, 		
			SRMonth, 		SRSerial,		SRSplitCount, 
			ShipDate, 		SRConfirmDate,		InvoiceNo, 		InvoiceDate,	
			MasterLCNo, 		MasterDate, 		LocalLCNo, 		LocalLCDate,
			ELNo1, 			ELDate1, 		ELNo2,			ELDate2,		
			CostGubun,		CheckSRNo,		PRTCd,			LastEmp)
		select	distinct b.xplant,		b.div,		substring(a.srno,3,1),	substring(a.srno, 4, 1),
			srmonth = case substring(a.srno, 5, 2)
			when '10' then 'A'
			when '11' then 'B'
			when '12' then 'C'
			else substring(a.srno, 6, 1)
			end,
			substring(a.srno, 7, 3),	substring(a.srno, 10, 2), 		
			@ls_dpdt,		@ls_srdt,		invoice,		@ls_indt,
			mlc,			@ls_mlcdt,		llc,			@ls_llcdt,
			elno1,			@ls_elno1dt,		elno2,			@ls_elno2dt,
			paycd,			a.srno,			'N',			'SYSTEM'
		from	pdsle301 a, sle302_temp b
		where	a.srno = @ls_srno
		and	a.srno = b.srno
		and	b.xplant = 'D'
		and	b.div in ('A')

		-- 대구기계
		insert into [ipismac_svr\ipis].ipis.dbo.tsrorder
			(SRNo,			PCGubun,		PSRNo,			
			KitGubun,
			SRAreaCode, 		SRDivisionCode,		ShipGubun,		SRYear,
			SRMonth,		SRSerial,		SRSplitCount,		AreaCode,	
			DivisionCode,		ProductGroup,		ModelGroup,		ProductCode,
			ItemCode,		CustCode,		
			ApplyFrom,		
			ShipEditNo,
			ShipOrderQty,		ShipRemainQty,		ShipEndGubun,		SRCancelGubun,		
			CustomerItemNo,		ShipUsage,		CheckSRNo,		stcd,
			orderno,		LastEmp)
		select	rtrim(csrno) + 'P00',	'P',			rtrim(csrno) + 'P00',
			'N', 			
			xplant,			div,			substring(srno, 3, 1),	substring(srno, 4, 1),
			srmonth = case substring(srno, 5, 2)
			when '10' then 'A'
			when '11' then 'B'
			when '12' then 'C'
			else substring(srno, 6, 1)
			end,
			substring(srno, 7, 3),	substring(srno, 10, 2),	xplant,
			div,			substring(pdcd,1,2),	substring(pdcd,1,3),	substring(pdcd,1,4),
			itno, 			custcd,			
			substring(frdt, 1, 4)+'.'+substring(frdt, 5, 2)+'.'+substring(frdt, 7,2),
			case dktm	when '' then 1
					when 0 then 1
					else dktm end,
			srqty,			srqty - saqty,		'N',			'N',			
			citno, 			suse,			srno,			'N',			
			ordno,			'SYSTEM'
		from	sle302_temp
		where	srno = @ls_srno
		and	kitcd not in ('P','C')
		and	stcd <> 'C'
		and	xplant = 'D'
		and	div in ('M','S')

		insert into [ipismac_svr\ipis].ipis.dbo.tsrorder
			(SRNo,			PCGubun,		PSRNo,			
			KitGubun,
			SRAreaCode, 		SRDivisionCode,		ShipGubun,		SRYear,
			SRMonth,		SRSerial,		SRSplitCount,		AreaCode,	
			DivisionCode,		ProductGroup,		ModelGroup,		ProductCode,
			ItemCode,		CustCode,		
			ApplyFrom,		
			ShipEditNo,
			ShipOrderQty,		ShipRemainQty,		ShipEndGubun,		SRCancelGubun,		
			CustomerItemNo,		ShipUsage,		CheckSRNo,		stcd,
			orderno,		LastEmp)
		select	rtrim(csrno) + 'P00',	'P',			rtrim(csrno) + 'P00',
			'Y', 			
			xplant,			div,			substring(srno, 3, 1),	substring(srno, 4, 1),
			srmonth = case substring(srno, 5, 2)
			when '10' then 'A'
			when '11' then 'B'
			when '12' then 'C'
			else substring(srno, 6, 1)
			end,
			substring(srno, 7, 3),	substring(srno, 10, 2),	xplant,
			div,			substring(pdcd,1,2),	substring(pdcd,1,3),	substring(pdcd,1,4),
			itno, 			custcd,			
			substring(frdt, 1, 4)+'.'+substring(frdt, 5, 2)+'.'+substring(frdt, 7,2),
			case dktm	when '' then 1
					when 0 then 1
					else dktm end,
			srqty,			srqty - saqty,		'N',			'N',			
			citno, 			suse,			srno,			'N',			
			ordno,			'SYSTEM'
		from	sle302_temp
		where	srno = @ls_srno
		and	kitcd = 'P'
		and	stcd <> 'C'
		and	xplant = 'D'
		and	div in ('M','S')

		insert into [ipismac_svr\ipis].ipis.dbo.tsrorder
			(SRNo,			PCGubun,		PSRNo,			
			KitGubun,
			SRAreaCode, 		SRDivisionCode,		ShipGubun,		SRYear,
			SRMonth,		SRSerial,		SRSplitCount,		AreaCode,	
			DivisionCode,		ProductGroup,		ModelGroup,		ProductCode,
			ItemCode,		CustCode,		
			ApplyFrom,		
			ShipEditNo,
			ShipOrderQty,		ShipRemainQty,		ShipEndGubun,		SRCancelGubun,		
			CustomerItemNo,		ShipUsage,		CheckSRNo,		stcd,
			orderno,		LastEmp)
		select	rtrim(b.csrno)+'C00',	'C',			rtrim(b.psrno) + 'P00',
			'Y', 			
			b.xplant,			b.div,		substring(b.srno,3,1),	substring(b.srno, 4, 1),
			srmonth = case substring(b.srno, 5, 2)
			when '10' then 'A'
			when '11' then 'B'
			when '12' then 'C'
			else substring(b.srno, 6, 1)
			end,
			substring(b.srno, 7, 3),substring(b.srno, 10, 2),	b.xplant,
			b.div,			substring(b.pdcd,1,2),	substring(b.pdcd,1,3),	substring(b.pdcd,1,4),
			b.itno, 			b.custcd,			
			substring(b.frdt, 1, 4)+'.'+substring(b.frdt, 5, 2)+'.'+substring(b.frdt, 7,2),
			case b.dktm	when '' then 1
					when 0 then 1
					else b.dktm end,
			b.srqty,			b.srqty - b.saqty,		'N',			'N',			
			b.citno, 			b.suse,			b.srno,			'N',			
			b.ordno,			'SYSTEM'
		from	sle302_temp a, sle308_temp b
		where	a.srno = @ls_srno
		and	a.csrno = b.psrno
		and	b.xplant = 'D'
		and	b.div in ('M','S')

		insert into [ipismac_svr\ipis].ipis.dbo.tsrheader
			(SRAreaCode,		SRDivisionCode,		ShipGubun, 		SRYear, 		
			SRMonth, 		SRSerial,		SRSplitCount, 
			ShipDate, 		SRConfirmDate,		InvoiceNo, 		InvoiceDate,	
			MasterLCNo, 		MasterDate, 		LocalLCNo, 		LocalLCDate,
			ELNo1, 			ELDate1, 		ELNo2,			ELDate2,		
			CostGubun,		CheckSRNo,		PRTCd,			LastEmp)
		select	distinct b.xplant,		b.div,		substring(a.srno,3,1),	substring(a.srno, 4, 1),
			srmonth = case substring(a.srno, 5, 2)
			when '10' then 'A'
			when '11' then 'B'
			when '12' then 'C'
			else substring(a.srno, 6, 1)
			end,
			substring(a.srno, 7, 3),substring(a.srno, 10, 2),
			@ls_dpdt,		@ls_srdt,		invoice,		@ls_indt,
			mlc,			@ls_mlcdt,		llc,			@ls_llcdt,
			elno1,			@ls_elno1dt,		elno2,			@ls_elno2dt,
			paycd,			a.srno,			'N',			'SYSTEM'
		from	pdsle301 a, sle302_temp b
		where	a.srno = @ls_srno
		and	a.srno = b.srno
		and	b.xplant = 'D'
		and	b.div in ('M','S')

		-- 대구공조
		insert into [ipishvac_svr\ipis].ipis.dbo.tsrorder
			(SRNo,			PCGubun,		PSRNo,			
			KitGubun,
			SRAreaCode, 		SRDivisionCode,		ShipGubun,		SRYear,
			SRMonth,		SRSerial,		SRSplitCount,		AreaCode,	
			DivisionCode,		ProductGroup,		ModelGroup,		ProductCode,
			ItemCode,		CustCode,		
			ApplyFrom,		
			ShipEditNo,
			ShipOrderQty,		ShipRemainQty,		ShipEndGubun,		SRCancelGubun,		
			CustomerItemNo,		ShipUsage,		CheckSRNo,		stcd,
			orderno,		LastEmp)
		select	rtrim(csrno) + 'P00',	'P',			rtrim(csrno) + 'P00',
			'N', 			
			xplant,			div,			substring(srno, 3, 1),	substring(srno, 4, 1),
			srmonth = case substring(srno, 5, 2)
			when '10' then 'A'
			when '11' then 'B'
			when '12' then 'C'
			else substring(srno, 6, 1)
			end,
			substring(srno, 7, 3),	substring(srno, 10, 2),	xplant,
			div,			substring(pdcd,1,2),	substring(pdcd,1,3),	substring(pdcd,1,4),
			itno, 			custcd,			
			substring(frdt, 1, 4)+'.'+substring(frdt, 5, 2)+'.'+substring(frdt, 7,2),
			case dktm	when '' then 1
					when 0 then 1
					else dktm end,
			srqty,			srqty - saqty,		'N',			'N',			
			citno, 			suse,			srno,			'N',			
			ordno,			'SYSTEM'
		from	sle302_temp
		where	srno = @ls_srno
		and	kitcd not in ('P','C')
		and	stcd <> 'C'
		and	((xplant = 'D' and div in ('H','V')) or xplant in ('K', 'Y'))

		insert into [ipishvac_svr\ipis].ipis.dbo.tsrorder
			(SRNo,			PCGubun,		PSRNo,			
			KitGubun,
			SRAreaCode, 		SRDivisionCode,		ShipGubun,		SRYear,
			SRMonth,		SRSerial,		SRSplitCount,		AreaCode,	
			DivisionCode,		ProductGroup,		ModelGroup,		ProductCode,
			ItemCode,		CustCode,		
			ApplyFrom,		
			ShipEditNo,
			ShipOrderQty,		ShipRemainQty,		ShipEndGubun,		SRCancelGubun,		
			CustomerItemNo,		ShipUsage,		CheckSRNo,		stcd,
			orderno,		LastEmp)
		select	rtrim(csrno) + 'P00',	'P',			rtrim(csrno) + 'P00',
			'Y', 			
			xplant,			div,			substring(srno, 3, 1),	substring(srno, 4, 1),
			srmonth = case substring(srno, 5, 2)
			when '10' then 'A'
			when '11' then 'B'
			when '12' then 'C'
			else substring(srno, 6, 1)
			end,
			substring(srno, 7, 3),	substring(srno, 10, 2),	xplant,
			div,			substring(pdcd,1,2),	substring(pdcd,1,3),	substring(pdcd,1,4),
			itno, 			custcd,			
			substring(frdt, 1, 4)+'.'+substring(frdt, 5, 2)+'.'+substring(frdt, 7,2),
			case dktm	when '' then 1
					when 0 then 1
					else dktm end,
			srqty,			srqty - saqty,		'N',			'N',			
			citno, 			suse,			srno,			'N',			
			ordno,			'SYSTEM'
		from	sle302_temp
		where	srno = @ls_srno
		and	kitcd = 'P'
		and	stcd <> 'C'
		and	((xplant = 'D' and div in ('H','V')) or xplant in ('K', 'Y'))		

		insert into [ipishvac_svr\ipis].ipis.dbo.tsrorder
			(SRNo,			PCGubun,		PSRNo,			
			KitGubun,
			SRAreaCode, 		SRDivisionCode,		ShipGubun,		SRYear,
			SRMonth,		SRSerial,		SRSplitCount,		AreaCode,	
			DivisionCode,		ProductGroup,		ModelGroup,		ProductCode,
			ItemCode,		CustCode,		
			ApplyFrom,		
			ShipEditNo,
			ShipOrderQty,		ShipRemainQty,		ShipEndGubun,		SRCancelGubun,		
			CustomerItemNo,		ShipUsage,		CheckSRNo,		stcd,
			orderno,		LastEmp)
		select	rtrim(b.csrno)+'C00',	'C',			rtrim(b.psrno) + 'P00',
			'Y', 			
			b.xplant,			b.div,		substring(b.srno,3,1),	substring(b.srno, 4, 1),
			srmonth = case substring(b.srno, 5, 2)
			when '10' then 'A'
			when '11' then 'B'
			when '12' then 'C'
			else substring(b.srno, 6, 1)
			end,
			substring(b.srno, 7, 3),	substring(b.srno, 10, 2),	b.xplant,
			b.div,			substring(b.pdcd,1,2),	substring(b.pdcd,1,3),	substring(b.pdcd,1,4),
			b.itno, 			b.custcd,			
			substring(b.frdt, 1, 4)+'.'+substring(b.frdt, 5, 2)+'.'+substring(b.frdt, 7,2),
			case b.dktm	when '' then 1
					when 0 then 1
					else b.dktm end,
			b.srqty,			b.srqty - b.saqty,		'N',			'N',			
			b.citno, 			b.suse,			b.srno,			'N',			
			b.ordno,			'SYSTEM'
		from	sle302_temp a, sle308_temp b
		where	a.srno = @ls_srno
		and	a.csrno = b.psrno
		and	((b.xplant = 'D' and b.div in ('H','V')) or b.xplant in ('K', 'Y'))

		insert into [ipishvac_svr\ipis].ipis.dbo.tsrheader
			(SRAreaCode,		SRDivisionCode,		ShipGubun, 		SRYear, 		
			SRMonth, 		SRSerial,		SRSplitCount, 
			ShipDate, 		SRConfirmDate,		InvoiceNo, 		InvoiceDate,	
			MasterLCNo, 		MasterDate, 		LocalLCNo, 		LocalLCDate,
			ELNo1, 			ELDate1, 		ELNo2,			ELDate2,		
			CostGubun,		CheckSRNo,		PRTCd,			LastEmp)
		select	distinct b.xplant,		b.div,		substring(a.srno,3,1),	substring(a.srno, 4, 1),
			srmonth = case substring(a.srno, 5, 2)
			when '10' then 'A'
			when '11' then 'B'
			when '12' then 'C'
			else substring(a.srno, 6, 1)
			end,
			substring(a.srno, 7, 3),	substring(a.srno, 10, 2),
			@ls_dpdt,		@ls_srdt,		invoice,		@ls_indt,
			mlc,			@ls_mlcdt,		llc,			@ls_llcdt,
			elno1,			@ls_elno1dt,		elno2,			@ls_elno2dt,
			paycd,			a.srno,			'N',			'SYSTEM'
		from	pdsle301 a, sle302_temp b
		where	a.srno = @ls_srno
		and	a.srno = b.srno
		and	((b.xplant = 'D' and b.div in ('H','V')) or b.xplant in ('K', 'Y'))

		-- 진천
		insert into [ipisjin_svr].ipis.dbo.tsrorder
			(SRNo,			PCGubun,		PSRNo,			
			KitGubun,
			SRAreaCode, 		SRDivisionCode,		ShipGubun,		SRYear,
			SRMonth,		SRSerial,		SRSplitCount,		AreaCode,	
			DivisionCode,		ProductGroup,		ModelGroup,		ProductCode,
			ItemCode,		CustCode,		
			ApplyFrom,		
			ShipEditNo,
			ShipOrderQty,		ShipRemainQty,		ShipEndGubun,		SRCancelGubun,		
			CustomerItemNo,		ShipUsage,		CheckSRNo,		stcd,
			orderno,		LastEmp)
		select	rtrim(csrno) + 'P00',	'P',			rtrim(csrno) + 'P00',
			'N', 			
			xplant,			div,			substring(srno, 3, 1),	substring(srno, 4, 1),
			srmonth = case substring(srno, 5, 2)
			when '10' then 'A'
			when '11' then 'B'
			when '12' then 'C'
			else substring(srno, 6, 1)
			end,
			substring(srno, 7, 3),	substring(srno, 10, 2),	xplant,
			div,			substring(pdcd,1,2),	substring(pdcd,1,3),	substring(pdcd,1,4),
			itno, 			custcd,			
			substring(frdt, 1, 4)+'.'+substring(frdt, 5, 2)+'.'+substring(frdt, 7,2),
			case dktm	when '' then 1
					when 0 then 1
					else dktm end,
			srqty,			srqty - saqty,		'N',			'N',			
			citno, 			suse,			srno,			'N',			
			ordno,			'SYSTEM'
		from	sle302_temp
		where	srno = @ls_srno
		and	kitcd not in ('P','C')
		and	stcd <> 'C'
		and	xplant = 'J'

		insert into [ipisjin_svr].ipis.dbo.tsrorder
			(SRNo,			PCGubun,		PSRNo,			
			KitGubun,
			SRAreaCode, 		SRDivisionCode,		ShipGubun,		SRYear,
			SRMonth,		SRSerial,		SRSplitCount,		AreaCode,	
			DivisionCode,		ProductGroup,		ModelGroup,		ProductCode,
			ItemCode,		CustCode,		
			ApplyFrom,		
			ShipEditNo,
			ShipOrderQty,		ShipRemainQty,		ShipEndGubun,		SRCancelGubun,		
			CustomerItemNo,		ShipUsage,		CheckSRNo,		stcd,
			orderno,		LastEmp)
		select	rtrim(csrno) + 'P00',	'P',			rtrim(csrno) + 'P00',
			'Y', 			
			xplant,			div,			substring(srno, 3, 1),	substring(srno, 4, 1),
			srmonth = case substring(srno, 5, 2)
			when '10' then 'A'
			when '11' then 'B'
			when '12' then 'C'
			else substring(srno, 6, 1)
			end,
			substring(srno, 7, 3),	substring(srno, 10, 2),	xplant,
			div,			substring(pdcd,1,2),	substring(pdcd,1,3),	substring(pdcd,1,4),
			itno, 			custcd,			
			substring(frdt, 1, 4)+'.'+substring(frdt, 5, 2)+'.'+substring(frdt, 7,2),
			case dktm	when '' then 1
					when 0 then 1
					else dktm end,
			srqty,			srqty - saqty,		'N',			'N',			
			citno, 			suse,			srno,			'N',			
			ordno,			'SYSTEM'
		from	sle302_temp
		where	srno = @ls_srno
		and	kitcd = 'P'
		and	stcd <> 'C'
		and	xplant = 'J'

		insert into [ipisjin_svr].ipis.dbo.tsrorder
			(SRNo,			PCGubun,		PSRNo,			
			KitGubun,
			SRAreaCode, 		SRDivisionCode,		ShipGubun,		SRYear,
			SRMonth,		SRSerial,		SRSplitCount,		AreaCode,	
			DivisionCode,		ProductGroup,		ModelGroup,		ProductCode,
			ItemCode,		CustCode,		
			ApplyFrom,		
			ShipEditNo,
			ShipOrderQty,		ShipRemainQty,		ShipEndGubun,		SRCancelGubun,		
			CustomerItemNo,		ShipUsage,		CheckSRNo,		stcd,
			orderno,		LastEmp)
		select	rtrim(b.csrno)+'C00',	'C',			rtrim(b.psrno) + 'P00',
			'Y', 			
			b.xplant,			b.div,		substring(b.srno,3,1),	substring(b.srno, 4, 1),
			srmonth = case substring(b.srno, 5, 2)
			when '10' then 'A'
			when '11' then 'B'
			when '12' then 'C'
			else substring(b.srno, 6, 1)
			end,
			substring(b.srno, 7, 3),substring(b.srno, 10, 2),	b.xplant,
			b.div,			substring(b.pdcd,1,2),	substring(b.pdcd,1,3),	substring(b.pdcd,1,4),
			b.itno, 			b.custcd,			
			substring(b.frdt, 1, 4)+'.'+substring(b.frdt, 5, 2)+'.'+substring(b.frdt, 7,2),
			case b.dktm	when '' then 1
					when 0 then 1
					else b.dktm end,
			b.srqty,			b.srqty - b.saqty,		'N',			'N',			
			b.citno, 			b.suse,			b.srno,			'N',			
			b.ordno,			'SYSTEM'
		from	sle302_temp a, sle308_temp b
		where	a.srno = @ls_srno
		and	a.csrno = b.psrno
		and	b.xplant = 'J'

		insert into [ipisjin_svr].ipis.dbo.tsrheader
			(SRAreaCode,		SRDivisionCode,		ShipGubun, 		SRYear, 		
			SRMonth, 		SRSerial,		SRSplitCount, 
			ShipDate, 		SRConfirmDate,		InvoiceNo, 		InvoiceDate,	
			MasterLCNo, 		MasterDate, 		LocalLCNo, 		LocalLCDate,
			ELNo1, 			ELDate1, 		ELNo2,			ELDate2,		
			CostGubun,		CheckSRNo,		PRTCd,			LastEmp)
		select	distinct b.xplant,		b.div,		substring(a.srno,3,1),	substring(a.srno, 4, 1),
			srmonth = case substring(a.srno, 5, 2)
			when '10' then 'A'
			when '11' then 'B'
			when '12' then 'C'
			else substring(a.srno, 6, 1)
			end,
			substring(a.srno, 7, 3),substring(a.srno, 10, 2),
			@ls_dpdt,		@ls_srdt,		invoice,		@ls_indt,
			mlc,			@ls_mlcdt,		llc,			@ls_llcdt,
			elno1,			@ls_elno1dt,		elno2,			@ls_elno2dt,
			paycd,			a.srno,			'N',			'SYSTEM'
		from	pdsle301 a, sle302_temp b
		where	a.srno = @ls_srno
		and	a.srno = b.srno
		and	b.xplant = 'J'
		
	end	-- len(@ls_srno) = 11 end		

	End	-- 추가 end
	
	If @ls_chgcd = 'D' 	-- 추가
	Begin
		delete from [ipisele_svr\ipis].ipis.dbo.tsrorder
		where	checksrno = @ls_srno

		delete from [ipisele_svr\ipis].ipis.dbo.tsrheader
		where	checksrno = @ls_srno
		
		delete from [ipismac_svr\ipis].ipis.dbo.tsrorder
		where	checksrno = @ls_srno

		delete from [ipismac_svr\ipis].ipis.dbo.tsrheader
		where	checksrno = @ls_srno

		delete from [ipishvac_svr\ipis].ipis.dbo.tsrorder
		where	checksrno = @ls_srno

		delete from [ipishvac_svr\ipis].ipis.dbo.tsrheader
		where	checksrno = @ls_srno

		delete from [ipisjin_svr].ipis.dbo.tsrorder
		where	checksrno = @ls_srno

		delete from [ipisjin_svr].ipis.dbo.tsrheader
		where	checksrno = @ls_srno
		
	End	-- 삭제 end
	
End			-- While Loop End

truncate table sle302_temp
truncate table sle308_temp

Drop table #tmp_pdsle301

End		-- Procedure End
Go
