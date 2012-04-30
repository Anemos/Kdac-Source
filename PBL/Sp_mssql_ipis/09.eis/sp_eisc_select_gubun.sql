/*
	File Name	: sp_eisc_select_gubun.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_eisc_select_gubun
	Description	: 
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: @ps_empno, @ps_areacode
	Use Table	: tmstarea
	Initial		: 2002. 09. 03
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_eisc_select_gubun]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_eisc_select_gubun]
GO

/*
Execute sp_eisc_select_gubun

select * from tmstarea


Select	LTrim(RTrim(A.AUTAREA))
From	tmstpassword	A
Where	A.EMP_NO	= 'IPIS'
*/

Create Procedure sp_eisc_select_gubun

As
Begin

Create Table #tmp_gubun
(
	gubuncode	varchar(1),
	gubunname	varchar(20)
)
Insert Into #tmp_gubun (GubunCode, GubunName)
Values ('Q', '수량')

Insert Into #tmp_gubun (GubunCode, GubunName)
Values ('L', 'LOT')

Select *
  From	#tmp_gubun	A
--Group By A.GubunCode, A.GubunName

Drop Table #tmp_gubun

Return

End		-- Procedure End

Go