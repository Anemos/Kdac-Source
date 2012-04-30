/*
	File Name	: sp_pisi_d_tsrcomment.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tsrcomment
	Description	: Download SR Header
			  tsrheader - pdsle305
			  여주전자 서버 추가 : 2004.04.19
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tsrcomment]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tsrcomment]
GO

/*
Execute sp_pisi_d_tsrcomment
*/

Create Procedure sp_pisi_d_tsrcomment
	
	
As
Begin

Declare	@i			Int,
	@li_loop_count		Int,
	@ls_chgdate		char(30),
	@ls_chgcd		char(1),
	@ls_srno		varchar(11),
	@ls_gubun		char(1),	
	@ls_comment		varchar(500),
	@ls_date		varchar(30),
	@ls_area		char(1),
	@ls_division		char(1)
	

Select	*
into	#tmp_pdsle305
from	pdsle305_log
order by chgdate
	
Select @i = 0, @li_loop_count = @@RowCount, @ls_date = ''

While @i < @li_loop_count
Begin
	
	Select	Top 1
		@i		= @i + 1,
		@ls_chgdate	= chgdate,
		@ls_chgcd	= chgcd,
		@ls_srno	= rtrim(srno),
		@ls_gubun	= gubun,
		@ls_comment	= comment,
		@ls_area	= substring(rtrim(srno),1,1),
		@ls_division	= substring(rtrim(srno),2,1),
		@ls_date	= chgdate		
	From	#tmp_pdsle305
	Where	chgdate > @ls_date

	If	(Select	count(*)
		 From	pdsle305_log
		 Where	chgdate 	<	@ls_chgdate	and
			srno		=	@ls_srno	and
			gubun		=	@ls_gubun) > 0
		begin
		continue
		end

	If len(@ls_srno) = 11
	Begin
	
	If @ls_chgcd = 'A' 	-- 추가
	Begin
			
	If @ls_area = 'D' and @ls_division = 'A'
		-- 대구전장
		If not exists (select * from [ipisele_svr\ipis].ipis.dbo.tsrcomment
					where	checksrno = @ls_srno and gubun =  @ls_gubun)
			begin
			insert into [ipisele_svr\ipis].ipis.dbo.tsrcomment
				(CheckSRNo,		Gubun,			SRComment,		LastEmp)
			values	(@ls_srno,		@ls_gubun,		@ls_comment,		'SYSTEM')
			end

		If exists (select * from [ipisele_svr\ipis].ipis.dbo.tsrcomment
					where	checksrno = @ls_srno and gubun =  @ls_gubun)
			begin
			Delete	From	pdsle305_log
			Where	chgdate	=	@ls_chgdate
			end
			
	If @ls_area = 'D' and (@ls_division = 'M' or @ls_division = 'S')
		-- 대구기계
		If not exists (select * from [ipismac_svr\ipis].ipis.dbo.tsrcomment
					where	checksrno = @ls_srno and gubun =  @ls_gubun)
			begin
			insert into [ipismac_svr\ipis].ipis.dbo.tsrcomment
				(CheckSRNo,		Gubun,			SRComment,		LastEmp)
			values	(@ls_srno,		@ls_gubun,		@ls_comment,		'SYSTEM')
			end
		
		If exists (select * from [ipismac_svr\ipis].ipis.dbo.tsrcomment
					where	checksrno = @ls_srno and gubun =  @ls_gubun)
			begin
			Delete	From	pdsle305_log
			Where	chgdate	=	@ls_chgdate
			end
			
	If (@ls_area = 'D' and (@ls_division = 'H' or @ls_division = 'V')) or (@ls_area = 'K')
		-- 대구공조
		If not exists (select * from [ipishvac_svr\ipis].ipis.dbo.tsrcomment
					where	checksrno = @ls_srno and gubun =  @ls_gubun)
			begin
			insert into [ipishvac_svr\ipis].ipis.dbo.tsrcomment
				(CheckSRNo,		Gubun,			SRComment,		LastEmp)
			values	(@ls_srno,		@ls_gubun,		@ls_comment,		'SYSTEM')
			end
			
		If exists (select * from [ipishvac_svr\ipis].ipis.dbo.tsrcomment
					where	checksrno = @ls_srno and gubun =  @ls_gubun)
			begin
			Delete	From	pdsle305_log
			Where	chgdate	=	@ls_chgdate
			end
	If @ls_area = 'J'
		-- 진천
		If not exists (select * from [ipisjin_svr].ipis.dbo.tsrcomment
					where	checksrno = @ls_srno and gubun =  @ls_gubun)
			begin
			insert into [ipisjin_svr].ipis.dbo.tsrcomment
				(CheckSRNo,		Gubun,			SRComment,		LastEmp)
			values	(@ls_srno,		@ls_gubun,		@ls_comment,		'SYSTEM')
			end
			
		If exists (select * from [ipisjin_svr].ipis.dbo.tsrcomment
					where	checksrno = @ls_srno and gubun =  @ls_gubun)
			begin
			Delete	From	pdsle305_log
			Where	chgdate	=	@ls_chgdate
			end
	If @ls_area = 'Y'
		-- 여주전자
		If not exists (select * from [ipisyeo_svr\ipis].ipis.dbo.tsrcomment
					where	checksrno = @ls_srno and gubun =  @ls_gubun)
			begin
			insert into [ipisyeo_svr\ipis].ipis.dbo.tsrcomment
				(CheckSRNo,		Gubun,			SRComment,		LastEmp)
			values	(@ls_srno,		@ls_gubun,		@ls_comment,		'SYSTEM')
			end
			
		If exists (select * from [ipisyeo_svr\ipis].ipis.dbo.tsrcomment
					where	checksrno = @ls_srno and gubun =  @ls_gubun)
			begin
			Delete	From	pdsle305_log
			Where	chgdate	=	@ls_chgdate
			end
	End	-- 추가 end
	
	If @ls_chgcd = 'R' 	-- 수정
	Begin
			
	If @ls_area = 'D' and @ls_division = 'A'
		-- 대구전장
		update	[ipisele_svr\ipis].ipis.dbo.tsrcomment
		set	srcomment	= @ls_comment,
			lastdate	= Getdate()
		where	checksrno	= @ls_srno
		
		If exists (select * from [ipisele_svr\ipis].ipis.dbo.tsrcomment
					where	checksrno		=	@ls_srno	and
						gubun		=	@ls_gubun	and
						srcomment	=	@ls_Comment)
			begin
			Delete	From	pdsle305_log
			Where	chgdate	=	@ls_chgdate
			end

	If @ls_area = 'D' and (@ls_division = 'M' or @ls_division = 'S')
		-- 대구기계
		update	[ipismac_svr\ipis].ipis.dbo.tsrcomment
		set	srcomment	= @ls_comment,
			lastdate	= Getdate()
		where	checksrno	= @ls_srno

		If exists (select * from [ipismac_svr\ipis].ipis.dbo.tsrcomment
					where	checksrno		=	@ls_srno	and
						gubun		=	@ls_gubun	and
						srcomment	=	@ls_Comment)
			begin
			Delete	From	pdsle305_log
			Where	chgdate	=	@ls_chgdate
			end
			
	If (@ls_area = 'D' and (@ls_division = 'H' or @ls_division = 'V')) or (@ls_area = 'K')
		-- 대구공조
		update	[ipishvac_svr\ipis].ipis.dbo.tsrcomment
		set	srcomment	= @ls_comment,
			lastdate	= Getdate()
		where	checksrno	= @ls_srno

		If exists (select * from [ipishvac_svr\ipis].ipis.dbo.tsrcomment
					where	checksrno		=	@ls_srno	and
						gubun		=	@ls_gubun	and
						srcomment	=	@ls_Comment)
			begin
			Delete	From	pdsle305_log
			Where	chgdate	=	@ls_chgdate
			end

	If @ls_area = 'J'
		-- 진천
		update	[ipisjin_svr].ipis.dbo.tsrcomment
		set	srcomment	= @ls_comment,
			lastdate	= Getdate()
		where	checksrno	= @ls_srno

		If exists (select * from [ipisjin_svr].ipis.dbo.tsrcomment
					where	checksrno		=	@ls_srno	and
						gubun		=	@ls_gubun	and
						srcomment	=	@ls_Comment)
			begin
			Delete	From	pdsle305_log
			Where	chgdate	=	@ls_chgdate
			end
  
  If @ls_area = 'Y'
		-- 여주전자
		update	[ipisyeo_svr\ipis].ipis.dbo.tsrcomment
		set	srcomment	= @ls_comment,
			lastdate	= Getdate()
		where	checksrno	= @ls_srno

		If exists (select * from [ipisyeo_svr\ipis].ipis.dbo.tsrcomment
					where	checksrno		=	@ls_srno	and
						gubun		=	@ls_gubun	and
						srcomment	=	@ls_Comment)
			begin
			Delete	From	pdsle305_log
			Where	chgdate	=	@ls_chgdate
			end
  
	End	-- 추가 end
	
	If @ls_chgcd = 'D' 	-- 추가
	Begin
	
	If @ls_area = 'D' and @ls_division = 'A'
		-- 대구전장
		delete from [ipisele_svr\ipis].ipis.dbo.tsrcomment
		where	checksrno = @ls_srno

		If Not exists (select * from [ipisele_svr\ipis].ipis.dbo.tsrcomment
					where	checksrno		=	@ls_srno	and
						gubun		=	@ls_gubun)
			begin
			Delete	From	pdsle305_log
			Where	chgdate	=	@ls_chgdate
			end

	If @ls_area = 'D' and (@ls_division = 'M' or @ls_division = 'S')
		-- 대구기계
		delete from [ipismac_svr\ipis].ipis.dbo.tsrcomment
		where	checksrno = @ls_srno
	

		If Not exists (select * from [ipismac_svr\ipis].ipis.dbo.tsrcomment
					where	checksrno		=	@ls_srno	and
						gubun		=	@ls_gubun)
			begin
			Delete	From	pdsle305_log
			Where	chgdate	=	@ls_chgdate
			end
			
	If (@ls_area = 'D' and (@ls_division = 'H' or @ls_division = 'V')) or (@ls_area = 'K')
		-- 대구공조
		delete from [ipishvac_svr\ipis].ipis.dbo.tsrcomment
		where	checksrno = @ls_srno


		If Not exists (select * from [ipishvac_svr\ipis].ipis.dbo.tsrcomment
					where	checksrno		=	@ls_srno	and
						gubun		=	@ls_gubun)
			begin
			Delete	From	pdsle305_log
			Where	chgdate	=	@ls_chgdate
			end
			
	If @ls_area = 'J'
		-- 진천
		delete from [ipisjin_svr].ipis.dbo.tsrcomment
		where	checksrno = @ls_srno

		
		If Not exists (select * from [ipisjin_svr].ipis.dbo.tsrcomment
					where	checksrno		=	@ls_srno	and
						gubun		=	@ls_gubun)
			begin
			Delete	From	pdsle305_log
			Where	chgdate	=	@ls_chgdate
			end
	
	If @ls_area = 'Y'
		-- 여주전자
		delete from [ipisyeo_svr\ipis].ipis.dbo.tsrcomment
		where	checksrno = @ls_srno


		If Not exists (select * from [ipisyeo_svr\ipis].ipis.dbo.tsrcomment
					where	checksrno		=	@ls_srno	and
						gubun		=	@ls_gubun)
			begin
			Delete	From	pdsle305_log
			Where	chgdate	=	@ls_chgdate
			end
	
	End	-- 삭제 end
	End	-- srno 11자리인놈만 수행

End			-- While Loop End

if (select count(*) from pdsle305_log) = 0
	begin
		truncate table pdsle305_log
	end

Drop table #tmp_pdsle305

End		-- Procedure End
Go
