SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




/*
Execute sp_pisi_d_tmstmodel
*/

ALTER    Procedure sp_pisi_d_tmstmodel


As
Begin

set xact_abort off

insert into invmaster
Select *
From  pdinv101_log
WHere Cls in  ('23',  '43') and
  chgdate not in (select  chgdate From  invmaster)

if @@error  <>  0
  Begin
  Return
  End

Delete  From  Pdinv101_log
Where cls in  ('21',  '41', '23', '43') and
  chgdate in (select  chgdate From  invmaster)

if @@error  <>  0
  Begin
  Return
  End

-- 유효한 데이타 가져오기
Select  *
into  #tmp_pdinv101
from  pdinv101_log
where xplant+div+itno+chgdate in (select xplant+div+itno+max(chgdate) from pdinv101_log
            group by xplant,div,itno)
order by chgdate

if @@rowcount = 0 
  Begin
  Return
  End

-- 전장서버
-- 1. Chgcd in ('A','R','D')
Delete  [ipisele_svr\ipis].ipis.dbo.tmstmodel
  From  [ipisele_svr\ipis].ipis.dbo.tmstmodel a,
    #tmp_pdinv101       b
  Where a.AreaCode  = b.xplant  and
    a.DivisionCode  = b.Div   and
    a.ItemCode  = b.Itno and
    b.xplant = 'D' and
    b.div = 'A'

if @@error  <>  0
  Begin
  Return
  End

Delete  [ipisele_svr\ipis].ipis.dbo.tmstitemcost
  From  [ipisele_svr\ipis].ipis.dbo.tmstitemcost  a,
    #tmp_pdinv101       b
  Where a.AreaCode  = b.xplant  and
    a.DivisionCode  = b.Div   and
    a.ItemCode  = b.Itno and
    b.xplant = 'D' and
    b.div = 'A'

if @@error  <>  0
  Begin
  Return
  End

-- 2. Chgcd in ('A','R')
INSERT INTO [ipisele_svr\ipis].ipis.dbo.tmstmodel
  (AreaCode,  DivisionCode, ProductGroup,ModelGroup,ProductCode,ItemCode,
  ItemClass,  ItemBuySource,  ItemUnit,ConvertFactor, AverageUnitCost,AbcCode,
  Location, Planner,  LastEmp)
SELECT AA.xplant, AA.div, substring(AA.pdcd, 1, 2),
  case len(substring(AA.pdcd, 1, 3))
  when 2 then rtrim(substring(AA.pdcd, 1, 3)) + '9'
  else substring(AA.pdcd, 1, 3) end, AA.pdcd,
  AA.itno,  AA.cls, AA.srce, AA.xunit, AA.convqty, AA.saud, AA.abccd,
  AA.wloc,  AA.xplan, 'SYSTEM'
FROM #tmp_pdinv101 AA
WHERE AA.Chgcd in ('A','R') and AA.xplant = 'D' and AA.div = 'A'

if @@error  <>  0
  Begin
  Return
  End

INSERT INTO [ipisele_svr\ipis].ipis.dbo.tmstitemcost
  (AreaCode,  DivisionCode, ItemCode,
  ItemClass,  ItemBuySource,  ItemUnit, UnitCost, LastEmp)
SELECT AA.xplant, AA.div, AA.itno,
  AA.cls, AA.srce, AA.xunit, AA.saud, 'SYSTEM'
FROM #tmp_pdinv101 AA
WHERE AA.Chgcd in ('A','R') and AA.xplant = 'D' and AA.div = 'A'

if @@error  <>  0
  Begin
  Return
  End

-- 공조서버
-- 1. Chgcd in ('A','R','D')
Delete  [ipishvac_svr\ipis].ipis.dbo.tmstmodel
  From  [ipishvac_svr\ipis].ipis.dbo.tmstmodel  a,
    #tmp_pdinv101       b
  Where a.AreaCode  = b.xplant  and
    a.DivisionCode  = b.Div   and
    a.ItemCode  = b.Itno and
    ((b.xplant = 'D' and b.div in ('H','V'))
	or b.xplant in ('K','Y')) 

if @@error  <>  0
  Begin
  Return
  End

Delete  [ipishvac_svr\ipis].ipis.dbo.tmstitemcost
  From  [ipishvac_svr\ipis].ipis.dbo.tmstitemcost a,
    #tmp_pdinv101       b
  Where a.AreaCode  = b.xplant  and
    a.DivisionCode  = b.Div   and
    a.ItemCode  = b.Itno and
    ((b.xplant = 'D' and b.div in ('H','V'))
	or b.xplant in ('K','Y')) 

