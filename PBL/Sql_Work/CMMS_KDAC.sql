SELECT PART_CODE, NORMAL_QTY,REPAIR_QTY,SCRAM_QTY,ETC_QTY,OHUQTY,OHRQTY,OHSQTY,EXQTY
UPDATE PART_MASTER
SET NORMAR_QTY = OHUQTY,
FROM PART_MASTER, QCMMSDM12
WHERE AREA_CODE = XPLANT AND FACTORY_CODE = DIV AND
PART_CODE = ITNO AND (NORMAL_QTY <> OHUQTY OR REPAIR_QTY <> OHRQTY OR
SCRAM_QTY <> OHSQTY OR ETC_QTY <> EXQTY);