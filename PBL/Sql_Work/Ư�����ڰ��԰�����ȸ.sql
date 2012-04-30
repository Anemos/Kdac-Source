SELECT 	A.SupplierCode,    
         		E.SupplierKorName,   
         		A.DivisionCode,   
         		A.ItemCode,   
         		B.ItemName,   
         		A.RackQty   
         		
    FROM 	TPARTKBSTATUS	A,   
         		TMSTITEM		B,   
         		TMSTORDERCHANGE	C,
		TMSTPARTCYCLE	D,
		TMSTSUPPLIER	E,
		TMSTPARTKB		F
   WHERE 	A.AreaCode		= 'D'	AND  
         		A.DivisionCode		= 'M'		AND  
         		A.SupplierCode		= 'D2883'	AND    
         		A.KBActiveGubun 	= 'A'  			AND  	--운용중인간판
        		A.PartOrderCancel 	= 'N'			AND  	--'Y'발주취소, 'N'발주취소아님
        		A.PartKBStatus 		= 'B'			AND  	--'A'발주, 'B'가입고, 'C'입고, 'D'발주대기
         		A.PartReceiptDate	<= '2005.12.31'		AND  	--가입고일자

         		A.ItemCode 		= B.ItemCode  		AND  

         		A.AreaCode 		*= C.AreaCode   	AND
         		A.DivisionCode 		*= C.DivisionCode   	AND
		A.OrderChangeCode 	*= C.OrderChangeCode 	AND

		A.AreaCode		= D.AreaCode		AND
		A.DivisionCode		= D.DivisionCode	AND
		A.SupplierCode		= D.SupplierCode	AND
         		D.ApplyFrom 		<= A.PartOrderDate  	AND
         		D.ApplyTo 		>= A.PartOrderDate  	AND

         		A.SupplierCode 		= E.SupplierCode  	AND  
         		
        		A.AreaCode 		= F.AreaCode		AND
        		A.DivisionCode 		= F.DivisionCode  	AND  
         		A.SupplierCode 		= F.SupplierCode  	AND  
         		A.ItemCode 		= F.ItemCode 
Union
  SELECT 	
         		A.SupplierCode,   
         		
         		E.SupplierKorName,   
         		A.DivisionCode,   
         		A.ItemCode,   
         		B.ItemName,   
         		
         		A.RackQty
    FROM 	TPARTKBHIS		A,   
         		TMSTITEM		B,   
         		TMSTORDERCHANGE	C,
		TMSTPARTCYCLE	D,
		TMSTSUPPLIER	E,
		TMSTPARTKB		F
   WHERE 	A.AreaCode		= 'D'	AND  
         		A.DivisionCode		= 'M'		AND  
         		A.SupplierCode		= 'D2883'	AND    
         		A.PartKBStatus	 	= 'C'  			AND  	--입고
         		A.KBActiveGubun 	= 'A'  			AND  	--운용중인간판
        		A.PartOrderCancel 	= 'N'			AND  	--'Y'발주취소, 'N'발주취소아님
         		A.PartReceiptDate	<= '2005.12.31'		AND  	--가입고일자
				A.PartIncomeDate    >= '2006.01.01'   AND
         		A.ItemCode 		= B.ItemCode  		AND  

         		A.AreaCode 		*= C.AreaCode   	AND
         		A.DivisionCode 		*= C.DivisionCode   	AND
		A.OrderChangeCode 	*= C.OrderChangeCode 	AND

		A.AreaCode		= D.AreaCode		AND
		A.DivisionCode		= D.DivisionCode	AND
		A.SupplierCode		= D.SupplierCode	AND
         		D.ApplyFrom 		<= A.PartOrderDate  	AND
         		D.ApplyTo 		>= A.PartOrderDate  	AND

         		A.SupplierCode 		= E.SupplierCode  	AND  
         		
        		A.AreaCode 		= F.AreaCode		AND
        		A.DivisionCode 		= F.DivisionCode  	AND  
         		A.SupplierCode 		= F.SupplierCode  	AND  
         		A.ItemCode 		= F.ItemCode 