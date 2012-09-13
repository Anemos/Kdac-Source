$PBExportHeader$u_pisr_treeview.sru
$PBExportComments$외주간판 공장,업체,[품목] Treeview
forward
global type u_pisr_treeview from treeview
end type
end forward

global type u_pisr_treeview from treeview
integer width = 713
integer height = 1832
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean linesatroot = true
boolean hideselection = false
string picturename[] = {"Custom039!","Custom039!","ScriptYes!","Custom039!","Custom050!"}
long picturemaskcolor = 553648127
long statepicturemaskcolor = 536870912
end type
global u_pisr_treeview u_pisr_treeview

type variables
Integer ii_levelGubun = 2 
Boolean	ib_applyfilter = true
Integer ii_selLevel
str_pisr_partkb uistr_partKB
Treeview itv_tar[]
end variables

forward prototypes
public function any uf_getpartkb ()
public subroutine uf_setlevelgubun (integer ai_levelgubun)
public function long uf_findchditem (long al_parhandle, str_pisr_partkb astr_data)
public function long uf_findequallevel (ref treeview atv_tar)
public function long uf_finditem (str_pisr_partkb astr_partkb, ref long al_parhandle)
public function long uf_finditem2 (str_pisr_partkb astr_data, ref long al_parhandle)
public function boolean uf_getchild (long al_hnd)
public function integer uf_settartv (ref treeview atv_tar)
public function long uf_additem (str_pisr_partkb astr_partkb)
public function long uf_insertitem (long al_parhandle, str_pisr_partkb astr_data)
public function integer uf_setitem (string as_areacode, string as_divcode, string as_suppcode, long al_supphandle)
public function integer uf_set_inittv (string as_areacode, string as_divcode, boolean as_applyfilter)
public function integer uf_setsupp (string as_areacode, string as_divcode, integer al_divhandle)
end prototypes

public function any uf_getpartkb ();Return uistr_partKB 
end function

public subroutine uf_setlevelgubun (integer ai_levelgubun);
ii_levelgubun = ai_levelgubun
end subroutine

public function long uf_findchditem (long al_parhandle, str_pisr_partkb astr_data);Long ll_Handle 
TreeViewItem tvi_Item 
str_pisr_partKb lstr_partKb 

ll_Handle = This.FindItem(ChildTreeItem!, al_parhandle)
Do While ll_Handle > 0 
	If This.GetItem(ll_Handle, tvi_Item) = -1 Then Return -1 
	lstr_partKb = tvi_Item.Data
	If tvi_Item.Level = 1 Then 
		If astr_data.divCode = lstr_partKb.divCode Then Return ll_Handle 
	Elseif tvi_Item.Level = 2 Then 
		If astr_data.suppCode = lstr_partKb.suppCode Then Return ll_Handle 
	ElseIf tvi_Item.Level = 3 Then 
		If astr_data.itemCode = lstr_partKb.itemCode Then Return ll_Handle 
	End If 
	
	ll_Handle = This.FindItem(NextTreeItem!, ll_Handle)
Loop

Return -1 
end function

public function long uf_findequallevel (ref treeview atv_tar);Long ll_divHnd, ll_suppHnd, ll_itemHnd, ll_selHand 
TreeviewItem ltvi_supp, ltvi_item 

ll_divHnd = atv_tar.FindItem(RootTreeItem!, 0)
Do While ll_divHnd > 0 
	ll_suppHnd = FindItem(ChildTreeItem!, ll_divHnd) 
	Do While ll_suppHnd > 0 
		If GetItem(ll_suppHnd, ltvi_supp) > 0 Then 
			If ltvi_supp.Data = uistr_partKB Then 
				ll_ItemHnd = FindItem(ChildTreeItem!, ll_suppHnd) 
				Do While ll_ItemHnd > 0 
					If GetItem(ll_ItemHnd, ltvi_item) > 0 Then
						If ltvi_item.Data = uistr_partKB Then ll_selHand = ll_ItemHnd 
					End If 
				Loop 
				If ll_selHand <= 0 Then ll_selHand = ll_suppHnd
			End If 
		End If
		ll_suppHnd = FindItem(NextTreeItem!, ll_suppHnd) 
	Loop 
	ll_divHnd = FindItem(NextTreeItem!, ll_divHnd)
Loop 

Return ll_selHand 
end function

