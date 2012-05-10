$PBExportHeader$w_pisr136p_opt.srw
$PBExportComments$사급품반출증출력
forward
global type w_pisr136p_opt from w_print_options
end type
end forward

global type w_pisr136p_opt from w_print_options
end type
global w_pisr136p_opt w_pisr136p_opt

on w_pisr136p_opt.create
call super::create
end on

on w_pisr136p_opt.destroy
call super::destroy
end on

type dw_dddw from w_print_options`dw_dddw within w_pisr136p_opt
end type

type st_6 from w_print_options`st_6 within w_pisr136p_opt
end type

type rb_file from w_print_options`rb_file within w_pisr136p_opt
end type

type rb_print from w_print_options`rb_print within w_pisr136p_opt
end type

type cb_printer from w_print_options`cb_printer within w_pisr136p_opt
end type

type cb_cancle from w_print_options`cb_cancle within w_pisr136p_opt
end type

type cb_ok from w_print_options`cb_ok within w_pisr136p_opt
end type

event cb_ok::clicked;
Setpointer(hourglass!)

string l_s_tmp, l_s_command, l_s_page, l_s_docname, l_s_named
int    l_n_scale, l_n_value, l_n_paper
long 	 l_n_row,   l_i_rtn

i_dw.Setredraw(true)

//출력 Data -> 파일생성
if rb_file.checked then
	string l_s_grid_column
	string l_s_dddw_nm, l_s_dddw_data, l_s_dddw_disp, l_s_col_nm
	long   i,j,p,q=1,r
	
	l_s_grid_column = i_dw.Object.DataWindow.Table.GridColumns
	FOR i = 1 TO Integer(i_dw.Object.DataWindow.Column.Count)
		l_s_col_nm  = i_dw.Describe('#'+String(i)+'.Name')
		l_s_dddw_nm = i_dw.DesCribe(l_s_col_nm+'.DDDW.Name')
		IF l_s_dddw_nm <> '?' THEN
			l_s_dddw_data = i_dw.Describe(l_s_col_nm + '.DDDW.DataColumn')
			l_s_dddw_disp = i_dw.Describe(l_s_col_nm + '.DDDW.DisplayColumn')
			dw_dddw.dataObject = l_s_dddw_nm
			dw_dddw.SetTransObject(i_s_transaction)
			l_n_row = dw_dddw.Retrieve() //row count of dddw
			for j=1 TO i_dw.RowCount()
				r = dw_dddw.Find(l_s_dddw_data+"='"+i_dw.GetItemString(j,i)+"'",1,l_n_row)
				IF r > 0 THEN i_dw.SetItem(j,i,dw_dddw.GetItemString(r,l_s_dddw_disp))
			next
		end if
	next	
	Choose case i_s_filetype
		case "1"		//Excel
			l_n_value = GetFileSaveName("저장 하기", l_s_docname, l_s_named, "xls", "Excel files (*.xls), *.xls")
			if l_n_value = 1 then
				i_dw.saveas(l_s_docname, Excel!, true)

			else
				messagebox("확 인", "파일저장 오류 입니다.")
				i_dw.Setredraw(false)
				closewithreturn(parent,-1)
			end if
		case "2"		//PDF
			l_n_value = GetFileSaveName("저장 하기", l_s_docname, l_s_named, "pdf", "PDF files (*.pdf), *.pdf")
			if l_n_value = 1 then
				i_dw.saveas(l_s_docname, pdf!, true)
			else
				messagebox("확 인", "파일저장 오류 입니다.")
				i_dw.Setredraw(false)
				closewithreturn(parent,-1)
			end if
		case "3"		//Text
			l_n_value = GetFileSaveName("저장 하기", l_s_docname, l_s_named, "txt", "Text files (*.txt), *.txt")
			if l_n_value = 1 then
				i_dw.saveas(l_s_docname, text!, false)
			else
				messagebox("확 인", "파일저장 오류 입니다.")
				i_dw.Setredraw(false)
				closewithreturn(parent,-1)
			end if
	end Choose
	i_dw.Setredraw(false)
	closewithreturn(parent,-1)
end if

////////////////////
//출력 Data -> 출력
////////////////////

//출력전 초기배율 100 %
i_dw.Object.Datawindow.Zoom = "100"

//출력할 Page 선택
choose case i_s_page_range
	case 'a'				//전체
		l_s_tmp  = ''
	case 'c' 			//현재면
		l_s_tmp  = i_s_page
	case 'p' 			//일부분
		l_s_tmp  = sle_page_range.text
end choose		
l_s_command = " datawindow.Print.Page.Range = '" + l_s_tmp + "'"
l_s_command = l_s_command + " datawindow.print.collate = yes"

// 용지
Choose Case i_n_paper_size
	case 2 //A4
		l_n_paper = 9
	case 1 //A3
		l_n_paper = 8
	case 5 //B4
		l_n_paper = 12
	case else
		l_n_paper = 0
End Choose
l_s_command = l_s_command + " datawindow.Print.Paper.Size = " + string(l_n_paper)

// 배율
if len(ddlb_scale.text) > 0 then
	l_s_command = l_s_command + " datawindow.Zoom = " + ddlb_scale.text
end if

// orientation (1.Landscape(가로)  2.Portrait (세로)
l_s_command = l_s_command + " datawindow.Print.Orientation = " + i_s_orient

// number of copies
if len(em_copies.text) > 0 then
	l_s_command = l_s_command + " datawindow.Print.Copies = " + em_copies.text
end if

// now alter the datawindow
l_s_tmp = i_dw.modify(l_s_command)

if len(l_s_tmp) > 0 then // if error the display the 
	messagebox("확 인", "Error message = " + l_s_tmp + "~r~nCommand = " + l_s_command)
	i_dw.Setredraw(false)
	closewithreturn(parent,-1)
	return
end if
i_dw.print()
//상속후 추가부분///////////////////////////////////
i_dw.Object.t_gubun.Text = '(2) 통제부서용'
i_dw.print()
i_dw.Object.t_gubun.Text = '(3)인수자확인용'
i_dw.print()
//상속후 추가부분///////////////////////////////////
i_dw.Setredraw(false)

closewithreturn(parent,1)

end event

type rb_sero from w_print_options`rb_sero within w_pisr136p_opt
end type

