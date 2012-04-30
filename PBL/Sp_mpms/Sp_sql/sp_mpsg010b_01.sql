/*
  File Name : sp_mpsg010b_01.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpsg010b_01
  Description : 단말기및WorkCenter
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_terminalcode varchar(5)
  Use Table :
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpsg010b_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpsg010b_01]
GO

/*
Execute sp_mpsg010b_01 'MTA01'
*/

Create Procedure sp_mpsg010b_01
  @ps_terminalcode varchar(5)

As
Begin

/*########################################################################################

단말기에 물려있는 WorkGroup와 WorkCenter코드를 가져온다.

########################################################################################*/

SELECT	aa.wgcode	AS as_WorkCenter,
	bb.wccode	AS as_LineCode
  FROM	tterminalworkgroup aa INNER JOIN tworkcenter bb
    ON aa.wgcode = bb.wgcode
 WHERE	aa.trmcode	= @ps_terminalcode
ORDER	BY bb.wcserial

End   -- Procedure End
Go
