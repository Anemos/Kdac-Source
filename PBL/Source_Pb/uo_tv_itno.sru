$PBExportHeader$uo_tv_itno.sru
$PBExportComments$TreeView (물성분류체계)
forward
global type uo_tv_itno from treeview
end type
end forward

global type uo_tv_itno from treeview
integer width = 1161
integer height = 1696
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string picturename[] = {"Custom039!","Custom050!"}
long picturemaskcolor = 536870912
string statepicturename[] = {"LibraryOpen!","Library5!"}
long statepicturemaskcolor = 536870912
event ue_construct ( string ag_gubun )
end type
global uo_tv_itno uo_tv_itno

type variables
datastore i_ds_data[8]
string root_nm , i_s_gubun
long i_n_gubun
end variables

forward prototypes
public subroutine uf_set_items (integer ag_level, long ag_rows, ref treeviewitem ag_tvi)
public subroutine uf_itempopulate (long ag_handle, ref treeview ag_tvcurrent)
public function long uf_add_items (long ag_handle, integer ag_level, long ag_rows, ref treeview ag_treeview)
public function long uf_get_handle (string ag_item)
end prototypes

event ue_construct(string ag_gubun);//초기화 (1레벨)
//간접제('0'),  업무지원품('1')
Treeviewitem l_tvi_root 
long ln_i ,ln_rows , ln_root, ln_tvi_hdl = 0

i_s_gubun = ag_gubun

DO UNTIL This.FindItem(RootTreeItem!, 0) = -1
		This.DeleteItem(ln_tvi_hdl)
LOOP

For ln_i = 1 to 4
	 i_ds_data[ln_i].reset()
Next

ln_rows = i_ds_data[1].retrieve(i_s_gubun)

For ln_i= 1 to ln_rows
	l_tvi_root.Label = trim(i_ds_data[1].object.bjdesc[ln_i]) + ' (' + i_ds_data[1].object.inl[ln_i] + ')'
	l_tvi_root.Data  = i_ds_data[1].object.inl[ln_i]
	l_tvi_root.Pictureindex = 1
	l_tvi_root.SelectedPictureIndex = 2
	l_tvi_root.Children = true
	ln_root = This.InsertItemLast(0,l_tvi_root)
Next



end event

public subroutine uf_set_items (integer ag_level, long ag_rows, ref treeviewitem ag_tvi);/////////////////////////////////////////////////////////////
//  Set the Label and Item Attribute for the TreeviewItem  //
/////////////////////////////////////////////////////////////

int li_cnt_level
string l_s_data ,l_s_data1, l_s_dsp

Choose case ag_level
	case 1
		l_s_dsp = i_ds_data[ag_level + 1].object.bjdesc[ag_rows]		
		l_s_data = i_ds_data[ag_level + 1].object.fst[ag_rows]
		l_s_data1 =i_ds_data[ag_level + 1].object.inl[ag_rows] + l_s_data
				
		ag_tvi.label = trim(l_s_dsp) + "(" + l_s_data + ")"
		ag_tvi.data = l_s_data
		ag_tvi.expanded = false
		ag_tvi.children = true		
		
	case 2
		l_s_dsp = i_ds_data[ag_level + 1].object.bjdesc[ag_rows]
		l_s_data = i_ds_data[ag_level + 1].object.snd[ag_rows]
		l_s_data1 =i_ds_data[ag_level + 1].object.inl[ag_rows] + i_ds_data[ag_level + 1].object.fst[ag_rows] &
		           + l_s_data
		
		ag_tvi.label = trim(l_s_dsp) + "(" + l_s_data + ")"
		ag_tvi.data = l_s_data
		ag_tvi.expanded = false
		ag_tvi.children = true
		
	case 3
		l_s_dsp = i_ds_data[ag_level + 1].object.bjdesc[ag_rows]
		l_s_data = i_ds_data[ag_level + 1].object.thd[ag_rows]
		l_s_data1 =i_ds_data[ag_level + 1].object.inl[ag_rows] + i_ds_data[ag_level + 1].object.fst[ag_rows] &
		           + i_ds_data[ag_level + 1].object.snd[ag_rows] + l_s_data
					  
		ag_tvi.label = trim(l_s_dsp) + "(" + l_s_data + ")"
		ag_tvi.data = l_s_data
		ag_tvi.expanded = false
		ag_tvi.children = false	
End Choose

ag_tvi.SelectedPictureIndex = 2
ag_tvi.PictureIndex = 1


end subroutine

public subroutine uf_itempopulate (long ag_handle, ref treeview ag_tvcurrent);////////////////////////////////////////////////////
//   TreeView에 TreeViewItem의 값들을 Add 한다    //
//    - uf_add_items : tvi 부여                   // 
//    - uf_set_items : tvi에 속성값 setting       // 
////////////////////////////////////////////////////	  

