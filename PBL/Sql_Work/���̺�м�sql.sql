SELECT object_name(id) ,rowcnt FROM sysindexes WHERE indid IN (1,0) AND OBJECTPROPERTY(id, 'isUserTable') = 1 
ORDER BY object_name(id)

SELECT COUNT(*) FROM [ipisele_svr\ipis].ipis.dbo.TMHVALUETARGET
WHERE TARMONTH < '2006.01'

SELECT COUNT(*) FROM [ipismac_svr\ipis].ipis.dbo.TMHVALUETARGET
WHERE TARMONTH < '2006.01'

SELECT COUNT(*) FROM [ipishvac_svr\ipis].ipis.dbo.TMHVALUETARGET
WHERE TARMONTH < '2006.01'

SELECT COUNT(*) FROM [ipisjin_svr].ipis.dbo.TMHVALUETARGET
WHERE TARMONTH < '2006.01'

exec [ipisele_svr\ipis].ipis.dbo.sp_spaceused 'TMHSummary_OT'
exec [ipismac_svr\ipis].ipis.dbo.sp_spaceused 'TMHWCITEM'
exec [ipishvac_svr\ipis].ipis.dbo.sp_spaceused 'TMHWCITEM'
exec [ipisjin_svr].ipis.dbo.sp_spaceused 'TMHWCITEM'