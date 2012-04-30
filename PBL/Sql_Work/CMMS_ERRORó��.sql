SELECT * FROM TMCPARTRELEASE
WHERE UPLOADFLAG = 'N'

SELECT *  FROM [IPISMAC_SVR\IPIS].cmms.dbo.part_out
where part_code = 'MC01A-003' AND
part_tag in ( select slipno from tmcpartrelease where uploadflag = 'N')

SELECT * FROM [IPISMAC_SVR\IPIS].cmms.dbo.part_master
where part_code = 'MC01A-003'

DELETE  FROM [IPISMAC_SVR\IPIS].cmms.dbo.part_out
where part_code = 'MC01A-003' AND
part_tag in ( select slipno from tmcpartrelease where uploadflag = 'N')

DELETE FROM TMCPARTRELEASE
WHERE UPLOADFLAG = 'N' AND ITEMCODE = 'MC01A-003'

