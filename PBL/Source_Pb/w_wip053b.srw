$PBExportHeader$w_wip053b.srw
$PBExportComments$�ǻ���� �������� Upload
forward
global type w_wip053b from w_origin_sheet06
end type
type gb_2 from groupbox within w_wip053b
end type
type gb_1 from groupbox within w_wip053b
end type
type st_1 from statictext within w_wip053b
end type
type st_a1 from statictext within w_wip053b
end type
type st_a2 from statictext within w_wip053b
end type
type st_3 from statictext within w_wip053b
end type
type st_daesang from statictext within w_wip053b
end type
type st_55 from statictext within w_wip053b
end type
type st_saeng from statictext within w_wip053b
end type
type uo_1 from uo_progress_bar within w_wip053b
end type
type dw_1 from datawindow within w_wip053b
end type
type cb_1 from commandbutton within w_wip053b
end type
type sle_1 from singlelineedit within w_wip053b
end type
type dw_2 from datawindow within w_wip053b
end type
type st_2 from statictext within w_wip053b
end type
type st_4 from statictext within w_wip053b
end type
type pb_down from picturebutton within w_wip053b
end type
end forward

global type w_wip053b from w_origin_sheet06
gb_2 gb_2
gb_1 gb_1
st_1 st_1
st_a1 st_a1
st_a2 st_a2
st_3 st_3
st_daesang st_daesang
st_55 st_55
st_saeng st_saeng
uo_1 uo_1
dw_1 dw_1
cb_1 cb_1
sle_1 sle_1
dw_2 dw_2
st_2 st_2
st_4 st_4
pb_down pb_down
end type
global w_wip053b w_wip053b

type variables
dec i_n_complete
end variables

on w_wip053b.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.st_1=create st_1
this.st_a1=create st_a1
this.st_a2=create st_a2
this.st_3=create st_3
this.st_daesang=create st_daesang
this.st_55=create st_55
this.st_saeng=create st_saeng
this.uo_1=create uo_1
this.dw_1=create dw_1
this.cb_1=create cb_1
this.sle_1=create sle_1
this.dw_2=create dw_2
this.st_2=create st_2
this.st_4=create st_4
this.pb_down=create pb_down
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_a1
this.Control[iCurrent+5]=this.st_a2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_daesang
this.Control[iCurrent+8]=this.st_55
this.Control[iCurrent+9]=this.st_saeng
this.Control[iCurrent+10]=this.uo_1
this.Control[iCurrent+11]=this.dw_1
this.Control[iCurrent+12]=this.cb_1
this.Control[iCurrent+13]=this.sle_1
this.Control[iCurrent+14]=this.dw_2
this.Control[iCurrent+15]=this.st_2
this.Control[iCurrent+16]=this.st_4
this.Control[iCurrent+17]=this.pb_down
end on

on w_wip053b.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.st_a1)
destroy(this.st_a2)
destroy(this.st_3)
destroy(this.st_daesang)
destroy(this.st_55)
destroy(this.st_saeng)
destroy(this.uo_1)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.sle_1)
destroy(this.dw_2)
destroy(this.st_2)
destroy(this.st_4)
destroy(this.pb_down)
end on

event ue_bretrieve;//long   l_n_count
//
//setpointer(HourGlass!)
//dw_1.reset()
//l_n_count = dw_1.importfile(sle_1.text)
//st_daesang.text = string(l_n_count,"###,### ")
//
//if l_n_count	  > 0 then
//	i_b_bcreate	  = True
//end if
//
////Icon ����(�����ȸ, �ڷ����, ����ȸ, ȭ���μ�, Ư������)
//wf_icon_onoff(i_b_bretrieve, i_b_bcreate, i_b_dretrieve, i_b_dprint, i_b_dchar)
//setpointer(Arrow!)
end event

event ue_bcreate;decimal    l_n_totalcnt,l_n_loopcnt
decimal{2} lc_phqt
decimal{4} lc_convqty
string     ls_plant,ls_dvsn,ls_itno,ls_date,ls_year,ls_month,ls_dept,ls_plan, ls_rtn, ls_cls, ls_srce
string     ls_chkplant, ls_chkdvsn, ls_error, ls_itnm, ls_spec, ls_unit, ls_chkpdcd, ls_pdnm
long 		  ll_tagno
integer    Net,l_n_chkcount

