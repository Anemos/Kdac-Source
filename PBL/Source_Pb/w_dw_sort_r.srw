$PBExportHeader$w_dw_sort_r.srw
$PBExportComments$dw sort
forward
global type w_dw_sort_r from window
end type
type cb_cancel from commandbutton within w_dw_sort_r
end type
type cb_ok from commandbutton within w_dw_sort_r
end type
type dw_1 from datawindow within w_dw_sort_r
end type
end forward

global type w_dw_sort_r from window
integer x = 581
integer y = 568
integer width = 2094
integer height = 1260
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 81839288
cb_cancel cb_cancel
cb_ok cb_ok
dw_1 dw_1
end type
global w_dw_sort_r w_dw_sort_r

type variables
datawindow idw_dw
string is_title

end variables

event open;INTEGER			li_num_header_texts		//Header band에 있는 모든 text들 
STRING			ls_cols[]
STRING			ls_texts[]
STRING			ls_label
STRING			ls_tmp
STRING			ls_resp
STRING			ls_col
STRING			ls_vis
STRING			ls_col_name
STRING			ls_text_name
INTEGER			li_num_cols
INTEGER			li_i
INTEGER			li_cnt
STR_SORT 		lstr_parm

f_pisc_win_center_move(This)

//ButtionFace Color 설정 
dw_1.Object.cf_btnface.Expression = String(this.BackColor)

lstr_parm = message.powerobjectparm

//Sort대상 Datawindow
idw_dw = lstr_parm.dw
//Title
is_title = lstr_parm.title
this.title = "정렬(Sort) - " + is_title
//visible로 된 colulmn list와 수를 반환

li_num_header_texts = f_dw_get_objects_attrib(idw_dw,ls_texts, "text","header","text")
li_cnt = 1
FOR li_i = 1 TO li_num_header_texts
	//Header에 있는 Text를 구한다 
	ls_text_name =  f_get_token(ls_texts[li_i],'~n') 
	
//	//text이름에 '_s'가 포함된 column애 대해서만 sort수행 
//	IF Right(ls_text_name,2) <> "_s" AND Pos(ls_text_name,"_s_") < 1 THEN CONTINUE

	//text이름에 '_s' 또는 '_s_f' 가 포함된 column애 대해서만 sort수행 
	IF Pos(ls_text_name,"_s_") >= 1 THEN
		//해당 text에 해당되는 column이 있는지 
		//text이름은 column_name + '_s_f"로 구성되어 있다고 가정 
		IF Len(ls_text_name) <= 4 THEN CONTINUE
		ls_col_name = Left(ls_text_name,Len(ls_text_name) - 4)
		ls_col_name = idw_dw.Describe( ls_col_name + ".name")
	ELSEIF Right(ls_text_name,2) = "_s" THEN
		IF Len(ls_text_name) <= 2 THEN CONTINUE
		ls_col_name = Left(ls_text_name,Len(ls_text_name) - 2)
		ls_col_name = idw_dw.Describe( ls_col_name + ".name")
	ELSE
		CONTINUE
	END IF		
	
	//그런 이름의 column이 없으면 CONTINUE
	IF ls_col_name = "!" THEN CONTINUE
	ls_label = f_get_token(ls_texts[li_i],'~n') 
	//라벨이 없어도 Sort Skip
	IF ls_label = "!" THEN CONTINUE
	
	//이제 Sort대상 column만 남았네..허허 
	ls_label = f_global_replace(ls_label,"~r~n"," ") // replace ~r~n with a space
	ls_label = f_global_replace(ls_label,"~r"," ") // replace ~r with a space
	ls_label = f_global_replace(ls_label,'"','') // remove any " 
	dw_1.Setvalue('col',li_cnt,ls_label+'~t'+ls_col_name)
	li_cnt++
	dw_1.Insertrow(0)
NEXT
li_num_cols = li_cnt

dw_1.SetValue('col', li_cnt, '~t' ) // add a blank line so they can cancel
// only show the direction RB's if there is something in the row
ls_resp = dw_1.Modify("direction.visible = '0~t if(len(col)>0,1,0)'")
IF Len(ls_resp) > 0 THEN Messagebox("", ls_resp )

// SHow the current sort, if there is one
ls_label = idw_dw.Describe('datawindow.table.sort')
IF Right(ls_label,1) = '!' THEN
	 ls_label = Left(ls_label,Len(ls_label) - 1)
END IF
li_cnt = 0
DO WHILE Len(ls_label) > 1 
	ls_tmp = Trim(f_get_token(ls_label,','))
	//Col
	ls_col = f_get_token(ls_tmp,' ')	
	//Direction
	ls_tmp = Upper(Left(ls_tmp,1))
	li_cnt++
	dw_1.SetItem(li_cnt,'col',ls_col)
	dw_1.SetItem(li_cnt,'direction',ls_tmp)
LOOP

//Sort항목의 수에따라 window의 크기를 바꿈
IF li_num_cols > 8 THEN li_num_cols = 8		//최대 8까지 만 커짐. 그 이후는 scroll bar 처리

dw_1.height = 100 + li_num_cols * Integer(dw_1.Describe('datawindow.detail.height'))
cb_ok.y = dw_1.height + 20
cb_cancel.y = cb_ok.y

this.height = cb_ok.y + cb_ok.height + 150
end event

on w_dw_sort_r.create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_1=create dw_1
this.Control[]={this.cb_cancel,&
this.cb_ok,&
this.dw_1}
end on

on w_dw_sort_r.destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

type cb_cancel from commandbutton within w_dw_sort_r
integer x = 1353
integer y = 1044
integer width = 306
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "취소(&C)"
boolean cancel = true
end type

event clicked;Close(PARENT)
end event

type cb_ok from commandbutton within w_dw_sort_r
integer x = 421
integer y = 1044
integer width = 311
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "확인(&O)"
boolean default = true
end type

event clicked;INTEGER		li_i
INTEGER		li_cnt
STRING		ls_sort_list
STRING		ls_tmp
li_cnt = dw_1.rowcount()
FOR li_i = 1 TO li_cnt
	ls_tmp = dw_1.getitemstring(li_i,'col')
	IF len(trim(ls_tmp)) > 0 THEN
		ls_tmp = ls_tmp + ' ' + dw_1.getitemstring(li_i,'Direction')
		IF len(ls_sort_list) > 0 THEN
			ls_sort_list = ls_sort_list + ', ' + ls_tmp
		ELSE
			ls_sort_list = ls_tmp
		END IF
	END IF
next

IF len(ls_sort_list) > 0 THEN
	IF idw_dw.setsort(ls_sort_list) <> 1 THEN 
		messagebox(is_title,"정렬을 수행할수 없는 내용입니다. " + ls_sort_list)
		RETURN
	END IF
	IF idw_dw.sort() <> 1 THEN 
		messagebox(is_title,"정렬을 수행할수 없습니다. " + ls_sort_list)
		RETURN
	END IF
END IF

Close(PARENT)

end event

type dw_1 from datawindow within w_dw_sort_r
integer x = 27
integer y = 20
integer width = 2007
integer height = 992
integer taborder = 30
string dataobject = "d_ex_tb_sort"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

