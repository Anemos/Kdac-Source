if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SP_PART_OUT_HIST]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SP_PART_OUT_HIST]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE SP_PART_OUT_HIST
AS
BEGIN -- BEGIN PROCEDURE
	
INSERT INTO PART_OUT_HIST( EQUIP_CODE, PART_CODE, PART_NAME, PART_SPEC, LASTDATE, AREA_CODE, FACTORY_CODE)
SELECT DISTINCT C.EQUIP_CODE, C.PART_CODE, C.PART_NAME, C.PART_SPEC, MAX(A.OUT_DATE) AS LASTDATE , C.AREA_CODE, C.FACTORY_CODE
FROM PART_OUT A, 
	PART_MASTER B,
	PART_OUT_HIST C
WHERE A.AREA_CODE=B.AREA_CODE AND 
	A.FACTORY_CODE=B.FACTORY_CODE AND
	A.PART_CODE = B.PART_CODE AND A.EQUIP_CODE IS NOT NULL AND A.EQUIP_CODE<>'' 
	AND A.PART_CODE=C.PART_CODE AND A.EQUIP_CODE=C.EQUIP_CODE
	 AND C.LASTDATE < A.OUT_DATE
	AND A.AREA_CODE='D' AND A.FACTORY_CODE='A'
GROUP BY C.EQUIP_CODE,
	C.PART_CODE,
	C.PART_NAME,
	C.PART_SPEC,
	C.AREA_CODE,
	C.FACTORY_CODE

DELETE PART_OUT_HIST
FROM PART_OUT A, 
	PART_OUT_HIST c,
	 (SELECT  a.part_code, a.equip_code, MAX(A.OUT_DATE) as out_date
	FROM  PART_OUT A, 
	PART_MASTER B
	WHERE A.AREA_CODE=B.AREA_CODE AND 
		A.FACTORY_CODE=B.FACTORY_CODE AND
		A.PART_CODE = B.PART_CODE AND A.EQUIP_CODE IS NOT NULL AND A.EQUIP_CODE<>''
		AND A.AREA_CODE='D' AND A.FACTORY_CODE='A'
	GROUP BY A.EQUIP_CODE,
		A.PART_CODE,
		B.PART_NAME,
		B.PART_SPEC,
	A.AREA_CODE,
	A.FACTORY_CODE ) b
WHERE 	A.PART_CODE=C.PART_CODE AND A.EQUIP_CODE=C.EQUIP_CODE and
	A.PART_CODE=b.PART_CODE AND A.EQUIP_CODE=b.EQUIP_CODE
	 AND C.LASTDATE < b.out_date


END -- END PROCEDURE

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

