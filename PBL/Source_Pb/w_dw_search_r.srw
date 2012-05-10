$PBExportHeader$w_dw_search_r.srw
$PBExportComments$dw���� ã��
forward
global type w_dw_search_r from window
end type
type rb_1 from radiobutton within w_dw_search_r
end type
type cbx_highlight from checkbox within w_dw_search_r
end type
type cb_all_search from commandbutton within w_dw_search_r
end type
type rb_down from radiobutton within w_dw_search_r
end type
type rb_up from radiobutton within w_dw_search_r
end type
type cbx_case from checkbox within w_dw_search_r
end type
type cb_cancel from commandbutton within w_dw_search_r
end type
type cb_search from commandbutton within w_dw_search_r
end type
type dw_1 from datawindow within w_dw_search_r
end type
type gb_1 from groupbox within w_dw_search_r
end type
end forward

global type w_dw_search_r from window
integer x = 512
integer y = 652
integer width = 2354
integer height = 1056
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 81576884
event ue_description pbm_custom01
rb_1 rb_1
cbx_highlight cbx_highlight
cb_all_search cb_all_search
rb_down rb_down
rb_up rb_up
cbx_case cbx_case
cb_cancel cb_cancel
cb_search cb_search
dw_1 dw_1
gb_1 gb_1
end type
global w_dw_search_r w_dw_search_r

type variables
/* ã�⸦ ������ datawindow */
DATAWINDOW   idw_dw
STRING             is_title
BOOLEAN		ib_mode_all_check = FALSE

end variables

forward prototypes
public function long wf_find ()
end prototypes

on ue_description;//�����
end on

public function long wf_find ();LONG		ll_row
LONG		ll_start_row	//ã�� ������ row #
LONG		ll_end_row		//ã�⸦ ���� row #
LONG		ll_rowcount
INT		li_cnt			//ã�� �����׸� ��
STRING	ls_col			//ã�� �����׸��̸�(column name)
STRING	ls_search_text	//ã�� ����
STRING	ls_and_or		//AND or OR
STRING	ls_coltype		//�׸��� data type
STRING	ls_find			//���������� �˻��� �̿�� ���ڿ�
LONG		ll_found_row	//ã���� �׸�
INT		li_i				//For-Next�� ���
STRING	ls_tail			//ls_find�� �����ι�
String	ls_operator		// 2001.12.22

dw_1.AcceptText()
ll_rowcount = idw_dw.RowCount()
IF ll_rowcount = 0 THEN
	MessageBox("ã�� ����","ã�⸦ ������ �ڷᰡ �����ϴ�")	
	RETURN -1
END IF	

//dw_1.SetRedraw(False)
ll_row = idw_dw.GetRow()

IF ll_row < 1 or ll_row > ll_rowcount THEN
	//�Ʒ��� ã���̸�
	IF rb_down.checked = TRUE THEN
		ll_row = 1
	ELSE
		ll_row = ll_rowcount
	END IF
END IF

//2002.01.22 - �߰� : ������ '���'�� �� ��� ó�� �����ϴ� row ���� 1��.
IF ib_mode_all_check = TRUE THEN
	ll_row = 1
END IF

//ã�� ������ �����Ѵ� : 2002.01.22 ���� 
IF rb_down.Checked = TRUE THEN
	ll_start_row = ll_row
	ll_end_row = ll_rowcount
ELSEIF rb_1.Checked = TRUE THEN
	ll_start_row = ll_row
	ll_end_row = ll_rowcount
ELSE 
	ll_start_row = ll_row
	ll_end_row = 1
END IF

////ã�� ���ǽ��� �����´�
//li_cnt = dw_1.rowcount()
//FOR li_i = 1 TO li_cnt
//	ls_col = trim(dw_1.getitemstring(li_i,'col'))		//column�̸�
//	IF len(ls_col) > 0 then
//		ls_search_text = 	trim(dw_1.getitemstring(li_i,'search_text'))
//		ls_and_or = trim(dw_1.getitemstring(li_i,'and_or'))
//		IF LEN(ls_search_text) > 0 THEN
//			ls_coltype = idw_dw.Describe(ls_col + ".coltype")
//			ls_coltype = Left(ls_coltype, 4)
//			CHOOSE CASE ls_coltype
//// 			CASE ELSE
//				CASE 'char'
//					ls_search_text = "= ~"" + ls_search_text + "~" " 
////				CASE "number"
//				CASE ELSE
//					//������ column�� ���� ���ǽ� ����
//					IF IsNumber(ls_search_text) = TRUE THEN
////						ls_search_text = " = " + ls_search_text + " " + ls_and_or
//						ls_search_text = " = " + ls_search_text
//					ELSE
//						IF Match(ls_search_text,"[0-9<=> ]+") = FALSE THEN
//							MessageBox("���� ����","�����׸� ���� �ʴ� �˻������Դϴ�")
//							dw_1.SetRow(li_i)
//							dw_1.ScrollToRow(li_i)
//							RETURN -1
//						END IF
//						ls_search_text = " " + ls_search_text + " " 
//					END IF
//			END CHOOSE						
//			ls_search_text = ls_search_text + ls_and_or + " "
//		
//			//��ҹ��� ������ ������
//			IF cbx_case.checked = FALSE and ls_coltype = 'char' THEN				
//				ls_col = "Lower(" + ls_col + ")"
//				ls_search_text = Lower(ls_search_text)
//			END IF
//			ls_find = ls_find + ls_col + ls_search_text
//		END IF
//	END IF	
//NEXT


