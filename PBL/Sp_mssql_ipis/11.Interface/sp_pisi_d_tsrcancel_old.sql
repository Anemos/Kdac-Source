/*
	File Name	: sp_pisi_d_tsrcancel.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tsrcancel
	Description	: Download SR Header
			  tsrheader - pdsle303
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tsrcancel]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tsrcancel]
GO

/*
Execute sp_pisi_d_tsrcancel
*/

Create Procedure sp_pisi_d_tsrcancel
	
	
As
Begin

Declare	@i			Int,
	@li_loop_count		Int,
	@ls_chgcd		char(1),
	@ls_srno		varchar(11),
	@ls_len			smallint,
	@ls_area		char(1),
	@ls_division		char(1),
	@li_qty			int,
	@ls_date		varchar(30)

/*	
-- SR 취소 down log table
Insert	into pdsle303_log		
Select	*
from	pdsle303
order by chgdate

Truncate table pdsle303

Insert	into pdsle303
	(CHGDATE,	CHGCD,		SRNO,		STSCD,		DOWNDATE)
Select	distinct CHGDATE,	CHGCD,		SRNO,		STSCD,		DOWNDATE
from	pdsle303_log
where	stscd = 'N'
order by chgdate
*/

select *
into	#tmp_pdsle303	
from	pdsle303
order by chgdate
	
Select @i = 0, @li_loop_count = @@RowCount, @ls_date = ''

While @i < @li_loop_count
Begin
	Select	Top 1
		@i		= @i + 1,
		@ls_chgcd	= chgcd,
		@ls_srno	= rtrim(srno),		-- sr전산번호
		@ls_date	= chgdate
	From	#tmp_pdsle303
	Where	chgdate > @ls_date
	
	select	top 1
		@ls_area	= xplant,
		@ls_division	= div,
		@li_qty		= caqty
	from	sle304_temp
	where	srno		= @ls_srno	

	If @ls_chgcd = 'A' 	-- 추가
	Begin
		If @ls_area = 'D' and @ls_division = 'A'
		begin	
			-- 대구전장
			If exists (select * from [ipisele_svr\ipis].ipis.dbo.tsrorder
					where	checksrno = @ls_srno)
			begin		
				select	@ls_len = max(len(csrno))
				from	sle304_temp
				where	srno = @ls_srno
				
				update	[ipisele_svr\ipis].ipis.dbo.tsrorder
				set	srcancelgubun ='Y',
					cancelqty = @li_qty,
					shipremainqty = shipremainqty - @li_qty,
					shipendgubun = case 
						when shipremainqty - @li_qty = 0 then 'Y'
						else shipendgubun
						end
				where	substring(srno, 1, @ls_len) in (select csrno from sle304_temp 
								where srno = @ls_srno)	-- sle304_temp의 csrno인 놈 

				If not exists (select * from [ipisele_svr\ipis].ipis.dbo.tsrcancel
						where	checksrno = @ls_srno)
					insert into [ipisele_svr\ipis].ipis.dbo.tsrcancel
						(CancelDate,		
						AreaCode,		DivisionCode,		SRNo,
						CancelGubun,		CheckSRNo,		ItemCode,		
						ConfirmFlag,		CancelQty,		LastEmp)
					select	substring(updtdt,1,4)+'.'+substring(updtdt,5,2)+'.'+substring(updtdt,7,2),
						xplant,			div,			csrno,
						'2',			srno,			itno,
						'N',			caqty,			'SYSTEM'			
					from	sle304_temp
					where	srno = @ls_srno
					and	stcd <> 'C'
					and	xplant = 'D'
					and	div in ('A')

			end						
--					If @@error = 0 					
--						update	pdsle303_log
--						set	stscd = 'Y',
--							lastdate = getdate()
--						where	chgdate = @ls_date
--			end	
--			Else
--				update	pdsle303_log
--				set	stscd = 'X',
--					lastdate = getdate()
--				where	chgdate = @ls_date


		end

		If @ls_area = 'D' and (@ls_division = 'M' or @ls_division = 'S')
		begin	
			-- 대구기계
			If exists (select * from [ipismac_svr\ipis].ipis.dbo.tsrorder
					where	checksrno = @ls_srno)
			begin				
				select	@ls_len = max(len(csrno))
				from	sle304_temp
				where	srno = @ls_srno
				
				update	[ipismac_svr\ipis].ipis.dbo.tsrorder
				set	srcancelgubun ='Y',
					cancelqty = @li_qty,
					shipremainqty = shipremainqty - @li_qty,
					shipendgubun = case 
						when shipremainqty - @li_qty = 0 then 'Y'
						else shipendgubun
						end
				where	substring(srno, 1, @ls_len) in (select csrno from sle304_temp 
									where srno = @ls_srno)	-- sle304_temp의 csrno인 놈 

				If not exists (select * from [ipismac_svr\ipis].ipis.dbo.tsrcancel
						where	checksrno = @ls_srno)
					insert into [ipismac_svr\ipis].ipis.dbo.tsrcancel
						(CancelDate,		
						AreaCode,		DivisionCode,		SRNo,
						CancelGubun,		CheckSRNo,		ItemCode,		
						ConfirmFlag,		CancelQty,		LastEmp)
					select	substring(updtdt,1,4)+'.'+substring(updtdt,5,2)+'.'+substring(updtdt,7,2),
						xplant,			div,			csrno,
						'2',			srno,			itno,
						'N',			caqty,			'SYSTEM'			
					from	sle304_temp
					where	srno = @ls_srno
					and	stcd <> 'C'
					and	xplant = 'D'
					and	div in ('M','S')
			
			end							
