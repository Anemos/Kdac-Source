/*
	File Name	: sp_pisi_d_tsrcancel.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tsrcancel
	Description	: Download SR Cancel
			  tsrcancel - pdsle304
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
	@ls_csrno		varchar(11),
	@ls_xplant		char(1),
	@ls_div			char(1),	
	@ls_srno		varchar(11),
	@ls_itno		varchar(12),
	@ls_psrno		varchar(11),
	@ls_kitcd		char(1),
	@ls_srdt		char(8),
	@li_caqty		int,
	@li_srqty		int,
	@ls_date		varchar(30)


select *
into	#tmp_pdsle304
from	pdsle304
order by chgdate
	
Select @i = 0, @li_loop_count = @@RowCount, @ls_date = ''

While @i < @li_loop_count
Begin
	Select	Top 1
		@i		= @i + 1,
		@ls_chgcd	= chgcd,
		@ls_csrno	= rtrim(csrno),
		@ls_xplant	= xplant,
		@ls_div		= div,
		@ls_srno	= rtrim(srno),
		@ls_itno	= rtrim(itno),
		@ls_psrno	= rtrim(psrno),
		@ls_kitcd	= kitcd,
		@li_caqty	= caqty,
		@li_srqty	= srqty,
		@ls_srdt	= srdt,
		@ls_date	= chgdate
	From	#tmp_pdsle304
	Where	chgdate > @ls_date

	If @ls_chgcd = 'A' 	-- 추가
	Begin
		If @ls_xplant = 'D' and @ls_div = 'A'
		begin	
			-- 대구전장
			If exists (select * from [ipisele_svr\ipis].ipis.dbo.tsrorder
					where	srno = @ls_csrno+'P00')
			begin		
				
				update	[ipisele_svr\ipis].ipis.dbo.tsrorder
				set	srcancelgubun ='Y',
					cancelqty = @li_caqty,
					shipremainqty = shipremainqty - @li_caqty,
					shipendgubun = case 
						when shipremainqty - @li_caqty = 0 then 'Y'
						else shipendgubun
						end
				where	srno = @ls_csrno+'P00'

				If not exists (select * from [ipisele_svr\ipis].ipis.dbo.tsrcancel
						where	srno = @ls_csrno)
					insert into [ipisele_svr\ipis].ipis.dbo.tsrcancel
						(CancelDate,		
						AreaCode,		DivisionCode,		SRNo,
						CancelGubun,		CheckSRNo,		ItemCode,		
						ConfirmFlag,		CancelQty,		LastEmp)
					values	(substring(@ls_srdt,1,4)+'.'+substring(@ls_srdt,5,2)+'.'+substring(@ls_srdt,7,2),
						@ls_xplant,		@ls_div,		@ls_csrno,
						'2',			@ls_srno,		@ls_itno,
						'N',			@li_caqty,		'SYSTEM')
				
				If @ls_kitcd = 'P'	-- kit일때 child 처리
					update	[ipisele_svr\ipis].ipis.dbo.tsrorder
					set	srcancelgubun ='Y',
						cancelqty = (shiporderqty / @li_srqty)*@li_caqty,
						shipremainqty = shipremainqty - (shiporderqty / @li_srqty)*@li_caqty,
						shipendgubun = case 
							when shipremainqty - (shiporderqty / @li_srqty)*@li_caqty = 0 then 'Y'
							else shipendgubun
							end
					where	psrno = @ls_csrno+'P00'
					and	pcgubun = 'C'


			end						
		end

		If @ls_xplant = 'D' and (@ls_div = 'M' or @ls_div = 'S')
		begin	
			-- 대구기계
			If exists (select * from [ipismac_svr\ipis].ipis.dbo.tsrorder
					where	srno = @ls_csrno+'P00')
			begin				
				update	[ipismac_svr\ipis].ipis.dbo.tsrorder
				set	srcancelgubun ='Y',
					cancelqty = @li_caqty,
					shipremainqty = shipremainqty - @li_caqty,
					shipendgubun = case 
						when shipremainqty - @li_caqty = 0 then 'Y'
						else shipendgubun
						end
				where	srno = @ls_csrno+'P00'

				If not exists (select * from [ipismac_svr\ipis].ipis.dbo.tsrcancel
						where	srno = @ls_csrno)
					insert into [ipismac_svr\ipis].ipis.dbo.tsrcancel
						(CancelDate,		
						AreaCode,		DivisionCode,		SRNo,
						CancelGubun,		CheckSRNo,		ItemCode,		
						ConfirmFlag,		CancelQty,		LastEmp)
					values	(substring(@ls_srdt,1,4)+'.'+substring(@ls_srdt,5,2)+'.'+substring(@ls_srdt,7,2),
						@ls_xplant,		@ls_div,		@ls_csrno,
						'2',			@ls_srno,		@ls_itno,
						'N',			@li_caqty,		'SYSTEM')

				If @ls_kitcd = 'P'
					update	[ipismac_svr\ipis].ipis.dbo.tsrorder
					set	srcancelgubun ='Y',
						cancelqty = (shiporderqty / @li_srqty)*@li_caqty,
						shipremainqty = shipremainqty - (shiporderqty / @li_srqty)*@li_caqty,
						shipendgubun = case 
							when shipremainqty - (shiporderqty / @li_srqty)*@li_caqty = 0 then 'Y'
							else shipendgubun
							end
					where	psrno = @ls_csrno+'P00'
					and	pcgubun = 'C'
			
			end							
		end	

		If (@ls_xplant = 'D' and (@ls_div = 'H' or @ls_div = 'V')) or @ls_xplant = 'K' or @ls_xplant = 'Y'
		begin	
			-- 대구공조
			If exists (select * from [ipishvac_svr\ipis].ipis.dbo.tsrorder
					where	srno = @ls_csrno+'P00')
			begin				
				update	[ipishvac_svr\ipis].ipis.dbo.tsrorder
				set	srcancelgubun ='Y',
					cancelqty = @li_caqty,
					shipremainqty = shipremainqty - @li_caqty,
					shipendgubun = case 
						when shipremainqty - @li_caqty = 0 then 'Y'
						else shipendgubun
						end
				where	srno = @ls_csrno+'P00'

				If not exists (select * from [ipishvac_svr\ipis].ipis.dbo.tsrcancel
						where	srno = @ls_csrno)
					insert into [ipishvac_svr\ipis].ipis.dbo.tsrcancel
						(CancelDate,		
						AreaCode,		DivisionCode,		SRNo,
						CancelGubun,		CheckSRNo,		ItemCode,		
						ConfirmFlag,		CancelQty,		LastEmp)
					values	(substring(@ls_srdt,1,4)+'.'+substring(@ls_srdt,5,2)+'.'+substring(@ls_srdt,7,2),
						@ls_xplant,		@ls_div,		@ls_csrno,
						'2',			@ls_srno,		@ls_itno,
						'N',			@li_caqty,		'SYSTEM')

				If @ls_kitcd = 'P'
					update	[ipishvac_svr\ipis].ipis.dbo.tsrorder
					set	srcancelgubun ='Y',
						cancelqty = (shiporderqty / @li_srqty)*@li_caqty,
						shipremainqty = shipremainqty - (shiporderqty / @li_srqty)*@li_caqty,
						shipendgubun = case 
							when shipremainqty - (shiporderqty / @li_srqty)*@li_caqty = 0 then 'Y'
							else shipendgubun
							end
					where	psrno = @ls_csrno+'P00'
					and	pcgubun = 'C'
			end							
		end	

		If @ls_xplant = 'J'
		begin	
			-- 진천
			If exists (select * from [ipisjin_svr].ipis.dbo.tsrorder
					where	srno = @ls_csrno+'P00')
			begin				
				update	[ipisjin_svr].ipis.dbo.tsrorder
				set	srcancelgubun ='Y',
					cancelqty = @li_caqty,
					shipremainqty = shipremainqty - @li_caqty,
					shipendgubun = case 
						when shipremainqty - @li_caqty = 0 then 'Y'
						else shipendgubun
						end
				where	srno = @ls_csrno+'P00'

				If not exists (select * from [ipisjin_svr].ipis.dbo.tsrcancel
						where	srno = @ls_csrno)
					insert into [ipisjin_svr].ipis.dbo.tsrcancel
						(CancelDate,		
						AreaCode,		DivisionCode,		SRNo,
						CancelGubun,		CheckSRNo,		ItemCode,		
						ConfirmFlag,		CancelQty,		LastEmp)
					values	(substring(@ls_srdt,1,4)+'.'+substring(@ls_srdt,5,2)+'.'+substring(@ls_srdt,7,2),
						@ls_xplant,		@ls_div,		@ls_csrno,
						'2',			@ls_srno,		@ls_itno,
						'N',			@li_caqty,		'SYSTEM')

				If @ls_kitcd = 'P'
					update	[ipisjin_svr].ipis.dbo.tsrorder
					set	srcancelgubun ='Y',
						cancelqty = (shiporderqty / @li_srqty)*@li_caqty,
						shipremainqty = shipremainqty - (shiporderqty / @li_srqty)*@li_caqty,
						shipendgubun = case 
							when shipremainqty - (shiporderqty / @li_srqty)*@li_caqty = 0 then 'Y'
							else shipendgubun
							end
					where	psrno = @ls_csrno+'P00'
					and	pcgubun = 'C'
			end							
		end	

	End	-- 추가 end
	
	If @ls_chgcd = 'D' 	-- 삭제
	Begin
		If @ls_xplant = 'D' and @ls_div = 'A'
		begin	
			-- 대구전장
			If exists (select * from [ipisele_svr\ipis].ipis.dbo.tsrorder
					where	srno = @ls_csrno+'P00')
			begin		
				
				update	[ipisele_svr\ipis].ipis.dbo.tsrorder
				set	srcancelgubun ='N',
					cancelqty = 0,
					shipremainqty = shipremainqty + cancelqty,
					shipendgubun = case 
						when shipremainqty + cancelqty = 0 then 'Y'
						else 'N'
						end
				where	srno = @ls_csrno+'P00'

				If exists (select * from [ipisele_svr\ipis].ipis.dbo.tsrcancel
						where	srno = @ls_csrno)
					delete from [ipisele_svr\ipis].ipis.dbo.tsrcancel
					where srno = @ls_csrno
				
				If @ls_kitcd = 'P'	-- kit일때 child 처리
					update	[ipisele_svr\ipis].ipis.dbo.tsrorder
					set	srcancelgubun ='N',
						cancelqty = 0,
						shipremainqty = shipremainqty + cancelqty,
						shipendgubun = case 
							when shipremainqty + cancelqty = 0 then 'Y'
							else 'N'
							end
					where	psrno = @ls_csrno+'P00'
					and	pcgubun = 'C'


			end						
		end

		If @ls_xplant = 'D' and (@ls_div = 'M' or @ls_div = 'S')
		begin	
			-- 대구기계
			If exists (select * from [ipismac_svr\ipis].ipis.dbo.tsrorder
					where	srno = @ls_csrno+'P00')
			begin		
				
				update	[ipismac_svr\ipis].ipis.dbo.tsrorder
				set	srcancelgubun ='N',
					cancelqty = 0,
					shipremainqty = shipremainqty + cancelqty,
					shipendgubun = case 
						when shipremainqty + cancelqty = 0 then 'Y'
						else 'N'
						end
				where	srno = @ls_csrno+'P00'

				If exists (select * from [ipismac_svr\ipis].ipis.dbo.tsrcancel
						where	srno = @ls_csrno)
					delete from [ipismac_svr\ipis].ipis.dbo.tsrcancel
					where srno = @ls_csrno
				
				If @ls_kitcd = 'P'	-- kit일때 child 처리
					update	[ipismac_svr\ipis].ipis.dbo.tsrorder
					set	srcancelgubun ='N',
						cancelqty = 0,
						shipremainqty = shipremainqty + cancelqty,
						shipendgubun = case 
							when shipremainqty + cancelqty = 0 then 'Y'
							else 'N'
							end
					where	psrno = @ls_csrno+'P00'
					and	pcgubun = 'C'


			end						
		end
		If @ls_xplant = 'D'If (@ls_xplant = 'D' and (@ls_div = 'H' or @ls_div = 'V')) or @ls_xplant = 'K' or @ls_xplant = 'Y'
		begin	
			-- 대구공조
			If exists (select * from [ipishvac_svr\ipis].ipis.dbo.tsrorder
					where	srno = @ls_csrno+'P00')
			begin		
				
				update	[ipishvac_svr\ipis].ipis.dbo.tsrorder
				set	srcancelgubun ='N',
					cancelqty = 0,
					shipremainqty = shipremainqty + cancelqty,
					shipendgubun = case 
						when shipremainqty + cancelqty = 0 then 'Y'
						else 'N'
						end
				where	srno = @ls_csrno+'P00'

				If exists (select * from [ipishvac_svr\ipis].ipis.dbo.tsrcancel
						where	srno = @ls_csrno)
					delete from [ipishvac_svr\ipis].ipis.dbo.tsrcancel
					where srno = @ls_csrno
				
				If @ls_kitcd = 'P'	-- kit일때 child 처리
					update	[ipishvac_svr\ipis].ipis.dbo.tsrorder
					set	srcancelgubun ='N',
						cancelqty = 0,
						shipremainqty = shipremainqty + cancelqty,
						shipendgubun = case 
							when shipremainqty + cancelqty = 0 then 'Y'
							else 'N'
							end
					where	psrno = @ls_csrno+'P00'
					and	pcgubun = 'C'


			end						
		end
		If @ls_xplant = 'J'
		begin	
			-- 진천
			If exists (select * from [ipisjin_svr].ipis.dbo.tsrorder
					where	srno = @ls_csrno+'P00')
			begin		
				
				update	[ipisjin_svr].ipis.dbo.tsrorder
				set	srcancelgubun ='N',
					cancelqty = 0,
					shipremainqty = shipremainqty + cancelqty,
					shipendgubun = case 
						when shipremainqty + cancelqty = 0 then 'Y'
						else 'N'
						end
				where	srno = @ls_csrno+'P00'

				If exists (select * from [ipisjin_svr].ipis.dbo.tsrcancel
						where	srno = @ls_csrno)
					delete from [ipisjin_svr].ipis.dbo.tsrcancel
					where srno = @ls_csrno
				
				If @ls_kitcd = 'P'	-- kit일때 child 처리
					update	[ipisjin_svr].ipis.dbo.tsrorder
					set	srcancelgubun ='N',
						cancelqty = 0,
						shipremainqty = shipremainqty + cancelqty,
						shipendgubun = case 
							when shipremainqty + cancelqty = 0 then 'Y'
							else 'N'
							end
					where	psrno = @ls_csrno+'P00'
					and	pcgubun = 'C'


			end						
		end

	End	-- 삭제 end
	
End			-- While Loop End

--truncate table sle304_temp
--truncate table pdsle304

drop table #tmp_pdsle304

End		-- Procedure End
Go