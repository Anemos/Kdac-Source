/*
	File Name	: sp_pisk_date.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisk_date
	Description	: dummy 일자
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 14
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisk_date]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisk_date]
GO

/*
Execute sp_pisk_date
	@ps_prdmonth		= '2002.10',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '%',
	@ps_linecode		= '%'

select * from tprdratekb
 where itemcode = '0000001'
select * from tplanday

select linecode, itemcode, sum(releasekbcount)
from tplanrelease
where plandate = '2002.10.14'
group by linecode, itemcode

dbcc opentran

*/

Create Procedure sp_pisk_date

As
Begin

Select	AreaCode	= '',
	AreaName	= '',
	DivisionCode	= '',
	DivisionName	= '',
	WorkCenter	= '',
	WorkCenterName	= '',
	LineCode	= '',
--	LineShortName	= '',
	LineFullName	= '',
	KBRate		= 0.0,
	KBRate01	= 0.0,
	KBRate02	= 0.0,
	KBRate03	= 0.0,
	KBRate04	= 0.0,
	KBRate05	= 0.0,
	KBRate06	= 0.0,
	KBRate07	= 0.0,
	KBRate08	= 0.0,
	KBRate09	= 0.0,
	KBRate10	= 0.0,
	KBRate11	= 0.0,
	KBRate12	= 0.0,
	KBRate13	= 0.0,
	KBRate14	= 0.0,
	KBRate15	= 0.0,
	KBRate16	= 0.0,
	KBRate17	= 0.0,
	KBRate18	= 0.0,
	KBRate19	= 0.0,
	KBRate20	= 0.0,
	KBRate21	= 0.0,
	KBRate22	= 0.0,
	KBRate23	= 0.0,
	KBRate24	= 0.0,
	KBRate25	= 0.0,
	KBRate26	= 0.0,
	KBRate27	= 0.0,
	KBRate28	= 0.0,
	KBRate29	= 0.0,
	KBRate30	= 0.0,
	KBRate31	= 0.0
From	tmstline		A

Return

End		-- Procedure End
Go
