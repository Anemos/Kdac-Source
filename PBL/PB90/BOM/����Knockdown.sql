select zmdcd,zitno,zdesc,zmdno,zunit1,zunit2,zcvtfact,sum(decimal(zunitqty,9,3)),zcalc,zwkct
	from pbpdm.bom013
where zdate = '200605' and zplant = 'D' and zdiv = 'H' and zsrce = '02'
group by zmdcd,zitno,zdesc,zmdno,zunit1,zunit2,zcvtfact,zcalc,zwkct
order by zmdcd,zitno,zdesc,zmdno,zunit1,zunit2,zcvtfact,zcalc,zwkct
;
select a.zitno,b.vndnm,c.cls,c.srce,a.zdesc,a.zspec,sum(decimal(a.zunitqty,9,3)),c.pdcd,a.zmdno,d.itnm from 
	pbpdm.bom013 a, pbpur.pur101 b,pbinv.inv101 c, pbinv.inv002 d,pbpur.pur103 e
where a.zcmcd = '01' and a.zdate = '200611' and a.zplant = 'D' and a.zdiv = 'M' and 
		a.zplant = c.xplant and a.zdiv = c.div and a.zitno = c.itno and a.zmdno = d.itno and 
		a.zcmcd = e.comltd and a.zitno = e.itno and e.xstop = 'O' and b.vsrno = e.vsrno 
		and c.pdcd in ( '71','72','73') and  a.zcalc = 'Y'
group by a.zitno,b.vndnm,c.cls,c.srce,a.zdesc,a.zspec,c.pdcd,a.zmdno,d.itnm
order by a.zitno,a.zmdno,b.vndnm
;