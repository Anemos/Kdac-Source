/*
	File Name	: sp_pisi_d_tsalescode.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisi_d_tsalescode
	Description	: Download SR Header
			  tsrheader - pdsle307
			  �������� �����߰� : 2004.04.19
			  ���򹰷� �����߰� : 2005.08
			  ���깰�� �����߰� : 2005.10
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
	@ls_chgdate		char(30),
	@ls_chgcd		char(1),
	@ls_cogubun		varchar(3),	
	@ls_cocode		varchar(5),		
	@ls_desc1		varchar(100),
	@ls_desc2		varchar(100),
	@ls_desc3		varchar(100),
	@ls_desc4		varchar(100),
	@ls_date		varchar(30),
	@ls_error		Char(1)
	
	
Select	*
into	#tmp_pdsle307
from	pdsle307_log
order by chgdate
	
Select @i = 0, @li_loop_count = @@RowCount, @ls_date = ''

While @i < @li_loop_count
Begin
	
	Select	Top 1
		@i		= @i + 1,
		@ls_chgdate	= chgdate,
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

	if (select Count(*) From pdsle307_log
	   Where  Chgdate	<	@ls_Chgdate	and
	   	  cogubun	=	@ls_cogubun	and
	   	  cocode	=	@ls_cocode)	 > 0
	   Begin
	   Continue
	   End
	
	If @ls_chgcd = 'A' 	-- �߰�
	Begin
			
	-- �뱸����
	If not exists (select * from [ipisele_svr\ipis].ipis.dbo.tsalescode
						where	cogubun	=	@ls_cogubun	and
							cocode	=	@ls_Cocode)
		insert into [ipisele_svr\ipis].ipis.dbo.tsalescode
			(Cogubun,	CoCode,		Desc1,		Desc2,		
			Desc3,		Desc4,		LastEmp)
		values	(@ls_cogubun,	@ls_cocode,	@ls_desc1,	@ls_desc2,
			@ls_desc3,	@ls_desc4,	'SYSTEM')
		
	-- �뱸���
	If not exists (select * from [ipismac_svr\ipis].ipis.dbo.tsalescode
						where	cogubun	=	@ls_cogubun	and
							cocode	=	@ls_Cocode)
		insert into [ipismac_svr\ipis].ipis.dbo.tsalescode
			(Cogubun,	CoCode,		Desc1,		Desc2,		
			Desc3,		Desc4,		LastEmp)
		values	(@ls_cogubun,	@ls_cocode,	@ls_desc1,	@ls_desc2,
			@ls_desc3,	@ls_desc4,	'SYSTEM')

	-- �뱸����
	If not exists (select * from [ipishvac_svr\ipis].ipis.dbo.tsalescode
						where	cogubun	=	@ls_cogubun	and
							cocode	=	@ls_Cocode)
		insert into [ipishvac_svr\ipis].ipis.dbo.tsalescode
			(Cogubun,	CoCode,		Desc1,		Desc2,		
			Desc3,		Desc4,		LastEmp)
		values	(@ls_cogubun,	@ls_cocode,	@ls_desc1,	@ls_desc2,
			@ls_desc3,	@ls_desc4,	'SYSTEM')
	
	-- ���򹰷�
	If not exists (select * from [ipisbup_svr\ipis].ipis.dbo.tsalescode
						where	cogubun	=	@ls_cogubun	and
							cocode	=	@ls_Cocode)
		insert into [ipisbup_svr\ipis].ipis.dbo.tsalescode
			(Cogubun,	CoCode,		Desc1,		Desc2,		
			Desc3,		Desc4,		LastEmp)
		values	(@ls_cogubun,	@ls_cocode,	@ls_desc1,	@ls_desc2,
			@ls_desc3,	@ls_desc4,	'SYSTEM')
	
	-- ���깰��
	If not exists (select * from [ipiskun_svr\ipis].ipis.dbo.tsalescode
						where	cogubun	=	@ls_cogubun	and
							cocode	=	@ls_Cocode)
		insert into [ipiskun_svr\ipis].ipis.dbo.tsalescode
			(Cogubun,	CoCode,		Desc1,		Desc2,		
			Desc3,		Desc4,		LastEmp)
		values	(@ls_cogubun,	@ls_cocode,	@ls_desc1,	@ls_desc2,
			@ls_desc3,	@ls_desc4,	'SYSTEM')
	
	-- ��������
	If not exists (select * from [ipisyeo_svr\ipis].ipis.dbo.tsalescode
						where	cogubun	=	@ls_cogubun	and
							cocode	=	@ls_Cocode)
		insert into [ipisyeo_svr\ipis].ipis.dbo.tsalescode
			(Cogubun,	CoCode,		Desc1,		Desc2,		
			Desc3,		Desc4,		LastEmp)
		values	(@ls_cogubun,	@ls_cocode,	@ls_desc1,	@ls_desc2,
			@ls_desc3,	@ls_desc4,	'SYSTEM')

	-- ��õ
	If not exists (select * from [ipisjin_svr].ipis.dbo.tsalescode
						where	cogubun	=	@ls_cogubun	and
							cocode	=	@ls_Cocode)
		insert into [ipisjin_svr].ipis.dbo.tsalescode
			(Cogubun,	CoCode,		Desc1,		Desc2,		
			Desc3,		Desc4,		LastEmp)
		values	(@ls_cogubun,	@ls_cocode,	@ls_desc1,	@ls_desc2,
			@ls_desc3,	@ls_desc4,	'SYSTEM')
	
	If exists (select * from [ipisjin_svr].ipis.dbo.tsalescode
			where	cogubun	=	@ls_cogubun	and
				cocode	=	@ls_Cocode)
		Delete	From pdsle307_log
	   	Where  Chgdate	=	@ls_Chgdate
	
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
	update	[ipismac_svr\ipis].ipis.dbo.tsalescode
	set	desc1		= @ls_desc1,
		desc2		= @ls_desc2,
		desc3		= @ls_desc3,
		desc4		= @ls_desc4,
		lastdate	= Getdate()
	where	cogubun		= @ls_cogubun
	and	cocode		= @ls_cocode

	-- �뱸����
	update	[ipishvac_svr\ipis].ipis.dbo.tsalescode
	set	desc1		= @ls_desc1,
		desc2		= @ls_desc2,
		desc3		= @ls_desc3,
		desc4		= @ls_desc4,
		lastdate	= Getdate()
	where	cogubun		= @ls_cogubun
	and	cocode		= @ls_cocode
	/*
	-- ���򹰷�
	update	[ipisbue_svr\ipis].ipis.dbo.tsalescode
	set	desc1		= @ls_desc1,
		desc2		= @ls_desc2,
		desc3		= @ls_desc3,
		desc4		= @ls_desc4,
		lastdate	= Getdate()
	where	cogubun		= @ls_cogubun
	and	cocode		= @ls_cocode
	*/
	-- ��������
	update	[ipisyeo_svr\ipis].ipis.dbo.tsalescode
	set	desc1		= @ls_desc1,
		desc2		= @ls_desc2,
		desc3		= @ls_desc3,
		desc4		= @ls_desc4,
		lastdate	= Getdate()
	where	cogubun		= @ls_cogubun
	and	cocode		= @ls_cocode

	-- ��õ
	update	[ipisjin_svr].ipis.dbo.tsalescode
	set	desc1		= @ls_desc1,
		desc2		= @ls_desc2,
		desc3		= @ls_desc3,
		desc4		= @ls_desc4,
		lastdate	= Getdate()
	where	cogubun		= @ls_cogubun
	and	cocode		= @ls_cocode

	If exists (select * from [ipisjin_svr].ipis.dbo.tsalescode
			where	cogubun	=	@ls_cogubun	and
				cocode	=	@ls_Cocode	and
				desc1	=	@ls_desc1	and
				desc2	=	@ls_desc2	and
				desc3	=	@ls_desc3	and
				desc4	=	@ls_desc4)
		Delete	From pdsle307_log
	   	Where  Chgdate	=	@ls_Chgdate
	
	
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
		
		delete from [ipisbup_svr\ipis].ipis.dbo.tsalescode
		where	cogubun		= @ls_cogubun
		and	cocode		= @ls_cocode

    delete from [ipiskun_svr\ipis].ipis.dbo.tsalescode
		where	cogubun		= @ls_cogubun
		and	cocode		= @ls_cocode

		delete from [ipisyeo_svr\ipis].ipis.dbo.tsalescode
		where	cogubun		= @ls_cogubun
		and	cocode		= @ls_cocode

		delete from [ipisjin_svr].ipis.dbo.tsalescode
		where	cogubun		= @ls_cogubun
		and	cocode		= @ls_cocode

		If Not exists (select * from [ipisjin_svr].ipis.dbo.tsalescode
			where	cogubun	=	@ls_cogubun	and
				cocode	=	@ls_Cocode)
		Delete	From pdsle307_log
	   	Where  Chgdate	=	@ls_Chgdate
	
	End	-- ���� end
	
End			-- While Loop End

if (select count(*) from pdsle307_log) = 0
	begin
		truncate table pdsle307_log
	end

Drop table #tmp_pdsle307

End		-- Procedure End
Go
