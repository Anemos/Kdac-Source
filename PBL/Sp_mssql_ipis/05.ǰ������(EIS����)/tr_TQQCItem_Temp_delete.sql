/************************************************************************************************/
/*	File Name	: tr_TQQCItem_Temp_delete.SQL                                                   */
/*	SYSTEM		: ǰ������(��ǰǰ��)                                                            */
/*	Description	: ���԰˻� ���˻�ǰ Ʈ����(DELETE)                                              */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQQCITEM																		*/
/*	              TQQCITEM_TEMP																	*/
/*	Notes		: ���˻翡�� ���˻簡 �ɶ� �߻�(���ڵ� �����ͽ� = 'D')							*/
/*	              RECORD�� ���������ʰ� �����ͽ��� �����Ѵ�										*/
/*	              RECSTATUS : 'D' ==> A:�ű�, R:����, D:����									*/
/*	Made Date	: 2002. 10. 29                                                                  */
/*	Author		: �������-������                                                               */
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