integer li_level ,li_cnt_level
long ln_Phandle, ln_PPhandle, ln_PPPhandle , ln_rows
string ls_inl, ls_fst, ls_snd

TreeViewItem l_tvi_cur

//Determine the level
ag_tvcurrent.GetItem(ag_handle,l_tvi_cur)
li_level = l_tvi_cur.Level

//하위 Item 부여
Choose case li_level 
	case 1
		ls_inl = l_tvi_cur.Data
		i_ds_data[li_level +1].reset()
		ln_rows = i_ds_data[li_level+1].retrieve(ls_inl,i_s_gubun)
		
		IF ln_rows > 0 Then
			uf_add_items(ag_handle,li_level,ln_rows,ag_tvcurrent)
		End IF
		
	case 2
		ls_fst = trim(l_tvi_cur.Data)
		
		ln_phandle = ag_tvcurrent.finditem(parenttreeitem!,ag_handle)
		ag_tvcurrent.GetItem(ln_phandle, l_tvi_Cur)		
		ls_inl = trim(l_tvi_cur.Data)		
		
		i_ds_data[li_level+1].reset()
		ln_rows = i_ds_data[li_level+1].retrieve(ls_inl,ls_fst,i_s_gubun)
		
		IF ln_rows > 0 Then
			uf_add_items(ag_handle,li_level,ln_rows,ag_tvcurrent)
		End IF
	case 3
		ls_snd = trim(l_tvi_cur.Data)
		
		ln_phandle = ag_tvcurrent.finditem(parenttreeitem!,ag_handle)
		ag_tvcurrent.GetItem(ln_phandle, l_tvi_Cur)		
		ls_fst = trim(l_tvi_cur.Data)
			
		ln_pphandle = ag_tvcurrent.finditem(parenttreeitem!,ln_phandle)
		ag_tvcurrent.getitem(ln_pphandle,l_tvi_cur)		
		ls_inl = trim(l_tvi_cur.Data)		
		
		i_ds_data[li_level+1].reset()
		ln_rows = i_ds_data[li_level+1].retrieve(ls_inl,ls_fst,ls_snd,i_s_gubun)
		
		IF ln_rows > 0 Then
			uf_add_items(ag_handle,li_level,ln_rows,ag_tvcurrent)
		End IF
		
End Choose


end subroutine

public function long uf_add_items (long ag_handle, integer ag_level, long ag_rows, ref treeview ag_treeview);long l_n_cnt
TreeViewItem l_tvi_new

For l_n_cnt = 1 to ag_rows
	//Set the item in the treeview
	uf_set_items(ag_level,l_n_cnt,l_tvi_new)

	//Add the item in the treeview
	IF ag_treeview.InsertItemLast(ag_handle,l_tvi_new) < 1 Then
		return -1
	End IF
Next

return ag_rows
end function

public function long uf_get_handle (string ag_item);long ln_i , ln_row , ln_handle
ln_row = i_ds_data[1].RowCount()
TreeView l_tv
l_tv = uo_tv_itno

For ln_i =1 to ln_row	
	IF i_ds_data[1].object.inl[ln_i] = ag_item Then
		//l_tv.FindItem
		ln_handle = l_tv.FindItem(parenttreeitem!,ln_i)
		Exit		
	Else 
		ln_handle = -1
	End IF
Next
Return ln_handle
end function

on uo_tv_itno.create
end on

on uo_tv_itno.destroy
end on

event constructor;integer li_cnt

//create datastore
//간접제
For li_cnt = 1 to 4
	i_ds_data[li_cnt] = create datastore
Next 
//i_ds_data[1].dataobject = "dddw_pur000inl01"  //물성분류
//i_ds_data[2].dataobject = "dddw_pur000fst01"  //대분류
//i_ds_data[3].dataobject = "dddw_pur000snd01"  //중분류
//i_ds_data[4].dataobject = "dddw_pur000thd01"  //소분류

i_ds_data[1].dataobject = "dddw_pur010_ifst01"  //물성분류
i_ds_data[2].dataobject = "dddw_pur010_ifst02"  //대분류
i_ds_data[3].dataobject = "dddw_pur010_ifst03"  //중분류
i_ds_data[4].dataobject = "dddw_pur010_ifst04"  //소분류

//datastroe db connection
//간접제
For li_cnt = 1 to 4
	i_ds_data[li_cnt].SetTransObject(sqlca)
Next 


end event

event destructor;integer li_cnt
//간접제
for li_cnt = 1 to 4
	destroy i_ds_data[li_cnt]
next
//업무지원품

end event

event itempopulate;integer l_n_level
TreeViewItem l_tvi_current
TreeView l_tv

//Determin the level 
This.GetItem(handle,l_tvi_current)
l_n_level = l_tvi_current.level

IF l_n_level > 4 Then return
l_tv = This
// 하위 tvi 할당
uf_itempopulate(handle, l_tv)
end event

