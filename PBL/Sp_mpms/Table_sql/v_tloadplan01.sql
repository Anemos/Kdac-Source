/*
  File Name : V_TLOADPLAN01.SQL
  SYSTEM    :
  View Name  : V_TLOADPLAN01
  Description : 최근 작업지시된 공정, 작업일자, 후공정 가져오기
  Supply    :
  Use DataBase  : MPMS
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2006.06
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[V_TLOADPLAN01]')
        And OBJECTPROPERTY(id, N'IsView') = 1)
  Drop View [dbo].[V_TLOADPLAN01]
GO

/* select * from V_TLOADPLAN01 */

CREATE  View V_TLOADPLAN01

As

select orderno = tmp.orderno,
  partno = tmp.partno,
  operno = tmp.operno,
  workdate = tmp.workdate,
  postoperno = ( select top 1 operno from trouting
    where orderno = tmp.orderno and partno = tmp.partno and
      operno > tmp.operno order by operno)
from (select orderno, partno, max(operno) as operno,
  max(workdate) as workdate
  from tloadplan
  group by orderno, partno) tmp

go
