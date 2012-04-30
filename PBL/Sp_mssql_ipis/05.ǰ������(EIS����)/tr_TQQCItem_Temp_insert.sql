/************************************************************************************************/
/*	File Name	: tr_TQQCItem_Temp_insert.SQL                                                   */
/*	SYSTEM		: 품질관리(부품품질)                                                            */
/*	Description	: 수입검사 무검사품 트리거(INSERT)                                              */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQQCITEM																		*/
/*	              TQQCITEM_TEMP																	*/
/*	Notes		: 유검사에서 무검사가 될때 발생(레코드 스태터스 = 'I')							*/
/*	              최초 신규건은 인서트하고 기존에 삭제건이 있으면 일자, 스태터스만 수정한다		*/
/*	              RECSTATUS : 'A' ==> A:신규, R:수정, D:삭제									*/
/*	Made Date	: 2002. 10. 29                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.tr_TQQCItem_Temp_insert') and sysstat & 0xf = 8)
	drop trigger dbo.tr_TQQCItem_Temp_insert
GO

/****** Object:  Trigger dbo.tr_TQQCItem_Temp_insert    Script Date: 02-09-01  ******/

CREATE TRIGGER tr_TQQCItem_Temp_insert
ON TQQCITEM
FOR INSERT
AS

--	SET XACT_ABORT  ON

	Declare	@pi_count	Int      
	
	SET @pi_count = 0 

	Begin
		SELECT @pi_count = count(*)
		  FROM TQQCITEM_temp
	 	 WHERE AREACODE + DIVISIONCODE + ITEMCODE + SUPPLIERCODE = 
		 	 ( SELECT ins.AREACODE + ins.DIVISIONCODE + ins.ITEMCODE + ins.SUPPLIERCODE FROM inserted ins )
	End

	IF @pi_count = 0 
		BEGIN
			INSERT INTO TQQCITEM_temp
			     ( AREACODE,   
			       DIVISIONCODE,   
			       PRODUCTGROUP,   
			       MODELGROUP,   
			       ITEMCODE,   
			       SUPPLIERCODE,   
			       APPLYDATEFROM,   
			       APPLYDATETO,   
			       RECSTATUS,
			       QCGUBUN
			       )  
			SELECT ins.AREACODE,   
			       ins.DIVISIONCODE,   
			       ins.PRODUCTGROUP,   
			       ins.MODELGROUP,   
			       ins.ITEMCODE,   
			       ins.SUPPLIERCODE,   
			       ins.APPLYDATEFROM,   
			       ins.APPLYDATETO,   
			       'A',
			       ins.QCGUBUN
			  FROM inserted ins

--			INSERT INTO [ipisele_svr\ipis].[eis].[dbo].TQQCITEM_temp
--			     ( AREACODE,   
--			       DIVISIONCODE,   
--			       PRODUCTGROUP,   
--			       MODELGROUP,   
--			       ITEMCODE,   
--			       SUPPLIERCODE,   
--			       APPLYDATEFROM,   
--			       APPLYDATETO,   
--			       RECSTATUS,
--			       QCGUBUN
--			       )  
--			SELECT ins.AREACODE,   
--			       ins.DIVISIONCODE,   
--			       ins.PRODUCTGROUP,   
--			       ins.MODELGROUP,   
--			       ins.ITEMCODE,   
--			       ins.SUPPLIERCODE,   
--			       ins.APPLYDATEFROM,   
--			       ins.APPLYDATETO,   
--			       'I',
--			       ins.QCGUBUN
--			  FROM inserted ins
		END 
	ELSE	
		BEGIN
			UPDATE TQQCITEM_temp
			   SET APPLYDATEFROM= ( SELECT ins.APPLYDATEFROM FROM inserted ins ), 
				   QCGUBUN		= ( SELECT ins.QCGUBUN		 FROM inserted ins ), 
			  	   RECSTATUS	= 'A'
			 WHERE AREACODE + DIVISIONCODE + ITEMCODE + SUPPLIERCODE = 
				 ( SELECT ins.AREACODE + ins.DIVISIONCODE + ins.ITEMCODE + ins.SUPPLIERCODE FROM inserted ins)

--			UPDATE [ipisele_svr\ipis].[eis].[dbo].TQQCITEM_temp
--			   SET APPLYDATEFROM= ( SELECT ins.APPLYDATEFROM FROM inserted ins ), 
--				   QCGUBUN		= ( SELECT ins.QCGUBUN		 FROM inserted ins ), 
--			  	   RECSTATUS	= 'I'
--			 WHERE AREACODE + DIVISIONCODE + ITEMCODE + SUPPLIERCODE = 
--				 ( SELECT ins.AREACODE + ins.DIVISIONCODE + ins.ITEMCODE + ins.SUPPLIERCODE FROM inserted ins)
		END 

--	SET XACT_ABORT  OFF

GO
