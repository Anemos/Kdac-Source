/*
	File Name	: sp_piso100u_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piso100u_01
	Description	: 메세지 전송 관리
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 18
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piso100u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piso100u_01]
GO

/*
Execute sp_piso100u_01
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'M',
	@ps_messagegubun	= '%',
	@ps_pcip		= '%'

select * from tmstip
select * from tmstemp

*/

Create Procedure sp_piso100u_01
	@ps_areacode		char(1),		-- 지역
	@ps_divisioncode	char(1),
	@ps_messagegubun	varchar(50),
	@ps_pcip		varchar(20)

As
Begin

Select	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	MessageGubun		= A.MessageGubun,
	PCIP			= A.PCIP,
	PCEmp			= A.PCEmp,
	PCName			= A.PCName,
	PCWorkGroup		= A.PCWorkGroup,
	LastEmp			= A.LastEmp,
	LastDate			= A.LastDate
From	tmstip		A
Where	A.AreaCode		= @ps_areacode		And
	A.DivisionCode		= @ps_divisioncode	And
	A.MessageGubun	Like @ps_messagegubun	And
	A.PCIP			Like @ps_pcip
Group By A.AreaCode, A.DivisionCode, A.MessageGubun, A.PCIP,
	A.PCEmp, A.PCName, A.PCWorkGroup, A.LastEmp, A.LastDate
	

Return

End		-- Procedure End

Go