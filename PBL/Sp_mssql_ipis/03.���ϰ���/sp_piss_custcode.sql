/*
	File Name	: sp_piss_custcode.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piss_custcode
	Description	: ���� ��Ȳ
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 14
	Author		: Kim Jin-Su
*/
If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss_custcode]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss_custcode]
GO


/*
Exec sp_piss_custcode @ps_custgubun    = 'D'
*/

/****** Object:  Stored Procedure dbo.sp_s_0010    Script Date: 02-08-26  ******/
Create Procedure sp_piss_custcode
	@ps_custgubun		varchar(01)	-- �ŷ�ó����
	
As
Begin


Select  custcode		= A.custcode,
	custName		= A.custname
  From	tmstcustomer	A
 Where	A.custgubun	like @ps_custgubun

Return

End		-- Procedure End


GO
