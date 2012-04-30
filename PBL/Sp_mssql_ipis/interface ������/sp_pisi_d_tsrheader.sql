/*
	File Name	: sp_pisi_d_tsrheader.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tsrheader
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
	    Where id = object_id(N'[dbo].[sp_pisi_d_tsrheader]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tsrheader]
GO


/*
Execute sp_pisi_d_tsrheader
*/

Create Procedure sp_pisi_d_tsrheader
	
As
Begin

Declare	@i			Int,
	@li_loop_count		Int,
	@ls_chgdate		Char(30),
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
	@ls_inptdt		varchar(10),
	@ls_extd		varchar(10),
	@ls_date		varchar(30),
	@ls_seller		varchar(2),	-- 2003.01.05 추가 tsalescode와 연동
	@ls_consig		varchar(2),
	@ls_buyer		varchar(2),
	@ls_trans		varchar(2),
	@ls_trdl		varchar(2),
	@ls_area		char(1),
	@ls_division		char(1),
	@ls_deletecheck		int

select	*
into	#tmp_pdsle301
from	pdsle301_log
order by chgdate
	
Select @i = 0, @li_loop_count = @@RowCount, @ls_date = ''

While @i < @li_loop_count
Begin
	
	Select	Top 1
		@i		= @i + 1,
		@ls_chgdate	= chgdate,
		@ls_chgcd	= chgcd,
		@ls_srno	= rtrim(srno),
		@ls_dpdt	= substring(dpdt,1,4)+'.'+substring(dpdt,5,2)+'.'+substring(dpdt,7,2),
		@ls_srdt	= substring(srdt,1,4)+'.'+substring(srdt,5,2)+'.'+substring(srdt,7,2),
		@ls_invoice	= invoice,
		@ls_indt	= substring(indt,1,4)+'.'+substring(indt,5,2)+'.'+substring(indt,7,2),
		@ls_mlc		= mlc,
		@ls_mlcdt	= substring(mlcdt,1,4)+'.'+substring(mlcdt,5,2)+'.'+substring(mlcdt,7,2),
		@ls_llc		= llc,
		@ls_llcdt	= substring(llcdt,1,4)+'.'+substring(llcdt,5,2)+'.'+substring(llcdt,7,2),
		@ls_elno1	= elno1,
		@ls_elno1dt	= substring(elno1dt,1,4)+'.'+substring(elno1dt,5,2)+'.'+substring(elno1dt,7,2),
		@ls_elno2	= elno2,
		@ls_elno2dt	= substring(elno2dt,1,4)+'.'+substring(elno2dt,5,2)+'.'+substring(elno2dt,7,2),
		@ls_paycd	= paycd,
		@ls_dstn	= dstn,
		@ls_inptdt	= substring(inptdt,1,4)+'.'+substring(inptdt,5,2)+'.'+substring(inptdt,7,2),
		@ls_extd	= extd,
		@ls_seller	= seller,	-- 2003.01.05 추가
		@ls_consig	= consig,
		@ls_buyer	= buyer,
		@ls_trans	= trans,
		@ls_trdl	= trdl,
		@ls_area	= substring(rtrim(srno),1,1),
		@ls_division	= substring(rtrim(srno),2,1),
		@ls_date	= chgdate		
	From	#tmp_pdsle301
	Where	chgdate > @ls_date

	If	(Select	count(*)
		 From	pdsle301_log
		 Where	chgdate 	<	@ls_date	and
			@ls_Srno	=	srno ) > 0
		begin
		continue
		end
		
	If @ls_chgcd = 'A' 	-- 추가
	Begin
			
	If len(@ls_srno) = 9 		---------------------------
	begin
	
		If @ls_area = 'A'
		Begin

		-- 대구전장
		If not exists (select * from [ipisele_svr\ipis].ipis.dbo.tsrorder
				where	checksrno = @ls_srno)
		begin		
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
			orderno,		LastEmp,		Extd,			Luprc,	Luamt)
		select	rtrim(csrno) + 'P00',	'P',			rtrim(csrno) + 'P00',
			case kitcd
				when 'P' then 'Y'
				else 'N'
				end,	
			xplant,			div,			substring(srno,2,1),	substring(srno,3,1),
			substring(srno,4,1),	substring(srno,5,3),	substring(srno,8,2),	xplant,
			div,			substring(pdcd,1,2),	substring(pdcd,1,3),	substring(pdcd,1,4),
			itno, 			custcd,			
			substring(frdt, 1, 4)+'.'+substring(frdt, 5, 2)+'.'+substring(frdt, 7,2),
			case dktm	when '' then 1
					when 0 then 1
					else dktm end,
			srqty,			srqty - saqty,		
			case srqty - saqty
				when 0 then 'Y'
				else 'N'
				end,			'N',			
			citno, 			suse,			srno,			'N',			
			ordno,			'SYSTEM',		extd,			luprc,	luamt
		from	Sle302_Log
		where	srno = @ls_srno
		and	kitcd in ('P','','M')
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
			orderno,		LastEmp,		Luprc,			Luamt)
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
			b.srqty,			b.srqty - b.saqty,		
			case b.srqty - b.saqty
				when 0 then 'Y'
				else 'N'
				end,			'N',			
			b.citno, 			b.suse,			b.srno,			'N',			
			b.ordno,			'SYSTEM',	b.luprc,		b.luamt
		from	sle302_log a, sle308_log b
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
			CostGubun,		CheckSRNo,		PRTCd,			
			inputdate,		inputtime,		LastEmp,		seller,
			consig,			buyer,			trans,			trdl,		dstn)
		select	distinct b.xplant,	b.div,			substring(@ls_srno,2,1),substring(@ls_srno,3,1),	
			substring(@ls_srno,4,1),substring(@ls_srno,5,3),substring(@ls_srno,8,2), 		
			@ls_dpdt,		@ls_srdt,		invoice,		@ls_indt,
			mlc,			@ls_mlcdt,		llc,			@ls_llcdt,
			elno1,			@ls_elno1dt,		elno2,			@ls_elno2dt,
			paycd,			a.srno,			'N',			
			@ls_inptdt,		@ls_extd,		'SYSTEM',		@ls_seller,
			@ls_consig,		@ls_buyer,		@ls_trans,		@ls_trdl,	@ls_dstn
		from	pdsle301_log a, sle302_log b
		where	a.srno		=	@ls_srno	and
			a.srno		=	b.srno		and
			b.xplant	=	'D'		and
			b.div		in	('A')

		if exists (select * from [ipisele_svr\ipis].ipis.dbo.tsrheader
				Where	checksrno	=	@ls_srno)
			delete	From	pdsle301_log
			where	chgdate = @ls_chgdate
			

		end		
			
		end

		If @ls_area = 'M' or @ls_area = 'S'
		Begin

		-- 대구기계
		If not exists (select * from [ipismac_svr\ipis].ipis.dbo.tsrorder
				where	checksrno = @ls_srno)
		begin		
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
			orderno,		LastEmp,		Extd,			Luprc,	Luamt)
		select	rtrim(csrno) + 'P00',	'P',			rtrim(csrno) + 'P00',
			case kitcd
				when 'P' then 'Y'
				else 'N'
				end,	
			xplant,			div,			substring(srno,2,1),	substring(srno,3,1),
			substring(srno,4,1),	substring(srno,5,3),	substring(srno,8,2),	xplant,
			div,			substring(pdcd,1,2),	substring(pdcd,1,3),	substring(pdcd,1,4),
			itno, 			custcd,			
			substring(frdt, 1, 4)+'.'+substring(frdt, 5, 2)+'.'+substring(frdt, 7,2),
			case dktm	when '' then 1
					when 0 then 1
					else dktm end,
			srqty,			srqty - saqty,		
			case srqty - saqty
				when 0 then 'Y'
				else 'N'
				end,			'N',			
			citno, 			suse,			srno,			'N',			
			ordno,			'SYSTEM',		extd,			luprc,	luamt
		from	sle302_log
		where	srno = @ls_srno
		and	kitcd in ('P','','M')
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
			orderno,		LastEmp,		Luprc,			Luamt)
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
			b.srqty,			b.srqty - b.saqty,		
			case b.srqty - b.saqty
				when 0 then 'Y'
				else 'N'
				end,			'N',			
			b.citno, 			b.suse,			b.srno,			'N',			
			b.ordno,			'SYSTEM',	b.luprc,		b.luamt
		from	sle302_log a, sle308_log b
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
			CostGubun,		CheckSRNo,		PRTCd,			
			inputdate,		inputtime,		LastEmp,		seller,
			consig,			buyer,			trans,			trdl,		dstn)
		select	distinct b.xplant,		b.div,			substring(@ls_srno,2,1),substring(@ls_srno,3,1),	
			substring(@ls_srno,4,1),substring(@ls_srno,5,3),substring(@ls_srno,8,2), 		
			@ls_dpdt,		@ls_srdt,		invoice,		@ls_indt,
			mlc,			@ls_mlcdt,		llc,			@ls_llcdt,
			elno1,			@ls_elno1dt,		elno2,			@ls_elno2dt,
			paycd,			a.srno,			'N',			
			@ls_inptdt,		@ls_extd,		'SYSTEM',		@ls_seller,
			@ls_consig,		@ls_buyer,		@ls_trans,		@ls_trdl,	@ls_dstn
		from	pdsle301_log a, sle302_log b
		where	a.srno = @ls_srno
		and	a.srno = b.srno
		and	b.xplant = 'D'
		and	b.div in ('M','S')

		if exists (select * from [ipismac_svr\ipis].ipis.dbo.tsrheader
				Where	checksrno	=	@ls_srno)
			delete	From	pdsle301_log
			where	chgdate = @ls_chgdate
			
		end		
		
		end

		If (@ls_area = 'H' or @ls_area = 'V' or @ls_area = 'N' or @ls_area = 'O' or @ls_area = 'P' or @ls_area = 'Y')
		Begin

		-- 대구공조
		If not exists (select * from [ipishvac_svr\ipis].ipis.dbo.tsrorder
				where	checksrno = @ls_srno)
		begin		
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
			orderno,		LastEmp,		Extd,			Luprc,	Luamt)
		select	rtrim(csrno) + 'P00',	'P',			rtrim(csrno) + 'P00',
			case kitcd
				when 'P' then 'Y'
				else 'N'
				end,	
			xplant,			div,			substring(srno,2,1),	substring(srno,3,1),
			substring(srno,4,1),	substring(srno,5,3),	substring(srno,8,2),	xplant,
			div,			substring(pdcd,1,2),	substring(pdcd,1,3),	substring(pdcd,1,4),
			itno, 			custcd,			
			substring(frdt, 1, 4)+'.'+substring(frdt, 5, 2)+'.'+substring(frdt, 7,2),
			case dktm	when '' then 1
					when 0 then 1
					else dktm end,
			srqty,			srqty - saqty,		
			case srqty - saqty
				when 0 then 'Y'
				else 'N'
				end,			'N',			
			citno, 			suse,			srno,			'N',			
			ordno,			'SYSTEM',		extd,			luprc,	luamt
		from	sle302_log
		where	srno = @ls_srno
		and	kitcd in ('P','','M')
		and	((xplant = 'D' and div in ('H','V')) or xplant = 'K' or xplant = 'Y' )

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
			orderno,		LastEmp,		Luprc,			Luamt)
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
			b.srqty,			b.srqty - b.saqty,		
			case b.srqty - b.saqty
				when 0 then 'Y'
				else 'N'
				end,			'N',			
			b.citno, 			b.suse,			b.srno,			'N',			
			b.ordno,			'SYSTEM',	b.luprc,		b.luamt
		from	sle302_log a, sle308_log b
		where	a.srno = @ls_srno
		and	a.csrno = b.psrno
		and	((b.xplant = 'D' and b.div in ('H','V')) or b.xplant = 'K' or b.xplant = 'Y')

		insert into [ipishvac_svr\ipis].ipis.dbo.tsrheader
			(SRAreaCode,		SRDivisionCode,		ShipGubun, 		SRYear, 		
			SRMonth, 		SRSerial,		SRSplitCount, 
			ShipDate, 		SRConfirmDate,		InvoiceNo, 		InvoiceDate,	
			MasterLCNo, 		MasterDate, 		LocalLCNo, 		LocalLCDate,
			ELNo1, 			ELDate1, 		ELNo2,			ELDate2,		
			CostGubun,		CheckSRNo,		PRTCd,			
			inputdate,		inputtime,		LastEmp,		seller,
			consig,			buyer,			trans,			trdl,		dstn)
		select	distinct b.xplant,		b.div,			substring(@ls_srno,2,1),substring(@ls_srno,3,1),	
			substring(@ls_srno,4,1),substring(@ls_srno,5,3),substring(@ls_srno,8,2), 		
			@ls_dpdt,		@ls_srdt,		invoice,		@ls_indt,
			mlc,			@ls_mlcdt,		llc,			@ls_llcdt,
			elno1,			@ls_elno1dt,		elno2,			@ls_elno2dt,
			paycd,			a.srno,			'N',			
			@ls_inptdt,		@ls_extd,		'SYSTEM',		@ls_seller,
			@ls_consig,		@ls_buyer,		@ls_trans,		@ls_trdl,	@ls_dstn
		from	pdsle301_log a, sle302_log b
		where	a.srno = @ls_srno
		and	a.srno = b.srno
		and	((b.xplant = 'D' and b.div in ('H','V')) or b.xplant = 'K' or b.xplant = 'Y')

		if exists (select * from [ipishvac_svr\ipis].ipis.dbo.tsrheader
				Where	checksrno	=	@ls_srno)
			delete	From	pdsle301_log
			where	chgdate = @ls_chgdate
			
		end		
	
		end
		
		If @ls_area = 'B' or @ls_area = 'L' or @ls_area = 'T'
		Begin
		
		-- 진천
		If not exists (select * from [ipisjin_svr].ipis.dbo.tsrorder
				where	checksrno = @ls_srno)
		begin		
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
			orderno,		LastEmp,		Extd,			Luprc,	Luamt)
		select	rtrim(csrno) + 'P00',	'P',			rtrim(csrno) + 'P00',
			case kitcd
				when 'P' then 'Y'
				else 'N'
				end,	
			xplant,			div,			substring(srno,2,1),	substring(srno,3,1),
			substring(srno,4,1),	substring(srno,5,3),	substring(srno,8,2),	xplant,
			div,			substring(pdcd,1,2),	substring(pdcd,1,3),	substring(pdcd,1,4),
			itno, 			custcd,			
			substring(frdt, 1, 4)+'.'+substring(frdt, 5, 2)+'.'+substring(frdt, 7,2),
			case dktm	when '' then 1
					when 0 then 1
					else dktm end,
			srqty,			srqty - saqty,		
			case srqty - saqty
				when 0 then 'Y'
				else 'N'
				end,			'N',			
			citno, 			suse,			srno,			'N',			
			ordno,			'SYSTEM',		extd,			luprc,	luamt
		from	sle302_log
		where	srno = @ls_srno
		and	kitcd in ('P','','M')
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
			orderno,		LastEmp,		Luprc,			Luamt)
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
			b.srqty,			b.srqty - b.saqty,		
			case b.srqty - b.saqty
				when 0 then 'Y'
				else 'N'
				end,			'N',			
			b.citno, 			b.suse,			b.srno,			'N',			
			b.ordno,			'SYSTEM',	b.luprc,		b.luamt
		from	sle302_log a, sle308_log b
		where	a.srno = @ls_srno
		and	a.csrno = b.psrno
		and	b.xplant = 'J'

		insert into [ipisjin_svr].ipis.dbo.tsrheader
			(SRAreaCode,		SRDivisionCode,		ShipGubun, 		SRYear, 		
			SRMonth, 		SRSerial,		SRSplitCount, 
			ShipDate, 		SRConfirmDate,		InvoiceNo, 		InvoiceDate,	
			MasterLCNo, 		MasterDate, 		LocalLCNo, 		LocalLCDate,
			ELNo1, 			ELDate1, 		ELNo2,			ELDate2,		
			CostGubun,		CheckSRNo,		PRTCd,			
			inputdate,		inputtime,		LastEmp,		seller,
			consig,			buyer,			trans,			trdl,		dstn)
		select	distinct b.xplant,		b.div,			substring(@ls_srno,2,1),substring(@ls_srno,3,1),	
			substring(@ls_srno,4,1),substring(@ls_srno,5,3),substring(@ls_srno,8,2), 		
			@ls_dpdt,		@ls_srdt,		invoice,		@ls_indt,
			mlc,			@ls_mlcdt,		llc,			@ls_llcdt,
			elno1,			@ls_elno1dt,		elno2,			@ls_elno2dt,
			paycd,			a.srno,			'N',			
			@ls_inptdt,		@ls_extd,		'SYSTEM',		@ls_seller,
			@ls_consig,		@ls_buyer,		@ls_trans,		@ls_trdl,	@ls_dstn
		from	pdsle301_log a, sle302_log b
		where	a.srno = @ls_srno
		and	a.srno = b.srno
		and	b.xplant = 'J'

		if exists (select * from [ipisjin_svr].ipis.dbo.tsrheader
				Where	checksrno	=	@ls_srno)
			delete	From	pdsle301_log
			where	chgdate = @ls_chgdate

		end		
		
		end

	End	-- len(srno) = 9 end
		
	If len(@ls_srno) = 11 		---------------------------------------
	Begin
	
		If @ls_area = 'D' and @ls_division = 'A'
		Begin

		-- 대구전장
		If not exists (select * from [ipisele_svr\ipis].ipis.dbo.tsrorder
				where	checksrno = @ls_srno)
		begin		
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
			orderno,		LastEmp,		Extd,			Luprc,	Luamt)
		select	rtrim(csrno) + 'P00',	'P',			rtrim(csrno) + 'P00',
			case kitcd
				when 'P' then 'Y'
				else 'N'
				end,	
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
			srqty,			srqty - saqty,		
			case srqty - saqty
				when 0 then 'Y'
				else 'N'
				end,			'N',			
			citno, 			suse,			srno,			'N',			
			ordno,			'SYSTEM',		extd,			Luprc,	Luamt
		from	sle302_log
		where	srno = @ls_srno
		and	kitcd in ('P','','M')
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
			orderno,		LastEmp,		Luprc,			Luamt)
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
			b.srqty,			b.srqty - b.saqty,		
			case b.srqty - b.saqty
				when 0 then 'Y'
				else 'N'
				end,			'N',			
			b.citno, 			b.suse,			b.srno,			'N',			
			b.ordno,			'SYSTEM',	b.luprc,		b.luamt
		from	sle302_log a, sle308_log b
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
			CostGubun,		CheckSRNo,		PRTCd,			
			inputdate,		inputtime,		LastEmp,		seller,
			consig,			buyer,			trans,			trdl,		dstn)
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
			paycd,			a.srno,			'N',			
			@ls_inptdt,		@ls_extd,		'SYSTEM',		@ls_seller,
			@ls_consig,		@ls_buyer,		@ls_trans,		@ls_trdl,	@ls_dstn
		from	pdsle301_log a, sle302_log b
		where	a.srno = @ls_srno
		and	a.srno = b.srno
		and	b.xplant = 'D'
		and	b.div in ('A')

		if exists (select * from [ipisele_svr\ipis].ipis.dbo.tsrheader
				Where	checksrno	=	@ls_srno)
			delete	From	pdsle301_log
			where	chgdate = @ls_chgdate
		end		
		
		end
		
		If @ls_area = 'D' and (@ls_division = 'M' or @ls_division = 'S')
		Begin

		-- 대구기계
		If not exists (select * from [ipismac_svr\ipis].ipis.dbo.tsrorder
				where	checksrno = @ls_srno)
		begin		
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
			orderno,		LastEmp,		Extd,			Luprc,	Luamt)
		select	rtrim(csrno) + 'P00',	'P',			rtrim(csrno) + 'P00',
			case kitcd
				when 'P' then 'Y'
				else 'N'
				end,	
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
			srqty,			srqty - saqty,		
			case srqty - saqty
				when 0 then 'Y'
				else 'N'
				end,			'N',			
			citno, 			suse,			srno,			'N',			
			ordno,			'SYSTEM',		extd,			luprc,	luamt
		from	sle302_log
		where	srno = @ls_srno
		and	kitcd in ('P','','M')
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
			orderno,		LastEmp,		Luprc,			Luamt)
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
			b.srqty,			b.srqty - b.saqty,		
			case b.srqty - b.saqty
				when 0 then 'Y'
				else 'N'
				end,			'N',			
			b.citno, 			b.suse,			b.srno,			'N',			
			b.ordno,			'SYSTEM',	b.luprc,		b.luamt
		from	sle302_log a, sle308_log b
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
			CostGubun,		CheckSRNo,		PRTCd,			
			inputdate,		inputtime,		LastEmp,		seller,
			consig,			buyer,			trans,			trdl,		dstn)
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
			paycd,			a.srno,			'N',			
			@ls_inptdt,		@ls_extd,		'SYSTEM',		@ls_seller,
			@ls_consig,		@ls_buyer,		@ls_trans,		@ls_trdl,	@ls_dstn
		from	pdsle301_log a, sle302_log b
		where	a.srno = @ls_srno
		and	a.srno = b.srno
		and	b.xplant = 'D'
		and	b.div in ('M','S')

		if exists (select * from [ipismac_svr\ipis].ipis.dbo.tsrheader
				Where	checksrno	=	@ls_srno)
			delete	From	pdsle301_log
			where	chgdate = @ls_chgdate
			
		end		
		
		end
		
		If (@ls_area = 'D' and (@ls_division = 'H' or @ls_division = 'V')) or @ls_area = 'K' or @ls_area = 'Y'
		Begin

		-- 대구공조
		If not exists (select * from [ipishvac_svr\ipis].ipis.dbo.tsrorder
				where	checksrno = @ls_srno)
		begin		
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
			orderno,		LastEmp,		Extd,			Luprc,	Luamt)
		select	rtrim(csrno) + 'P00',	'P',			rtrim(csrno) + 'P00',
			case kitcd
				when 'P' then 'Y'
				else 'N'
				end,	
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
			srqty,			srqty - saqty,		
			case srqty - saqty
				when 0 then 'Y'
				else 'N'
				end,			'N',			
			citno, 			suse,			srno,			'N',			
			ordno,			'SYSTEM',		extd,			luprc,	luamt
		from	sle302_log
		where	srno = @ls_srno
		and	kitcd in ('P','','M')
		and	((xplant = 'D' and div in ('H','V')) or xplant = 'K' or xplant = 'Y')

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
			orderno,		LastEmp,		Luprc,			Luamt)
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
			b.srqty,			b.srqty - b.saqty,		
			case b.srqty - b.saqty
				when 0 then 'Y'
				else 'N'
				end,			'N',			
			b.citno, 			b.suse,			b.srno,			'N',			
			b.ordno,			'SYSTEM',	b.luprc,		b.luamt
		from	sle302_log a, sle308_log b
		where	a.srno = @ls_srno
		and	a.csrno = b.psrno
		and	((b.xplant = 'D' and b.div in ('H','V')) or b.xplant = 'K' or b.xplant = 'Y')

		insert into [ipishvac_svr\ipis].ipis.dbo.tsrheader
			(SRAreaCode,		SRDivisionCode,		ShipGubun, 		SRYear, 		
			SRMonth, 		SRSerial,		SRSplitCount, 
			ShipDate, 		SRConfirmDate,		InvoiceNo, 		InvoiceDate,	
			MasterLCNo, 		MasterDate, 		LocalLCNo, 		LocalLCDate,
			ELNo1, 			ELDate1, 		ELNo2,			ELDate2,		
			CostGubun,		CheckSRNo,		PRTCd,			
			inputdate,		inputtime,		LastEmp,		seller,
			consig,			buyer,			trans,			trdl,		dstn)
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
			paycd,			a.srno,			'N',			
			@ls_inptdt,		@ls_extd,		'SYSTEM',		@ls_seller,
			@ls_consig,		@ls_buyer,		@ls_trans,		@ls_trdl,	@ls_dstn
		from	pdsle301_log a, sle302_log b
		where	a.srno = @ls_srno
		and	a.srno = b.srno
		and	((b.xplant = 'D' and b.div in ('H','V')) or b.xplant = 'K' or b.xplant = 'Y')

		if exists (select * from [ipishvac_svr\ipis].ipis.dbo.tsrheader
				Where	checksrno	=	@ls_srno)
			delete	From	pdsle301_log
			where	chgdate = @ls_chgdate
			
		end		
				
		end
		
		If @ls_area = 'J'
		Begin

		-- 진천
		If not exists (select * from [ipisjin_svr].ipis.dbo.tsrorder
				where	checksrno = @ls_srno)
		begin		
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
			orderno,		LastEmp,		Extd,			Luprc,	Luamt)
		select	rtrim(csrno) + 'P00',	'P',			rtrim(csrno) + 'P00',
			case kitcd
				when 'P' then 'Y'
				else 'N'
				end,	
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
			srqty,			srqty - saqty,		
			case srqty - saqty
				when 0 then 'Y'
				else 'N'
				end,			'N',			
			citno, 			suse,			srno,			'N',			
			ordno,			'SYSTEM',		extd,			luprc,	luamt
		from	sle302_log
		where	srno = @ls_srno
		and	kitcd in ('P','','M')
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
			orderno,		LastEmp,		Luprc,			Luamt)
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
			b.srqty,			b.srqty - b.saqty,		
			case b.srqty - b.saqty
				when 0 then 'Y'
				else 'N'
				end,			'N',			
			b.citno, 			b.suse,			b.srno,			'N',			
			b.ordno,			'SYSTEM',	b.luprc,		b.luamt
		from	sle302_log a, sle308_log b
		where	a.srno = @ls_srno
		and	a.csrno = b.psrno
		and	b.xplant = 'J'

		insert into [ipisjin_svr].ipis.dbo.tsrheader
			(SRAreaCode,		SRDivisionCode,		ShipGubun, 		SRYear, 		
			SRMonth, 		SRSerial,		SRSplitCount, 
			ShipDate, 		SRConfirmDate,		InvoiceNo, 		InvoiceDate,	
			MasterLCNo, 		MasterDate, 		LocalLCNo, 		LocalLCDate,
			ELNo1, 			ELDate1, 		ELNo2,			ELDate2,		
			CostGubun,		CheckSRNo,		PRTCd,			
			inputdate,		inputtime,		LastEmp,		seller,
			consig,			buyer,			trans,			trdl,		dstn)
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
			paycd,			a.srno,			'N',			
			@ls_inptdt,		@ls_extd,		'SYSTEM',		@ls_seller,
			@ls_consig,		@ls_buyer,		@ls_trans,		@ls_trdl,	@ls_dstn
		from	pdsle301_log a, sle302_log b
		where	a.srno = @ls_srno
		and	a.srno = b.srno
		and	b.xplant = 'J'
		
		if exists (select * from [ipisjin_svr].ipis.dbo.tsrheader
				Where	checksrno	=	@ls_srno)
			delete	From	pdsle301_log
			where	chgdate = @ls_chgdate

		end		
				
		end
		
	end	-- len(@ls_srno) = 11 end		

	End	-- 추가 end
	
	If @ls_chgcd = 'D' 	-- 삭제
	Begin
		-- 대구 전장
		If exists (select * from [ipisele_svr\ipis].ipis.dbo.tsrorder
				where	checksrno = @ls_srno)
		begin		
		select @ls_deletecheck = sum(shiporderqty) - sum(shipremainqty) 
		from [ipisele_svr\ipis].ipis.dbo.tsrorder
		where	checksrno = @ls_srno

		
		If @ls_deletecheck = 0
		begin		
			delete from [ipisele_svr\ipis].ipis.dbo.tsrorder
			where	checksrno = @ls_srno

			delete from [ipisele_svr\ipis].ipis.dbo.tsrheader
			where	checksrno = @ls_srno
			
			if Not exists (select * from [ipisele_svr\ipis].ipis.dbo.tsrheader
				Where	checksrno	=	@ls_srno)
				delete	From	pdsle301_log
				where	chgdate = @ls_chgdate

		end	
		end
		
		-- 대구 기계
		If exists (select * from [ipismac_svr\ipis].ipis.dbo.tsrorder
				where	checksrno = @ls_srno)
		begin		
		select @ls_deletecheck = sum(shiporderqty) - sum(shipremainqty) 
		from [ipismac_svr\ipis].ipis.dbo.tsrorder
		where	checksrno = @ls_srno

		
		If @ls_deletecheck = 0
		begin		
			delete from [ipismac_svr\ipis].ipis.dbo.tsrorder
			where	checksrno = @ls_srno

	
			delete from [ipismac_svr\ipis].ipis.dbo.tsrheader
			where	checksrno = @ls_srno

			if Not exists (select * from [ipismac_svr\ipis].ipis.dbo.tsrheader
				Where	checksrno	=	@ls_srno)
				delete	From	pdsle301_log
				where	chgdate = @ls_chgdate
		end	
		end

		-- 대구 공조
		If exists (select * from [ipishvac_svr\ipis].ipis.dbo.tsrorder
				where	checksrno = @ls_srno)
		begin		
		select @ls_deletecheck = sum(shiporderqty) - sum(shipremainqty) 
		from [ipishvac_svr\ipis].ipis.dbo.tsrorder
		where	checksrno = @ls_srno

		If @ls_deletecheck = 0
		begin		
			delete from [ipishvac_svr\ipis].ipis.dbo.tsrorder
			where	checksrno = @ls_srno

			delete from [ipishvac_svr\ipis].ipis.dbo.tsrheader
			where	checksrno = @ls_srno
			
			if Not exists (select * from [ipishvac_svr\ipis].ipis.dbo.tsrheader
				Where	checksrno	=	@ls_srno)
				delete	From	pdsle301_log
				where	chgdate = @ls_chgdate

		end	
		end

		-- 진천
		If exists (select * from [ipisjin_svr].ipis.dbo.tsrorder
				where	checksrno = @ls_srno)
		begin		
		select @ls_deletecheck = sum(shiporderqty) - sum(shipremainqty) 
		from [ipisjin_svr].ipis.dbo.tsrorder
		where	checksrno = @ls_srno

		If @ls_deletecheck = 0
		begin		
			delete from [ipisjin_svr].ipis.dbo.tsrorder
			where	checksrno = @ls_srno

			delete from [ipisjin_svr].ipis.dbo.tsrheader
			where	checksrno = @ls_srno
			
			if Not exists (select * from [ipisjin_svr].ipis.dbo.tsrheader
				Where	checksrno	=	@ls_srno)
				delete	From	pdsle301_log
				where	chgdate = @ls_chgdate

		end	
		end
		
	End	-- 삭제 end

End			-- While Loop End
	
drop table #tmp_pdsle301

if (select count(*) from pdsle301_log) = 0
	begin
		truncate table pdsle301_log
		truncate table sle302_log
		truncate table sle308_log
	end
	
End		-- Procedure End
Go
