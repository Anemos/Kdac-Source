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

event open;INTEGER			li_num_header_texts		//Header band�� �ִ� ��� text�� 
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

//ButtionFace Color ���� 
dw_1.Object.cf_btnface.Expression = String(this.BackColor)

lstr_parm = message.powerobjectparm

//Sort��� Datawindow
idw_dw = lstr_parm.dw
//Title
is_title = lstr_parm.title
this.title = "����(Sort) - " + is_title
//visible�� �� colulmn list�� ���� ��ȯ

li_num_header_texts = f_dw_get_objects_attrib(idw_dw,ls_texts, "text","header","text")
li_cnt = 1
FOR li_i = 1 TO li_num_header_texts
	//Header�� �ִ� Text�� ���Ѵ� 
	ls_text_name =  f_get_token(ls_texts[li_i],'~n') 
	
//	//text�̸��� '_s'�� ���Ե� column�� ���ؼ��� sort���� 
//	IF Right(ls_text_name,2) <> "_s" AND Pos(ls_text_name,"_s_") < 1 THEN CONTINUE

	//text�̸��� '_s' �Ǵ� '_s_f' �� ���Ե� column�� ���ؼ��� sort���� 
	IF Pos(ls_text_name,"_s_") >= 1 THEN
		//�ش� text�� �ش�Ǵ� column�� �ִ��� 
		//text�̸��� column_name + '_s_f"�� �����Ǿ� �ִٰ� ���� 
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
	
	//�׷� �̸��� column�� ������ CONTINUE
	IF ls_col_name = "!" THEN CONTINUE
	ls_label = f_get_token(ls_texts[li_i],'~n') 
	//���� ��� Sort Skip
	IF ls_label = "!" THEN CONTINUE
	
	//���� Sort��� column�� ���ҳ�..���� 
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

//Sort�׸��� �������� window�� ũ�⸦ �ٲ�
IF li_num_cols > 8 THEN li_num_cols = 8		//�ִ� 8���� �� Ŀ��. �� ���Ĵ� scroll bar ó��

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
string facename = "����"
string text = "���(&C)"
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
string facename = "����"
string text = "Ȯ��(&O)"
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
		messagebox(is_title,"������ �����Ҽ� ���� �����Դϴ�. " + ls_sort_list)
		RETURN
	END IF
	IF idw_dw.sort() <> 1 THEN 
		messagebox(is_title,"������ �����Ҽ� �����ϴ�. " + ls_sort_list)
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

