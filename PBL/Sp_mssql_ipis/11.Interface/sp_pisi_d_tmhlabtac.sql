/*
	File Name	: sp_pisi_d_tmhlabtac.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tmhlabtac
	Description	: Download 근태 데이타 - 매일
			  tmhlabtac
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tmhlabtac]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tmhlabtac]
GO

/*
Execute sp_pisi_d_tmhlabtac
*/

Create Procedure sp_pisi_d_tmhlabtac
	
As
Begin

Declare	@i			Int,
	@li_loop_count		Int,
	@li_id			int,
	@ls_dgempno		char(6),
	@ls_dgday		char(10),
	@ls_dgyy		char(4),
	@ls_dgmm		char(2),
	@ls_dgdd		char(2),
	@ls_dgdiv		char(1),
	@ls_dgdepte		char(4),
	@ls_dgempgb		char(1),
	@ls_dgdaygb		char(1),
	@ls_dgtimer		decimal(2,1),
	@ls_dgcd1r		char(1),
	@ls_dgcd2r		char(1),
	@ls_dgcd3r		char(1),
	@ls_dgdngbr		char(1),
	@ls_dgotr		decimal(3,1),
	@ls_dgntr		decimal(2,1),
	@ls_dgjor		decimal(3,1),
	@ls_dgsangr		decimal(2,1),
	@ls_dgjuhur		decimal(2,1),
	@ls_dghumur		decimal(2,1),
	@ls_dgspcr		decimal(2,1),
	@ls_dgjir		decimal(2,1),
	@ls_dgoor		decimal(2,1),
	@ls_dgpor		decimal(2,1),
	@ls_dgjtr		decimal(2,1),
	@ls_dggunbor		decimal(2,1),
	@ls_dgmur		decimal(2,1),
	@ls_dgclass		char(2),
	@ls_dgindt		char(8),
	@ls_dgintime		char(6),
	@ls_dginusr		char(6),
	@ls_dgupdt		char(8),
	@ls_dguptime		char(6),
	@ls_dgupusr		char(6)

create table #tmp_tmislabtac
(	checkid			int IDENTITY(1,1),
	dgempno			char(6),
	dgyy			char(4),
	dgmm			char(2),
	dgdd			char(2),
	dgdiv			char(1),
	dgdepte			char(4),
	dgempgb			char(1),
	dgdaygb			char(1),
	dgtimer			decimal(2,1),
	dgcd1r			char(1),
	dgcd2r			char(1),
	dgcd3r			char(1),
	dgdngbr			char(1),
	dgotr			decimal(3,1),
	dgntr			decimal(2,1),
	dgjor			decimal(3,1),
	dgsangr			decimal(2,1),
	dgjuhur			decimal(2,1),
	dghumur			decimal(2,1),
	dgspcr			decimal(2,1),
	dgjir			decimal(2,1),
	dgoor			decimal(2,1),
	dgpor			decimal(2,1),
	dgjtr			decimal(2,1),
	dggunbor		decimal(2,1),
	dgmur			decimal(2,1),
	dgclass			char(2),
	dgindt			char(8),
	dgintime		char(6),
	dginusr			char(6),
	dgupdt			char(8),
	dguptime		char(6),
	dgupusr			char(6)		)

Insert	into #tmp_tmislabtac
	(dgempno,	dgyy,		dgmm,		dgdd,		dgdiv,
	dgdepte,	dgempgb,	dgdaygb,	dgtimer,	dgcd1r,
	dgcd2r,		dgcd3r,		dgdngbr,	dgotr,		dgntr,
	dgjor,		dgsangr,	dgjuhur,	dghumur,	dgspcr,
	dgjir,		dgoor,		dgpor,		dgjtr,		dggunbor,
	dgmur,		dgclass,	dgindt,		dgintime,	dginusr,
	dgupdt,		dguptime,	dgupusr)
