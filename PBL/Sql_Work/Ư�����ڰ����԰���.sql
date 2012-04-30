SELECT 	
         		A.SupplierCode,   
         		
         		A.DivisionCode,   
         		A.ItemCode,      
         		
         		A.RackQty,
				A.Partkbno
    FROM 	[ipisele_svr\ipis].ipis.dbo.TPARTKBHIS		A
   WHERE 	A.SupplierCode		= 'D1055'	AND    
         		A.PartKBStatus	 	= 'C'  			AND  	--�԰�
         		A.KBActiveGubun 	= 'A'  			AND  	--������ΰ���
        		A.PartOrderCancel 	= 'N'			AND  	--'Y'�������, 'N'������Ҿƴ�
         		A.PartReceiptDate	<= '2005.12.31'		AND  	--���԰�����
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
         		A.PartKBStatus	 	= 'C'  			AND  	--�԰�
         		A.KBActiveGubun 	= 'A'  			AND  	--������ΰ���
        		A.PartOrderCancel 	= 'N'			AND  	--'Y'�������, 'N'������Ҿƴ�
         		A.PartReceiptDate	<= '2005.12.31'		AND  	--���԰�����
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
         		A.PartKBStatus	 	= 'C'  			AND  	--�԰�
         		A.KBActiveGubun 	= 'A'  			AND  	--������ΰ���
        		A.PartOrderCancel 	= 'N'			AND  	--'Y'�������, 'N'������Ҿƴ�
         		A.PartReceiptDate	<= '2005.12.31'		AND  	--���԰�����
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
         		A.PartKBStatus	 	= 'C'  			AND  	--�԰�
         		A.KBActiveGubun 	= 'A'  			AND  	--������ΰ���
        		A.PartOrderCancel 	= 'N'			AND  	--'Y'�������, 'N'������Ҿƴ�
         		A.PartReceiptDate	<= '2005.12.31'		AND  	--���԰�����
				A.PartIncomeDate    >= '2006.01.01'