if @@error  <>  0
  Begin
  Return
  End

-- 2. Chgcd in ('A','R')
INSERT INTO [ipishvac_svr\ipis].ipis.dbo.tmstmodel
  (AreaCode,  DivisionCode, ProductGroup,ModelGroup,ProductCode,ItemCode,
  ItemClass,  ItemBuySource,  ItemUnit,ConvertFactor, AverageUnitCost,AbcCode,
  Location, Planner,  LastEmp)
SELECT AA.xplant, AA.div, substring(AA.pdcd, 1, 2),
  case len(substring(AA.pdcd, 1, 3))
  when 2 then rtrim(substring(AA.pdcd, 1, 3)) + '9'
  else substring(AA.pdcd, 1, 3) end,  AA.pdcd,
  AA.itno,  AA.cls, AA.srce, AA.xunit, AA.convqty, AA.saud, AA.abccd,
  AA.wloc,  AA.xplan, 'SYSTEM'
FROM #tmp_pdinv101 AA
WHERE AA.Chgcd in ('A','R') and
    ((AA.xplant = 'D' and AA.div in ('H','V'))
	or AA.xplant in ('K','Y')) 

if @@error  <>  0
  Begin
  Return
  End

INSERT INTO [ipishvac_svr\ipis].ipis.dbo.tmstitemcost
  (AreaCode,  DivisionCode, ItemCode,
  ItemClass,  ItemBuySource,  ItemUnit, UnitCost, LastEmp)
SELECT AA.xplant, AA.div, AA.itno,
  AA.cls, AA.srce, AA.xunit, AA.saud, 'SYSTEM'
FROM #tmp_pdinv101 AA
WHERE AA.Chgcd in ('A','R') and
    ((AA.xplant = 'D' and AA.div in ('H','V'))
	or AA.xplant in ('K','Y')) 

if @@error  <>  0
  Begin
  Return
  End

-- 제동서버
-- 1. Chgcd in ('A','R','D')
Delete  [ipismac_svr\ipis].ipis.dbo.tmstmodel
  From  [ipismac_svr\ipis].ipis.dbo.tmstmodel a,
    #tmp_pdinv101       b
  Where a.AreaCode  = b.xplant  and
    a.DivisionCode  = b.Div   and
    a.ItemCode  = b.Itno and
    b.xplant = 'D' and
    b.div in ('M','S')

if @@error  <>  0
  Begin
  Return
  End

Delete  [ipismac_svr\ipis].ipis.dbo.tmstitemcost
  From  [ipismac_svr\ipis].ipis.dbo.tmstitemcost  a,
    #tmp_pdinv101       b
  Where a.AreaCode  = b.xplant  and
    a.DivisionCode  = b.Div   and
    a.ItemCode  = b.Itno and
    b.xplant = 'D' and
    b.div in ('M','S')

if @@error  <>  0
  Begin
  Return
  End

-- 2. Chgcd in ('A','R')
INSERT INTO [ipismac_svr\ipis].ipis.dbo.tmstmodel
  (AreaCode,  DivisionCode, ProductGroup,ModelGroup,ProductCode,ItemCode,
  ItemClass,  ItemBuySource,  ItemUnit,ConvertFactor, AverageUnitCost,AbcCode,
  Location, Planner,  LastEmp)
SELECT AA.xplant, AA.div, substring(AA.pdcd, 1, 2),
  case len(substring(AA.pdcd, 1, 3))
  when 2 then rtrim(substring(AA.pdcd, 1, 3)) + '9'
  else substring(AA.pdcd, 1, 3) end,  AA.pdcd,
  AA.itno,  AA.cls, AA.srce, AA.xunit, AA.convqty, AA.saud, AA.abccd,
  AA.wloc,  AA.xplan, 'SYSTEM'
FROM #tmp_pdinv101 AA
WHERE AA.Chgcd in ('A','R') and
    AA.xplant = 'D' and
    AA.div in ('M','S')

if @@error  <>  0
  Begin
  Return
  End

INSERT INTO [ipismac_svr\ipis].ipis.dbo.tmstitemcost
  (AreaCode,  DivisionCode, ItemCode,
  ItemClass,  ItemBuySource,  ItemUnit, UnitCost, LastEmp)
SELECT AA.xplant, AA.div, AA.itno,
  AA.cls, AA.srce, AA.xunit, AA.saud, 'SYSTEM'
FROM #tmp_pdinv101 AA
WHERE AA.Chgcd in ('A','R') and
    AA.xplant = 'D' and
    AA.div in ('M','S')

