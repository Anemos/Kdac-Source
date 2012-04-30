insert into tterminal(trmcode,trmname,trmetc,lastemp)
values('MTA01','MTA01','test','000030')

go

insert into tworkgroup(wgcode,wgname,wgetc,lastemp)
values('MWG01','°¡°ø1Á¶','test','000030')

go

insert into tterminalworkgroup(trmcode,wgcode,lastemp)
values('MTA01','MWG01','000030')