Net = messagebox("Ȯ ��", "�ڷ���� �۾��� ���� �ϰڽ��ϱ�?",Question!, OkCancel!, 1)
if Net <> 1 then
	return
end if

setpointer(HourGlass!)
//dw_1.accepttext()

ls_error = ' '
l_n_totalcnt = dec(st_daesang.text)
uo_status.st_message.text = "�ڷ� ó����(���� Ȯ����)..."

l_n_chkcount = 0
for l_n_loopcnt = 1 to l_n_totalcnt
	ls_itno   = trim(dw_1.object.wfitno[l_n_loopcnt])
	ls_plant  = trim(dw_1.object.wfplant[l_n_loopcnt])
	ls_dvsn   = trim(dw_1.object.wfdvsn[l_n_loopcnt])
	ls_year   = trim(dw_1.object.wfyear[l_n_loopcnt])
	ls_month  = trim(dw_1.object.wfmonth[l_n_loopcnt])
	if l_n_loopcnt <> l_n_totalcnt then
		if dw_1.find("wfitno = '" + ls_itno + "'", l_n_loopcnt + 1, dw_1.rowcount()) > 0 then
			messagebox("�ڷ� ����",string(l_n_loopcnt) + "Row�� " +"ǰ����ġ ���� =  " + ls_itno)
			return 0
		end if
	end if
next

// �ǻ� ����üũ
if Not f_wip_check_applystatus('01',ls_plant,ls_dvsn, ls_year + ls_month) then
	uo_status.st_message.text = "�ǻ����� �ƴϰų� �ǻ簡 Ȯ���Ǿ����ϴ�."
	return -1
end if

