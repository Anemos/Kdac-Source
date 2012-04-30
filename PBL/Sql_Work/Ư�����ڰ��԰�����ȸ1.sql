SELECT 	A.SupplierCode,     
         		A.DivisionCode,   
         		A.ItemCode,   
         		A.RackQty,
				A.Partkbno   
         		
    FROM 	TPARTKBSTATUS	A
   WHERE 	A.AreaCode		= 'J'	AND  
         		A.DivisionCode		= 'S'		AND  
         		A.SupplierCode		= 'D2883'	AND    
         		A.KBActiveGubun 	= 'A'  			AND  	--������ΰ���
        		A.PartOrderCancel 	= 'N'			AND  	--'Y'�������, 'N'������Ҿƴ�
        		A.PartKBStatus 		= 'B'			AND  	--'A'����, 'B'���԰�, 'C'�԰�, 'D'���ִ��
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
         		A.PartKBStatus	 	= 'C'  			AND  	--�԰�
         		A.KBActiveGubun 	= 'A'  			AND  	--������ΰ���
        		A.PartOrderCancel 	= 'N'			AND  	--'Y'�������, 'N'������Ҿƴ�
         		A.PartReceiptDate	<= '2005.12.31'		AND  	--���԰�����
				A.PartIncomeDate    >= '2006.01.01'