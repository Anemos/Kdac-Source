-- ele server
SELECT 	A.SupplierCode,     
         		A.DivisionCode,   
         		A.ItemCode,   
         		A.RackQty,
				A.Partkbno,
				A.PartReceiptDate,
				A.PartIncomeDate  
         		
    FROM 	[ipisele_svr\ipis].ipis.dbo.TPARTKBSTATUS	A
   WHERE 	A.SupplierCode		= 'D1055'	AND    
         		A.KBActiveGubun 	= 'A'  			AND  	--운용중인간판
        		A.PartOrderCancel 	= 'N'			AND  	--'Y'발주취소, 'N'발주취소아님
        		A.PartKBStatus 		= 'B'			AND  	--'A'발주, 'B'가입고, 'C'입고, 'D'발주대기
         		A.PartReceiptDate	<= '2005.12.31'
union all
SELECT 	
         		A.SupplierCode,   
         		
         		A.DivisionCode,   
         		A.ItemCode,      
         		
         		A.RackQty,
				A.Partkbno,
				A.PartReceiptDate,
				A.PartIncomeDate
    FROM 	[ipisele_svr\ipis].ipis.dbo.TPARTKBHIS		A
   WHERE 	A.SupplierCode		= 'D1055'	AND    
         		A.PartKBStatus	 	= 'C'  			AND  	--입고
         		A.KBActiveGubun 	= 'A'  			AND  	--운용중인간판
        		A.PartOrderCancel 	= 'N'			AND  	--'Y'발주취소, 'N'발주취소아님
         		A.PartReceiptDate	<= '2005.12.31'		AND  	--가입고일자
				A.PartIncomeDate    >= '2006.01.01'
union all
-- mac server
SELECT 	
         		A.SupplierCode,   
         		
         		A.DivisionCode,   
         		A.ItemCode,      
         		
         		A.RackQty,
				A.Partkbno,
				A.PartReceiptDate,
				A.PartIncomeDate
    FROM 	[ipismac_svr\ipis].ipis.dbo.TPARTKBHIS		A
   WHERE 	A.SupplierCode		= 'D1055'	AND    
         		A.PartKBStatus	 	= 'C'  			AND  	--입고
         		A.KBActiveGubun 	= 'A'  			AND  	--운용중인간판
        		A.PartOrderCancel 	= 'N'			AND  	--'Y'발주취소, 'N'발주취소아님
         		A.PartReceiptDate	<= '2005.12.31'		AND  	--가입고일자
				A.PartIncomeDate    >= '2006.01.01'
union all
SELECT 	A.SupplierCode,     
         		A.DivisionCode,   
         		A.ItemCode,   
         		A.RackQty,
				A.Partkbno,
				A.PartReceiptDate,
				A.PartIncomeDate  
         		
    FROM 	[ipismac_svr\ipis].ipis.dbo.TPARTKBSTATUS	A
   WHERE 	A.SupplierCode		= 'D1055'	AND    
         		A.KBActiveGubun 	= 'A'  			AND  	--운용중인간판
        		A.PartOrderCancel 	= 'N'			AND  	--'Y'발주취소, 'N'발주취소아님
        		A.PartKBStatus 		= 'B'			AND  	--'A'발주, 'B'가입고, 'C'입고, 'D'발주대기
         		A.PartReceiptDate	<= '2005.12.31'
union all
-- hvac server
SELECT 	
         		A.SupplierCode,   
         		
         		A.DivisionCode,   
         		A.ItemCode,      
         		
         		A.RackQty,
				A.Partkbno,
				A.PartReceiptDate,
				A.PartIncomeDate
    FROM 	[ipishvac_svr\ipis].ipis.dbo.TPARTKBHIS		A
   WHERE 	A.SupplierCode		= 'D1055'	AND    
         		A.PartKBStatus	 	= 'C'  			AND  	--입고
         		A.KBActiveGubun 	= 'A'  			AND  	--운용중인간판
        		A.PartOrderCancel 	= 'N'			AND  	--'Y'발주취소, 'N'발주취소아님
         		A.PartReceiptDate	<= '2005.12.31'		AND  	--가입고일자
				A.PartIncomeDate    >= '2006.01.01'
union all
SELECT 	A.SupplierCode,     
         		A.DivisionCode,   
         		A.ItemCode,   
         		A.RackQty,
				A.Partkbno,
				A.PartReceiptDate,
				A.PartIncomeDate  
         		
    FROM 	[ipishvac_svr\ipis].ipis.dbo.TPARTKBSTATUS	A
   WHERE 	A.SupplierCode		= 'D1055'	AND    
         		A.KBActiveGubun 	= 'A'  			AND  	--운용중인간판
        		A.PartOrderCancel 	= 'N'			AND  	--'Y'발주취소, 'N'발주취소아님
        		A.PartKBStatus 		= 'B'			AND  	--'A'발주, 'B'가입고, 'C'입고, 'D'발주대기
         		A.PartReceiptDate	<= '2005.12.31'
union all
-- jin server
SELECT 	
         		A.SupplierCode,   
         		
         		A.DivisionCode,   
         		A.ItemCode,      
         		
         		A.RackQty,
				A.Partkbno,
				A.PartReceiptDate,
				A.PartIncomeDate
    FROM 	[ipisjin_svr].ipis.dbo.TPARTKBHIS		A
   WHERE 	A.SupplierCode		= 'D1055'	AND    
         		A.PartKBStatus	 	= 'C'  			AND  	--입고
         		A.KBActiveGubun 	= 'A'  			AND  	--운용중인간판
        		A.PartOrderCancel 	= 'N'			AND  	--'Y'발주취소, 'N'발주취소아님
         		A.PartReceiptDate	<= '2005.12.31'		AND  	--가입고일자
				A.PartIncomeDate    >= '2006.01.01'
union all
SELECT 	A.SupplierCode,     
         		A.DivisionCode,   
         		A.ItemCode,   
         		A.RackQty,
				A.Partkbno,
				A.PartReceiptDate,
				A.PartIncomeDate  
         		
    FROM 	[ipisjin_svr].ipis.dbo.TPARTKBSTATUS	A
   WHERE 	A.SupplierCode		= 'D1055'	AND    
         		A.KBActiveGubun 	= 'A'  			AND  	--운용중인간판
        		A.PartOrderCancel 	= 'N'			AND  	--'Y'발주취소, 'N'발주취소아님
        		A.PartKBStatus 		= 'B'			AND  	--'A'발주, 'B'가입고, 'C'입고, 'D'발주대기
         		A.PartReceiptDate	<= '2005.12.31'
