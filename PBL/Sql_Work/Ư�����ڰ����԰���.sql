SELECT 	
         		A.SupplierCode,   
         		
         		A.DivisionCode,   
         		A.ItemCode,      
         		
         		A.RackQty,
				A.Partkbno
    FROM 	[ipisele_svr\ipis].ipis.dbo.TPARTKBHIS		A
   WHERE 	A.SupplierCode		= 'D1055'	AND    
         		A.PartKBStatus	 	= 'C'  			AND  	--입고
         		A.KBActiveGubun 	= 'A'  			AND  	--운용중인간판
        		A.PartOrderCancel 	= 'N'			AND  	--'Y'발주취소, 'N'발주취소아님
         		A.PartReceiptDate	<= '2005.12.31'		AND  	--가입고일자
				A.PartIncomeDate    >= '2006.01.01'
union all
SELECT 	
         		A.SupplierCode,   
         		
         		A.DivisionCode,   
         		A.ItemCode,      
         		
         		A.RackQty,
				A.Partkbno
    FROM 	[ipismac_svr\ipis].ipis.dbo.TPARTKBHIS		A
   WHERE 	A.SupplierCode		= 'D1055'	AND    
         		A.PartKBStatus	 	= 'C'  			AND  	--입고
         		A.KBActiveGubun 	= 'A'  			AND  	--운용중인간판
        		A.PartOrderCancel 	= 'N'			AND  	--'Y'발주취소, 'N'발주취소아님
         		A.PartReceiptDate	<= '2005.12.31'		AND  	--가입고일자
				A.PartIncomeDate    >= '2006.01.01'
union all
SELECT 	
         		A.SupplierCode,   
         		
         		A.DivisionCode,   
         		A.ItemCode,      
         		
         		A.RackQty,
				A.Partkbno
    FROM 	[ipishvac_svr\ipis].ipis.dbo.TPARTKBHIS		A
   WHERE 	A.SupplierCode		= 'D1055'	AND    
         		A.PartKBStatus	 	= 'C'  			AND  	--입고
         		A.KBActiveGubun 	= 'A'  			AND  	--운용중인간판
        		A.PartOrderCancel 	= 'N'			AND  	--'Y'발주취소, 'N'발주취소아님
         		A.PartReceiptDate	<= '2005.12.31'		AND  	--가입고일자
				A.PartIncomeDate    >= '2006.01.01'
union all
SELECT 	
         		A.SupplierCode,   
         		
         		A.DivisionCode,   
         		A.ItemCode,      
         		
         		A.RackQty,
				A.Partkbno
    FROM 	[ipisjin_svr].ipis.dbo.TPARTKBHIS		A
   WHERE 	A.SupplierCode		= 'D1055'	AND    
         		A.PartKBStatus	 	= 'C'  			AND  	--입고
         		A.KBActiveGubun 	= 'A'  			AND  	--운용중인간판
        		A.PartOrderCancel 	= 'N'			AND  	--'Y'발주취소, 'N'발주취소아님
         		A.PartReceiptDate	<= '2005.12.31'		AND  	--가입고일자
				A.PartIncomeDate    >= '2006.01.01'