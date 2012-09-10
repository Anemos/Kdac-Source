$PBExportHeader$u_pism_tv_divmod.sru
$PBExportComments$공장별 완제품 - Treeview
forward
global type u_pism_tv_divmod from treeview
end type
end forward

global type u_pism_tv_divmod from treeview
integer width = 549
integer height = 452
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean linesatroot = true
boolean hideselection = false
string picturename[] = {"Library!","Custom039!","Custom039!","Project!","Custom050!"}
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type
global u_pism_tv_divmod u_pism_tv_divmod

type variables
DataStore ids_divmod
String is_area, is_div, is_dispDay 
end variables

forward prototypes
public function integer uf_setdivmod (long al_divhandle, string as_prodgroup, string as_modgroup)
public function integer uf_setdivprod (string as_area, string as_div, string as_dispday)
end prototypes

public function integer uf_setdivmod (long al_divhandle, string as_prodgroup, string as_modgroup);Int i, li_cnt
Long ll_Roothandle, ll_selHanble, ll_handle
String ls_divmodNo, ls_divmodName 
TreeviewItem ltvi_Item 

ids_divmod.DataObject = 'd_pism_divmod_tv'	
ids_divmod.SetTransObject(SqlPIS) 
li_cnt = ids_divmod.Retrieve(is_area, is_div, as_prodgroup, as_modGroup, is_dispDay)	 

For i = 1 To li_cnt 
	ls_divmodNo = ids_divmod.GetitemString(I, "tmstbomdata_bmdno") 
	ls_divmodName = ids_divmod.GetItemString( i, 'tmstitem_itemname' ) 

	ltvi_Item.Data = ls_divmodNo  
	ltvi_Item.Label = ls_divmodName 
	ltvi_Item.SelectedPictureIndex = 4; ltvi_Item.PictureIndex = 4 
	
	ll_handle = This.InsertItemLast( al_divHandle, ltvi_Item ) 
//	If ll_selHanble = 0 Then ll_selHanble = ll_handle 
Next 

Return 1 
end function

public function integer uf_setdivprod (string as_area, string as_div, string as_dispday);Integer i, li_level = 1 
Long ll_cnt, ll_handle[], ll_selHanble, ll_modCnt 
String ls_Data, ls_divName 
TreeviewItem ltvi_Item 

This.DeleteItem(0) 

  SELECT DivisionName INTO :ls_divName FROM TMSTDIVISION  
   WHERE ( AreaCode = :as_area ) AND ( DivisionCode = :as_div ) Using SqlPIS ; 
ll_handle[1] = This.InsertItemLast( 0, ls_divName, 1 ) 

ids_divmod.DataObject = 'd_pism_divprodgroup_tv'	
ids_divmod.SetTransObject(SqlPIS) 
ll_cnt = ids_divmod.Retrieve(as_area, as_div)	 

For i = 1 To ll_cnt 
	li_level = ids_divmod.GetItemNumber( i, 'blev' ) 
	ltvi_Item.Label = ids_divmod.GetItemString( i, 'label' ) 
	If li_level = 1 Then 	// 제품군 
		ls_Data = ids_divmod.GetItemString( i, 'productgroup' ) 
	Else							// 모델군  
		ls_Data = ids_divmod.GetItemString( i, 'productgroup' ) 
		ls_Data = trim(ls_Data) + Space(2 - Len(trim(ls_Data))) 
		ls_Data = ls_Data + ids_divmod.GetItemString( i, 'modelgroup' ) 
	End If 
	ltvi_Item.Data = ls_Data 
	
	ll_modCnt = ids_divmod.GetItemNumber(I, "modcnt") 
	If ids_divmod.GetItemNumber(I, "modcnt")  > 0 Then 
		ltvi_Item.Children	= True 
	Else
		ltvi_Item.Children	= False 
	End If 
	ltvi_Item.SelectedPictureIndex = li_level + 1; ltvi_Item.PictureIndex = li_level + 1 
	
	ll_handle[li_level + 1] = This.InsertItemLast( ll_handle[li_level], ltvi_Item )
	If li_level = 2 And ll_selHanble = 0 Then ll_selHanble = ll_handle[li_level + 1] 
Next 

is_area = as_area; is_div = as_div; is_dispDay = as_dispDay 
This.SelectItem(ll_selHanble) 
//This.ExpandItem(ll_selHanble) 

Return 1 
end function

on u_pism_tv_divmod.create
end on

on u_pism_tv_divmod.destroy
end on

event constructor;ids_divmod = CREATE datastore 

end event

event itemcollapsed;TreeViewItem tvi_Item 

If This.GetItem ( handle, tvi_Item) = -1 Then Return 

tvi_Item.SelectedPictureIndex	= tvi_Item.Level
tvi_Item.PictureIndex	= tvi_Item.Level
This.SetItem(handle, tvi_Item) 
end event

event itemexpanding;TreeViewItem tvi_Item 
String ls_prodGroup, ls_modGruop 

If This.GetItem ( handle, tvi_Item) = -1 Then Return 
If tvi_Item.Level = 1 Then Return 

tvi_Item.SelectedPictureIndex	= 5
tvi_Item.PictureIndex	= 5 
This.SetItem(handle, tvi_Item)

If tvi_Item.Level = 2 Then Return 

// 모델군 

If This.FindItem(ChildTreeItem!, handle) > 0 Then Return 
ls_prodGroup = Left(tvi_Item.Data, 2)
ls_modGruop = Mid(tvi_Item.Data, 3, 3)  
If uf_setDivMod( handle, ls_prodGroup, ls_modGruop ) > 0 Then This.SelectItem(handle) 

end event

event selectionchanged;TreeViewItem ltvi_Item 

If This.GetItem ( newhandle, ltvi_Item) = -1 Then Return 
If ltvi_Item.Level <> 3 Then Return 

end event

