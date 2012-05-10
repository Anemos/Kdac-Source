$PBExportHeader$w_dw_filter_r.srw
$PBExportComments$dw에서 걸러보기(filter)~t
forward
global type w_dw_filter_r from window
end type
type cb_cancel from commandbutton within w_dw_filter_r
end type
type cb_ok from commandbutton within w_dw_filter_r
end type
type dw_1 from datawindow within w_dw_filter_r
end type
end forward

global type w_dw_filter_r from window
integer x = 512
integer y = 568
integer width = 2277
integer height = 1260
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 81576884
cb_cancel cb_cancel
cb_ok cb_ok
dw_1 dw_1
end type
global w_dw_filter_r w_dw_filter_r

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
INTEGER			li_cnt = 0
STR_FILTER 		lstr_parm
STRING			ls_cur_filter
INTEGER			li_and_pos
INTEGER			li_and_pos1
INTEGER			li_and_pos2
INTEGER			li_or_pos
INTEGER			li_or_pos1
INTEGER			li_or_pos2
INTEGER			li_pos
INTEGER			li_shift
STRING			ls_operator
STRING			ls_filter_text

f_pisc_win_center_move(This)

//ButtionFace Color 설정 
dw_1.Object.cf_btnface.Expression = String(this.BackColor)

lstr_parm = message.powerobjectparm

//Filter대상 Datawindow
idw_dw = lstr_parm.dw
//Title
is_title = lstr_parm.title
this.title = '걸러보기(Filter) - ' + is_title
//visible로 된 colulmn list와 수를 반환

li_num_header_texts = f_dw_get_objects_attrib(idw_dw,ls_texts, "text","header","text")
li_cnt = 1
FOR li_i = 1 TO li_num_header_texts
	//Header에 을 구한다 
	ls_text_name =  f_get_token(ls_texts[li_i],'~n') 
	//text이름에 '_f'가 포함된 column애 대해서만 filter수행 
	IF Right(ls_text_name,2) <> "_f" AND Pos(ls_text_name,"_f_") < 1 THEN CONTINUE
	//해당 text에 해당되는 column이 있는지 
	//text이름은 column_name + '_s_f"로 구성되어 있다고 가정 
	IF Len(ls_text_name) <= 4 THEN CONTINUE
	ls_col_name = Left(ls_text_name,Len(ls_text_name) - 4)
	ls_col_name = idw_dw.Describe( ls_col_name + ".name")
	//그런 이름의 column이 없으면 CONTINUE
	IF ls_col_name = "!" THEN CONTINUE
	ls_vis = idw_dw.Describe(ls_col_name + ".visible")	
	//보이는 coulnm에 대해서만 filter수행	
	//김용욱씨의 의견을 수렴하여 막음 - 필요없잖아요~
//	IF ls_vis <> "1" THEN CONTINUE
	ls_label = f_get_token(ls_texts[li_i],'~n') 
	//라벨이 없어도 filter Skip
	IF ls_label = "!" THEN CONTINUE
	
	//이제 Filter대상 column만 남았네..허허 
	ls_label = f_global_replace(ls_label,"~r~n"," ") // replace ~r~n with a space
	ls_label = f_global_replace(ls_label,"~r"," ") // replace ~r with a space
	ls_label = f_global_replace(ls_label,'"','') // remove any " 
	dw_1.Setvalue('col',li_cnt,ls_label+'~t'+ls_col_name)
	li_cnt++
	dw_1.Insertrow(0)
NEXT
li_num_cols = li_cnt

dw_1.Setvalue('col',li_cnt,'~t') // add a blank line so they can cancel
// only show the direction RB's if there is something in the row
ls_resp = dw_1.Modify("operator.visible = '0~t if(len(col)>0,1,0)'")
IF Len(ls_resp) > 0 THEN Messagebox("",ls_resp)
ls_resp = dw_1.Modify("filter_text.visible = '0~t if(len(col)>0,1,0)'")
IF Len(ls_resp) > 0 THEN Messagebox("",ls_resp)
ls_resp = dw_1.Modify("and_or.visible = '0~t if(len(col)>0,1,0)'")
IF Len(ls_resp) > 0 THEN Messagebox("",ls_resp)

