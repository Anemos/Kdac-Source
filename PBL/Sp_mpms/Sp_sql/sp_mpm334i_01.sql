/*
  File Name : sp_mpm334i_01.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm334i_01
  Description : W/C별 부하현황 - 일자별 조회
  Use DataBase  : MPMS
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2006.05
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm334i_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm334i_01]
GO

/*
Execute sp_mpm334i_01
  @ps_orderno   = 'A',
  @ps_workdate   = '2006.05.10'
*/

Create Procedure sp_mpm334i_01
  @ps_orderno varchar(9),    /* OrderNo */
  @ps_workdate varchar(11)    /* 적용일 */


As
Begin

select WorkDate = aa.WorkDate,
  OrderNo = aa.OrderNo,
  PartNo = aa.PartNo,
  OperNo = aa.OperNo,
  TBS = case aa.WcCode when 'TBS' then aa.stdtime else 0 end,
  TLA = case aa.WcCode when 'TLA' then aa.stdtime else 0 end,
  TDM = case aa.WcCode when 'TDM' then aa.stdtime else 0 end,
  TPM = case aa.WcCode when 'TPM' then aa.stdtime else 0 end,
  TBM = case aa.WcCode when 'TBM' then aa.stdtime else 0 end,
  TMM = case aa.WcCode when 'TMM' then aa.stdtime else 0 end,
  TJB = case aa.WcCode when 'TJB' then aa.stdtime else 0 end,
  THT = case aa.WcCode when 'THT' then aa.stdtime else 0 end,
  TUG = case aa.WcCode when 'TUG' then aa.stdtime else 0 end,
  TSG = case aa.WcCode when 'TSG' then aa.stdtime else 0 end,
  TJG = case aa.WcCode when 'TJG' then aa.stdtime else 0 end,
  TVG = case aa.WcCode when 'TVG' then aa.stdtime else 0 end,
  TWC = case aa.WcCode when 'TWC' then aa.stdtime else 0 end,
  TED = case aa.WcCode when 'TED' then aa.stdtime else 0 end,
  TLP = case aa.WcCode when 'TLP' then aa.stdtime else 0 end,
  TAM = case aa.WcCode when 'TAM' then aa.stdtime else 0 end
from tloadplan aa
where aa.workdate like @ps_workdate and aa.orderno like @ps_orderno
order by workdate, orderno, partno, operno

select WorkDate = aa.WorkDate,
  TBS = sum(case aa.WcCode when 'TBS' then aa.stdtime else 0 end),
  TLA = sum(case aa.WcCode when 'TLA' then aa.stdtime else 0 end),
  TDM = sum(case aa.WcCode when 'TDM' then aa.stdtime else 0 end),
  TPM = sum(case aa.WcCode when 'TPM' then aa.stdtime else 0 end),
  TBM = sum(case aa.WcCode when 'TBM' then aa.stdtime else 0 end),
  TMM = sum(case aa.WcCode when 'TMM' then aa.stdtime else 0 end),
  TJB = sum(case aa.WcCode when 'TJB' then aa.stdtime else 0 end),
  THT = sum(case aa.WcCode when 'THT' then aa.stdtime else 0 end),
  TUG = sum(case aa.WcCode when 'TUG' then aa.stdtime else 0 end),
  TSG = sum(case aa.WcCode when 'TSG' then aa.stdtime else 0 end),
  TJG = sum(case aa.WcCode when 'TJG' then aa.stdtime else 0 end),
  TVG = sum(case aa.WcCode when 'TVG' then aa.stdtime else 0 end),
  TWC = sum(case aa.WcCode when 'TWC' then aa.stdtime else 0 end),
  TED = sum(case aa.WcCode when 'TED' then aa.stdtime else 0 end),
  TLP = sum(case aa.WcCode when 'TLP' then aa.stdtime else 0 end),
  TAM = sum(case aa.WcCode when 'TAM' then aa.stdtime else 0 end)
from tloadplan aa
group by aa.workdate
order by workdate

End   -- Procedure End
Go
