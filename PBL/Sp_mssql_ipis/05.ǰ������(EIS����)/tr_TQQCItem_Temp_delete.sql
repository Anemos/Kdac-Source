/************************************************************************************************/
/*	File Name	: tr_TQQCItem_Temp_delete.SQL                                                   */
/*	SYSTEM		: 품질관리(부품품질)                                                            */
/*	Description	: 수입검사 무검사품 트리거(DELETE)                                              */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQQCITEM																		*/
/*	              TQQCITEM_TEMP																	*/
/*	Notes		: 무검사에서 유검사가 될때 발생(레코드 스태터스 = 'D')							*/
/*	              RECORD는 삭제되지않고 스태터스만 수정한다										*/
/*	              RECSTATUS : 'D' ==> A:신규, R:수정, D:삭제									*/
/*	Made Date	: 2002. 10. 29                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.tr_TQQCItem_Temp_delete') and sysstat & 0xf = 8)
	drop trigger dbo.tr_TQQCItem_Temp_delete
GO

/****** Object:  Trigger dbo.tr_TQQCItem_Temp_delete    Script Date: 02-09-01  ******/

CREATE TRIGGER tr_TQQCItem_Temp_delete
ON TQQCITEM
FOR DELETE
AS


	Declare	@pi_count	Int      
	
	SET @pi_count = 0 

	Begin
		SELECT @pi_count = count(*)
		  FROM TQQCITEM_temp
	 	 WHERE AREACODE + DIVISIONCODE + ITEMCODE + SUPPLIERCODE = 
		 	 ( SELECT del.AREACODE + del.DIVISIONCODE + del.ITEMCODE + del.SUPPLIERCODE FROM deleted del )
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
			SELECT del.AREACODE,   
			       del.DIVISIONCODE,   
			       del.PRODUCTGROUP,   
			       del.MODELGROUP,   
			       del.ITEMCODE,   
			       del.SUPPLIERCODE,   
			       del.APPLYDATEFROM,   
			       del.APPLYDATETO,   
			       'D',
			       del.QCGUBUN
			  FROM deleted del

		END 
	ELSE	
		BEGIN
			UPDATE TQQCITEM_temp
			   SET RECSTATUS	= 'D'
			 WHERE AREACODE + DIVISIONCODE + ITEMCODE + SUPPLIERCODE = 
				 ( SELECT del.AREACODE + del.DIVISIONCODE + del.ITEMCODE + del.SUPPLIERCODE FROM deleted del )
		END 

--	UPDATE TQQCITEM_temp
--	   SET RECSTATUS	= 'D'
--	 WHERE AREACODE + DIVISIONCODE + ITEMCODE + SUPPLIERCODE = 
--		 ( SELECT del.AREACODE + del.DIVISIONCODE + del.ITEMCODE + del.SUPPLIERCODE FROM deleted del )

GO
