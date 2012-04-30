SELECT a.name table_name,a.id table_id, b.id trigger_id, b.name
trig_name, a.deltrig, a.updtrig, a.instrig
FROM sysobjects a, sysobjects b
WHERE a.type='U' AND (a.id = b.deltrig OR a.id = b.updtrig OR a.id = b.instrig)
AND a.name IN (SELECT name FROM sysobjects WHERE type = 'U')
ORDER BY 1
