-- file name : sp_wip_14
-- procedure name : pbwip.sp_wip_14
-- desc : wip input qty, amount

drop procedure pbwip.sp_wip_14;
create procedure pbwip.sp_wip_14 (
in a_comltd varchar(2),
in a_prsrty varchar(2),
in a_prsrno varchar(8),
in a_prsrno1 varchar(2),
in a_prsrno2 varchar(2),
in a_ipaddr varchar(30),
in a_macaddr varchar(30),
in a_inptid varchar(6),
in a_inptdt varchar(8))
language sql
begin
declare sqlcode integer default 0;
declare p_plant    char(1);
declare p_dvsn     char(1);
declare p_slno     char(12);
declare p_itno     char(15);
declare p_iocd     char(1);
declare p_xuse     char(2);
declare p_rtngub   char(2);
declare p_dept     char(4);
declare p_wkct     char(5);
declare p_tdte4    char(8);
declare p_cls      char(2);
declare p_srce     char(2);
declare p_convqty  numeric(13,4);
declare p_tqty4    numeric(11,1);
declare p_chqt     numeric(15,4);
declare p_tramt    numeric(13,0);
declare p_prdpt    char(5);
declare p_chdpt    char(5);
declare p_chkitno  char(15);
declare at_end integer default 0;
declare not_found condition for '02000';

declare wipchk_cur cursor for
select waitno
from pbwip.wip001
where wacmcd = a_comltd and waplant = p_plant and
      wadvsn = p_dvsn and waitno = p_itno and
      waorct = p_wkct;

declare continue handler for not_found
 insert into pbwip.wip001(wacmcd,waplant,wadvsn,waorct,
  waitno,waiocd,waavrg1,waavrg2,wabgqt,wabgat1,wabgat2,
  wainqt,wainat1,wainat2,wainat3,wainat4,wausqt1,wausat1,
  wausqt2,wausat2,wausqt3,wausat3,wausqt4,wausat4,
  wausqt5,wausat5,wausqt6,wausat6,wausqt7,wausat7,
  wausqt8,wausat8,wausat9,waohqt,waohat1,waohat2,wascrp,
  waretn,waplan,waipaddr,wamacaddr,wainptdt,waupdtdt)
  values (a_comltd,p_plant,p_dvsn,p_wkct,p_itno,
  p_iocd,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,' ',
  a_ipaddr,a_macaddr,a_inptdt,' ');

-- First Step
select xplant, div, slno, itno, xuse, rtngub, dept,
       vsrno, tdte4,tqty4,tramt
into p_plant,p_dvsn,p_slno,p_itno,p_xuse,p_rtngub,p_dept,
       p_prdpt,p_tdte4,p_tqty4,p_tramt
from pbinv.inv401
where comltd = a_comltd and
      sliptype = a_prsrty and
      srno = a_prsrno and
      srno1 = a_prsrno1 and
      srno2 = a_prsrno2;

-- get Conversion Vector
select convqty,cls,srce into p_convqty,p_cls,p_srce
from pbinv.inv101
where comltd = a_comltd and xplant = p_plant and
      div = p_dvsn and itno = p_itno;

