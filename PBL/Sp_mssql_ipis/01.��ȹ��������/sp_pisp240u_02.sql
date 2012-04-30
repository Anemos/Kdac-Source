/*
	File Name	: sp_pisp240u_02.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp240u_02
	Description	: 간판 번호 관리 - 생성할 간판 매수 등록
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 07
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp240u_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp240u_02]
GO

/*
Execute sp_pisp240u_02
	@ps_planmonth		= '2002.09',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '4201',
	@ps_linecode		= '%',
	@ps_itemcode		= '%'

select * from tmstkb
select * from tmstkbhis
select * from tkb

rollback
dbcc opentran

*/

Create Procedure sp_pisp240u_02
	@ps_areacode		char(1),		-- 지역 코드
	@ps_divisioncode	char(1),		-- 공장 코드
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1),
	@ps_itemcode		varchar(12)

As
Begin

Select	NormalKBCount	= 0,
	TempKBCount	= 0,
	TempKBRackQty	= 0


Return

End		-- Procedure End
Go