//ã�� ���ǽ��� �����´�
// 2001.12.22

li_cnt = dw_1.rowcount()
FOR li_i = 1 TO li_cnt
	ls_col = trim(dw_1.getitemstring(li_i,'col'))		//column�̸�
	ls_operator = dw_1.getitemstring(li_i,'operator')		//���ǽ� 
	IF len(ls_col) > 0 then
		ls_search_text = 	trim(dw_1.getitemstring(li_i,'search_text'))
		ls_and_or = trim(dw_1.getitemstring(li_i,'and_or'))
		IF LEN(ls_search_text) > 0 THEN
			ls_coltype = idw_dw.Describe(ls_col + ".coltype")
			ls_coltype = Left(ls_coltype, 4)
			CHOOSE CASE ls_coltype
				CASE 'char'
					IF Lower(ls_operator) = 'like' or Lower(ls_operator) = 'not like' THEN
						ls_search_text = ls_operator + " ~"" +"%"+ ls_search_text +"%" +"~" " 
					ELSE	
						ls_search_text = ls_operator + " ~"" + ls_search_text + "~" " 
					END IF	
				CASE ELSE
					//������ column�� ���� ���ǽ� ����
					IF IsNumber(ls_search_text) = TRUE THEN
						IF Lower(ls_operator) = 'like' or Lower(ls_operator) = 'not like' THEN
							MessageBox("���� ����","�����׸� ���� �ʴ� �˻������Դϴ�")
							dw_1.SetRow(li_i)
							dw_1.ScrollToRow(li_i)
							RETURN -1
						ELSE	
							ls_search_text = ls_operator + " " + ls_search_text
						END IF	
					ELSE
						IF Match(ls_search_text,"[0-9<=> ]+") = FALSE THEN
							MessageBox("���� ����","�����׸� ���� �ʴ� �˻������Դϴ�")
							dw_1.SetRow(li_i)
							dw_1.ScrollToRow(li_i)
							RETURN -1
						END IF
						ls_search_text = " " + ls_search_text + " " 
					END IF
			END CHOOSE						
			ls_search_text = ls_search_text + ls_and_or + " "
		
			//��ҹ��� ������ ������
			IF cbx_case.checked = FALSE and ls_coltype = 'char' THEN				
				ls_col = "Lower(" + ls_col + ")"
				ls_search_text = Lower(ls_search_text)
			END IF
			ls_find = ls_find + ls_col + ls_search_text
		END IF
	END IF	
NEXT

//�������� 'AND' or 'OR'�� �߶󳻾��
ls_find = trim(ls_find)
ls_tail = Upper(RIGHT(ls_find,2))
IF ls_tail = "ND" THEN 
	ls_find = LEFT(ls_find, len(ls_find) - 3)
ELSEIF ls_tail = "OR" THEN
	ls_find = LEFT(ls_find, len(ls_find) - 2)
END IF

//Search
ll_found_row = idw_dw.Find( ls_find, ll_start_row, ll_end_row )
IF ll_found_row > 0 THEN
	//ã�Ҵ�!
	IF cbx_highlight.checked = FALSE THEN
		idw_dw.SelectRow(0,FALSE)
	END IF
	idw_dw.ScrollToRow(ll_found_row)
	idw_dw.SelectRow(ll_found_row,TRUE)	
	
	IF idw_dw.IsSelected(ll_found_row) THEN
		//ã�� ������ �����Ѵ�
		IF rb_down.Checked = TRUE THEN
			ll_start_row = ll_start_row + 1
			ll_end_row = ll_rowcount
		ELSEIF rb_1.Checked = TRUE THEN
			ll_start_row = ll_start_row + 1
			ll_end_row = ll_rowcount
		ELSE
			ll_start_row = ll_row - 1
			ll_end_row = 1
		END IF
		
		ll_found_row = idw_dw.Find( ls_find, ll_start_row, ll_end_row )

		IF ll_found_row > 0 THEN
			//ã�Ҵ�!
			IF cbx_highlight.checked = FALSE THEN
				idw_dw.SelectRow(0,FALSE)
			END IF
			idw_dw.ScrollToRow(ll_found_row)
			idw_dw.SelectRow(ll_found_row,TRUE)	
		END IF
	END IF	
