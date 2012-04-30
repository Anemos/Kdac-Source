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

Declare	@i			Int,
	@li_loop_count		Int,
	@ls_area		char(1),
	@ls_division		char(1),
	@ls_csrno		varchar(11),
	@ls_slno		varchar(10),
	@ls_flag		char(1),
	@ls_date		varchar(30)
	
Select	*
into	#tmp_pdsle401
from	pdsle401
order by chgdate
	
Select @i = 0, @li_loop_count = @@RowCount, @ls_date = ''

While @i < @li_loop_count
Begin
	Select	Top 1
		@i		= @i + 1,
		@ls_flag	= case chgcd
					when 'A' then 'Y'
					when 'D' then 'N'
					end,
		@ls_area	= xplant,
		@ls_division	= div,
		@ls_csrno	= rtrim(csrno) + 'P00',
		@ls_slno	= rtrim(slno),
		@ls_date	= chgdate		
	From	#tmp_pdsle401
	Where	chgdate > @ls_date

		
	If @ls_area = 'D' and @ls_division = 'A'

		-- 대구전장
		update	[ipisele_svr\ipis].ipis.dbo.tshipsheet
		set	DeliveryFlag = @ls_flag
		where	areacode = @ls_area
		and	divisioncode = @ls_division
		and	srno = @ls_csrno
		and	shipsheetno = @ls_slno


	If @ls_area = 'D' and (@ls_division = 'M' or @ls_division = 'S')

		-- 대구기계
		update	[ipismac_svr\ipis].ipis.dbo.tshipsheet
		set	DeliveryFlag = @ls_flag
		where	areacode = @ls_area
		and	divisioncode = @ls_division
		and	srno = @ls_csrno
		and	shipsheetno = @ls_slno

	If (@ls_area = 'D' and (@ls_division = 'H' or @ls_division = 'V')) or (@ls_area = 'Y' or @ls_area = 'K')

		-- 대구공조
		update	[ipishvac_svr\ipis].ipis.dbo.tshipsheet
		set	DeliveryFlag = @ls_flag
		where	areacode = @ls_area
		and	divisioncode = @ls_division
		and	srno = @ls_csrno
		and	shipsheetno = @ls_slno
		
	If @ls_area = 'J'
		
		-- 진천
		update	[ipisjin_svr].ipis.dbo.tshipsheet
		set	DeliveryFlag = @ls_flag
		where	areacode = @ls_area
		and	divisioncode = @ls_division
		and	srno = @ls_csrno
		and	shipsheetno = @ls_slno
	
End			-- While Loop End

Drop table #tmp_pdsle401

End		-- Procedure End
Go
