/*
	File Name	: sp_pisc_menu_02.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisc_menu_02
	Description	: 모듈 조회
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 14
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisc_menu_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisc_menu_02]
GO

/*
Execute sp_pisc_menu_02
	@ps_menucd2	= '71'

select * from tmstpgmlist
*/

Create Procedure sp_pisc_menu_02
	@ps_menucd2	char(2)

As
Begin

Select	MENU_CD	= A.MENU_CD,
	WIN_NM		= A.WIN_NM
From	tmstpgmlist	A
Where	Substring(A.MENU_CD, 1, 2)	= @ps_menucd2		And
	Substring(A.MENU_CD, 3, 1)	<> '0'			And
	Substring(A.MENU_CD, 4, 1)	= '0'
Order By A.MENU_CD ASC

Return

End		-- Procedure End
Go
