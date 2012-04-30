/*
	File Name	: sp_pisc_select_shift.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisc_select_shift
	Description	: 주/야 구분 DDDW을 위한 조회
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 27
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisc_select_shift]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisc_select_shift]
GO

/*
Execute sp_pisc_select_shift '%', '%'

*/

Create Procedure sp_pisc_select_shift
	@ps_areacode		char(1),		-- 지역
	@ps_divisioncode	char(1)

As
Begin

Create Table #tmp_shift
(
	shiftcode	char(1),
	shiftname	varchar(10)
)
Insert Into #tmp_shift (shiftcode, shiftname)
Values ('A', '주간')

Insert Into #tmp_shift (shiftcode, shiftname)
Values ('B', '야간')

Select *
  From	#tmp_shift	A
Group By A.ShiftCode, A.ShiftName

Drop Table #tmp_shift

Return

End		-- Procedure End
Go
