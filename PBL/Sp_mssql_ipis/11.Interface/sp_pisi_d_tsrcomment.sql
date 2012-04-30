/*
	File Name	: sp_pisi_d_tsrcomment.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisi_d_tsrcomment
	Description	: Download SR Header
			  tsrheader - pdsle305
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
	@ls_chgcd		char(1),
	@ls_srno		varchar(11),
	@ls_gubun		char(1),	
	@ls_comment		varchar(500),
	@ls_date		varchar(30),
	@ls_area		char(1),
	@ls_division		char(1)
	
Select	*
into	#tmp_pdsle305
from	pdsle305
order by chgdate
	
Select @i = 0, @li_loop_count = @@RowCount, @ls_date = ''

While @i < @li_loop_count
Begin
	Select	Top 1
		@i		= @i + 1,
		@ls_chgcd	= chgcd,
		@ls_srno	= rtrim(srno),
		@ls_gubun	= gubun,
		@ls_comment	= comment,
		@ls_area	= substring(rtrim(srno),1,1),
		@ls_division	= substring(rtrim(srno),2,1),
		@ls_date	= chgdate		
	From	#tmp_pdsle305
	Where	chgdate > @ls_date

	If len(@ls_srno) = 11
	Begin
	
	If @ls_chgcd = 'A' 	-- �߰�
	Begin
			
	If @ls_area = 'D' and @ls_division = 'A'
		-- �뱸����
		insert into [ipisele_svr\ipis].ipis.dbo.tsrcomment
			(CheckSRNo,		Gubun,			SRComment,		LastEmp)
		values	(@ls_srno,		@ls_gubun,		@ls_comment,		'SYSTEM')

	If @ls_area = 'D' and (@ls_division = 'M' or @ls_division = 'S')
		-- �뱸���
		insert into [ipismac_svr\ipis].ipis.dbo.tsrcomment
			(CheckSRNo,		Gubun,			SRComment,		LastEmp)
		values	(@ls_srno,		@ls_gubun,		@ls_comment,		'SYSTEM')

	If (@ls_area = 'D' and (@ls_division = 'H' or @ls_division = 'V')) or (@ls_area = 'Y' or @ls_area = 'K')
		-- �뱸����
		insert into [ipishvac_svr\ipis].ipis.dbo.tsrcomment
			(CheckSRNo,		Gubun,			SRComment,		LastEmp)
		values	(@ls_srno,		@ls_gubun,		@ls_comment,		'SYSTEM')

	If @ls_area = 'J'
		-- ��õ
		insert into [ipisjin_svr].ipis.dbo.tsrcomment
			(CheckSRNo,		Gubun,			SRComment,		LastEmp)
		values	(@ls_srno,		@ls_gubun,		@ls_comment,		'SYSTEM')

	End	-- �߰� end
	
	If @ls_chgcd = 'R' 	-- ����
	Begin
			
	If @ls_area = 'D' and @ls_division = 'A'
		-- �뱸����
		update	[ipisele_svr\ipis].ipis.dbo.tsrcomment
		set	srcomment	= @ls_comment,
			lastdate	= Getdate()
		where	checksrno	= @ls_srno

	If @ls_area = 'D' and (@ls_division = 'M' or @ls_division = 'S')
		-- �뱸���
		update	[ipismac_svr\ipis].ipis.dbo.tsrcomment
		set	srcomment	= @ls_comment,
			lastdate	= Getdate()
		where	checksrno	= @ls_srno

	If (@ls_area = 'D' and (@ls_division = 'H' or @ls_division = 'V')) or (@ls_area = 'Y' or @ls_area = 'K')
		-- �뱸����
		update	[ipishvac_svr\ipis].ipis.dbo.tsrcomment
		set	srcomment	= @ls_comment,
			lastdate	= Getdate()
		where	checksrno	= @ls_srno

	If @ls_area = 'J'
		-- ��õ
		update	[ipisjin_svr].ipis.dbo.tsrcomment
		set	srcomment	= @ls_comment,
			lastdate	= Getdate()
		where	checksrno	= @ls_srno

	End	-- �߰� end
	
	If @ls_chgcd = 'D' 	-- �߰�
	Begin
		delete from [ipisele_svr\ipis].ipis.dbo.tsrcomment
		where	checksrno = @ls_srno

		delete from [ipisele_svr\ipis].ipis.dbo.tsrheader
		where	checksrno = @ls_srno
		
		delete from [ipismac_svr\ipis].ipis.dbo.tsrcomment
		where	checksrno = @ls_srno

		delete from [ipismac_svr\ipis].ipis.dbo.tsrheader
		where	checksrno = @ls_srno

		delete from [ipishvac_svr\ipis].ipis.dbo.tsrcomment
		where	checksrno = @ls_srno

		delete from [ipishvac_svr\ipis].ipis.dbo.tsrheader
		where	checksrno = @ls_srno

		delete from [ipisjin_svr].ipis.dbo.tsrcomment
		where	checksrno = @ls_srno

		delete from [ipisjin_svr].ipis.dbo.tsrheader
		where	checksrno = @ls_srno
		
	End	-- ���� end
	End	-- srno 11�ڸ��γ� ����
	
End			-- While Loop End

Drop table #tmp_pdsle305

End		-- Procedure End
Go
