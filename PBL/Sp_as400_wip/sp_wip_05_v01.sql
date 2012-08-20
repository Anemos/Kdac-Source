-- file name : sp_wip_05
-- procedure name : pbwip.sp_wip_05
-- desc : WIP History Deploy Check ( include iocd = 03 )

--drop procedure pbwip.sp_wip_05;

create procedure pbwip.sp_wip_05 (
in a_comltd varchar(2),
in a_plant varchar(1),
in a_dvsn varchar(1),
in a_date varchar(6))
language sql
begin
declare sqlcode integer default 0;
declare p_plant    char(1);
declare p_dvsn     char(1);
declare p_pitno    char(15);
declare p_srty     char(2);
declare p_srno     char(8);
declare p_srno1    char(2);
declare p_srno2    char(2);
declare p_adjdt    char(8);
declare p_chkitno  char(15);
declare p_chkdate  char(8);
declare p_selcnt   numeric(5,0);
declare p_selcnt2  numeric(5,0);
declare p_calcnt   numeric(5,0);
declare p_calcnt2  numeric(5,0);
declare p_rtn      char(1);
declare p_chkcnt   integer;
declare at_end integer default 0;
declare not_found condition for '02000';

--Return Result set
declare wipsel_cur cursor for
select tcmcd,tprsrty,tprsrno,tprsrno1,tprsrno2,tplant,
       tdvsn,tprno,tselcnt,tcalcnt,tdate
from qtemp.wiptemp02;

declare wipchk_cur cursor for
  select wdplant,wddvsn,wdprsrty,wdprsrno,wdprsrno1,
        wdprsrno2, wdprno, wddate, count(wditno)
  from pbwip.wip004
  where wdcmcd = a_comltd and wdplant = a_plant and
        wddvsn = a_dvsn and
        wdslty = 'WC' and
        substr(wddate,1,6) = a_date and
        wdupdtid <> 'Y'
  group by wdplant,wddvsn,wdprsrty,wdprsrno,
           wdprsrno1,wdprsrno2,wdprno,wddate
  order by wddate,wdprno;

declare continue handler for not_found
        set at_end = 1;
declare continue handler for sqlstate '42704'
-- create qtemp.wiptemp02
 create table qtemp.wiptemp02 (tcmcd char(2) not null,
 tprsrty char(2) not null, tprsrno char(8) not null,
 tprsrno1 char(2) not null, tprsrno2 char(2) not null,
 tplant char(1) not null, tdvsn char(1) not null,
 tprno char(15) not null, tdate char(8) not null,
 tselcnt numeric(5,0) not null,
 tcalcnt numeric(5,0) not null);

delete from qtemp.wiptemp02;
set p_chkitno = ' ';
set p_chkdate = ' ';

open wipchk_cur;
fetch wipchk_cur into p_plant,p_dvsn,p_srty,p_srno,
      p_srno1,p_srno2,p_pitno,p_adjdt,p_selcnt;

while at_end = 0 do
 if p_chkitno <> p_pitno or p_chkdate <> p_adjdt then
   if p_srty = 'RP' or p_srty = 'SS' then
     select count(*) into p_selcnt
     from pbwip.wip004
     where wdcmcd = a_comltd and wdprsrty = p_srty and
      wdprsrno = p_srno and wdprsrno1 = p_srno1 and
      wdprsrno2 = p_srno2 and wddate = p_adjdt and
      wdiocd = '2';

     select count(*) into p_selcnt2
     from pbwip.wip004
     where wdcmcd = a_comltd and wdprsrty = p_srty and
      wdprsrno = p_srno and wdprsrno1 = p_srno1 and
      wdprsrno2 = p_srno2 and wddate = p_adjdt and
      wdiocd = '3';

     set p_rtn = pbwip.sf_wip_bom(a_comltd,p_plant,p_dvsn,
                p_pitno,p_adjdt,'I');
   else
     set p_rtn = pbwip.sf_wip_bom(a_comltd,p_plant,p_dvsn,
                p_pitno,p_adjdt,'G');
   end if;
   set p_chkitno = p_pitno;
   set p_chkdate = p_adjdt;
 end if;
 if p_rtn = 'Y' then
    if p_srty = 'RP' or p_srty = 'SS' then
       select ifnull(count(*),0) into p_calcnt
       from qtemp.bomtemp01,pbinv.inv101
        where tcmcd = a_comltd and tplnt = p_plant and
                tdvsn = p_dvsn and
                tcmcd = comltd and tplnt = xplant and
                tdvsn = div and tcitn = itno and
                ( cls = '10' or cls = '40' or cls = '50') and
                topcd <> '2'  and twkct = '9999';
      select ifnull(count(*),0) into p_calcnt2
       from qtemp.bomtemp01,pbinv.inv101
        where tcmcd = a_comltd and tplnt = p_plant and
                tdvsn = p_dvsn and
                tcmcd = comltd and tplnt = xplant and
                tdvsn = div and tcitn = itno and
                ( cls = '10' or cls = '40' or cls = '50') and
                topcd <> '2'  and twkct = '8888';
    else
        select ifnull(count(*),0) into p_calcnt
        from qtemp.bomtemp01,pbinv.inv101
        where tcmcd = a_comltd and tplnt = p_plant and
                tdvsn = p_dvsn and
                tcmcd = comltd and tplnt = xplant and
                tdvsn = div and tcitn = itno and
                ( cls = '10' or cls = '40' or cls = '50') and
                srce <> '03' and topcd <> '2' and  twkct <> '8888';
    end if;
 else
        set p_calcnt = 0;
 end if;
 if p_selcnt < p_calcnt or p_selcnt2 < p_calcnt2 then
    insert into qtemp.wiptemp02(tcmcd,tprsrty,tprsrno,
       tprsrno1,tprsrno2,tplant,tdvsn,tprno,tdate,
       tselcnt,tcalcnt)
    values(a_comltd,p_srty,p_srno,p_srno1,p_srno2,
       p_plant,p_dvsn,p_pitno,p_adjdt,p_selcnt,p_calcnt);
 else
    update pbwip.wip004
    set wdupdtid = 'Y'
    where wdcmcd = a_comltd and wdprsrty = p_srty and
         wdprsrno = p_srno and wdprsrno1 = p_srno1 and
         wdprsrno2 = p_srno2;
 end if;
 fetch wipchk_cur into p_plant,p_dvsn,p_srty,p_srno,
      p_srno1,p_srno2,p_pitno,p_adjdt,p_selcnt;
end while;
close wipchk_cur;

end
