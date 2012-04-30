/************************************************************************************************/
/*	File Name	: sp_pisq180u_01.SQL                                                            */
/*	SYSTEM		: 품질관리(공정품질)	                                                        */
/*	Description	: 공정불량등록중 생산수량 일괄등록 처리										    */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQSMALLGROUPTOITEM	                                                        */
/*	              TMHREALPROD			                                                        */
/*	              TQSMALLGROUPTOPROCESS	                                                        */
/*  Parameter   : @ps_AreaCode          char(01)    => 지역구분                                 */
/*                @ps_DivisionCode      char(01)    => 공장코드                                 */
/*                @ps_Date		        char(10)    => 작업일자                                 */
/*	Notes		: 작업일보의 일별 생산수량을 가져온다											*/
/*	Made Date	: 2002. 10. 17                                                                  */
/*	Author		: 대우정보-유종희                                                               */
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
        @ps_AreaCode          char(01)      ,   -- 지역구분
        @ps_DivisionCode      char(01)      ,   -- 공장코드
        @ps_Date		      char(10) 			-- 작업일자

AS

BEGIN

	-- 기등록된 자료를 삭제한다
	--
	DELETE FROM TQPROGRESSBADMASTER  
			WHERE AREACODE			= @ps_AreaCode
			  AND DIVISIONCODE		= @ps_DivisionCode
			  AND ORIGINATIONDATE	= @ps_Date
	
	-- QC소분류별 품번열결된 테이블에 등록된 품번을 가지고 작업일보의 생산수량을 가져오고
	-- 최종공정의 생산원가도 함께구하여 공정불량마스타에 입력한다
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


    -- 기등록된 자료를 삭제한다(인터페이스용 템프)
    --
    DELETE FROM TQPROGRESSBADMASTER_TEMP
    		WHERE AREACODE			= @ps_AreaCode
    		  AND DIVISIONCODE		= @ps_DivisionCode
    		  AND ORIGINATIONDATE	= @ps_Date
    
    -- QC소분류별 품번열결된 테이블에 등록된 품번을 가지고 작업일보의 생산수량을 가져오고
    -- 최종공정의 생산원가도 함께구하여 공정불량마스타에 입력한다
    -- (인터페이스용 템프)
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