//윈도우 높이 조절
IF li_num_cols > 8 THEN li_num_cols = 8
dw_1.height = 100 + li_num_cols * Integer(dw_1.Describe('datawindow.detail.height'))
cb_ok.y = dw_1.height + 20
cb_cancel.y = cb_ok.y

this.height = cb_ok.y + cb_ok.height + 150

//현재 설정되어 있는 Filter를 보인다
ls_cur_filter = idw_dw.Describe('datawindow.table.filter')
IF Right(ls_cur_filter,1) = '!' THEN ls_cur_filter = Left(ls_cur_filter,Len(ls_cur_filter) - 1)
IF ls_cur_filter = "?" THEN RETURN

/////////////////////////////////////////////////////////////////
//이전 filtering 조건 중에서 '(',')'를 제거한다. : 2002.01.11
//C. H. Jang
/////////////////////////////////////////////////////////////////
ls_cur_filter = f_global_replace(ls_cur_filter,"("," ")
ls_cur_filter = f_global_replace(ls_cur_filter,")"," ")
ls_cur_filter = f_global_replace(ls_cur_filter,"%"," ")
ls_cur_filter = Trim(ls_cur_filter)

li_cnt = 0
DO 
	//AND문의 처음찾기
	li_and_pos1 = Pos(ls_cur_filter," and ",1)
	li_and_pos2 = Pos(ls_cur_filter," AND ",1)
	IF li_and_pos1 = 0 THEN 
		li_and_pos = li_and_pos2
	ELSEIF li_and_pos2 = 0 THEN
		li_and_pos = li_and_pos1
	ELSEIF li_and_pos2 < li_and_pos1 THEN
		li_and_pos = li_and_pos2
	ELSE
		li_and_pos = li_and_pos1
	END IF
	//OR문의 처음찾기
	li_or_pos1 = Pos(ls_cur_filter," or ",1)
	li_or_pos2 = Pos(ls_cur_filter," OR ",1)
	IF li_or_pos1 = 0 THEN 
		li_or_pos = li_or_pos2
	ELSEIF li_or_pos2 = 0 THEN
		li_or_pos = li_or_pos1
	ELSEIF li_or_pos2 < li_or_pos1 THEN
		li_or_pos = li_or_pos2
	ELSE
		li_or_pos = li_or_pos1
	END IF	
	//어느것이 먼저인지 
	IF li_and_pos = 0 THEN
		IF li_or_pos > 0 THEN
			li_pos = li_or_pos
			li_shift = 4
		ELSE
			li_pos = 0
			ls_tmp = ""
		END IF
	ELSE
		IF li_or_pos > 0 THEN
			IF li_and_pos < li_or_pos THEN
				li_pos = li_and_pos
				li_shift = 5
			ELSE
				li_pos = li_or_pos
				li_shift = 4
			END IF
		ELSE
			li_pos = li_and_pos
			li_shift = 5
		END IF
	END IF	
	IF li_pos > 0 THEN
		ls_tmp = Left(ls_cur_filter,li_pos - 1)
		ls_cur_filter = Mid(ls_cur_filter,li_pos + li_shift)
	ELSE
		ls_tmp = ls_cur_filter
	END IF
	//Get
	ls_tmp = Trim(ls_tmp)
	ls_col = f_get_token(ls_tmp," ")
	ls_tmp = Trim(ls_tmp)		
	ls_operator = 	f_get_token(ls_tmp," ")
	ls_filter_text = Trim(ls_tmp)	
	IF Left(ls_filter_text,1) = "'" AND Right(ls_filter_text,1) = "'" THEN
		ls_filter_text = Mid(ls_filter_text,2)
		ls_filter_text = Left(ls_filter_text,Len(ls_filter_text)-1)
	END IF
	//Set
	li_cnt ++
	dw_1.Setitem(li_cnt,'col',ls_col)
	dw_1.Setitem(li_cnt,'operator',ls_operator)		
	dw_1.Setitem(li_cnt,'filter_text',ls_filter_text)
	IF ls_col <> "" AND li_pos > 0 THEN
		IF li_shift = 4 THEN
			dw_1.Setitem(li_cnt,'and_or',"OR")
		ELSE
			dw_1.Setitem(li_cnt,'and_or',"AND")				
		END IF
	END IF