public function long uf_finditem (str_pisr_partkb astr_partkb, ref long al_parhandle);Long ll_divHandle, ll_suppHandle, ll_itemHandle 
TreeViewItem tvi_Item 
str_pisr_partKb lstr_partKb 

ll_divHandle = This.FindItem(RootTreeItem!, 0)
Do While ll_divHandle > 0 
	If This.GetItem(ll_divHandle, tvi_Item) = -1 Then Return -1
	lstr_partKb = tvi_Item.Data
	If lstr_partKb.divCode = astr_partkb.divCode Then 	
		ll_suppHandle = This.FindItem(ChildTreeItem!, ll_divHandle)
		Do While ll_suppHandle > 0 
			If This.GetItem(ll_suppHandle, tvi_Item) = -1 Then Return -1 
			lstR_partKb = tvi_Item.Data 
			If lstr_partKb.suppCode = astr_partkb.suppCode Then 
				If ii_levelgubun <> 3 Then Return ll_suppHandle 
				ll_itemHandle = This.FindItem(ChildTreeItem!, ll_suppHandle)
				Do While ll_itemHandle > 0 
					If This.GetItem(ll_itemHandle, tvi_Item) = -1 Then Return -1 
					lstr_partKb = tvi_Item.Data
					If lstr_partKb.itemCode = astr_partkb.ItemCode Then Return ll_itemHandle 
					ll_itemHandle = This.FindItem(NextTreeItem!, ll_itemHandle)
				Loop
				If ll_itemHandle <= 0 Then al_parHandle = ll_suppHandle 
			End If 
			ll_suppHandle = This.FindItem(NextTreeItem!, ll_suppHandle)
		Loop
		If ll_suppHandle <= 0 Then al_parHandle = ll_divHandle 
	End If
	ll_divHandle = This.FindItem(NextTreeItem!, ll_divHandle)
Loop

Return -1 
end function

public function long uf_finditem2 (str_pisr_partkb astr_data, ref long al_parhandle);Long ll_Handle
TreeViewItem tvi_Item 
str_pisr_partKb lstr_partKb 

If al_parHandle = 0 Then 
   ll_Handle = This.FindItem(RootTreeItem!, 0)
Else
	ll_Handle = This.FindItem(ChildTreeItem!, al_parHandle)
End If 
Do While ll_Handle > 0 
	If This.GetItem(ll_Handle, tvi_Item) = -1 Then Return -1
	lstr_partKb = tvi_Item.Data
	If tvi_Item.level = 1 Then 
		If lstr_partKb.divCode = astr_data.divCode Then Return ll_Handle
	ElseIf tvi_Item.level = 2 Then
		If lstr_partKb.suppCode = astr_data.suppCode Then Return ll_Handle
	ElseIf tvi_Item.level = 3 Then 
		If lstr_partKb.itemCode = astr_data.itemCode Then Return ll_Handle
	End If
	ll_Handle = This.FindItem(NextTreeItem!, ll_Handle)
Loop

Return -1 
end function

public function boolean uf_getchild (long al_hnd);Boolean lb_chdChk = False 
long ll_chdCnt, ll_curhnd
TreeviewItem ltvi_item 
str_pisr_partKb lstr_partKb

If This.GetItem(al_hnd, ltvi_item) = -1 Then Return False 
lstr_partKb = ltvi_item.Data 
Choose Case ltvi_item.Level 
	Case 1
	  SELECT count(*) INTO :ll_chdCnt FROM TMSTPARTCYCLE A 
		WHERE A.AreaCode 		= :lstr_partKb.areaCode 	AND
				A.DivisionCode = :lstr_partKb.divCode 		
		USING sqlpis ;
	Case 2
	  SELECT count(*) INTO :ll_chdCnt FROM TMSTPARTKB A 
		WHERE A.AreaCode 		= :lstr_partKb.areaCode 	AND
				A.DivisionCode = :lstr_partKb.divCode 		AND
				A.SupplierCode = :lstr_partKb.suppCode
		USING sqlpis ;
	Case 3
//	  SELECT count(*) INTO :ll_chdCnt FROM TMSTPARTKB A 
//		WHERE A.AreaCode 		= :lstr_partKb.areaCode 	AND
//				A.DivisionCode = :lstr_partKb.divCode 		AND
//				A.SupplierCode = :lstr_partKb.suppCode		AND
//				A.ItemCode 		= :lstr_partKb.itemCode
//		USING sqlpis ;
End Choose 
If ll_chdCnt > 0 Then lb_chdChk = True 
ltvi_item.Children = lb_chdChk
This.SetItem(al_hnd, ltvi_item)