END IF

//2002.01.22 - ������ ����� ��츦 ���Ͽ� �߰�. �ٽ� false �����ش�.
//             �ѹ��� ���� row�� 1�� �ǵ���.
ib_mode_all_check = FALSE

RETURN ll_found_row
end function

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
INTEGER			li_pos
STR_SEARCH 		lstr_parm

//ButtionFace Color ���� 
dw_1.Object.cf_btnface.Expression = String(this.BackColor)

//�߾ӿ� 
f_pisc_win_center_move(this)

lstr_parm = message.powerobjectparm

//Filter��� Datawindow
idw_dw = lstr_parm.dw
//Title
is_title = lstr_parm.title
this.title = "ã��(Search) - " + is_title
//visible�� �� colulmn list�� ���� ��ȯ

li_num_header_texts = f_dw_get_objects_attrib(idw_dw,ls_texts, "text","header","text")
li_cnt = 1
FOR li_i = 1 TO li_num_header_texts
	//Header�� �� ���Ѵ� 
	ls_text_name =  f_get_token(ls_texts[li_i],'~n') 
	//��ġ�ϴ� column�� �ִ��� ã�ƺ��� 
	ls_col_name = idw_dw.Describe( ls_text_name + ".name")
	IF ls_col_name = "!" THEN
		li_pos = 0
		DO 
			li_pos = Pos(ls_text_name,"-", li_pos + 1)
			IF li_pos < 1 THEN CONTINUE
			ls_col_name = Left(ls_text_name, li_pos - 1)
			ls_col_name = idw_dw.Describe( ls_col_name + ".name")	
			IF ls_col_name <> "!" THEN CONTINUE
		LOOP WHILE li_pos > 0 
	ELSE		// �߰� 2001.06.19
		IF Right(ls_col_name, 2) = '_s' or Right(ls_col_name, 2) = '_t' THEN
			ls_col_name = Mid(ls_col_name, 1, Len(ls_col_name) - 2)
		ELSE
			IF Right(ls_col_name, 4) = '_s_f' THEN
				ls_col_name = Mid(ls_col_name, 1, Len(ls_col_name) - 4)
			ELSE
				ls_col_name = Mid(ls_col_name, 1, Len(ls_col_name) - 2)
			END IF
		END IF	
	END IF
	ls_vis = idw_dw.Describe(ls_col_name + ".visible")	
	//���̴� coulnm�� ���ؼ��� Search����	
	IF ls_vis <> "1" THEN CONTINUE
	ls_label = f_get_token(ls_texts[li_i],'~n') 
	//���� ��� filter Skip
	IF ls_label = "!" THEN CONTINUE
	
	//���� Search��� column�� ���ҳ�..���� 
	ls_label = f_global_replace(ls_label,"~r~n"," ") // replace ~r~n with a space
	ls_label = f_global_replace(ls_label,"~r"," ") // replace ~r with a space
	ls_label = f_global_replace(ls_label,'"','') // remove any " 
	dw_1.Setvalue('col',li_cnt,ls_label+'~t'+ls_col_name)
	li_cnt++
	dw_1.Insertrow(0)
NEXT
li_num_cols = li_cnt

dw_1.setvalue('col',li_cnt,'~t') // add a blank line so they can cancel

// only show the direction RB's if there is something in the row
ls_resp = dw_1.modify("search_text.visible = '0~t if(len(col)>0,1,0)'")
IF len(ls_resp) > 0 THEN messagebox("",ls_resp)
ls_resp = dw_1.modify("and_or.visible = '0~t if(len(col)>0,1,0)'")
IF len(ls_resp) > 0 THEN messagebox("",ls_resp)

