SELECT pbcommon.F_CODENM('01','SLE220',aa.wfplant,'1') as plantnm,
    pbcommon.F_CODENM('01','DAC030',aa.wfdvsn,'1') as dvsnnm,
    pbcommon.F_CODENM('01','DAC160',bb.pdcd,'1') as pdcdnm,
    aa.wfvendor,
    cc.vndnm,
    cc.vndr,
    aa.wfplant,
    aa.wfdvsn,
    bb.pdcd,
    sum(aa.wfclat)
FROM  pbwip.wip009 aa,
      pbinv.inv101 bb,
    pbpur.pur101 cc,
    ( select wfcmcd, wfyear, wfmonth, wfvendor, sum(wfclat)
            from pbwip.wip009
            where wfcmcd = '01' and wfyear = '2004' and wfmonth = '06' and wfclat > 0
            group by wfcmcd, wfyear, wfmonth, wfvendor
            having sum(wfclat) >= 100000) dd
WHERE ( aa.wfcmcd  = bb.comltd )  and   ( aa.wfplant = bb.xplant ) and
      ( aa.wfdvsn = bb.div )      and   ( aa.wfitno = bb.itno ) and
      ( aa.wfcmcd = cc.comltd )   and   ( aa.wfvendor = cc.vsrno ) and
      ( aa.wfcmcd = dd.wfcmcd )   and   ( aa.wfyear = dd.wfyear ) and
      ( aa.wfmonth = dd.wfmonth)  and   ( aa.wfvendor = dd.wfvendor ) and
      ( aa.wfstscd >= '3' )       and   ( cc.scgubun = 'S' ) and
      ( aa.wfclat > 0 )
group by aa.wfvendor, cc.vndnm, cc.vndr, aa.wfplant, aa.wfdvsn, bb.pdcd
order by aa.wfvendor, aa.wfplant, aa.wfdvsn, bb.pdcd;