Return lb_chdChk 
end function

public function integer uf_settartv (ref treeview atv_tar);Integer li_tartvCnt 

li_tartvCnt = UpperBound(itv_tar)
li_tartvCnt ++
itv_tar[li_tartvCnt] = atv_tar

Return li_tartvCnt
end function

public function long uf_additem (str_pisr_partkb astr_partkb);Long ll_findHandle, ll_parHandle

ll_findHandle = uf_findItem(astr_partKb, ll_parHandle)
Do While ll_findHandle < 0 
	ll_parHandle = uf_insertItem(ll_parHandle, astr_partKb)
	ll_findHandle = uf_findItem(astr_partKb, ll_parHandle)
Loop

This.SelectItem(ll_findHandle)

Return 1 
end function

public function long uf_insertitem (long al_parhandle, str_pisr_partkb astr_data);TreeViewItem tvi_Item, tvi_parItem 
str_pisr_partKb lstr_partKB 
Integer li_Level 
String ls_Label 

If al_parhandle = 0 Then 
	li_Level = 1 
Else
	If This.GetItem(al_parhandle, tvi_parItem) = -1 Then Return -1 
	li_Level = tvi_parItem.Level + 1 
End If 
tvi_Item.PictureIndex = li_Level; tvi_Item.SelectedPictureIndex = li_Level

Choose Case li_Level 
	Case 1
	  SELECT DivisionName INTO :ls_Label FROM TMSTDIVISION  
		WHERE AreaCode 		= :astr_data.areaCode 	AND
		      DivisionCode 	= :astr_data.divCode 
		USING sqlpis	;
//		lstr_partKB.areaCode = astr_data.areaCode 
		lstr_partKB.divCode 	= astr_data.divCode 
	Case 2
	  SELECT SupplierKorName INTO :ls_Label FROM TMSTSUPPLIER  
		WHERE SupplierCode 	= :astr_data.suppCode 
	Order By	SupplierKorName
		USING	sqlpis	;
//		lstr_partKB.areaCode = astr_data.areaCode 
		lstr_partKB.divCode 	= astr_data.divCode; lstr_partKB.suppCode = astr_data.suppCode
	Case 3
	  SELECT ItemName INTO :ls_Label FROM TMSTITEM  
		WHERE ItemCode 		= :astr_data.ItemCode 
	Order By ItemCode
		USING	sqlpis	;
//		lstr_partKB.areaCode = astr_data.areaCode 
		lstr_partKB.divCode 	= astr_data.divCode; lstr_partKB.suppCode = astr_data.suppCode; lstr_partKB.itemCode = astr_data.ItemCode
End Choose 
tvi_Item.Label = ls_label; tvi_Item.Data = lstr_partKB 

Return This.InsertItemSort(al_parhandle, tvi_Item)

end function

public function integer uf_setitem (string as_areacode, string as_divcode, string as_suppcode, long al_supphandle);TreeViewItem ltvi_Item 
String ls_itemCode, ls_itemName 
Long ll_itemHandle, ll_selHandle
str_pisr_partKB lstr_partKB 

 DECLARE cur_PARTKB_item CURSOR FOR  
  SELECT TMSTPARTKB.ItemCode, TMSTITEM.ItemName  
    FROM TMSTPARTKB,   
         TMSTITEM  
   WHERE TMSTPARTKB.ItemCode = TMSTITEM.ItemCode  And
	      ( TMSTPARTKB.AreaCode 	  = :as_areaCode And 
			  TMSTPARTKB.DivisionCode = :as_divCode  And 
			  TMSTPARTKB.SupplierCode = :as_suppCode  ) 
Order By TMSTPARTKB.ItemCode
   USING sqlpis;
Open cur_PARTKB_item;
Fetch cur_PARTKB_item Into :ls_itemCode, :ls_itemName ;
Do While Sqlpis.Sqlcode = 0 
	lstr_partKB.areaCode = as_areacode; lstr_partKB.divCode = as_divcode; 
	lstr_partKB.suppCode = as_suppcode; lstr_partKB.itemCode = ls_itemCode 
	ltvi_Item.PictureIndex = 3; ltvi_Item.SelectedPictureIndex	= 3
	ltvi_Item.Label = ls_itemName + ' [' + ls_itemCode + ']'; ltvi_Item.Data = lstr_partKB 
