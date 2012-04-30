/************************************************************************************************/
/*	File Name	: sp_pisq180u_01.SQL                                                            */
/*	SYSTEM		: ǰ������(����ǰ��)	                                                        */
/*	Description	: �����ҷ������ ������� �ϰ���� ó��										    */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQSMALLGROUPTOITEM	                                                        */
/*	              TMHREALPROD			                                                        */
/*	              TQSMALLGROUPTOPROCESS	                                                        */
/*  Parameter   : @ps_AreaCode          char(01)    => ��������                                 */
/*                @ps_DivisionCode      char(01)    => �����ڵ�                                 */
/*                @ps_Date		        char(10)    => �۾�����                                 */
/*	Notes		: �۾��Ϻ��� �Ϻ� ��������� �����´�											*/
/*	Made Date	: 2002. 10. 17                                                                  */
/*	Author		: �������-������                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq180u_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq180u_01
GO
/*
Exec sp_pisq180u_01
		@ps_AreaCode        = 'D'       ,
		@ps_DivisionCode    = 'S'       ,
        @ps_Date    		= '2002.10.01'    
*/


/****** Object:  Stored Procedure dbo.sp_pisq180u_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq180u_01
        @ps_AreaCode          char(01)      ,   -- ��������
        @ps_DivisionCode      char(01)      ,   -- �����ڵ�
        @ps_Date		      char(10) 			-- �۾�����

AS

BEGIN

	-- ���ϵ� �ڷḦ �����Ѵ�
	--
	DELETE FROM TQPROGRESSBADMASTER  
			WHERE AREACODE			= @ps_AreaCode
			  AND DIVISIONCODE		= @ps_DivisionCode
			  AND ORIGINATIONDATE	= @ps_Date
	
	-- QC�Һз��� ǰ������� ���̺� ��ϵ� ǰ���� ������ �۾��Ϻ��� ��������� ��������
	-- ���������� ��������� �Բ����Ͽ� �����ҷ�����Ÿ�� �Է��Ѵ�
	--
	INSERT INTO TQPROGRESSBADMASTER  
	         ( AREACODE,   
	           DIVISIONCODE,   
	           ORIGINATIONDATE,   
	           LARGEGROUPCODE,   
	           MIDDLEGROUPCODE,   
	           SMALLGROUPCODE,   
	           PRODUCTQTY,   
	           PROCESSCOST )  
				( SELECT AS_AREACODE,   
							AS_DIVISIONCODE,   
							AS_DATE,
							AS_LARGEGROUPCODE,   
							AS_MIDDLEGROUPCODE,   
							AS_SMALLGROUPCODE,   
							SUM(AS_QTY),
							SUM(AS_AMT)
					FROM (  SELECT A.AREACODE									AS AS_AREACODE,   
									A.DIVISIONCODE								AS AS_DIVISIONCODE,   
									@ps_date 									AS AS_DATE,
									A.LARGEGROUPCODE							AS AS_LARGEGROUPCODE,   
									A.MIDDLEGROUPCODE							AS AS_MIDDLEGROUPCODE,   
									A.SMALLGROUPCODE							AS AS_SMALLGROUPCODE,   
									SUM(ISNULL(B.DAYPQTY,0)) + SUM(ISNULL(B.NIGHTPQTY,0))	AS AS_QTY,
									0											AS AS_AMT
							   FROM TQSMALLGROUPTOITEM	A,
									TMHREALPROD			B
								WHERE A.AREACODE		= B.AREACODE
								  AND A.DIVISIONCODE	= B.DIVISIONCODE
								  AND A.WORKCENTER		= B.WORKCENTER
								  AND A.ITEMCODE		= B.ITEMCODE
								  AND A.SUBLINECODE		= B.SUBLINECODE
								  AND A.SUBLINENO		= B.SUBLINENO
								  AND A.AREACODE		= @ps_areacode
								  AND A.DIVISIONCODE	= @ps_divisioncode
								  AND B.WORKDAY			= @ps_date
							 GROUP BY A.AREACODE				,
									  A.DIVISIONCODE		,
									  A.LARGEGROUPCODE	,
									  A.MIDDLEGROUPCODE	,
									  A.SMALLGROUPCODE

								UNION ALL
						
							  SELECT A.AREACODE   							AS AS_AREACODE,       
										A.DIVISIONCODE                      AS AS_DIVISIONCODE,   
										@ps_date							AS AS_DATE,           
										A.LARGEGROUPCODE                    AS AS_LARGEGROUPCODE, 
										A.MIDDLEGROUPCODE                   AS AS_MIDDLEGROUPCODE,
										A.SMALLGROUPCODE                    AS AS_SMALLGROUPCODE, 
										0					                AS AS_QTY,            
										B.PROCESSCOST                       AS AS_AMT             
								   FROM TQSMALLGROUPTOITEM		A,   
										TQSMALLGROUPTOPROCESS	B 
								  WHERE A.AREACODE			= B.AREACODE
								    AND A.DIVISIONCODE		= B.DIVISIONCODE
								    AND A.LARGEGROUPCODE	= B.LARGEGROUPCODE
								    AND A.MIDDLEGROUPCODE	= B.MIDDLEGROUPCODE
								    AND A.SMALLGROUPCODE	= B.SMALLGROUPCODE
								    AND A.AREACODE			= @ps_areacode
								    AND A.DIVISIONCODE		= @ps_divisioncode
								    AND B.FINALPROCESSFLAG= '1'
						          GROUP BY A.AREACODE,   
										   A.DIVISIONCODE,   
										   A.LARGEGROUPCODE,   
										   A.MIDDLEGROUPCODE,   
										   A.SMALLGROUPCODE,
										   B.PROCESSCOST
						  ) TMP
				 GROUP BY AS_AREACODE,   
							 AS_DATE,
							 AS_DIVISIONCODE,   
							 AS_LARGEGROUPCODE,   
							 AS_MIDDLEGROUPCODE,   
							 AS_SMALLGROUPCODE
				)


    -- ���ϵ� �ڷḦ �����Ѵ�(�������̽��� ����)
    --
    DELETE FROM TQPROGRESSBADMASTER_TEMP
    		WHERE AREACODE			= @ps_AreaCode
    		  AND DIVISIONCODE		= @ps_DivisionCode
    		  AND ORIGINATIONDATE	= @ps_Date
    
    -- QC�Һз��� ǰ������� ���̺� ��ϵ� ǰ���� ������ �۾��Ϻ��� ��������� ��������
    -- ���������� ��������� �Բ����Ͽ� �����ҷ�����Ÿ�� �Է��Ѵ�
    -- (�������̽��� ����)
    --
    INSERT INTO TQPROGRESSBADMASTER_TEMP  
             ( AREACODE,   
               DIVISIONCODE,   
               ORIGINATIONDATE,   
               LARGEGROUPCODE,   
               MIDDLEGROUPCODE,   
               SMALLGROUPCODE,   
               PRODUCTQTY,   
               PROCESSCOST,
               LASTEMP )  
    			( SELECT AS_AREACODE,   
    						AS_DIVISIONCODE,   
    						AS_DATE,
    						AS_LARGEGROUPCODE,   
    						AS_MIDDLEGROUPCODE,   
    						AS_SMALLGROUPCODE,   
    						SUM(AS_QTY),
    						SUM(AS_AMT),
    						'Y'
    				FROM (  SELECT A.AREACODE									AS AS_AREACODE,   
    								A.DIVISIONCODE								AS AS_DIVISIONCODE,   
    								@ps_date 									AS AS_DATE,
    								A.LARGEGROUPCODE							AS AS_LARGEGROUPCODE,   
    								A.MIDDLEGROUPCODE							AS AS_MIDDLEGROUPCODE,   
    								A.SMALLGROUPCODE							AS AS_SMALLGROUPCODE,   
    								SUM(ISNULL(B.DAYPQTY,0)) + SUM(ISNULL(B.NIGHTPQTY,0))	AS AS_QTY,
    								0											AS AS_AMT
    						   FROM TQSMALLGROUPTOITEM	A,
    								TMHREALPROD			B
    							WHERE A.AREACODE		= B.AREACODE
    							  AND A.DIVISIONCODE	= B.DIVISIONCODE
    							  AND A.WORKCENTER		= B.WORKCENTER
    							  AND A.ITEMCODE		= B.ITEMCODE
    							  AND A.SUBLINECODE		= B.SUBLINECODE
    							  AND A.SUBLINENO		= B.SUBLINENO
    							  AND A.AREACODE		= @ps_areacode
    							  AND A.DIVISIONCODE	= @ps_divisioncode
    							  AND B.WORKDAY			= @ps_date
    						 GROUP BY A.AREACODE				,
    								  A.DIVISIONCODE		,
    								  A.LARGEGROUPCODE	,
    								  A.MIDDLEGROUPCODE	,
    								  A.SMALLGROUPCODE
    
    							UNION ALL
    					
    						  SELECT A.AREACODE   							AS AS_AREACODE,       
    									A.DIVISIONCODE                      AS AS_DIVISIONCODE,   
    									@ps_date							AS AS_DATE,           
    									A.LARGEGROUPCODE                    AS AS_LARGEGROUPCODE, 
    									A.MIDDLEGROUPCODE                   AS AS_MIDDLEGROUPCODE,
    									A.SMALLGROUPCODE                    AS AS_SMALLGROUPCODE, 
    									0					                AS AS_QTY,            
    									B.PROCESSCOST                       AS AS_AMT             
    							   FROM TQSMALLGROUPTOITEM		A,   
    									TQSMALLGROUPTOPROCESS	B 
    							  WHERE A.AREACODE			= B.AREACODE
    							    AND A.DIVISIONCODE		= B.DIVISIONCODE
    							    AND A.LARGEGROUPCODE	= B.LARGEGROUPCODE
    							    AND A.MIDDLEGROUPCODE	= B.MIDDLEGROUPCODE
    							    AND A.SMALLGROUPCODE	= B.SMALLGROUPCODE
    							    AND A.AREACODE			= @ps_areacode
    							    AND A.DIVISIONCODE		= @ps_divisioncode
    							    AND B.FINALPROCESSFLAG= '1'
    					          GROUP BY A.AREACODE,   
    									   A.DIVISIONCODE,   
    									   A.LARGEGROUPCODE,   
    									   A.MIDDLEGROUPCODE,   
    									   A.SMALLGROUPCODE,
    									   B.PROCESSCOST
    					  ) TMP
    			 GROUP BY AS_AREACODE,   
    						 AS_DATE,
    						 AS_DIVISIONCODE,   
    						 AS_LARGEGROUPCODE,   
    						 AS_MIDDLEGROUPCODE,   
    						 AS_SMALLGROUPCODE
    			)
    
END 

go
