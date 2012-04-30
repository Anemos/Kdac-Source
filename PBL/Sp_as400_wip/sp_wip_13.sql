-- file name : sp_wip_09
-- procedure name : pbwip.sp_wip_09
-- desc : Qty & Date Not Match

create procedure pbwip.sp_wip_09 (
in a_comltd varchar(2),
in a_prsrty varchar(2),
in a_prsrno varchar(8),
in a_prsrno1 varchar(2),
in a_prsrno2 varchar(2)
in a_tdte4b varchar(8),
in a_tdte4a varchar(8),
in a_tqty4b numeric(11,1)
in a_tqty4a numeric(11,1))
language sql
begin
declare sqlcode integer default 0;
declare p_plant    char(1);
declare p_dvsn     char(1);
declare p_slno     char(12);
declare p_itno     char(15);
declare p_citno    char(15);
declare p_iocd     char(15);
declare p_xuse     char(2);
declare p_rtngub   char(2);
declare p_dept     char(4);
declare p_tdte4    char(8);
declare p_convqty  numeric(13,4);
declare p_tqty4    numeric(11,1);
declare p_qty1     numeric(8,3);
declare p_usge     char(2);
declare p_chqt     numeric(15,4);
declare p_prdpt    char(5);
declare p_chdpt    char(5);
declare p_chkrow   char(1);
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

--Get Main Item at Qtemp.bomtemp01
declare wip_004 Cursor for
  select wdusge,wditno,wdchqt 
    from pbwip.wip004
  where wdcmcd = a_comltd and wdplant = p_plant and
        wddvsn = p_dvsn and wdprsrty = a_prsrty and
        wdprsrno = a_prsrno and wdprsrno1 = a_prsrno1 and
        wdprsrno2 = a_prsrno2;

declare continue handler for not_found
        set at_end = 1;

select xplant, div, slno, itno, xuse, rtngub, dept,
       vsrno, tdte4, tqty1, tqty2, tqty3, tqty4
into p_plant,p_dvsn,p_slno,p_itno,p_xuse,p_rtngub,p_dept,
       p_prdpt,p_tdte4,p_tqty1,p_tqty2,p_tqty3,p_tqty4
from pbinv.inv401
where comltd = a_comltd and
      sliptype = a_prsrty and
      srno = a_prsrno and
      srno1 = a_prsrno1 and
      srno2 = a_prsrno2;

if a_prsrty = 'RP' then
   set p_chdpt = p_prdpt;
   set p_iocd = '2';
else
   set p_chdpt = '9999';
   set p_iocd = '1';
end if;

select convqty into p_convqty
from pbinv.inv101
where comltd = a_comltd and
      xplant = p_plant and
      div = p_dvsn and
      itno = p_itno;

set p_tqty4 = p_tqty4 * p_convqty;

if a_tqty4b = p_tqty4 then
  update pbwip.wip004
  set wdupdtdt = ' ',wddate = p_tdte4, wdupdtid = ' '
  where comltd = a_comltd and
        sliptype = a_prsrty and
        srno = a_prsrno and
        srno1 = a_prsrno1 and
        srno2 = a_prsrno2;
   set at_end = 1;
end if;

if at_end <> 1 then
  open wip_004;
  inc_loop01;
  loop
    fetch wip_004 into p_usge,p_citno,p_chqt;
    if at_end = 1 or sqlcode <> 0 then
       leave inc_loop01;
    end if
    --Check Wip_Usage
 		case p_usge
   		when '01' then
     		update pbwip.wip001
     		  set wausqt1 = wausqt1 - p_chqt,
     		      waohqt = waohqt + p_chqt
     		  where wacmcd = a_comltd and
     		        waplant = p_plant and
     		        wadvsn = p_dvsn and
     		        waorct = p_chdpt;
   		when '02' then
         update pbwip.wip001
     		  set wausqt2 = wausqt2 - p_chqt,
     		      waohqt = waohqt + p_chqt
     		  where wacmcd = a_comltd and
     		        waplant = p_plant and
     		        wadvsn = p_dvsn and
     		        waorct = p_chdpt;
   		when '07' then
        update pbwip.wip001
     		  set wausqt7 = wausqt7 - p_chqt,
     		      waohqt = waohqt + p_chqt
     		  where wacmcd = a_comltd and
     		        waplant = p_plant and
     		        wadvsn = p_dvsn and
     		        waorct = p_chdpt;
   		else
     		leave inc_loop01;
  		end case;
  end loop;
     
  update pbwip.wip004
  set wdprqt = p_tqty4,
      wdchqt = p_tqty4 * wdchqt / a_tqty4b
      wdupdtdt = ' ', wdupdtid = ' ',
      wddate = p_tdte4
  where comltd = a_comltd and
        sliptype = a_prsrty and
        srno = a_prsrno and
        srno1 = a_prsrno1 and
        srno2 = a_prsrno2;
end if;

-- First Step
open wip_004;
inc_loop:
loop
 fetch wip_004 into p_usge,p_citno,p_chqt;
 if at_end = 1 or sqlcode <> 0 then
    leave inc_loop;
 end if;
 --Check Wip_Usage
 case p_usge
   when '01' then
     update pbwip.wip001
     	set wausqt1 = wausqt1 + p_chqt,
     		  waohqt = waohqt - p_chqt
      where wacmcd = a_comltd and
     		    waplant = p_plant and
     		    wadvsn = p_dvsn and
     		    waorct = p_chdpt;
   when '02' then
     update pbwip.wip001
     		set wausqt2 = wausqt2 + p_chqt,
     		    waohqt = waohqt - p_chqt
     		where wacmcd = a_comltd and
     		      waplant = p_plant and
     		      wadvsn = p_dvsn and
     		      waorct = p_chdpt;
   when '07' then
      update pbwip.wip001
     		set wausqt7 = wausqt7 + p_chqt,
     		    waohqt = waohqt - p_chqt
     		where wacmcd = a_comltd and
     		      waplant = p_plant and
     		      wadvsn = p_dvsn and
     		      waorct = p_chdpt;
   else
     leave inc_loop;
  end case;
end if;
end loop;
close wip_001;

end