//	ltvi_Item.Label = ls_itemName; ltvi_Item.Data = lstr_partKB 
	ll_itemHandle = This.InsertItemLast(al_supphandle, ltvi_Item)
	If ll_selHandle <= 0 Then ll_selHandle = ll_itemHandle
	Fetch cur_PARTKB_item Into :ls_itemCode, :ls_itemName ;
Loop
Close cur_PARTKB_item ;

This.SelectItem(ll_selHandle)

Return 1 
end function

public function integer uf_set_inittv (string as_areacode, string as_divcode, boolean as_applyfilter);Long ll_tvihdl = 0, ll_divHandle, ll_rootHandle = 0, ll_selHandle = 0 
String ls_divCode, ls_divName 
TreeviewItem ltvi_Item 
str_pisr_partKb lstr_partKB

if isnull(as_applyfilter) then
	ib_applyfilter = true
else
	ib_applyfilter = as_applyfilter
end if

DO UNTIL This.FindItem(RootTreeItem!, 0) = -1 
	This.DeleteItem(ll_tvihdl)
LOOP

 DECLARE cur_PARTKB_Division CURSOR FOR  
  SELECT DivisionCode, 
  			DivisionName  
    FROM TMSTDIVISION 
   WHERE AreaCode 		= 		:as_areacode AND 
	      DivisionCode 	LIKE 	:as_divcode 
	USING sqlpis	;
Open cur_PARTKB_Division ;
Fetch cur_PARTKB_Division Into :ls_divCode, :ls_divName ;

Do While Sqlpis.Sqlcode = 0 
	lstr_partKB.areaCode = as_areacode 
	lstr_partKB.divCode 	= ls_divCode 
	ltvi_Item.PictureIndex = 1; ltvi_Item.SelectedPictureIndex = 1 
	ltvi_Item.Label = ls_divName; ltvi_Item.Data = lstr_partKB 
////	ltvi_Item.children = true
	
	ll_divHandle = This.InsertItemLast ( ll_rootHandle, ltvi_Item )
	If ll_selHandle = 0 Then ll_selHandle = ll_divHandle 
	uf_getChild(ll_divHandle) 
////	If uf_setSupp(ls_areaCode, ls_divCode, ll_divHandle) = -1 Then Exit 
	Fetch cur_PARTKB_Division Into :ls_divCode, :ls_divName ;
Loop
Close cur_PARTKB_Division ;

This.Event ItemExpanded ( ll_selHandle )
This.ExpandItem(ll_selHandle) 

Return 1 
end function