case
  when a_prsrty = 'IS' or a_prsrty = 'IP' then
   case
    when p_xuse = '01' or p_xuse = '02' then
      set p_wkct = '9999';
      set p_iocd = '1';
      open wipchk_cur;
      fetch wipchk_cur into p_chkitno;
      close wipchk_cur;
      update pbwip.wip001
        set wainqt = wainqt + (p_tqty4 * p_convqty),
            wainat1 = wainat1 + p_tramt,
            waohqt = (wabgqt + wainqt + (p_tqty4 * p_convqty) - (wausqt1 +
              wausqt2 + wausqt3 + wausqt4 + wausqt5 + wausqt6 + wausqt7 +
              wausqt8 )),
            waohat1 = waohat1 + p_tramt
        where wacmcd = a_comltd and waplant = p_plant and
              wadvsn = p_dvsn and waitno = p_itno and
              waorct = p_wkct;
    when p_xuse = '03' or p_xuse = '05' then
      set p_wkct = '9999';
      set p_iocd = '1';
      open wipchk_cur;
      fetch wipchk_cur into p_chkitno;
      close wipchk_cur;
      update pbwip.wip001
        set wainqt = wainqt + (p_tqty4 * p_convqty),
            wainat1 = wainat1 + p_tramt,
            waohqt = (wabgqt + wainqt + (p_tqty4 * p_convqty) - (wausqt1 +
              wausqt2 + wausqt3 + wausqt4 + wausqt5 + wausqt6 + wausqt7 +
              wausqt8 )),
            waohat1 = waohat1 + p_tramt
        where wacmcd = a_comltd and waplant = p_plant and
              wadvsn = p_dvsn and waitno = p_itno and
              waorct = p_wkct;
    when p_xuse = '04' then
      set p_wkct = p_prdpt;
      set p_iocd = '2';
      open wipchk_cur;
      fetch wipchk_cur into p_chkitno;
      close wipchk_cur;
      update pbwip.wip001
        set wainqt = wainqt + (p_tqty4 * p_convqty),
            wainat1 = wainat1 + p_tramt,
            waohqt = (wabgqt + wainqt + (p_tqty4 * p_convqty) - (wausqt1 +
              wausqt2 + wausqt3 + wausqt4 + wausqt5 + wausqt6 + wausqt7 +
              wausqt8 )),
            waohat1 = waohat1 + p_tramt
        where wacmcd = a_comltd and waplant = p_plant and
              wadvsn = p_dvsn and waitno = p_itno and
              waorct = p_wkct;
    when p_xuse = '07' then
      set p_wkct = p_prdpt;
      set p_iocd = '2';
      open wipchk_cur;
      fetch wipchk_cur into p_chkitno;
      close wipchk_cur;
      update pbwip.wip001
        set wainqt = wainqt + (p_tqty4 * p_convqty),
            wainat1 = wainat1 + p_tramt,
            wausqt3 = wausqt3 + (p_tqty4 * p_convqty),
            wausat3 = wausat3 + p_tramt
        where wacmcd = a_comltd and waplant = p_plant and
              wadvsn = p_dvsn and waitno = p_itno and
              waorct = p_wkct;
   end case;
  when a_prsrty = 'RS' then
   if p_xuse = '04' then
     if p_rtngub = '02' then
       set p_wkct = p_prdpt;
       set p_iocd = '2';
       open wipchk_cur;
       fetch wipchk_cur into p_chkitno;
       close wipchk_cur;
       update pbwip.wip001
        set wausqt7 = wausqt7 + (p_tqty4 * p_convqty),
            waohqt = (wabgqt + wainqt - (wausqt1 + wausqt2 + wausqt3
            + wausqt4 + wausqt5 + wausqt6 + wausqt7 + (p_tqty4 * p_convqty)
            + wausqt8 )),
        where wacmcd = a_comltd and waplant = p_plant and
              wadvsn = p_dvsn and waitno = p_itno and
              waorct = p_wkct;
     else
       set p_wkct = p_prdpt;
       set p_iocd = '2';
       open wipchk_cur;
       fetch wipchk_cur into p_chkitno;
       close wipchk_cur;
       update pbwip.wip001
        set wainqt = wainqt - (p_tqty4 * p_convqty),
            wainat1 = wainat1 - p_tramt,
            waohqt = waohqt - (p_tqty4 * p_convqty),
            waohqt = (wabgqt + wainqt - (p_tqty4 * p_convqty) - (wausqt1
              + wausqt2 + wausqt3 + wausqt4 + wausqt5 + wausqt6 + wausqt7
              + wausqt8 )),
            waohat1 = waohat1 - p_tramt
        where wacmcd = a_comltd and waplant = p_plant and
              wadvsn = p_dvsn and waitno = p_itno and
              waorct = p_wkct;
     end if;
   elseif p_xuse = '03' or p_xuse = '05' then
     set p_wkct = '9999';
     set p_iocd = '1';
     open wipchk_cur;
     fetch wipchk_cur into p_chkitno;
     close wipchk_cur;
     update pbwip.wip001
        set wainqt = wainqt - (p_tqty4 * p_convqty),
            wainat1 = wainat1 - p_tramt,
            waohqt = (wabgqt + wainqt - (p_tqty4 * p_convqty) - (wausqt1
              + wausqt2 + wausqt3 + wausqt4 + wausqt5 + wausqt6
              + wausqt7 + wausqt8 )),
            waohat1 = waohat1 - p_tramt
        where wacmcd = a_comltd and waplant = p_plant and
              wadvsn = p_dvsn and waitno = p_itno and
              waorct = p_wkct;
   elseif p_xuse = '01' or p_xuse = '02' then
     if p_rtngub = '02' then
        set p_wkct = '9999';
        set p_iocd = '1';
        open wipchk_cur;
        fetch wipchk_cur into p_chkitno;
        close wipchk_cur;
        update pbwip.wip001
          set wausqt7 = wausqt7 + (p_tqty4 * p_convqty),
              waohqt = (wabgqt + wainqt - (wausqt1 + wausqt2 + wausqt3
              + wausqt4 + wausqt5 + wausqt6 + wausqt7
              + (p_tqty4 * p_convqty) + wausqt8 ))
          where wacmcd = a_comltd and waplant = p_plant and
                wadvsn = p_dvsn and waitno = p_itno and
                waorct = p_wkct;
     else
        set p_wkct = '9999';
        set p_iocd = '1';
        open wipchk_cur;
        fetch wipchk_cur into p_chkitno;
        close wipchk_cur;
        update pbwip.wip001
          set wainqt = wainqt - (p_tqty4 * p_convqty),
              wainat1 = wainat1 - p_tramt,
              waohqt = (wabgqt + wainqt - (p_tqty4 * p_convqty) - (wausqt1
              + wausqt2 + wausqt3 + wausqt4 + wausqt5 + wausqt6
              + wausqt7 + wausqt8 )),
              waohat1 = waohat1 - p_tramt
          where wacmcd = a_comltd and waplant = p_plant and
                wadvsn = p_dvsn and waitno = p_itno and
                waorct = p_wkct;
     end if;
   end if;
  when a_prsrty = 'SA' then
    set p_wkct = '9999';
    set p_iocd = '1';
    open wipchk_cur;
    fetch wipchk_cur into p_chkitno;
    close wipchk_cur;
    update pbwip.wip001
      set wainqt = wainqt + (p_tqty4 * p_convqty),
          wainat1 = wainat1 + p_tramt,
          wausqt4 = wausqt4 + (p_tqty4 * p_convqty),
          wausat4 = wausat4 + p_tramt
    where wacmcd = a_comltd and waplant = p_plant and
          wadvsn = p_dvsn and waitno = p_itno and
          waorct = p_wkct;
  when a_prsrty = 'SR' then
    set p_wkct = '9999';
    set p_iocd = '1';
    open wipchk_cur;
    fetch wipchk_cur into p_chkitno;
    close wipchk_cur;
    update pbwip.wip001
      set wainqt = wainqt - (p_tqty4 * p_convqty),
          wainat1 = wainat1 - p_tramt,
          wausqt4 = wausqt4 - (p_tqty4 * p_convqty),
          wausat4 = wausat4 - p_tramt
    where wacmcd = a_comltd and waplant = p_plant and
          wadvsn = p_dvsn and waitno = p_itno and
          waorct = p_wkct;
  when a_prsrty = 'RP' then
    if (p_plant = 'D' and ( p_dvsn = 'A' or p_dvsn = 'V' )) then
      set p_wkct = '9999';
    else
      if p_cls = '50' and p_srce = '04' then
        set p_wkct = '9999';
        set p_iocd = '1';
        open wipchk_cur;
          fetch wipchk_cur into p_chkitno;
        close wipchk_cur;
        update pbwip.wip001
          set wainqt = wainqt + (p_tqty4 * p_convqty),
              waohqt = (wabgqt + wainqt + (p_tqty4 * p_convqty) - (wausqt1
              + wausqt2 + wausqt3 + wausqt4 + wausqt5 + wausqt6
              + wausqt7 + wausqt8 ))
        where wacmcd = a_comltd and waplant = p_plant and
            wadvsn = p_dvsn and waitno = p_itno and
            waorct = p_wkct;
      end if;
    end if;
end case;
end
