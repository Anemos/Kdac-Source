/*
	File Name	: sp_mcmaster_no_down.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_mcmaster_no_down
	Description	: Download 고정자산번호
			  equip_master - 일간단위 갱신
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
	Remark		: 
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_mcmaster_no_down]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_mcmaster_no_down]
GO

/*
Execute sp_mcmaster_no_down
*/

Create  Procedure sp_mcmaster_no_down
	
As
Begin


if Exists (select * from fia030)
	Begin

		-- 대구 전장
	
		Update	[ipisele_svr\ipis].cmms.dbo.equip_master
		Set	Asset_code	=	''
		Where	Area_Code+Factory_code+Equip_code	Not in
			(Select	Case Fidiv
		         		When	'C'	Then	'D'
			        	When	'E'	Then	'D'
		         		When	'W'	Then	'D'
		         		When	'Y'	Then	'D'
		         		When	'M'	Then	'D'
		         		When	'S'	Then	'D'
		         		When	'H'	Then	'D'
		         		When	'V'	Then	'D'
		         		When	'B'	Then	'J'
		         		When	'L'	Then	'J'
		         		When	'T'	Then	'J'
					When	'N'	Then	'K'
					When	'O'	Then	'K'
					When	'P'	Then	'K'
					When	'D'	Then	'Y'
					Else	'X'
				End +	
				Case Fidiv
		         		When	'C'	Then	'A'
			        	When	'E'	Then	'A'
		         		When	'W'	Then	'A'
		         		When	'Y'	Then	'A'
		         		When	'M'	Then	'M'
		         		When	'S'	Then	'S'
		         		When	'H'	Then	'H'
		         		When	'V'	Then	'V'
		         		When	'B'	Then	'M'
		         		When	'L'	Then	'S'
		         		When	'T'	Then	'H'
					When	'N'	Then	'S'
					When	'O'	Then	'H'
					When	'P'	Then	'M'
					When	'D'	Then	'Y'
					Else	'X'
				End +
				Fimchno
			From	Fia030)
		
		Update	[ipisele_svr\ipis].cmms.dbo.equip_master
		Set	Asset_code	=	b.ficode
		From	[ipisele_svr\ipis].cmms.dbo.equip_master	a,
			(Select	Area_Code	=	Case Fidiv
					         		When	'C'	Then	'D'
						        	When	'E'	Then	'D'
					         		When	'W'	Then	'D'
					         		When	'Y'	Then	'D'
					         		When	'M'	Then	'D'
					         		When	'S'	Then	'D'
					         		When	'H'	Then	'D'
					         		When	'V'	Then	'D'
					         		When	'B'	Then	'J'
					         		When	'L'	Then	'J'
					         		When	'T'	Then	'J'
								When	'N'	Then	'K'
								When	'O'	Then	'K'
								When	'P'	Then	'K'
								When	'D'	Then	'Y'
								Else	'X'
							End,
				Factory_code	=	Case Fidiv
					         		When	'C'	Then	'A'
						        	When	'E'	Then	'A'
					         		When	'W'	Then	'A'
					         		When	'Y'	Then	'A'
					         		When	'M'	Then	'M'
					         		When	'S'	Then	'S'
					         		When	'H'	Then	'H'
					         		When	'V'	Then	'V'
					         		When	'B'	Then	'M'
					         		When	'L'	Then	'S'
					         		When	'T'	Then	'H'
								When	'N'	Then	'S'
								When	'O'	Then	'H'
								When	'P'	Then	'M'
								When	'D'	Then	'Y'
								Else	'X'
							End,
				Fimchno,
				Ficode
			From	Fia030)	b
		Where	a.Area_Code	=	b.Area_Code	and
			a.Factory_code	=	b.Factory_code	and
			a.Equip_code	=	b.Fimchno	
		
		-- 대구 기계
		
		Update	[ipismac_svr\ipis].cmms.dbo.equip_master
		Set	Asset_code	=	''
		Where	Area_Code+Factory_code+Equip_code	Not in
			(Select	Case Fidiv
		         		When	'C'	Then	'D'
			        	When	'E'	Then	'D'
		         		When	'W'	Then	'D'
		         		When	'Y'	Then	'D'
		         		When	'M'	Then	'D'
		         		When	'S'	Then	'D'
		         		When	'H'	Then	'D'
		         		When	'V'	Then	'D'
		         		When	'B'	Then	'J'
		         		When	'L'	Then	'J'
		         		When	'T'	Then	'J'
					When	'N'	Then	'K'
					When	'O'	Then	'K'
					When	'P'	Then	'K'
					When	'D'	Then	'Y'
					Else	'X'
				End +	
				Case Fidiv
		         		When	'C'	Then	'A'
			        	When	'E'	Then	'A'
		         		When	'W'	Then	'A'
		         		When	'Y'	Then	'A'
		         		When	'M'	Then	'M'
		         		When	'S'	Then	'S'
		         		When	'H'	Then	'H'
		         		When	'V'	Then	'V'
		         		When	'B'	Then	'M'
		         		When	'L'	Then	'S'
		         		When	'T'	Then	'H'
					When	'N'	Then	'S'
					When	'O'	Then	'H'
					When	'P'	Then	'M'
					When	'D'	Then	'Y'
					Else	'X'
				End +
				Fimchno
			From	Fia030)
		
		Update	[ipismac_svr\ipis].cmms.dbo.equip_master
		Set	Asset_code	=	b.ficode
		From	[ipismac_svr\ipis].cmms.dbo.equip_master	a,
			(Select	Area_Code	=	Case Fidiv
					         		When	'C'	Then	'D'
						        	When	'E'	Then	'D'
					         		When	'W'	Then	'D'
					         		When	'Y'	Then	'D'
					         		When	'M'	Then	'D'
					         		When	'S'	Then	'D'
					         		When	'H'	Then	'D'
					         		When	'V'	Then	'D'
					         		When	'B'	Then	'J'
					         		When	'L'	Then	'J'
					         		When	'T'	Then	'J'
								When	'N'	Then	'K'
								When	'O'	Then	'K'
								When	'P'	Then	'K'
								When	'D'	Then	'Y'
								Else	'X'
							End,
				Factory_code	=	Case Fidiv
					         		When	'C'	Then	'A'
						        	When	'E'	Then	'A'
					         		When	'W'	Then	'A'
					         		When	'Y'	Then	'A'
					         		When	'M'	Then	'M'
					         		When	'S'	Then	'S'
					         		When	'H'	Then	'H'
					         		When	'V'	Then	'V'
					         		When	'B'	Then	'M'
					         		When	'L'	Then	'S'
					         		When	'T'	Then	'H'
								When	'N'	Then	'S'
								When	'O'	Then	'H'
								When	'P'	Then	'M'
								When	'D'	Then	'Y'
								Else	'X'
							End,
				Fimchno,
				Ficode
			From	Fia030)	b
		Where	a.Area_Code	=	b.Area_Code	and
			a.Factory_code	=	b.Factory_code	and
			a.Equip_code	=	b.Fimchno	
		
		-- 대구 공조
		
		
		Update	[ipishvac_svr\ipis].cmms.dbo.equip_master
		Set	Asset_code	=	''
		Where	Area_Code+Factory_code+Equip_code	Not in
			(Select	Case Fidiv
		         		When	'C'	Then	'D'
			        	When	'E'	Then	'D'
		         		When	'W'	Then	'D'
		         		When	'Y'	Then	'D'
		         		When	'M'	Then	'D'
		         		When	'S'	Then	'D'
		         		When	'H'	Then	'D'
		         		When	'V'	Then	'D'
		         		When	'B'	Then	'J'
		         		When	'L'	Then	'J'
		         		When	'T'	Then	'J'
					When	'N'	Then	'K'
					When	'O'	Then	'K'
					When	'P'	Then	'K'
					When	'D'	Then	'Y'
					Else	'X'
				End +	
				Case Fidiv
		         		When	'C'	Then	'A'
			        	When	'E'	Then	'A'
		         		When	'W'	Then	'A'
		         		When	'Y'	Then	'A'
		         		When	'M'	Then	'M'
		         		When	'S'	Then	'S'
		         		When	'H'	Then	'H'
		         		When	'V'	Then	'V'
		         		When	'B'	Then	'M'
		         		When	'L'	Then	'S'
		         		When	'T'	Then	'H'
					When	'N'	Then	'S'
					When	'O'	Then	'H'
					When	'P'	Then	'M'
					When	'D'	Then	'Y'
					Else	'X'
				End +
				Fimchno
			From	Fia030)
		
		Update	[ipishvac_svr\ipis].cmms.dbo.equip_master
		Set	Asset_code	=	b.ficode
		From	[ipishvac_svr\ipis].cmms.dbo.equip_master	a,
			(Select	Area_Code	=	Case Fidiv
					         		When	'C'	Then	'D'
						        	When	'E'	Then	'D'
					         		When	'W'	Then	'D'
					         		When	'Y'	Then	'D'
					         		When	'M'	Then	'D'
					         		When	'S'	Then	'D'
					         		When	'H'	Then	'D'
					         		When	'V'	Then	'D'
					         		When	'B'	Then	'J'
					         		When	'L'	Then	'J'
					         		When	'T'	Then	'J'
								When	'N'	Then	'K'
								When	'O'	Then	'K'
								When	'P'	Then	'K'
								When	'D'	Then	'Y'
								Else	'X'
							End,
				Factory_code	=	Case Fidiv
					         		When	'C'	Then	'A'
						        	When	'E'	Then	'A'
					         		When	'W'	Then	'A'
					         		When	'Y'	Then	'A'
					         		When	'M'	Then	'M'
					         		When	'S'	Then	'S'
					         		When	'H'	Then	'H'
					         		When	'V'	Then	'V'
					         		When	'B'	Then	'M'
					         		When	'L'	Then	'S'
					         		When	'T'	Then	'H'
								When	'N'	Then	'S'
								When	'O'	Then	'H'
								When	'P'	Then	'M'
								When	'D'	Then	'Y'
								Else	'X'
							End,
				Fimchno,
				Ficode
			From	Fia030)	b
		Where	a.Area_Code	=	b.Area_Code	and
			a.Factory_code	=	b.Factory_code	and
			a.Equip_code	=	b.Fimchno	
		
		
		-- 진천
		
		Update	[ipisjin_svr].cmms.dbo.equip_master
		Set	Asset_code	=	''
		Where	Area_Code+Factory_code+Equip_code	Not in
			(Select	Case Fidiv
		         		When	'C'	Then	'D'
			        	When	'E'	Then	'D'
		         		When	'W'	Then	'D'
		         		When	'Y'	Then	'D'
		         		When	'M'	Then	'D'
		         		When	'S'	Then	'D'
		         		When	'H'	Then	'D'
		         		When	'V'	Then	'D'
		         		When	'B'	Then	'J'
		         		When	'L'	Then	'J'
		         		When	'T'	Then	'J'
					When	'N'	Then	'K'
					When	'O'	Then	'K'
					When	'P'	Then	'K'
					When	'D'	Then	'Y'
					Else	'X'
				End +	
				Case Fidiv
		         		When	'C'	Then	'A'
			        	When	'E'	Then	'A'
		         		When	'W'	Then	'A'
		         		When	'Y'	Then	'A'
		         		When	'M'	Then	'M'
		         		When	'S'	Then	'S'
		         		When	'H'	Then	'H'
		         		When	'V'	Then	'V'
		         		When	'B'	Then	'M'
		         		When	'L'	Then	'S'
		         		When	'T'	Then	'H'
					When	'N'	Then	'S'
					When	'O'	Then	'H'
					When	'P'	Then	'M'
					When	'D'	Then	'Y'
					Else	'X'
				End +
				Fimchno
			From	Fia030)
		
		Update	[ipisjin_svr].cmms.dbo.equip_master
		Set	Asset_code	=	b.ficode
		From	[ipisjin_svr].cmms.dbo.equip_master	a,
			(Select	Area_Code	=	Case Fidiv
					         		When	'C'	Then	'D'
						        	When	'E'	Then	'D'
					         		When	'W'	Then	'D'
					         		When	'Y'	Then	'D'
					         		When	'M'	Then	'D'
					         		When	'S'	Then	'D'
					         		When	'H'	Then	'D'
					         		When	'V'	Then	'D'
					         		When	'B'	Then	'J'
					         		When	'L'	Then	'J'
					         		When	'T'	Then	'J'
								When	'N'	Then	'K'
								When	'O'	Then	'K'
								When	'P'	Then	'K'
								When	'D'	Then	'Y'
								Else	'X'
							End,
				Factory_code	=	Case Fidiv
					         		When	'C'	Then	'A'
						        	When	'E'	Then	'A'
					         		When	'W'	Then	'A'
					         		When	'Y'	Then	'A'
					         		When	'M'	Then	'M'
					         		When	'S'	Then	'S'
					         		When	'H'	Then	'H'
					         		When	'V'	Then	'V'
					         		When	'B'	Then	'M'
					         		When	'L'	Then	'S'
					         		When	'T'	Then	'H'
								When	'N'	Then	'S'
								When	'O'	Then	'H'
								When	'P'	Then	'M'
								When	'D'	Then	'Y'
								Else	'X'
							End,
				Fimchno,
				Ficode
			From	Fia030)	b
		Where	a.Area_Code	=	b.Area_Code	and
			a.Factory_code	=	b.Factory_code	and
			a.Equip_code	=	b.Fimchno	
		
		Truncate table fia030
	end
	
End		-- Procedure End

GO