public function integer uf_setsupp (string as_areacode, string as_divcode, integer al_divhandle);String ls_suppCode, ls_suppName, ls_suppNation, ls_suppXstop
Long ll_suppHandle, ll_selHandle 
TreeviewItem ltvi_Item 
str_pisr_partKB lstr_partKB 
String ls_MaxDate = '9999.12.31'

 DECLARE cur_PARTKB_Supplier CURSOR FOR 
  SELECT TMSTPARTCYCLE.SupplierCode,   
         TMSTSUPPLIER.SupplierKorName,
			TMSTSUPPLIER.SupplierNation,
			TMSTSUPPLIER.Xstop
    FROM TMSTPARTCYCLE,   
         TMSTSUPPLIER  
   WHERE TMSTPARTCYCLE.SupplierCode = TMSTSUPPLIER.SupplierCode  and
			ISNULL(TMSTSUPPLIER.Xstop,'')  <> 'X' AND
         TMSTPARTCYCLE.AreaCode 		= :as_areaCode   AND
         TMSTPARTCYCLE.DivisionCode = :as_divCode    AND
         TMSTPARTCYCLE.ApplyTo		= :ls_MaxDate	AND
			TMSTPARTCYCLE.SupplierCode NOT IN 
			( SELECT AA.SUPPLIERCODE FROM TMSTPARTKB AA 
				WHERE AA.AREACODE = :as_areaCode AND AA.DIVISIONCODE = :as_divCode )
	UNION ALL
  SELECT TMSTPARTCYCLE.SupplierCode,   
         TMSTSUPPLIER.SupplierKorName,
			TMSTSUPPLIER.SupplierNation,
			TMSTSUPPLIER.Xstop
    FROM TMSTPARTCYCLE,   
         TMSTSUPPLIER  
   WHERE TMSTPARTCYCLE.SupplierCode = TMSTSUPPLIER.SupplierCode  and
			ISNULL(TMSTSUPPLIER.Xstop,'')  <> 'X' AND
         TMSTPARTCYCLE.AreaCode 		= :as_areaCode   AND
         TMSTPARTCYCLE.DivisionCode = :as_divCode    AND
         TMSTPARTCYCLE.ApplyTo		= :ls_MaxDate	AND
			TMSTPARTCYCLE.SupplierCode IN 
			( SELECT TMP.SUPP FROM ( SELECT SUPPLIERCODE AS SUPP, COUNT(*) AS CNT FROM TMSTPARTKB
				WHERE AreaCode = :as_areaCode AND DivisionCode = :as_divCode AND
					USEFLAG <> 'Y' 
				GROUP BY SUPPLIERCODE
				HAVING  COUNT(*) > 0  ) TMP )
	UNION ALL
	SELECT TMSTPARTCYCLE.SupplierCode,   
         TMSTSUPPLIER.SupplierKorName,
			TMSTSUPPLIER.SupplierNation,
			'X'
    FROM TMSTPARTCYCLE,   
         TMSTSUPPLIER  
   WHERE TMSTPARTCYCLE.SupplierCode = TMSTSUPPLIER.SupplierCode  and
			ISNULL(TMSTSUPPLIER.Xstop,'')  <> 'X' AND
         TMSTPARTCYCLE.AreaCode 		= :as_areaCode   AND
         TMSTPARTCYCLE.DivisionCode = :as_divCode    AND
         TMSTPARTCYCLE.ApplyTo		= :ls_MaxDate	AND
			TMSTPARTCYCLE.SupplierCode IN 
			( SELECT TMP.SUPP FROM ( SELECT SUPPLIERCODE AS SUPP, COUNT(*) AS CNT FROM TMSTPARTKB
				WHERE AreaCode = :as_areaCode AND DivisionCode = :as_divCode AND
					USEFLAG = 'Y' 
				GROUP BY SUPPLIERCODE
				HAVING  COUNT(*) > 0  ) TMP )
	UNION ALL
	SELECT TMSTPARTCYCLE.SupplierCode,   
         TMSTSUPPLIER.SupplierKorName,
			TMSTSUPPLIER.SupplierNation,
			'O'
    FROM TMSTPARTCYCLE,   
         TMSTSUPPLIER  
   WHERE TMSTPARTCYCLE.SupplierCode = TMSTSUPPLIER.SupplierCode  and
			ISNULL(TMSTSUPPLIER.Xstop,'')  = 'X' AND
         TMSTPARTCYCLE.AreaCode 		= :as_areaCode   AND
         TMSTPARTCYCLE.DivisionCode = :as_divCode    AND
         TMSTPARTCYCLE.ApplyTo		= :ls_MaxDate	AND
			TMSTPARTCYCLE.SupplierCode IN 
			( SELECT TMP.SUPP FROM ( SELECT SUPPLIERCODE AS SUPP, COUNT(*) AS CNT FROM TMSTPARTKB
				WHERE AreaCode = :as_areaCode AND DivisionCode = :as_divCode AND
					USEFLAG <> 'Y' 
				GROUP BY SUPPLIERCODE
				HAVING  COUNT(*) > 0  ) TMP )
	UNION ALL
	SELECT TMSTPARTCYCLE.SupplierCode,   
         TMSTSUPPLIER.SupplierKorName,
			TMSTSUPPLIER.SupplierNation,
			'X'
    FROM TMSTPARTCYCLE,   
         TMSTSUPPLIER  
   WHERE TMSTPARTCYCLE.SupplierCode = TMSTSUPPLIER.SupplierCode  and
			ISNULL(TMSTSUPPLIER.Xstop,'')  = 'X' AND
         TMSTPARTCYCLE.AreaCode 		= :as_areaCode   AND
         TMSTPARTCYCLE.DivisionCode = :as_divCode    AND
         TMSTPARTCYCLE.ApplyTo		= :ls_MaxDate	AND
			TMSTPARTCYCLE.SupplierCode IN 
			( SELECT TMP.SUPP FROM ( SELECT SUPPLIERCODE AS SUPP, COUNT(*) AS CNT FROM TMSTPARTKB
				WHERE AreaCode = :as_areaCode AND DivisionCode = :as_divCode AND
					USEFLAG = 'Y' 
				GROUP BY SUPPLIERCODE
				HAVING  COUNT(*) > 0  ) TMP )
