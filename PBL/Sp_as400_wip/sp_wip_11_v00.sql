-- file name : sp_wip_11
-- procedure name : pbwip.sp_wip_11
-- desc : WIP002 Vendor WIP Update

create procedure pbwip.sp_wip_11 (
in a_comltd varchar(2),
in a_prsrty varchar(2),
in a_prsrno varchar(8),
in a_prsrno1 varchar(2),
in a_prsrno2 varchar(2),
in a_ipaddr varchar(30),
in a_macaddr varchar(30),
in a_inptid varchar(6),
in a_inptdt varchar(8),
in a_inpttm varchar(6),
in a_adjdt varchar(6),
in a_nextdt varchar(6))
language sql
begin
declare sqlcode integer default 0;
declare p_plant    char(1);
declare p_dvsn     char(1);
declare p_slno     char(12);
declare p_itno     char(15);
declare p_pitno    char(15);
declare p_citno    char(15);
declare p_iocd     char(15);
declare p_xuse     char(2);
declare p_rtngub   char(2);
declare p_dept     char(4);
declare p_tdte4    char(8);
declare p_convqty  numeric(13,4);
declare p_tqty     numeric(11,1);
declare p_tqty4    numeric(11,1);
declare p_qty1     numeric(8,3);
declare p_usge     char(2);
declare p_diffqt   numeric(15,4);
declare p_chqt     numeric(15,4);
declare p_prdpt    char(5);
declare p_chdpt    char(5);
declare p_wkct     char(4);
declare p_rtn      char(1);
declare p_opcd     char(1);
declare p_serl     char(600);
declare p_cls     char(2);
declare p_chkrtn   numeric(15,4);
declare p_chkcnt   integer;
declare p_continue char(1);
declare p_count    integer;
declare at_end integer default 0;
declare not_found condition for '02000';

--Return Result Set
declare wipsel_cur cursor for
select ifnull(count(*),0)
from pbwip.wip004
where wdcmcd = a_comltd and
      wdplant = p_plant and
      wddvsn = p_dvsn and
      wdprsrty = a_prsrty and
      wdprsrno = a_prsrno and
      wdprsrno1 = a_prsrno1 and
      wdprsrno2 = a_prsrno2;

--Get Option Item at Qtemp.bomtemp01
declare bom_temp cursor for
  select bb.tcitn,bb.tqty1,bb.twkct
  from pbinv.inv101 aa,
       (select tcmcd,tplnt,tdvsn,tpitn,tcitn,tqty1,twkct
                 from pbwip.wip001, qtemp.bomtemp01
                 where tcmcd = wacmcd and tplnt = waplant and
                       tdvsn = wadvsn and tcitn = waitno and
                       tcmcd = a_comltd and tplnt = p_plant and
                       tdvsn = p_dvsn and toption = p_citno and
                       tpitn = p_pitno and topcd = '2' and
                       twkct <> '8888' and
                       waiocd = '2' and waohqt > 0) bb
  where bb.tplnt = aa.xplant and bb.tcmcd = aa.comltd and
         bb.tdvsn = aa.div and bb.tcitn = aa.itno and
         ( aa.cls = '10' or aa.cls = '40' or aa.cls = '50');

--Get Main Item at Qtemp.bomtemp01
declare wip_001 Cursor for
        select topcd,tpitn,tcitn,tqty1,twkct,tserl
        from qtemp.bomtemp01,pbinv.inv101
        where tcmcd = a_comltd and tplnt = p_plant and
              tdvsn = p_dvsn and
              tcmcd = comltd and tplnt = xplant and
              tdvsn = div and tcitn = itno and
              ( cls = '10' or cls = '40' or cls = '50') and
              topcd <> '2' and twkct <> '8888'
        order by tserl;

declare continue handler for not_found
        set at_end = 1;

select xplant, div, slno, itno, xuse, rtngub, dept,
       vsrno, tdte4, tqty4, cls
into p_plant,p_dvsn,p_slno,p_itno,p_xuse,p_rtngub,p_dept,
       p_prdpt,p_tdte4,p_tqty4,p_cls
from pbinv.inv401
where comltd = a_comltd and
      sliptype = a_prsrty and
      srno = a_prsrno and
      srno1 = a_prsrno1 and
      srno2 = a_prsrno2;

if p_cls = '50' and p_dvsn <> 'A' then
        set p_chdpt = p_prdpt;
        set p_prdpt = '9999';
        set p_iocd = '2';
else
  set p_chdpt = p_prdpt;
  set p_prdpt = ' ';
  set p_iocd = '2';
end if;

select convqty into p_convqty
from pbinv.inv101
where comltd = a_comltd and
      xplant = p_plant and
      div = p_dvsn and
      itno = p_itno;

set p_tqty = p_tqty4 * p_convqty;
set p_rtn = pbwip.sf_wip_bom(a_comltd,p_plant,p_dvsn,
            p_itno,p_tdte4,'I');
if p_rtn <> 'Y' or a_prsrty <> 'RP' then
   set at_end = 1;
end if;
-- First Step
open wip_001;
inc_loop:
loop
 fetch wip_001 into p_opcd,p_pitno,p_citno,p_qty1,
                    p_wkct,p_serl;
 if at_end = 1 or sqlcode <> 0 then
    leave inc_loop;
 end if;
 if p_opcd <> '1' then
-- This item is not option
  set p_continue = 'N';
  set p_chqt = p_tqty * p_qty1;
  set p_chkrtn = pbwip.sf_wip_003(a_comltd,a_prsrty,
      a_prsrno,a_prsrno1,a_prsrno2,p_iocd,p_plant,
      p_dvsn,p_itno,p_citno,p_slno,p_xuse,p_rtngub,
      p_prdpt,p_chdpt,p_tqty4,p_chqt,p_tdte4,
      p_opcd,p_continue,a_ipaddr,a_macaddr,a_inptid,
      a_inptdt,a_inpttm,a_adjdt,a_nextdt);
  if p_chkrtn = -999999 then
     leave inc_loop;
  end if;
 else
  set p_continue = 'N';
  set p_chqt = p_tqty * p_qty1;
  set p_chkrtn = pbwip.sf_wip_003(a_comltd,a_prsrty,
      a_prsrno,a_prsrno1,a_prsrno2,p_iocd,p_plant,
      p_dvsn,p_itno,p_citno,p_slno,p_xuse,p_rtngub,
      p_prdpt,p_chdpt,p_tqty4,p_chqt,p_tdte4,
      p_opcd,p_continue,a_ipaddr,a_macaddr,a_inptid,
      a_inptdt,a_inpttm,a_adjdt,a_nextdt);
  if p_chkrtn = -999999 then
     leave inc_loop;
  end if;
end if;
end loop;
close wip_001;

end