//STRING 		cols[],label,tmp,resp,col,vis,col_name
//INTEGER		num_cols
//INTEGER		li_i,cnt
//STR_SEARCH 	parm
//
//parm = message.powerobjectparm
//
//idw_dw = parm.dw
//is_title = parm.title
//this.title = 'FIND - ' + parm.title
//num_cols = f_dw_get_objects_attrib(idw_dw,cols,'column','*','visible')
//cnt = 1
//FOR li_i = 1 TO num_cols
//	//column�� �̸���������
//	col_name =  f_get_token(cols[li_i],'~n')
//	//visible?
//	vis = f_get_token(cols[li_i],'~n') 
//	IF vis = '1' THEN // ���̴� column�� �ƴϸ� ã�⿡���� ����
//		label = idw_dw.describe(col_name+"_t.text")
//		IF label = '!' THEN 	//label(�ѱ��̸�)�� ������ column name����
//			label = f_global_replace(col_name,"_"," ") // replace under_scores with spaces
//			tmp = "evaluate('wordcap(~""+label+"~")',1)" // make it pretty
//			label =  idw_dw.describe(tmp)
//		ELSE
//			// might have <cr><lf> or <cr> embedded, lets get rid of them
//			label = f_global_replace(label,"~r~n"," ") // replace ~r~n with a space
//			label = f_global_replace(label,"~r"," ") // replace ~r with a space
//			label = f_global_replace(label,'"','') // remove any " 
//		END IF
//		dw_1.setvalue('col',cnt,label+'~t'+col_name)
//		cnt++
//		dw_1.insertrow(0)
//	END IF
//NEXT
//
//dw_1.setvalue('col',cnt,'~t') // add a blank line so they can cancel
//
//// only show the direction RB's if there is something in the row
//resp = dw_1.modify("search_text.visible = '0~t if(len(col)>0,1,0)'")
//IF len(resp) > 0 THEN messagebox("",resp)
//resp = dw_1.modify("and_or.visible = '0~t if(len(col)>0,1,0)'")
//IF len(resp) > 0 THEN messagebox("",resp)
end event

on w_dw_search_r.create
this.rb_1=create rb_1
this.cbx_highlight=create cbx_highlight
this.cb_all_search=create cb_all_search
this.rb_down=create rb_down
this.rb_up=create rb_up
this.cbx_case=create cbx_case
this.cb_cancel=create cb_cancel
this.cb_search=create cb_search
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.rb_1,&
this.cbx_highlight,&
this.cb_all_search,&
this.rb_down,&
this.rb_up,&
this.cbx_case,&
this.cb_cancel,&
this.cb_search,&
this.dw_1,&
this.gb_1}
end on

on w_dw_search_r.destroy
destroy(this.rb_1)
destroy(this.cbx_highlight)
destroy(this.cb_all_search)
destroy(this.rb_down)
destroy(this.rb_up)
destroy(this.cbx_case)
destroy(this.cb_cancel)
destroy(this.cb_search)
destroy(this.dw_1)
destroy(this.gb_1)
end on

type rb_1 from radiobutton within w_dw_search_r
integer x = 1815
integer y = 668
integer width = 361
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "����"
long backcolor = 81576884
string text = "���(&A)"
borderstyle borderstyle = stylelowered!
end type

event clicked;ib_mode_all_check = TRUE
end event

type cbx_highlight from checkbox within w_dw_search_r
integer x = 69
integer y = 692
integer width = 608
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "����"
long backcolor = 81576884
string text = "ã���� ��� ����"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

type cb_all_search from commandbutton within w_dw_search_r
integer x = 965
integer y = 828
integer width = 494
integer height = 108
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "����"
string text = "��� ã��(&T)"
end type

event clicked;
Integer		li_ret, li_temp

li_ret = wf_find()

DO WHILE (li_ret > 0 AND IsNull(li_ret) = False)
	li_ret = wf_find()
	
	IF li_ret = li_temp THEN
		EXIT
	END IF	
	li_temp = li_ret
LOOP	

//Close(Parent)
end event

type rb_down from radiobutton within w_dw_search_r
integer x = 1344
integer y = 668
integer width = 416
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "����"
long backcolor = 81576884
string text = "�Ʒ���(&D)"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

type rb_up from radiobutton within w_dw_search_r
integer x = 919
integer y = 668
integer width = 352
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "����"
long backcolor = 81576884
string text = "����(&U)"
borderstyle borderstyle = stylelowered!
end type

type cbx_case from checkbox within w_dw_search_r
integer x = 69
integer y = 588
integer width = 485
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "����"
long backcolor = 81576884
string text = "��ҹ��ڱ���"
borderstyle borderstyle = stylelowered!
end type

type cb_cancel from commandbutton within w_dw_search_r
integer x = 1893
integer y = 828
integer width = 306
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "����"
string text = "���(&C)"
boolean cancel = true
end type

on clicked;close(parent)
end on

type cb_search from commandbutton within w_dw_search_r
integer x = 82
integer y = 828
integer width = 494
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "����"
string text = "���� ã��(&F)"
boolean default = true
end type

on clicked;//ã�� ����
INT	li_ret

li_ret = wf_find()
end on

type dw_1 from datawindow within w_dw_search_r
integer x = 27
integer y = 12
integer width = 2267
integer height = 532
integer taborder = 10
string dataobject = "d_ex_tb_search"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_dw_search_r
integer x = 832
integer y = 580
integer width = 1376
integer height = 196
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "����"
long backcolor = 81576884
string text = "ã�� ����"
borderstyle borderstyle = stylelowered!
end type

