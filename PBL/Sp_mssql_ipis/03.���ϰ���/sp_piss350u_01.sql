/*
	File Name	: sp_piss350u_01 .SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss350u_01 
	Description	: 간판 번호 List
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 14
	Author		: Kim Jin-Su
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss350u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss350u_01]
GO


/*
exec sp_piss350u_01 
*/

Create Procedure sp_piss350u_01
As
Begin
  SELECT areacode     = substring(a.confirmno,1,1),
         divisioncode = substring(a.confirmno,1,1),
         shipgubun    = substring(a.confirmno,3,1),
         confirmno1   = '',
         yymm         = substring(a.confirmno,4,3),
         seqno        = substring(a.confirmno,7,6),
         input        = a.InputFlag,   
         confirmno    = a.confirmno,   
         deptcode     = a.DeptCode,   
         projectno    = a.ProjectNo, 
         itemcode     = a.ItemCode,   
         itemname     = '', 
         invgubunflag = a.InvGubunFlag,   
         etcqty       = a.EtcQty,   
         reason       = a.Reason,
         projectname  = ''
    FROM TSHIPETC  a
  where a.areacode = 'z'
end


GO
