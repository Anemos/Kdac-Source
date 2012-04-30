SELECT 	A.SupplierCode,     
         		A.DivisionCode,   
         		A.ItemCode,   
         		A.RackQty,
				A.Partkbno   
         		
    FROM 	TPARTKBSTATUS	A
   WHERE 	A.AreaCode		= 'J'	AND  
         		A.DivisionCode		= 'S'		AND  
         		A.SupplierCode		= 'D2883'	AND    
         		A.KBActiveGubun 	= 'A'  			AND  	--운용중인간판
        		A.PartOrderCancel 	= 'N'			AND  	--'Y'발주취소, 'N'발주취소아님
        		A.PartKBStatus 		= 'B'			AND  	--'A'발주, 'B'가입고, 'C'입고, 'D'발주대기
         		A.PartReceiptDate	<= '2005.12.31'
Union
  SELECT 	
         		A.SupplierCode,   
         		
         		A.DivisionCode,   
         		A.ItemCode,      
         		
         		A.RackQty,
				A.Partkbno
    FROM 	TPARTKBHIS		A
   WHERE 	A.AreaCode		= 'J'	AND  
         		A.DivisionCode		= 'S'		AND  
         		A.SupplierCode		= 'D2883'	AND    
         		A.PartKBStatus	 	= 'C'  			AND  	--입고
         		A.KBActiveGubun 	= 'A'  			AND  	--운용중인간판
        		A.PartOrderCancel 	= 'N'			AND  	--'Y'발주취소, 'N'발주취소아님
         		A.PartReceiptDate	<= '2005.12.31'		AND  	--가입고일자
				A.PartIncomeDate    >= '2006.01.01'