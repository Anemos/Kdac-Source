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
	@ls_date		varchar(30)
	
Select	*
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

	If @ls_chgcd = 'A' 	-- 추가
	Begin
			
		-- 대구전장
		select	@ls_len = max(len(csrno))
		from	sle304_temp
		where	srno = @ls_srno
		
		If exists (select * from [ipisele_svr\ipis].ipis.dbo.tsrorder
				where substring(srno, 1, @ls_len) in (select csrno from sle304_temp 
									where srno = @ls_srno))
		begin							
			update	[ipisele_svr\ipis].ipis.dbo.tsrorder
			set	srcancelgubun ='Y'
			where	substring(srno, 1, @ls_len) in (select csrno from sle304_temp 
								where srno = @ls_srno)	-- sle304_temp의 csrno인 놈 
	
			insert into [ipisele_svr\ipis].ipis.dbo.tsrcancel
				(CancelDate,		
				AreaCode,		DivisionCode,		SRNo,
				CancelGubun,		CheckSRNo,		ItemCode,		
				ConfirmFlag,		LastEmp)
			select	substring(updtdt,1,4)+'.'+substring(updtdt,5,2)+'.'+substring(updtdt,7,2),
				xplant,			div,			csrno,
				'2',			srno,			itno,
				'N',			'SYSTEM'			
			from	sle304_temp
			where	srno = @ls_srno
			and	stcd <> 'C'
			and	xplant = 'D'
			and	div in ('A')
		end	

		
		-- 대구기계
		select	@ls_len = max(len(csrno))
		from	sle304_temp
		where	srno = @ls_srno
		
		If exists (select * from [ipisele_svr\ipis].ipis.dbo.tsrorder
				where substring(srno, 1, @ls_len) in (select csrno from sle304_temp 
									where srno = @ls_srno))
		begin							
			update	[ipisele_svr\ipis].ipis.dbo.tsrorder
			set	srcancelgubun ='Y'
			where	substring(srno, 1, @ls_len) in (select csrno from sle304_temp 
								where srno = @ls_srno)	-- sle304_temp의 csrno인 놈 
	
			insert into [ipisele_svr\ipis].ipis.dbo.tsrcancel
				(CancelDate,		
				AreaCode,		DivisionCode,		SRNo,
				CancelGubun,		CheckSRNo,		ItemCode,		
				ConfirmFlag,		LastEmp)
			select	substring(updtdt,1,4)+'.'+substring(updtdt,5,2)+'.'+substring(updtdt,7,2),
				xplant,			div,			csrno,
				'2',			srno,			itno,
				'N',			'SYSTEM'			
			from	sle304_temp
			where	srno = @ls_srno
			and	stcd <> 'C'
			and	xplant = 'D'
			and	div in ('A')
		end	

		-- 대구공조
		insert into [ipishvac_svr\ipis].ipis.dbo.tsrcancel
			(CancelDate,		
			AreaCode,		DivisionCode,		SRNo,
			CancelGubun,		CheckSRNo,		ItemCode,		
			ConfirmFlag,		LastEmp)
		select	substring(updtdt,1,4)+'.'+substring(updtdt,5,2)+'.'+substring(updtdt,7,2),
			xplant,			div,			csrno,
			'2',			srno,			itno,
			'N',			'SYSTEM'			
		from	sle304_temp
		where	srno = @ls_srno
		and	stcd <> 'C'
		and	((xplant = 'D' and div in ('H','V')) or xplant in ('K', 'Y'))

		select	@ls_len = max(len(csrno))
		from	sle304_temp
		where	srno = @ls_srno
		
		update	[ipishvac_svr\ipis].ipis.dbo.tsrorder
		set	srcancelgubun ='Y'
		where	substring(srno, 1, @ls_len) in (select csrno from sle304_temp 
							where srno = @ls_srno)	-- sle304_temp의 csrno인 놈 

		-- 진천
		insert into [ipisjin_svr].ipis.dbo.tsrcancel
			(CancelDate,		
			AreaCode,		DivisionCode,		SRNo,
			CancelGubun,		CheckSRNo,		ItemCode,		
			ConfirmFlag,		LastEmp)
		select	substring(updtdt,1,4)+'.'+substring(updtdt,5,2)+'.'+substring(updtdt,7,2),
			xplant,			div,			csrno,
			'2',			srno,			itno,
			'N',			'SYSTEM'			
		from	sle304_temp
		where	srno = @ls_srno
		and	stcd <> 'C'
		and	xplant = 'J'
		
		select	@ls_len = max(len(csrno))
		from	sle304_temp
		where	srno = @ls_srno
		
		update	[ipisjin_svr].ipis.dbo.tsrorder
		set	srcancelgubun ='Y'
		where	substring(srno, 1, @ls_len) in (select csrno from sle304_temp 
							where srno = @ls_srno)	-- sle304_temp의 csrno인 놈 

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

truncate table sle304_temp

Drop table #tmp_pdsle303

End		-- Procedure End
Go