l_n_loopcnt = 0
do while true
	if l_n_loopcnt = l_n_totalcnt  then exit
	l_n_loopcnt ++
   dw_1.scrolltorow(l_n_loopcnt)
	dw_1.selectrow(0,false)
	dw_1.selectrow(l_n_loopcnt,true)
	ls_year   = trim(dw_1.object.wfyear[l_n_loopcnt])
	ls_month  = trim(dw_1.object.wfmonth[l_n_loopcnt])
	ls_dept   = trim(dw_1.object.wfdept[l_n_loopcnt])
	ls_plant  = trim(dw_1.object.wfplant[l_n_loopcnt])
	ls_dvsn   = trim(dw_1.object.wfdvsn[l_n_loopcnt])
	ls_itno   = trim(dw_1.object.wfitno[l_n_loopcnt])
	ll_tagno	 = dw_1.object.wfserial[l_n_loopcnt]
	lc_phqt   = dw_1.object.wfphqt[l_n_loopcnt]

	if l_n_loopcnt = l_n_totalcnt then
		//pass
	else
		if dw_1.find("wfitno = '" + ls_itno + "'",(l_n_loopcnt + 1),l_n_totalcnt) > 0 then
			ls_error = 'E01 : ǰ����ġ ����' 	// ǰ����ġ ����
		end if
	end if
	if f_spacechk(ls_year) = -1 or mid(g_s_date,1,4) < ls_year then
		ls_error = 'E02 : �ش�⵵ ����'  	// �ش�⵵ ����
	end if
	if ls_month <> '12'  then
		ls_error = 'E03 : �ش�� ����'		// �ش�� ����
	end if
	if f_spacechk(ls_dept) = -1 or ls_dept <> '9999' then
		ls_error = 'E04 : ���ڵ� ����'		// ���ڵ� ����
	end if		
	if f_spacechk(f_get_coflname('01','SLE220', ls_plant)) = -1 then	
		ls_error = 'E05 : �����ڵ� ����'		// �����ڵ� ����
	end if
	if f_spacechk(f_get_coflname('01','DAC030', ls_dvsn)) = -1 then
		ls_error = 'E06 : �����ڵ� ����'		// �����ڵ� ����
	end if
	SELECT AA.ITNM, AA.SPEC, BB.XUNIT, SUBSTRING(BB.PDCD,1,2), BB.CONVQTY, BB.CLS, BB.SRCE
		INTO :ls_itnm, :ls_spec, :ls_unit, :ls_chkpdcd, :lc_convqty, :ls_cls, :ls_srce
		FROM PBINV.INV002 AA, PBINV.INV101 BB
		WHERE AA.COMLTD = BB.COMLTD AND AA.ITNO = BB.ITNO AND
				BB.COMLTD = :g_s_company AND BB.XPLANT = :ls_plant AND
				BB.DIV = :ls_dvsn AND BB.ITNO = :ls_itno
		using sqlca;

	if sqlca.sqlcode <> 0 then
		ls_error = 'E07 : ǰ�������� ����'		// ǰ�������� ����
	else
		select wbitno into :ls_rtn from pbwip.wip002
			where wbcmcd = :g_s_company and wbplant = :ls_plant and 
					wbdvsn = :ls_dvsn and wbitno = :ls_itno and
					wbyear = :ls_year and wbmonth = :ls_month and 
					wborct = '9999'
			using sqlca;
		if f_spacechk(ls_rtn) = -1 then
			ls_error = 'E08 : ����̿�ǰ�� ����'	// ����̿�ǰ�� ����
		else
			if ls_cls = '30' or ls_cls = '50' or ls_srce = '03' then
				ls_error = 'E13 : �ǻ���ǰ���� �ƴ�'	// �ǻ���ǰ���� �ƴ�
			else
				select wfitno into :ls_rtn from pbwip.wip006
				where wfcmcd = :g_s_company and wfplant = :ls_plant and 
						wfdvsn = :ls_dvsn and wfitno = :ls_itno and
						wfyear = :ls_year and wfmonth = :ls_month and 
						wfdept = '9999' and wfserial = 0
				using sqlca;
				if sqlca.sqlcode <> 0 or f_spacechk(ls_rtn) = -1 then
					ls_error = 'E09'	// �ǻ�ǰ�� ������
				else
					//PASS
				end if
			end if
		end if
	end if
	
	if isnull(lc_phqt)  or lc_phqt < 0 then 
		ls_error = 'E10 : �ǻ���� ����'			// �ǻ���� ����
	else
		lc_phqt = lc_phqt * lc_convqty
	end if
   
	if f_spacechk(ls_error) <> -1 then
		// ������ �߻��� ǰ��
		if ls_error = 'E09' then
			INSERT INTO PBWIP.WIP006(WFYEAR,WFMONTH,WFCMCD,WFPLANT,WFDVSN,
    			WFDEPT,WFITNO,WFSERIAL,WFDEPTNM,WFITNM,WFSPEC,WFPDCD,WFPDNM,
    			WFUNIT,WFOHQT,WFPHQT,WFSTSCD,WFEXTD,WFIPADDR,WFMACADDR,
    			WFINPTDT,WFUPDTDT)
			VALUES( :ls_year, :ls_month, '01', :ls_plant, :ls_dvsn,
				'9999', :ls_itno,0,' ',' ',' ',:ls_chkpdcd,' ',
   			:ls_unit, 0, :lc_phqt, 'A', ' ', ' ', ' ', ' ', ' ') 
			using sqlca;
			if sqlca.sqlcode <> 0 then
				dw_1.setitem(l_n_loopcnt,"chk",ls_error)
				dw_1.RowsCopy(l_n_loopcnt, l_n_loopcnt, primary!,dw_2, (dw_2.rowcount() + 1), Primary!)
			end if
		else
			dw_1.setitem(l_n_loopcnt,"chk",ls_error)
			dw_1.RowsCopy(l_n_loopcnt, l_n_loopcnt, primary!,dw_2, (dw_2.rowcount() + 1), Primary!)
		end if
	else
		// �ǻ���� ������Ʈ
		UPDATE "PBWIP"."WIP006"  
     		SET "WFPHQT" = :lc_phqt  
			WHERE ( "PBWIP"."WIP006"."WFYEAR" = :ls_year ) AND  
					( "PBWIP"."WIP006"."WFMONTH" = :ls_month ) AND  
					( "PBWIP"."WIP006"."WFCMCD" = '01' ) AND  
					( "PBWIP"."WIP006"."WFPLANT" = :ls_plant ) AND  
					( "PBWIP"."WIP006"."WFDVSN" = :ls_dvsn ) AND  
					( "PBWIP"."WIP006"."WFITNO" = :ls_itno ) AND
					( "PBWIP"."WIP006"."WFDEPT" = '9999' ) AND
					( "PBWIP"."WIP006"."WFSERIAL" = 0 )
		using sqlca;
		if sqlca.sqlcode = 0 and sqlca.sqlnrows < 1 then
			// ������ �߻��� ǰ��
			ls_error = 'E12'
			dw_1.setitem(l_n_loopcnt,"chk",ls_error)
			dw_1.RowsCopy(l_n_loopcnt, l_n_loopcnt, primary!,dw_2, (dw_2.rowcount() + 1), Primary!)
		end if
	end if
	ls_error = ' '
	i_n_complete = l_n_loopcnt * 100 / l_n_totalcnt
	if mod(l_n_loopcnt,5) = 0 then
		uo_1.uf_set_position (i_n_complete)
		st_saeng.text = string(l_n_loopcnt,"###,### ")
	end if