Order By TMSTSUPPLIER.SupplierNation
	USING sqlpis	;
Open cur_PARTKB_Supplier ;
Fetch cur_PARTKB_Supplier Into :ls_suppCode, :ls_suppName, :ls_suppNation, :ls_suppXstop ;
Do While Sqlpis.Sqlcode = 0
	If ib_applyfilter Then
		If ls_suppXstop <> 'X' or isnull(ls_suppXstop) Then
			lstr_partKB.areaCode = as_areacode; lstr_partKB.divCode = as_divcode; lstr_partKB.suppCode = ls_suppCode 
			ltvi_Item.PictureIndex = 2; ltvi_Item.SelectedPictureIndex = 2 
			ltvi_Item.Label = ls_suppName; ltvi_Item.Data = lstr_partKB 
			ll_suppHandle = This.InsertItemLast ( al_divhandle, ltvi_Item )
			If ii_levelgubun = 3 Then 
				uf_getChild(ll_suppHandle)
		//		If uf_setitem(as_divcode, ls_suppCode, ll_suppHandle) = -1 Then Exit
			End If 
			If ll_selHandle <= 0 Then ll_selHandle = ll_suppHandle 
		End If
	Else
		If ls_suppXstop = 'X' Then
			lstr_partKB.areaCode = as_areacode; lstr_partKB.divCode = as_divcode; lstr_partKB.suppCode = ls_suppCode 
			ltvi_Item.PictureIndex = 2; ltvi_Item.SelectedPictureIndex = 2 
			ltvi_Item.Label = ls_suppName; ltvi_Item.Data = lstr_partKB 
			ll_suppHandle = This.InsertItemLast ( al_divhandle, ltvi_Item )
			If ii_levelgubun = 3 Then 
				uf_getChild(ll_suppHandle)
		//		If uf_setitem(as_divcode, ls_suppCode, ll_suppHandle) = -1 Then Exit
			End If 
			If ll_selHandle <= 0 Then ll_selHandle = ll_suppHandle 
		End If
	End If
	Fetch cur_PARTKB_Supplier Into :ls_suppCode, :ls_suppName, :ls_suppNation, :ls_suppXstop ;
Loop
Close cur_PARTKB_Supplier ;

//If ii_levelgubun = 3 Then 
//	This.Event ItemExpanded ( ll_selHandle )
//	This.ExpandItem(ll_selHandle) 
//Else
	This.SelectItem (ll_selHandle)
//End If 

Return 1 
end function

event selectionchanged;TreeViewItem ltvi_Item 
Integer I 
Long ll_selHnd 

If This.GetItem(newhandle, ltvi_Item) < 0 Then Return 
uistr_partKB = ltvi_Item.Data 
ii_selLevel = ltvi_Item.Level 

For I = 1 To UpperBound(itv_tar)
	ll_selHnd = uf_findEqualLevel(itv_tar[I])
   If ll_selHnd > 0 Then itv_tar[I].SelectItem(ll_selHnd)
Next 
end event

event itemcollapsed;TreeviewItem ltvi_Item 
If GetItem(handle, ltvi_Item) < 0 Then Return 

ltvi_Item.PictureIndex = 4; ltvi_Item.SelectedPictureIndex = 4 
SetItem(handle, ltvi_Item) 

SetRedraw(True) 
end event

on u_pisr_treeview.create
end on

on u_pisr_treeview.destroy
end on

event itemexpanding;TreeviewItem ltvi_Item 
str_pisr_partKb lstr_partKb 
If GetItem(handle, ltvi_Item) < 0 Then Return 

ltvi_Item.PictureIndex = 5; ltvi_Item.SelectedPictureIndex = 5 
SetItem(handle, ltvi_Item) 
lstr_partKb = ltvi_Item.Data 
If This.FindItem(ChildTreeItem!, handle) > 0 Then Return 
Choose Case ltvi_Item.Level
	Case 1
		uf_setSupp(lstr_partKb.areaCode, lstr_partKb.divCode, handle)
	Case 2
		uf_setItem(lstr_partKb.areaCode, lstr_partKb.divCode, lstr_partKb.suppCode, handle)
	Case 3
End Choose 

SetRedraw(True) 
end event