if @@error  <>  0
  Begin
  Return
  End

-- 진천서버
-- 1. Chgcd in ('A','R','D')
Delete  [ipisjin_svr].ipis.dbo.tmstmodel
  From  [ipisjin_svr].ipis.dbo.tmstmodel  a,
    #tmp_pdinv101       b
  Where a.AreaCode  = b.xplant  and
    a.DivisionCode  = b.Div   and
    a.ItemCode  = b.Itno and
    b.xplant = 'J'

if @@error  <>  0
  Begin
  Return
  End

Delete  [ipisjin_svr].ipis.dbo.tmstitemcost
  From  [ipisjin_svr].ipis.dbo.tmstitemcost a,
    #tmp_pdinv101       b
  Where a.AreaCode  = b.xplant  and
    a.DivisionCode  = b.Div   and
    a.ItemCode  = b.Itno and
    b.xplant = 'J'

if @@error  <>  0
  Begin
  Return
  End

-- 2. Chgcd in ('A','R')
INSERT INTO [ipisjin_svr].ipis.dbo.tmstmodel
  (AreaCode,  DivisionCode, ProductGroup,ModelGroup,ProductCode,ItemCode,
  ItemClass,  ItemBuySource,  ItemUnit,ConvertFactor, AverageUnitCost,AbcCode,
  Location, Planner,  LastEmp)
SELECT AA.xplant, AA.div, substring(AA.pdcd, 1, 2),
  case len(substring(AA.pdcd, 1, 3))
  when 2 then rtrim(substring(AA.pdcd, 1, 3)) + '9'
  else substring(AA.pdcd, 1, 3) end,  AA.pdcd,
  AA.itno,  AA.cls, AA.srce, AA.xunit, AA.convqty, AA.saud, AA.abccd,
  AA.wloc,  AA.xplan, 'SYSTEM'
FROM #tmp_pdinv101 AA
WHERE AA.Chgcd in ('A','R') and AA.xplant = 'J'

if @@error  <>  0
  Begin
  Return
  End

INSERT INTO [ipisjin_svr].ipis.dbo.tmstitemcost
  (AreaCode,  DivisionCode, ItemCode,
  ItemClass,  ItemBuySource,  ItemUnit, UnitCost, LastEmp)
SELECT AA.xplant, AA.div, AA.itno,
  AA.cls, AA.srce, AA.xunit, AA.saud, 'SYSTEM'
FROM #tmp_pdinv101 AA
WHERE AA.Chgcd in ('A','R') and AA.xplant = 'J'

if @@error  <>  0
  Begin
  Return
  End

-- EIS 서버
-- 1. Chgcd in ('A','R','D')
Delete  [ipisele_svr\ipis].eis.dbo.tmstmodel
  From  [ipisele_svr\ipis].eis.dbo.tmstmodel  a,
    #tmp_pdinv101       b
  Where a.AreaCode  = b.xplant  and
    a.DivisionCode  = b.Div   and
    a.ItemCode  = b.Itno

if @@error  <>  0
  Begin
  Return
  End

-- 2. Chgcd in ('A','R')
INSERT INTO [ipisele_svr\ipis].eis.dbo.tmstmodel
  (AreaCode,  DivisionCode, ProductGroup,ModelGroup,ProductCode,ItemCode,
  ItemClass,  ItemBuySource,  ItemUnit,ConvertFactor, AverageUnitCost,AbcCode,
  Location, Planner,  LastEmp)
SELECT AA.xplant, AA.div, substring(AA.pdcd, 1, 2),
  case len(substring(AA.pdcd, 1, 3))
  when 2 then rtrim(substring(AA.pdcd, 1, 3)) + '9'
  else substring(AA.pdcd, 1, 3) end,  AA.pdcd,
  AA.itno,  AA.cls, AA.srce, AA.xunit, AA.convqty, AA.saud, AA.abccd,
  AA.wloc,  AA.xplan, 'SYSTEM'
FROM #tmp_pdinv101 AA
WHERE AA.Chgcd in ('A','R')

if @@error  <>  0
  Begin
  Return
  End

-- pdinv101_log
Delete  pdinv101_log
  From  pdinv101_log  a,
    #tmp_pdinv101     b
  Where a.xplant = b.xplant and
		   a.div = b.div and
		   a.itno = b.itno

if (select count(*) from pdinv101_log) = 0
  begin
    truncate table pdinv101_log
  end

Drop table #tmp_pdinv101

End		-- Procedure End



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

