SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/*
Execute sp_pisi_d_tmstpartcost_movelog
*/

ALTER  Procedure sp_pisi_d_tmstpartcost_movelog
	
	
As
Begin

SET XACT_ABORT OFF

Begin Tran

--Select	*
--into	#tmp_pdpur103
--from	pdpur103
--where comltd+vsrc+vsrno+chgdate+dept in (select comltd+vsrc+vsrno+chgdate+min(dept) from pdpur103
--       			group by comltd,vsrc,vsrno,chgdate)
--order by chgdate

--if @@error<> 0
--	Begin
--		RollBack Tran
--		Return
--	End
	
insert	into	pdpur103_log
	(chgdate,		chgcd,			comltd,			vsrc,
	 Dept,			Vsrno,			itno,			itno1,
	 itnm1,			spec1,			unit1,			wsrc,
	 convqty1,		dadjdt,			dcurr,			dcost,
	 dsheet,		eadjdt,			ecurr,			ecost,
	 esheet,		arr,			xpay,			vzero,
	 qccd,			adjdt,			Frpdt,			pqty,
	 xrate,			shrt,			xplan,			strt,
	 chcs,			fpurno,			fpindt,			fcost,
	 purno,			pindt,			rqno,			srno,
	 srno1,			dkdt,			lcost,			xstop,
	 extd,			inptid,			inptdt,			updtid,
	 updtdt,		ipaddr,			macaddr,		stscd,
	 downdate)
select	 rtrim(chgdate),	rtrim(chgcd),		rtrim(comltd),		rtrim(vsrc),
	 rtrim(Dept),		rtrim(vsrno),		rtrim(itno),		rtrim(itno1),
	 rtrim(itnm1),		rtrim(spec1),		rtrim(unit1),		rtrim(wsrc),
	 convqty1,		rtrim(dadjdt),		rtrim(dcurr),		dcost,
	 rtrim(dsheet),		rtrim(eadjdt),		rtrim(ecurr),		ecost,
	 rtrim(esheet),		rtrim(arr),		rtrim(xpay),		rtrim(vzero),
	 rtrim(qccd),		rtrim(adjdt),		rtrim(frpdt),		pqty,
	 xrate,			shrt,			rtrim(xplan),		rtrim(strt),
	 chcs,			rtrim(fpurno),		rtrim(fpindt),		fcost,
	 rtrim(purno),		rtrim(pindt),		rtrim(rqno),		rtrim(srno),
	 rtrim(srno1),		rtrim(dkdt),		lcost,			rtrim(xstop),
	 rtrim(extd),		rtrim(inptid),		rtrim(inptdt),		rtrim(updtid),
	 rtrim(updtdt),		rtrim(ipaddr),		rtrim(macaddr),		rtrim(stscd),
	 downdate
From	Pdpur103
where	stscd = 'N'	and
	vsrno 	is not null and
	itno 	is not null and
	chgdate not in	(select	chgdate	from	pdpur103_log)
order by chgdate

if @@error<> 0
	Begin
		RollBack Tran
		Return
	End
	
Update	pdpur103
Set	stscd	=	'Y'
From	Pdpur103	a,
	pdpur103_log	b
Where	a.chgdate	=	b.chgdate or
		a.vsrno is null or
		a.itno    is null

if @@error <> 0
	begin
		RollBack Tran
		Return
	End

commit tran

--drop table #tmp_pdpur103

End		-- Procedure End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

