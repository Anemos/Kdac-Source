/*
	File Name	: sp_pisi_d_tsalescode.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisi_d_tsalescode
	Description	: Download SR Header
			  tsrheader - pdsle307
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tsalescode]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tsalescode]
GO

/*
Execute sp_pisi_d_tsalescode
*/

Create Procedure sp_pisi_d_tsalescode
	
	
As
Begin

Declare	@i			Int,
	@li_loop_count		Int,
	@ls_chgcd		char(1),
	@ls_cogubun		varchar(3),	
	@ls_cocode		varchar(5),		
	@ls_desc1		varchar(100),
	@ls_desc2		varchar(100),
	@ls_desc3		varchar(100),
	@ls_desc4		varchar(100),
	@ls_date		varchar(30)
	
Select	*
into	#tmp_pdsle307
from	pdsle307
order by chgdate
	
Select @i = 0, @li_loop_count = @@RowCount, @ls_date = ''

While @i < @li_loop_count
Begin
	Select	Top 1
		@i		= @i + 1,
		@ls_chgcd	= chgcd,
		@ls_cogubun	= cogubun,
		@ls_cocode	= cocode,
		@ls_desc1	= desc1,
		@ls_desc2	= desc2,
		@ls_desc3	= desc3,
		@ls_desc4	= desc4,
		@ls_date	= chgdate		
	From	#tmp_pdsle307
	Where	chgdate > @ls_date

	If @ls_chgcd = 'A' 	-- �߰�
	Begin
			
	-- �뱸����
	insert into [ipisele_svr\ipis].ipis.dbo.tsalescode
		(Cogubun,	CoCode,		Desc1,		Desc2,		
		Desc3,		Desc4,		LastEmp)
	values	(@ls_cogubun,	@ls_cocode,	@ls_desc1,	@ls_desc2,
		@ls_desc3,	@ls_desc4,	'SYSTEM')

	-- �뱸���
	insert into [ipismac_svr\ipis].ipis.dbo.tsalescode
		(Cogubun,	CoCode,		Desc1,		Desc2,		
		Desc3,		Desc4,		LastEmp)
	values	(@ls_cogubun,	@ls_cocode,	@ls_desc1,	@ls_desc2,
		@ls_desc3,	@ls_desc4,	'SYSTEM')

	-- �뱸����
	insert into [ipishvac_svr\ipis].ipis.dbo.tsalescode
		(Cogubun,	CoCode,		Desc1,		Desc2,		
		Desc3,		Desc4,		LastEmp)
	values	(@ls_cogubun,	@ls_cocode,	@ls_desc1,	@ls_desc2,
		@ls_desc3,	@ls_desc4,	'SYSTEM')

	-- ��õ
	insert into [ipisjin_svr].ipis.dbo.tsalescode
		(Cogubun,	CoCode,		Desc1,		Desc2,		
		Desc3,		Desc4,		LastEmp)
	values	(@ls_cogubun,	@ls_cocode,	@ls_desc1,	@ls_desc2,
		@ls_desc3,	@ls_desc4,	'SYSTEM')

	End	-- �߰� end
	
	If @ls_chgcd = 'R' 	-- ����
	Begin
			
	-- �뱸����
	update	[ipisele_svr\ipis].ipis.dbo.tsalescode
	set	desc1		= @ls_desc1,
		desc2		= @ls_desc2,
		desc3		= @ls_desc3,
		desc4		= @ls_desc4,
		lastdate	= Getdate()
	where	cogubun		= @ls_cogubun
	and	cocode		= @ls_cocode

	-- �뱸���
	update	[ipisele_svr\ipis].ipis.dbo.tsalescode
	set	desc1		= @ls_desc1,
		desc2		= @ls_desc2,
		desc3		= @ls_desc3,
		desc4		= @ls_desc4,
		lastdate	= Getdate()
	where	cogubun		= @ls_cogubun
	and	cocode		= @ls_cocode

	-- �뱸����
	update	[ipisele_svr\ipis].ipis.dbo.tsalescode
	set	desc1		= @ls_desc1,
		desc2		= @ls_desc2,
		desc3		= @ls_desc3,
		desc4		= @ls_desc4,
		lastdate	= Getdate()
	where	cogubun		= @ls_cogubun
	and	cocode		= @ls_cocode

	-- ��õ
	update	[ipisele_svr\ipis].ipis.dbo.tsalescode
	set	desc1		= @ls_desc1,
		desc2		= @ls_desc2,
		desc3		= @ls_desc3,
		desc4		= @ls_desc4,
		lastdate	= Getdate()
	where	cogubun		= @ls_cogubun
	and	cocode		= @ls_cocode

	End	-- ���� end
	
	If @ls_chgcd = 'D' 	-- ����
	Begin
		delete from [ipisele_svr\ipis].ipis.dbo.tsalescode
		where	cogubun		= @ls_cogubun
		and	cocode		= @ls_cocode

		delete from [ipismac_svr\ipis].ipis.dbo.tsalescode
		where	cogubun		= @ls_cogubun
		and	cocode		= @ls_cocode

		delete from [ipishvac_svr\ipis].ipis.dbo.tsalescode
		where	cogubun		= @ls_cogubun
		and	cocode		= @ls_cocode

		delete from [ipisjin_svr].ipis.dbo.tsalescode
		where	cogubun		= @ls_cogubun
		and	cocode		= @ls_cocode

	End	-- ���� end
	
End			-- While Loop End

Drop table #tmp_pdsle307

End		-- Procedure End
Go