loop

uo_1.uf_set_position (i_n_complete)
st_saeng.text = string(l_n_loopcnt,"###,### ")
uo_status.st_message.text = f_message("U010")		//������ �Ǿ����ϴ�.

//Icon ����(�����ȸ, �ڷ����, ����ȸ, ȭ���μ�, Ư������)
wf_icon_onoff(i_b_bretrieve, i_b_bcreate, i_b_dretrieve, i_b_dprint, i_b_dchar)
setpointer(Arrow!)
end event

event open;call super::open;dw_1.settransobject(sqlca)

//Icon ����(�����ȸ, �ڷ����, ����ȸ, ȭ���μ�, Ư������)
wf_icon_onoff(i_b_bretrieve, TRUE, i_b_dretrieve, i_b_dprint, i_b_dchar)
end event

type uo_status from w_origin_sheet06`uo_status within w_wip053b
end type

type gb_2 from groupbox within w_wip053b
integer x = 2185
integer y = 1020
integer width = 2011
integer height = 188
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "[ó������]"
end type

type gb_1 from groupbox within w_wip053b
integer x = 2185
integer y = 820
integer width = 2011
integer height = 188
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
end type

type st_1 from statictext within w_wip053b
integer x = 91
integer y = 28
integer width = 3456
integer height = 92
integer textsize = -16
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
boolean enabled = false
string text = "��  EXCEL �ڷ� LOAD  ��"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_a1 from statictext within w_wip053b
integer x = 101
integer y = 860
integer width = 1998
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
boolean enabled = false
string text = "1.~'�ڷ���~'�� ���� ��󿢼������� ���ùٶ��ϴ�."
boolean focusrectangle = false
end type

type st_a2 from statictext within w_wip053b
integer x = 101
integer y = 928
integer width = 2007
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
boolean enabled = false
string text = "2. ���Ǽ��� �̻��� ������ ~'�ڷ����~'�� �����ʽÿ�."
boolean focusrectangle = false
end type

type st_3 from statictext within w_wip053b
integer x = 2354
integer y = 900
integer width = 311
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
boolean enabled = false
string text = "���Ǽ�"
boolean focusrectangle = false
end type

type st_daesang from statictext within w_wip053b
integer x = 2679
integer y = 884
integer width = 389
integer height = 92
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_55 from statictext within w_wip053b
integer x = 3305
integer y = 900
integer width = 311
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
boolean enabled = false
string text = "�����Ǽ�"
boolean focusrectangle = false
end type

type st_saeng from statictext within w_wip053b
integer x = 3625
integer y = 884
integer width = 389
integer height = 92
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type uo_1 from uo_progress_bar within w_wip053b
event destroy ( )
integer x = 2450
integer y = 1080
boolean bringtotop = true
end type

on uo_1.destroy
call uo_progress_bar::destroy
end on

type dw_1 from datawindow within w_wip053b
event ue_validation pbm_dwnitemvalidationerror
integer x = 91
integer y = 156
integer width = 4123
integer height = 648
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip053b_upload"
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;return 1
end event

event itemerror;return 1
end event

type cb_1 from commandbutton within w_wip053b
integer x = 224
integer y = 1076
integer width = 302
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�ڷ���"
end type

event clicked;//string ls_pathname,ls_filename
//GetFileOpenName("Select File", ls_pathname, ls_filename, "txt","Text Files (*.txt),*.txt,")
//sle_1.text = ls_pathname


string	ls_docname, ls_named, ls_name
Long		ll_rtn
OLEObject lole_UploadObject

// UPLOAD�� ���������� �����Ѵ�
//
GetFileOpenName("Select File", + ls_docname, ls_named, "xls", &
				  + "Excle Files (*.xls),*.xls," + "All Files (*.*),*.*")

setpointer(hourglass!)
sle_1.text = ls_docname
// ������ ���������� �ؽ�Ʈ ���Ϸ� ���� �ٲ۴�.(test.xls => test.txt)
//
ls_name = Mid(ls_docname, 1, Len(Trim(ls_docname)) -3) + 'txt'

// ������ �������ϸ�� ������ �ؽ�Ʈ ���ϸ��� ���翩�θ� üũ�Ѵ�
//
IF FileExists(ls_name) = TRUE THEN
	MessageBox('Ȯ ��', '�ش纯ȯ ������ �����մϴ�')
	RETURN
END IF

// ����Ÿ������ �ʱ�ȭ
//
dw_1.ReSet()

// �ű� ������Ʈ ����
//
lole_UploadObject = CREATE OLEObject

// ���� ������Ʈ�� �����Ѵ�
//
ll_rtn = lole_UploadObject.ConnectToNewObject("excel.application") 

IF ll_rtn = 0 THEN
	// �������� ���õ� ���������� �����Ѵ�
	//
	lole_UploadObject.workbooks.Open(ls_docname)
	// ���µ� ���������� �ؽ�Ʈ ���Ϸ� �����Ѵ�(3:text ������ ����)
	//
	lole_UploadObject.application.workbooks(1).saveas(ls_name, 3)
	// ���µ� ���������� �ݴ´�(���������� Ȯ������ �ʴ´�Close(0))
	//
	lole_UploadObject.application.workbooks(1).close(0)
	// ���� ������Ʈ�� ������ �����Ѵ�
	//
	lole_UploadObject.DisConnectObject()   
ELSE
	// ���� ������Ʈ�� ������ �����Ѵ�
	//
	lole_UploadObject.DisConnectObject()   
	//Excel�� ���� ����!
	//
	MessageBox("ConnectToNewObject Error!",string(ll_rtn))
END IF

// �ű� ������Ʈ�� �޸𸮿��� ����
//
DESTROY lole_UploadObject

// �ؽ�Ʈ ���Ϸ� ����� ����� ����Ÿ�����쿡 ����Ʈ��Ų��(Ÿ��Ʋ�� ������ 2���κ���)
// ����Ʈ�� �Ϸ�Ǹ� �ؽ�Ʈ ������ �����Ѵ�
//
ll_rtn = dw_1.ImportFile(ls_name, 2) 
IF ll_rtn > 0 THEN
	filedelete(ls_name)
ELSE
	// ����Ʈ ERROR
	//
	CHOOSE CASE ll_rtn
		CASE 0
			MessageBox("Ȯ ��", 'End of file; too many rows')
		CASE -1
			MessageBox("Ȯ ��", 'No rows')
		CASE -2
			MessageBox("Ȯ ��", 'Empty file')
		CASE -3
			MessageBox("Ȯ ��", 'Invalid argument')
		CASE -4
			MessageBox("Ȯ ��", 'Invalid input')
		CASE -5
			MessageBox("Ȯ ��", 'Could not open the file')
		CASE -6
			MessageBox("Ȯ ��", 'Could not close the file')
		CASE -7
			MessageBox("Ȯ ��", 'Error reading the text')
		CASE -8
			MessageBox("Ȯ ��", 'Not a TXT file')
	END CHOOSE
END IF

st_daesang.text = string(dw_1.rowcount())
end event

type sle_1 from singlelineedit within w_wip053b
integer x = 544
integer y = 1072
integer width = 1266
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_wip053b
integer x = 91
integer y = 1372
integer width = 4123
integer height = 1092
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip053b_upload"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_wip053b
integer x = 91
integer y = 1280
integer width = 791
integer height = 72
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12639424
string text = "������ �߻��� ǰ��"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_4 from statictext within w_wip053b
integer x = 101
integer y = 1000
integer width = 2007
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "3. ǰ���ߺ��Ұ�, ���ڵ� ~'9999~', Tag��ȣ 0 �̾�� �մϴ�."
boolean focusrectangle = false
end type

type pb_down from picturebutton within w_wip053b
integer x = 1061
integer y = 1232
integer width = 155
integer height = 132
integer taborder = 30
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel(dw_2)
end event

