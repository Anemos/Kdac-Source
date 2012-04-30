/*
	File Name	: sp_pisi_d_pdsle401.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_pdsle401
	Description	: Download 영업납품확인
			  tshipsheet update - pdsle401
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_pdsle401]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_pdsle401]
GO

/*
Execute sp_pisi_d_pdsle401
*/

Create Procedure sp_pisi_d_pdsle401
	
	
As
Begin

set xact_abort off

Select	top 100 *
into	#tmp_pdsle401
from	pdsle401_log
where csrno+slno+chgdate in (select csrno+slno+max(chgdate) from pdsle401_log
       			group by csrno,slno)
order by chgdate

-- 대구전장

update	[ipisele_svr\ipis].ipis.dbo.tshipsheet
set	DeliveryFlag = case b.chgcd
			when 'A' then 'Y'
			when 'D' then 'N'
		        end
from [ipisele_svr\ipis].ipis.dbo.tshipsheet	a,
     #tmp_pdsle401				b
where	a.srno 		= rtrim(b.csrno)+'P00' and
	a.shipsheetno 	= b.slno	and
	b.xplant	= 'D'		and
	b.div 		= 'A'

if @@error	=	0
	Begin
	Delete	From	pdsle401_log
	Where	xplant		= 'D'		and
		div 		= 'A'		and
		rtrim(Csrno)+'P00'+Slno	in	(Select srno+ShipSheetNo
					 From	[ipisele_svr\ipis].ipis.dbo.tshipsheet	a,
					 	  #tmp_pdsle401				b
						where	a.srno 		= rtrim(b.csrno)+'P00' and
							a.shipsheetno 	= b.slno)
End
	
-- 대구기계

update	[ipismac_svr\ipis].ipis.dbo.tshipsheet
set	DeliveryFlag = case b.chgcd
			when 'A' then 'Y'
			when 'D' then 'N'
		        end
from [ipismac_svr\ipis].ipis.dbo.tshipsheet	a,
     #tmp_pdsle401 				b
where	a.srno 		=	rtrim(b.csrno)+'P00'	and
	a.shipsheetno 	=	b.slno		and
	b.xplant	=	'D' 		and
	b.div 		in	('M','S')

if @@error	=	0	
	Begin
	Delete	From	pdsle401_log
	Where	xplant		=	'D'		and
		div			in	('M','S')		and
		rtrim(Csrno)+'P00'+Slno	in	(Select srno+ShipSheetNo
						 From	[ipismac_svr\ipis].ipis.dbo.tshipsheet	a,
					 	  	#tmp_pdsle401				b
						where	a.srno 		= rtrim(b.csrno)+'P00' and
							a.shipsheetno 	= b.slno )
	End
	
	
-- 대구공조

update	[ipishvac_svr\ipis].ipis.dbo.tshipsheet
set	DeliveryFlag = case chgcd
			when 'A' then 'Y'
			when 'D' then 'N'
		       end
from [ipishvac_svr\ipis].ipis.dbo.tshipsheet	a,
     #tmp_pdsle401 				b
where	a.srno 		=	rtrim(b.csrno)+'P00'	and
	a.shipsheetno	=	b.slno		and
	((b.xplant	=	'D'		and
	  b.div 	in	('H','V'))	or
	  (b.xplant 	=	'K' or b.xplant = 'Y'))


if @@error	=	0	
	Begin
	Delete	From	pdsle401_log
	Where		((xplant	=	'D'		and
			  div 	in	('H','V'))	or
			  (xplant 	=	'K' or xplant = 'Y'))		and
			  rtrim(Csrno)+'P00'+Slno	in	(Select srno+ShipSheetNo
						 From	[ipishvac_svr\ipis].ipis.dbo.tshipsheet	a,
					 	  	#tmp_pdsle401				b
						where	a.srno 		= rtrim(b.csrno)+'P00' and
							a.shipsheetno 	= b.slno)
	End
	
-- 진천

update	[ipisjin_svr].ipis.dbo.tshipsheet
set	DeliveryFlag = case chgcd
			when 'A' then 'Y'
			when 'D' then 'N'
		       end
from [ipisjin_svr].ipis.dbo.tshipsheet	a,
     #tmp_pdsle401 			b
where	a.srno		=	rtrim(b.csrno)+'P00'	and
	a.shipsheetno	=	b.slno		and
	b.xplant	=	'J'

if @@error	=	0	
	Begin
	Delete	From	pdsle401_log
	Where	xplant	=	'J'		and
		rtrim(Csrno)+'P00'+Slno	in	(Select srno+ShipSheetNo
						 From	[ipisjin_svr].ipis.dbo.tshipsheet	a,
					 	  	#tmp_pdsle401				b
						where	a.srno 		= rtrim(b.csrno)+'P00' and
							a.shipsheetno 	= b.slno)
	End
	
if (select count(*) from pdsle401_log) = 0
	begin
		truncate table pdsle401_log
	end

Drop table #tmp_pdsle401

End		-- Procedure End
Go
