/*
	File Name	: sp_pisp241u_02.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp241u_02
	Description	: ���� ��ȣ ���� - �μ� ��� ����
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 10
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp241u_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp241u_02]
GO

/*
Execute sp_pisp241u_02

select * from tcalendarwork
select * from tplanday


dbcc opentran

*/

Create Procedure sp_pisp241u_02

As
Begin

Select	KBNo			= '',
	TempGubun		= '',
	TempGubunName	= '',
	RackQty			= 0,
	PrintCount		= 0,
	KBPrintTime		= Null

Return

End		-- Procedure End
Go
