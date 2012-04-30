/************************************************************************************************/
/*	File Name	: tr_TQQCItem_Temp_insert.SQL                                                   */
/*	SYSTEM		: ǰ������(��ǰǰ��)                                                            */
/*	Description	: ���԰˻� ���˻�ǰ Ʈ����(INSERT)                                              */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQQCITEM																		*/
/*	              TQQCITEM_TEMP																	*/
/*	Notes		: ���˻翡�� ���˻簡 �ɶ� �߻�(���ڵ� �����ͽ� = 'I')							*/
/*	              ���� �ű԰��� �μ�Ʈ�ϰ� ������ �������� ������ ����, �����ͽ��� �����Ѵ�		*/
/*	              RECSTATUS : 'A' ==> A:�ű�, R:����, D:����									*/
/*	Made Date	: 2002. 10. 29                                                                  */
/*	Author		: �������-������                                                               */
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
