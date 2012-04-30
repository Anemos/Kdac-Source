-- file name : sf_bom_105
-- procedure name : pbpdm.sf_bom_105
-- desc : BOM 공장 재료비 데이타생성함수_고객사유상사급포함 'B'
-- a_comltd, a_plant, a_dvsn, a_itno, a_pdcd, a_costdiv,
-- a_yyyymm, a_createdate, a_rtn

drop function pbpdm.sf_bom_105;
create function pbpdm.sf_bom_105 (
a_itno varchar(15))
returns numeric(5,2)
language sql
modifies sql data
begin
declare sqlcode integer default 0;
declare p_txrt numeric(5,2);
declare at_end integer default 0;
declare not_found condition for '02000';

declare continue handler for not_found
        set at_end = 1;

select coalesce (max(x.txrt),0) into p_txrt
        from pbrcd.rcd302 x, pbrcd.rcd303 y
        where x.comltd = '01'
        and    x.comltd = y.comltd
        and   x.ipdt = y.ipdt
        and   x.ipno = y.ipno
        and   x.lanno = y.lanno
        and   y.itno2 = a_itno
        and   y.ipdt = (select coalesce(max(t.ipdt),'')
        from pbrcd.rcd303 t
        where t.comltd = '01'
        and t.itno2 = a_itno);

return p_txrt;
end