Select	empno,	dgyy,		dgmm,		dgdd,		dgdiv,
	dgdepte,	dgempgb,	dgdaygb,	dgtimer,	dgcd1r,
	dgcd2r,		dgcd3r,		dgdngbr,	dgotr,		dgntr,
	dgjor,		dgsangr,	dgjuhur,	dghumur,	dgspcr,
	dgjir,		dgoor,		dgpor,		dgjtr,		dggunbor,
	dgmur,		dgclass,	dgindt,		dgintime,	dginusr,
	dgupdt,		dguptime,	dgupusr
from	tmislabtac
order by empno, dgyy, dgmm, dgdd, dgindt, dgintime, dgupdt, dguptime

	
Select @i = 0, @li_loop_count = @@RowCount, @li_id = 0

While @i < @li_loop_count
Begin
	Select	Top 1
		@i		= @i + 1,
		@li_id		= checkid,
		@ls_dgempno	= dgempno,
		@ls_dgyy	= dgyy,
		@ls_dgmm	= dgmm,
		@ls_dgdd	= dgdd,
		@ls_dgday	= dgyy+'.'+dgmm+'.'+dgdd,
		@ls_dgdiv	= dgdiv,
		@ls_dgdepte	= dgdepte,
		@ls_dgempgb	= dgempgb,
		@ls_dgdaygb	= dgdaygb,
		@ls_dgtimer	= dgtimer,
		@ls_dgcd1r	= dgcd1r,
		@ls_dgcd2r	= dgcd2r,
		@ls_dgcd3r	= dgcd3r,
		@ls_dgdngbr	= dgdngbr,
		@ls_dgotr	= dgotr,
		@ls_dgntr	= dgntr,
		@ls_dgjor	= dgjor,
		@ls_dgsangr	= dgsangr,
		@ls_dgjuhur	= dgjuhur,
		@ls_dghumur	= dghumur,
		@ls_dgspcr	= dgspcr,
		@ls_dgjir	= dgjir,
		@ls_dgoor	= dgoor,
		@ls_dgpor	= dgpor,
		@ls_dgjtr	= dgjtr,
		@ls_dggunbor	= dggunbor,
		@ls_dgmur	= dgmur,
		@ls_dgclass	= dgclass,
		@ls_dgindt	= dgindt,
		@ls_dgintime	= dgintime,
		@ls_dginusr	= dginusr,
		@ls_dgupdt	= dgupdt,
		@ls_dguptime	= dguptime,
		@ls_dgupusr	= dgupusr
	From	#tmp_tmislabtac
	Where	checkid > @li_id

	If @ls_dgdiv = 'X' or @ls_dgdiv = 'E' or @ls_dgdiv = 'A'
	begin
		-- 대구전장
		If Not Exists (select * from [ipisele_svr\ipis].ipis.dbo.tmhlabtac
				where dgempno = @ls_dgempno and dgday = @ls_dgday and dgdiv in ('X','E','A'))
		begin

			insert into [ipisele_svr\ipis].ipis.dbo.tmhlabtac
				(dgempno,	dgday,		dgdiv,		dgdepte,
				dgempgb,	dgdaygb,	dgtimer,	dgcd1r,
				dgcd2r,		dgcd3r,		dgdngbr,	dgotr,
				dgntr,		dgjor,		dgsangr,	dgjuhur,
				dghumur,	dgspcr,		dgjir,		dgoor,
				dgpor,		dgjtr,		dggunbor,	dgmur,
				dgclass,	dgindt,		dgintime,	dginusr,
				dgupdt,		dguptime,	dgupusr,	excflag)
			values	(@ls_dgempno,	@ls_dgday,	@ls_dgdiv,	@ls_dgdepte,
				@ls_dgempgb,	@ls_dgdaygb,	@ls_dgtimer,	@ls_dgcd1r,
				@ls_dgcd2r,	@ls_dgcd3r,	@ls_dgdngbr,	@ls_dgotr,
				@ls_dgntr,	@ls_dgjor,	@ls_dgsangr,	@ls_dgjuhur,
				@ls_dghumur,	@ls_dgspcr,	@ls_dgjir,	@ls_dgoor,
				@ls_dgpor,	@ls_dgjtr,	@ls_dggunbor,	@ls_dgmur,
				@ls_dgclass,	@ls_dgindt,	@ls_dgintime,	@ls_dginusr,
				@ls_dgupdt,	@ls_dguptime,	@ls_dgupusr,	null)
		end
		else
			update	[ipisele_svr\ipis].ipis.dbo.tmhlabtac
			set	dgdiv = @ls_dgdiv,		dgdepte = @ls_dgdepte,
				dgempgb = @ls_dgempgb,		dgdaygb = @ls_dgdaygb,			
				dgtimer	= @ls_dgtimer,		dgcd1r = @ls_dgcd1r,
				dgcd2r = @ls_dgcd2r,		dgcd3r = @ls_dgcd3r,
				dgdngbr = @ls_dgdngbr,		dgotr = @ls_dgotr,
				dgntr = @ls_dgntr,		dgjor = @ls_dgjor,
				dgsangr = @ls_dgsangr,		dgjuhur = @ls_dgjuhur,
				dghumur = @ls_dghumur,		dgspcr = @ls_dgspcr,
				dgjir = @ls_dgjir,		dgoor = @ls_dgoor,
				dgpor = @ls_dgpor,		dgjtr = @ls_dgjtr,
				dggunbor = @ls_dggunbor,	dgmur = @ls_dgmur,
				dgclass = @ls_dgclass,		dgindt = @ls_dgindt,
				dgintime = @ls_dgintime,	dginusr = @ls_dginusr,
				dgupdt = @ls_dgupdt,		dguptime = @ls_dguptime,	
				dgupusr = @ls_dgupusr
			from	[ipisele_svr\ipis].ipis.dbo.tmhlabtac
			where	dgempno = @ls_dgempno
			and	dgday = @ls_dgday
	end

	If @ls_dgdiv = 'X' or @ls_dgdiv = 'M' or @ls_dgdiv = 'S'
	begin
		-- 대구기계
		If Not Exists (select * from [ipismac_svr\ipis].ipis.dbo.tmhlabtac
				where dgempno = @ls_dgempno and dgday = @ls_dgday and dgdiv in ('X','M','S'))
		begin

			insert into [ipismac_svr\ipis].ipis.dbo.tmhlabtac
				(dgempno,	dgday,		dgdiv,		dgdepte,
				dgempgb,	dgdaygb,	dgtimer,	dgcd1r,
				dgcd2r,		dgcd3r,		dgdngbr,	dgotr,
				dgntr,		dgjor,		dgsangr,	dgjuhur,
				dghumur,	dgspcr,		dgjir,		dgoor,
				dgpor,		dgjtr,		dggunbor,	dgmur,
				dgclass,	dgindt,		dgintime,	dginusr,
				dgupdt,		dguptime,	dgupusr,	excflag)
			values	(@ls_dgempno,	@ls_dgday,	@ls_dgdiv,	@ls_dgdepte,
				@ls_dgempgb,	@ls_dgdaygb,	@ls_dgtimer,	@ls_dgcd1r,
				@ls_dgcd2r,	@ls_dgcd3r,	@ls_dgdngbr,	@ls_dgotr,
				@ls_dgntr,	@ls_dgjor,	@ls_dgsangr,	@ls_dgjuhur,
				@ls_dghumur,	@ls_dgspcr,	@ls_dgjir,	@ls_dgoor,
				@ls_dgpor,	@ls_dgjtr,	@ls_dggunbor,	@ls_dgmur,
				@ls_dgclass,	@ls_dgindt,	@ls_dgintime,	@ls_dginusr,
				@ls_dgupdt,	@ls_dguptime,	@ls_dgupusr,	null)
		end
		else
			update	[ipismac_svr\ipis].ipis.dbo.tmhlabtac
			set	dgdiv = @ls_dgdiv,		dgdepte = @ls_dgdepte,
				dgempgb = @ls_dgempgb,		dgdaygb = @ls_dgdaygb,			
				dgtimer	= @ls_dgtimer,		dgcd1r = @ls_dgcd1r,
				dgcd2r = @ls_dgcd2r,		dgcd3r = @ls_dgcd3r,
				dgdngbr = @ls_dgdngbr,		dgotr = @ls_dgotr,
				dgntr = @ls_dgntr,		dgjor = @ls_dgjor,
				dgsangr = @ls_dgsangr,		dgjuhur = @ls_dgjuhur,
				dghumur = @ls_dghumur,		dgspcr = @ls_dgspcr,
				dgjir = @ls_dgjir,		dgoor = @ls_dgoor,
				dgpor = @ls_dgpor,		dgjtr = @ls_dgjtr,
				dggunbor = @ls_dggunbor,	dgmur = @ls_dgmur,
				dgclass = @ls_dgclass,		dgindt = @ls_dgindt,
				dgintime = @ls_dgintime,	dginusr = @ls_dginusr,
				dgupdt = @ls_dgupdt,		dguptime = @ls_dguptime,	
				dgupusr = @ls_dgupusr
			from	[ipismac_svr\ipis].ipis.dbo.tmhlabtac
			where	dgempno = @ls_dgempno
			and	dgday = @ls_dgday
	end

	If @ls_dgdiv = 'X' or @ls_dgdiv = 'H' or @ls_dgdiv = 'V' or @ls_dgdiv = 'K'
	begin
		-- 대구공조
		If Not Exists (select * from [ipishvac_svr\ipis].ipis.dbo.tmhlabtac
				where dgempno = @ls_dgempno and dgday = @ls_dgday and dgdiv in ('X','H','V','K'))
		begin

			insert into [ipishvac_svr\ipis].ipis.dbo.tmhlabtac
				(dgempno,	dgday,		dgdiv,		dgdepte,
				dgempgb,	dgdaygb,	dgtimer,	dgcd1r,
				dgcd2r,		dgcd3r,		dgdngbr,	dgotr,
				dgntr,		dgjor,		dgsangr,	dgjuhur,
				dghumur,	dgspcr,		dgjir,		dgoor,
				dgpor,		dgjtr,		dggunbor,	dgmur,
				dgclass,	dgindt,		dgintime,	dginusr,
				dgupdt,		dguptime,	dgupusr,	excflag)
			values	(@ls_dgempno,	@ls_dgday,	@ls_dgdiv,	@ls_dgdepte,
				@ls_dgempgb,	@ls_dgdaygb,	@ls_dgtimer,	@ls_dgcd1r,
				@ls_dgcd2r,	@ls_dgcd3r,	@ls_dgdngbr,	@ls_dgotr,
				@ls_dgntr,	@ls_dgjor,	@ls_dgsangr,	@ls_dgjuhur,
				@ls_dghumur,	@ls_dgspcr,	@ls_dgjir,	@ls_dgoor,
				@ls_dgpor,	@ls_dgjtr,	@ls_dggunbor,	@ls_dgmur,
				@ls_dgclass,	@ls_dgindt,	@ls_dgintime,	@ls_dginusr,
				@ls_dgupdt,	@ls_dguptime,	@ls_dgupusr,	null)
		end
		else
			update	[ipishvac_svr\ipis].ipis.dbo.tmhlabtac
			set	dgdiv = @ls_dgdiv,		dgdepte = @ls_dgdepte,
				dgempgb = @ls_dgempgb,		dgdaygb = @ls_dgdaygb,			
				dgtimer	= @ls_dgtimer,		dgcd1r = @ls_dgcd1r,
				dgcd2r = @ls_dgcd2r,		dgcd3r = @ls_dgcd3r,
				dgdngbr = @ls_dgdngbr,		dgotr = @ls_dgotr,
				dgntr = @ls_dgntr,		dgjor = @ls_dgjor,
				dgsangr = @ls_dgsangr,		dgjuhur = @ls_dgjuhur,
				dghumur = @ls_dghumur,		dgspcr = @ls_dgspcr,
				dgjir = @ls_dgjir,		dgoor = @ls_dgoor,
				dgpor = @ls_dgpor,		dgjtr = @ls_dgjtr,
				dggunbor = @ls_dggunbor,	dgmur = @ls_dgmur,
				dgclass = @ls_dgclass,		dgindt = @ls_dgindt,
				dgintime = @ls_dgintime,	dginusr = @ls_dginusr,
				dgupdt = @ls_dgupdt,		dguptime = @ls_dguptime,	
				dgupusr = @ls_dgupusr
			from	[ipishvac_svr\ipis].ipis.dbo.tmhlabtac
			where	dgempno = @ls_dgempno
			and	dgday = @ls_dgday
	end
		
	If @ls_dgdiv = 'X' or @ls_dgdiv = 'J'
	begin
		-- 진천
		If Not Exists (select * from [ipisjin_svr].ipis.dbo.tmhlabtac
				where dgempno = @ls_dgempno and dgday = @ls_dgday and dgdiv in ('X','J'))
		begin

			insert into [ipisjin_svr].ipis.dbo.tmhlabtac
				(dgempno,	dgday,		dgdiv,		dgdepte,
				dgempgb,	dgdaygb,	dgtimer,	dgcd1r,
				dgcd2r,		dgcd3r,		dgdngbr,	dgotr,
				dgntr,		dgjor,		dgsangr,	dgjuhur,
				dghumur,	dgspcr,		dgjir,		dgoor,
				dgpor,		dgjtr,		dggunbor,	dgmur,
				dgclass,	dgindt,		dgintime,	dginusr,
				dgupdt,		dguptime,	dgupusr,	excflag)
			values	(@ls_dgempno,	@ls_dgday,	@ls_dgdiv,	@ls_dgdepte,
				@ls_dgempgb,	@ls_dgdaygb,	@ls_dgtimer,	@ls_dgcd1r,
				@ls_dgcd2r,	@ls_dgcd3r,	@ls_dgdngbr,	@ls_dgotr,
				@ls_dgntr,	@ls_dgjor,	@ls_dgsangr,	@ls_dgjuhur,
				@ls_dghumur,	@ls_dgspcr,	@ls_dgjir,	@ls_dgoor,
				@ls_dgpor,	@ls_dgjtr,	@ls_dggunbor,	@ls_dgmur,
				@ls_dgclass,	@ls_dgindt,	@ls_dgintime,	@ls_dginusr,
				@ls_dgupdt,	@ls_dguptime,	@ls_dgupusr,	null)
		end
		else
			update	[ipisjin_svr].ipis.dbo.tmhlabtac
			set	dgdiv = @ls_dgdiv,		dgdepte = @ls_dgdepte,
				dgempgb = @ls_dgempgb,		dgdaygb = @ls_dgdaygb,			
				dgtimer	= @ls_dgtimer,		dgcd1r = @ls_dgcd1r,
				dgcd2r = @ls_dgcd2r,		dgcd3r = @ls_dgcd3r,
				dgdngbr = @ls_dgdngbr,		dgotr = @ls_dgotr,
				dgntr = @ls_dgntr,		dgjor = @ls_dgjor,
				dgsangr = @ls_dgsangr,		dgjuhur = @ls_dgjuhur,
				dghumur = @ls_dghumur,		dgspcr = @ls_dgspcr,
				dgjir = @ls_dgjir,		dgoor = @ls_dgoor,
				dgpor = @ls_dgpor,		dgjtr = @ls_dgjtr,
				dggunbor = @ls_dggunbor,	dgmur = @ls_dgmur,
				dgclass = @ls_dgclass,		dgindt = @ls_dgindt,
				dgintime = @ls_dgintime,	dginusr = @ls_dginusr,
				dgupdt = @ls_dgupdt,		dguptime = @ls_dguptime,	
				dgupusr = @ls_dgupusr
			from	[ipisjin_svr].ipis.dbo.tmhlabtac
			where	dgempno = @ls_dgempno
			and	dgday = @ls_dgday
	end

End
 
drop table #tmp_tmislabtac

End		-- Procedure End
Go
