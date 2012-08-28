-- file name : sf_bom_106
-- procedure name : pbpdm.sf_bom_106
-- desc : 가공관리비 가져오기
-- a_itno, a_rtn

drop function pbpdm.sf_bom_106;
create function pbpdm.sf_bom_106 (
a_itno varchar(15))
returns numeric(15,6)
language sql
modifies sql data
begin
declare sqlcode integer default 0;
declare p_ygcst numeric(15,6);
declare at_end integer default 0;
declare not_found condition for '02000';

declare continue handler for not_found
        set at_end = 1;

select decimal(
      (select coalesce(sum(a.gcost + a.mcost),0)
     from pbpur.pur103a a  inner join pbpur.pur103 b
      on a.comltd = b.comltd and a.dept = b.dept and
        a.vsrno = b.vsrno and a.itno = b.itno
        where a.comltd = '01' and  a.itno = a_itno
        and  b.xstop = 'O' and  a.gcost <> 0)
      / case when
          (select count(*)
      from pbpur.pur103a a inner join pbpur.pur103 b
        on a.comltd = b.comltd and a.dept = b.dept and
          a.vsrno = b.vsrno and a.itno = b.itno
            where a.comltd = '01' and a.itno = a_itno
              and b.xstop = 'O' and a.gcost <> 0) = 0 then 1
        else
          (select count(*)
      from pbpur.pur103a a inner join pbpur.pur103 b
      on a.comltd = b.comltd and a.dept = b.dept and
        a.vsrno = b.vsrno and a.itno = b.itno
            where a.comltd = '01' and a.itno = a_itno
              and b.xstop = 'O' and a.gcost <> 0)
        end,15,6)
    into p_ygcst
    from pbcommon.comm000;

return ifnull(p_ygcst,0);
end
