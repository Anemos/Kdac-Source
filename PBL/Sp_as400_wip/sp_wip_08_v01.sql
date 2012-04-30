-- file name : sp_wip_08
-- procedure name : pbwip.sp_wip_08
-- desc : WIP004 USQT DELETE (ADD IOCD = 3)

create procedure pbwip.sp_wip_08 (
in a_comltd varchar(2),
in a_prsrty varchar(2),
in a_prsrno varchar(8),
in a_prsrno1 varchar(2),
in a_prsrno2 varchar(2))
language sql
begin
declare sqlcode integer default 0;
declare p_slty     char(2);
declare p_srno     char(10);
declare p_plant    char(1);
declare p_dvsn     char(1);
declare p_itno     char(15);
declare p_usge     char(2);
declare p_iocd     char(1);
declare p_chdpt    char(5);
declare p_chqt     numeric(15,4);
declare p_count    integer;
declare at_end integer default 0;
declare not_found condition for '02000';

--Return Result Set
declare wipsel_cur cursor for
select count(*)
from pbwip.wip004
where wdcmcd = a_comltd and
      wdplant = p_plant and
      wddvsn = p_dvsn and
      wdprsrty = a_prsrty and
      wdprsrno = a_prsrno and
      wdprsrno1 = a_prsrno1 and
      wdprsrno2 = a_prsrno2;

--Get Main Item at WIP004
declare wip_004 Cursor for
  select wdslty,wdsrno,wdplant,wddvsn,wditno,
         wdiocd,wdchdpt,wdusge,wdchqt
  from pbwip.wip004
  where wdcmcd = a_comltd and
        wdprsrty = a_prsrty and
        wdprsrno = a_prsrno and
        wdprsrno1 = a_prsrno1 and
        wdprsrno2 = a_prsrno2;

declare continue handler for not_found
        set at_end = 1;

-- First Step
open wip_004;
inc_loop:
loop
 fetch wip_004 into p_slty,p_srno,p_plant,p_dvsn,p_itno,
               p_iocd,p_chdpt,p_usge,p_chqt;
 if at_end = 1 or sqlcode <> 0 then
    leave inc_loop;
 end if;

 case p_usge
 when '01' then
   update pbwip.wip001
     set wausqt1 = wausqt1 - p_chqt
     where wacmcd = a_comltd and waplant = p_plant and
          wadvsn = p_dvsn and waitno = p_itno and
          waorct = p_chdpt and waiocd = p_iocd;
 when '02' then
   update pbwip.wip001
     set wausqt2 = wausqt2 - p_chqt
     where wacmcd = a_comltd and waplant = p_plant and
          wadvsn = p_dvsn and waitno = p_itno and
          waorct = p_chdpt and waiocd = p_iocd;
 when '03' then
   update pbwip.wip001
     set wausqt3 = wausqt3 - p_chqt
     where wacmcd = a_comltd and waplant = p_plant and
          wadvsn = p_dvsn and waitno = p_itno and
          waorct = p_chdpt and waiocd = p_iocd;
 when '07' then
   update pbwip.wip001
     set wausqt7 = wausqt7 - p_chqt
     where wacmcd = a_comltd and waplant = p_plant and
          wadvsn = p_dvsn and waitno = p_itno and
          waorct = p_chdpt and waiocd = p_iocd;
 else
   leave inc_loop;
 end case;
 update pbwip.wip001
     set waohqt = waohqt + p_chqt
     where wacmcd = a_comltd and waplant = p_plant and
          wadvsn = p_dvsn and waitno = p_itno and
          waorct = p_chdpt and waiocd = p_iocd;
 delete from pbwip.wip004
   where wdcmcd = a_comltd and wdslty = p_slty and
         wdsrno = p_srno;
end loop;
close wip_004;

end