--					If @@error = 0
--						update	pdsle303_log
--						set	stscd = 'Y',
--							lastdate = getdate()
--						where	chgdate = @ls_date
--			end	
--			Else
--				update	pdsle303_log
--				set	stscd = 'X',
--					lastdate = getdate()
--				where	chgdate = @ls_date
				
		end	

		If (@ls_area = 'D' and (@ls_division = 'H' or @ls_division = 'V')) or (@ls_area = 'K' or @ls_area = 'Y')
		begin	
			-- 대구공조
			If exists (select * from [ipishvac_svr\ipis].ipis.dbo.tsrorder
					where	checksrno = @ls_srno)
			begin				
				select	@ls_len = max(len(csrno))
				from	sle304_temp
				where	srno = @ls_srno
				
				update	[ipishvac_svr\ipis].ipis.dbo.tsrorder
				set	srcancelgubun ='Y',
					cancelqty = @li_qty,
					shipremainqty = shipremainqty - @li_qty,
					shipendgubun = case 
						when shipremainqty - @li_qty = 0 then 'Y'
						else shipendgubun
						end
				where	substring(srno, 1, @ls_len) in (select csrno from sle304_temp 
									where srno = @ls_srno)	-- sle304_temp의 csrno인 놈 

				If not exists (select * from [ipishvac_svr\ipis].ipis.dbo.tsrcancel
						where	checksrno = @ls_srno)
					insert into [ipishvac_svr\ipis].ipis.dbo.tsrcancel
						(CancelDate,		
						AreaCode,		DivisionCode,		SRNo,
						CancelGubun,		CheckSRNo,		ItemCode,		
						ConfirmFlag,		CancelQty,		LastEmp)
					select	substring(updtdt,1,4)+'.'+substring(updtdt,5,2)+'.'+substring(updtdt,7,2),
						xplant,			div,			csrno,
						'2',			srno,			itno,
						'N',			caqty,			'SYSTEM'			
					from	sle304_temp
					where	srno = @ls_srno
					and	stcd <> 'C'
					and	((xplant = 'D' and div in ('H','V')) or xplant in ('K', 'Y'))
			
			end							
--					If @@error = 0
--						update	pdsle303_log
--						set	stscd = 'Y',
--							lastdate = getdate()
--						where	chgdate = @ls_date
--			end	
--			Else
--				update	pdsle303_log
--				set	stscd = 'X',
--					lastdate = getdate()
--				where	chgdate = @ls_date
				
		end	

		If @ls_area = 'J'
		begin	
			-- 진천
			If exists (select * from [ipisjin_svr].ipis.dbo.tsrorder
					where	checksrno = @ls_srno)
			begin				
				select	@ls_len = max(len(csrno))
				from	sle304_temp
				where	srno = @ls_srno
				
				update	[ipisjin_svr].ipis.dbo.tsrorder
				set	srcancelgubun ='Y',
					cancelqty = @li_qty,
					shipremainqty = shipremainqty - @li_qty,
					shipendgubun = case 
						when shipremainqty - @li_qty = 0 then 'Y'
						else shipendgubun
						end
				where	substring(srno, 1, @ls_len) in (select csrno from sle304_temp 
									where srno = @ls_srno)	-- sle304_temp의 csrno인 놈 

				If not exists (select * from [ipisjin_svr].ipis.dbo.tsrcancel
						where	checksrno = @ls_srno)
					insert into [ipisjin_svr].ipis.dbo.tsrcancel
						(CancelDate,		
						AreaCode,		DivisionCode,		SRNo,
						CancelGubun,		CheckSRNo,		ItemCode,		
						ConfirmFlag,		CancelQty,		LastEmp)
					select	substring(updtdt,1,4)+'.'+substring(updtdt,5,2)+'.'+substring(updtdt,7,2),
						xplant,			div,			csrno,
						'2',			srno,			itno,
						'N',			caqty,			'SYSTEM'			
					from	sle304_temp
					where	srno = @ls_srno
					and	stcd <> 'C'
					and	xplant = 'J'
					
			end							
--					If @@error = 0
--						update	pdsle303_log
--						set	stscd = 'Y',
--							lastdate = getdate()
--						where	chgdate = @ls_date
--			end	
--			Else
--				update	pdsle303_log
--				set	stscd = 'X',
--					lastdate = getdate()
--				where	chgdate = @ls_date
				
		end	

	End	-- 추가 end
	
	If @ls_chgcd = 'D' 	-- 삭제
	Begin
		delete from [ipisele_svr\ipis].ipis.dbo.tsrcancel
		where	substring(srno, 1, @ls_len) = @ls_srno

		delete from [ipismac_svr\ipis].ipis.dbo.tsrcancel
		where	substring(srno, 1, @ls_len) = @ls_srno

		delete from [ipishvac_svr\ipis].ipis.dbo.tsrcancel
		where	substring(srno, 1, @ls_len) = @ls_srno

		delete from [ipisjin_svr].ipis.dbo.tsrcancel
		where	substring(srno, 1, @ls_len) = @ls_srno

	End	-- 삭제 end
	
End			-- While Loop End

--truncate table sle304_temp
--truncate table pdsle303

drop table #tmp_pdsle303

End		-- Procedure End
Go