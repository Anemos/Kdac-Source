/*
	File Name	: sp_pisc_menu_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisc_menu_01
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
	    Where id = object_id(N'[dbo].[sp_pisc_menu_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisc_menu_01]
GO

/*
Execute sp_pisc_menu_01
	@ps_menucd1	= '7'
*/

Create Procedure sp_pisc_menu_01
	@ps_menucd1	char(1)

As
Begin

Select	WIN_NM		= A.WIN_NM,
	MENU_CD	= A.MENU_CD
From	tmstpgmlist	A
Where	Substring(A.MENU_CD, 1, 1)	= @ps_menucd1		And
	Substring(A.MENU_CD, 2, 1)	<> '0'			And
	Substring(A.MENU_CD, 3, 2)	= '00'
Order By A.MENU_CD ASC

Return

End		-- Procedure End
Go