type p_sero from w_print_options`p_sero within w_pisr136p_opt
end type

type rb_garo from w_print_options`rb_garo within w_pisr136p_opt
end type

type p_garo from w_print_options`p_garo within w_pisr136p_opt
end type

type st_5 from w_print_options`st_5 within w_pisr136p_opt
end type

type sle_page_range from w_print_options`sle_page_range within w_pisr136p_opt
end type

type rb_range_user from w_print_options`rb_range_user within w_pisr136p_opt
end type

type rb_range_cur from w_print_options`rb_range_cur within w_pisr136p_opt
end type

type rb_range_all from w_print_options`rb_range_all within w_pisr136p_opt
end type

type ddlb_scale from w_print_options`ddlb_scale within w_pisr136p_opt
end type

type st_4 from w_print_options`st_4 within w_pisr136p_opt
end type

type em_copies from w_print_options`em_copies within w_pisr136p_opt
end type

type st_3 from w_print_options`st_3 within w_pisr136p_opt
end type

type ddlb_size from w_print_options`ddlb_size within w_pisr136p_opt
end type

type st_2 from w_print_options`st_2 within w_pisr136p_opt
end type

type p_printer from w_print_options`p_printer within w_pisr136p_opt
end type

type gb_4 from w_print_options`gb_4 within w_pisr136p_opt
end type

type gb_2 from w_print_options`gb_2 within w_pisr136p_opt
end type

type gb_3 from w_print_options`gb_3 within w_pisr136p_opt
end type

type gb_1 from w_print_options`gb_1 within w_pisr136p_opt
end type

type rb_excel from w_print_options`rb_excel within w_pisr136p_opt
end type

type rb_pdf from w_print_options`rb_pdf within w_pisr136p_opt
end type

type rb_text from w_print_options`rb_text within w_pisr136p_opt
end type

type st_printer from w_print_options`st_printer within w_pisr136p_opt
end type

type st_1 from w_print_options`st_1 within w_pisr136p_opt
end type

type gb_5 from w_print_options`gb_5 within w_pisr136p_opt
end type