LOOP WHILE li_pos > 1 
end event

on w_dw_filter_r.create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_1=create dw_1
this.Control[]={this.cb_cancel,&
this.cb_ok,&
this.dw_1}
end on

on w_dw_filter_r.destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

type cb_cancel from commandbutton within w_dw_filter_r
integer x = 1376
integer y = 1036
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

on clicked;close(parent)
end on

type cb_ok from commandbutton within w_dw_filter_r
integer x = 466
integer y = 1036
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

event clicked;INTEGER	li_i
INTEGER	li_cnt
STRING	ls_filter_list
STRING	ls_filter
STRING	ls_operator
STRING	ls_tmp
STRING	ls_col
STRING	ls_value
STRING	ls_and_or
STRING	ls_type

dw_1.AcceptText()
li_cnt = dw_1.rowcount()
FOR li_i = 1 TO li_cnt
	ls_col = dw_1.getitemstring(li_i,'col')
	IF IsNull(ls_col) THEN ls_col = ""
	ls_operator = dw_1.Getitemstring(li_i,'operator')
	IF IsNull(ls_operator) THEN ls_operator = ""	
	ls_value = dw_1.getitemstring(li_i,'filter_text')	
	IF IsNull(ls_value) THEN ls_value = ""	
	//LIKE문인 경우 '%'가 없으면 '%'추가 
	IF Pos(ls_operator,"like",1) > 0 AND Pos(ls_value,"%",1) = 0 THEN
		ls_value += "%"
	END IF
	//Type이 String인 경우 "'"넣어줌 
	ls_type = Lower(Trim(idw_dw.Describe( ls_col + ".ColType" )))
	ls_type = Left(ls_type,4)
	IF ls_type = "char" THEN
		ls_value = "~'" + ls_value + "~'"
	END IF	
	ls_and_or = dw_1.getitemstring(li_i,'and_or')
	IF IsNull(ls_and_or) THEN ls_and_or = ""

	IF ls_col <> "" AND ls_operator <> "" AND ls_value <> "" AND ls_and_or <> "" THEN
		ls_filter_list +="(" + ls_col + " " + &
								ls_operator + " " + &
								ls_value + " " + &
								+ ") " + &
						ls_and_or + "  "
	END IF
NEXT

ls_filter_list = Trim(ls_filter_list)
IF Right(ls_filter_list,3) = "AND" THEN 
	ls_filter_list = Left(ls_filter_list,Len(ls_filter_list) - 3)
END IF	
IF Right(ls_filter_list,2) = "OR" THEN 
	ls_filter_list = Left(ls_filter_list,Len(ls_filter_list) - 2)
END IF

IF len(ls_filter_list) > 0 THEN
	IF idw_dw.SetFilter(ls_filter_list) <> 1 THEN
		MessageBox(is_title,"걸러보기에 사용할수 없는 문장입니다. " + & 
									+ "~r~n" + ls_filter_list )
		RETURN	
	END IF
	IF idw_dw.Filter() <> 1 THEN 
		MessageBox(is_title,"걸러보기를 수행할수가 없습니다. " + &
									+ "~r~n" + ls_filter_list )
		RETURN
	END IF
	// 2001.12.24 - new
	idw_dw.GroupCalc()
ELSE
	// 2001.12.24 - 조건없으면 원래대로 
	idw_dw.SetFilter("")
	idw_dw.Filter()
END IF

Close(parent)

end event

type dw_1 from datawindow within w_dw_filter_r
integer x = 9
integer y = 8
integer width = 2208
integer height = 996
integer taborder = 30
string dataobject = "d_ex_tb_filter"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

