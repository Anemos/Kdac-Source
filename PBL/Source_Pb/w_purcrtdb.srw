$PBExportHeader$w_purcrtdb.srw
$PBExportComments$������ķ��̾ƿ���SQL������ȯ
forward
global type w_purcrtdb from w_origin_sheet09
end type
type tab_1 from tab within w_purcrtdb
end type
type tabpage_1 from userobject within tab_1
end type
type dw_11 from datawindow within tabpage_1
end type
type dw_10 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_11 dw_11
dw_10 dw_10
end type
type tab_1 from tab within w_purcrtdb
tabpage_1 tabpage_1
end type
end forward

global type w_purcrtdb from w_origin_sheet09
integer width = 4699
string title = "�����������"
event ue_open_after ( )
event ue_keydown pbm_keydown
tab_1 tab_1
end type
global w_purcrtdb w_purcrtdb

type prototypes
Function boolean SetCurrentDirectoryA(ref string path) library "kernel32.dll" 
end prototypes

type variables
datawindowchild  idwc_1
integer          ii_tabindex
window           iw_sheet
datawindow idw_11, idw_12, idw_13, idw_14, idw_21, idw_22, idw_23, idw_24,idw_25,idw_26
datawindow idw_10, idw_20, idw_30, idw_31, idw_32, idw_40, idw_41, idw_42
datawindow idw_50, idw_51, idw_60, idw_61, idw_62, idw_temp6
string   is_colnm, is_mail_body
str_easy i_str_prt

Long     il_lastclickedrow

end variables

forward prototypes
public function long wf_mail_tabpage3 ()
end prototypes

event ue_open_after();
iw_sheet = w_frame.getactivesheet()


end event

event ue_keydown;if key=keyenter! then
	iw_sheet.triggerevent('ue_retrieve')
end if
end event

public function long wf_mail_tabpage3 ();//********************������ڿ��� ���Ϲ߼�
long ll_row
string ls_mail, ls_mail_opm,ls_dept
int li_rtn
uo_status.st_message.text = ''

setpointer(hourglass!)


OLEobject	Mail  // ����� ������Ʈ��  OLE ��ü�� ����.
Mail = Create OLEobject // OLE ��ü ����.


// ������Ʈ���� ��ϵ� �ܺ� ������Ʈ(AspEmail.dll)�� Access�ؼ� �Ŀ��������� ��밡����
// OLE ��ü�� ����.
li_rtn = Mail.ConnectToNewObject("Persits.MailSender")

If li_rtn <> 0 Then // Access�� �����ϸ�...
	//MessageBox("Error", "Could not create Mail Object!")
	MessageBox("Error", "���� ������Ʈ�� ��ġ�Ͻð� �۾��Ͻñ� �ٶ��ϴ�(�����ڷ������).")
	uo_status.st_message.text = "���� ������Ʈ�� ��ġ�Ͻð� �۾��Ͻñ� �ٶ��ϴ�(�����ڷ������)."
	Return -1
End If
//�ش�μ���������
//  SELECT "PBCOMMON"."DAC003"."PEDEPT"  
//  INTO :ls_dept  
//  FROM "PBCOMMON"."DAC003"  
//  WHERE "PBCOMMON"."DAC003"."PEEMPNO" = :g_s_empno ;  

	

//messagebox('is_mail_body',is_mail_body)

//  **����� ���Ϻ����� *** //
Mail.Reset // Mail��ü �ʱ�ȭ.
Mail.IsHTML 	= True  // ���� ������ HTML �������� �������ΰ� ���θ� ����.
Mail.Host   	= "kdacn01.kdac.co.kr"  // SMTP ����(�츮�� Notes!!) ����.
Mail.From		= f_pur040_get_mailaddr(g_s_empno ,'1')  // ������ ��� �ּ� ����.
Mail.FromName  = g_s_empno + " " + g_s_kornm  // ������ ��� �̸� ����.

ls_mail = f_pur040_get_mailaddr(g_s_empno ,'2')  //�μ���
//ls_mail = f_pur040_get_mailaddr('970077' ,'1')  
if match(trim(ls_mail), '@kdac.co.kr') = false then
	return -2
end if
Mail.AddAddress( ls_mail ) // �޴� ��� �����ּ� ����.	
Mail.Subject   = "���� �߼� ���ο�û �����Դϴ�."   // ���� ���� ����.
is_mail_body = is_mail_body + ' ~<~B~R~>' + ' ~<~B~R~>' + &
        '�����۾��� ~"KDAC�ý���/����/���ڰ���/���ǰ�߼�/���ù߼��������~" ���� �۾��ϼ���.' 
Mail.Body		= is_mail_body
 // ���� ���� ����.	
Mail.Send  //   --->  ���� �߼�.




Mail.DisConnectObject( )

uo_status.st_message.text = '���Ϲ߼� �Ϸ�'

setpointer(arrow!)
return 1




end function

on w_purcrtdb.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_purcrtdb.destroy
call super::destroy
destroy(this.tab_1)
end on

event ue_retrieve;call super::ue_retrieve;String  ls_lib, ls_dbid, ls_dbname, ls_dbsql, ls_dbdesc, ls_name, ls_length, ls_xdesc, ls_type 
string  ls_xnull, ls_xdefault, ls_comment, ls_dropsql,ls_pathname,ls_filename
long    ll_row, ll_rcnt, ll_len 
int  li_rtn

SetPointer(hourglass!)

CHOOSE CASE ii_tabindex  // 
	CASE 1
		IF idw_10.AcceptText() = -1 THEN
			MessageBox('Ȯ��','������ �� ������ ��ȸ�ϼ���!',Exclamation!)
			Return
		END IF
		//IF f_mandantory_chk(idw_10) = -1 THEN Return
		ls_lib    = upper(trim(idw_10.object.lib[1]))
		ls_dbid   = upper(trim(idw_10.object.dbid[1]))
		ls_dbname   = upper(trim(idw_10.object.dbname[1]))
		
		if g_s_empno = '970077' then
//			ls_PathName = 'D:\������\2008�������μ�������\���⹰\����'
//			ls_FileName = 'D:\������\2008�������μ�������\���⹰\����\*.*'
			ls_PathName = 'D:\������\����-�\DB�ڷ�'
			ls_FileName = 'D:\������\����-�\DB�ڷ�\*.*'
		end if
		
		SetCurrentDirectorya(ls_pathname)  //���丮 ����
		
		idw_11.reset()
		f_pur040_getdbexcel(idw_11,ls_dbid)
		idw_11.accepttext()
		if idw_11.rowcount() = 0 then
			messagebox('Ȯ��','������ DB�ڷ����')
			return
//		else
//			messagebox('Ȯ��','������ ��ġ�� �����ϼ���!')
		end if
		//return
		
		
		string  ls_docname, ls_named  
		long ll_file
		if g_s_empno = '970077' then
			ls_docname = 'D:\������\SQL�׼ҽ�\DB����\' + ls_dbid + '.sql'
		else
			ls_docname = 'C:\KDAC\PBL\' + ls_dbid + '.sql'
		end if
		li_Rtn = GetFileSaveName( "Save file", ls_DocName, ls_named, "sql", &
								  "SQL Files (*.sql), *.sql" )
      If li_Rtn = 0 Then
			uo_status.st_message.text = "�����������."
			Return 
		end if
		
		uo_status.st_message.text = "���ϻ������Դϴ�."
		
		ls_dbsql = 'CREATE TABLE ~"' + ls_dbid + '~" ( ~r~n'
      for ll_row = 1 to idw_11.rowcount()
			ls_name = upper(trim(idw_11.object.name[ll_row]))
			ls_type = upper(trim(idw_11.object.type[ll_row]))
			ls_length = upper(trim(idw_11.object.length[ll_row]))
			ls_xnull  = upper(trim(idw_11.object.xnull[ll_row]))
			ls_xdefault = upper(trim(string(idw_11.object.xdefault[ll_row])))
			Choose case ls_type
				case 'C','S'
					ls_length = "CHAR(" + ls_length + ")"
				case 'V'
					ls_length = "VARCHAR(" + ls_length + ")"	
				case 'N'
					ls_length = "NUMERIC(" + ls_length + ")"
				case 'I'
					ls_length = "INT(" + ls_length + ")"
				case else
					ls_length = "CHAR(" + ls_length + ")"
			End choose
			
			//ls_length = Replace(ls_length, 1, 1, "CHAR")
						
			ls_dbsql = ls_dbsql + ' ~"' + ls_name + '~" ' + ls_length 
			if ls_xnull = 'Y' then
				ls_dbsql = ls_dbsql + ' NULL ' 
			else
				ls_dbsql = ls_dbsql + ' NOT NULL ' 
			end if
			if ls_type = 'C' OR ls_type = 'V' or ls_type = 'S' then
				ls_dbsql = ls_dbsql + ' DEFAULT ~'' + ls_xdefault + '~', ~r~n'   
			else
				if isnumber(ls_xdefault) = false or ls_xdefault <> '' or isnull(ls_xdefault) then
				   ls_xdefault = '0' 
				end if	
				ls_dbsql = ls_dbsql + ' DEFAULT ' + ls_xdefault + ', ~r~n'   
		   end if
		next
		ls_dbsql = ls_dbsql + 'PRIMARY KEY ('
		for ll_row = 1 to idw_11.rowcount()
			ls_name = upper(trim(idw_11.object.name[ll_row]))
			ls_comment = upper(trim(idw_11.object.comment[ll_row]))
			if upper(mid(ls_comment,1,3)) = 'KEY' then
				ls_dbsql = ls_dbsql + ' ~"' + ls_name + '~", ' 
			end if
		next
		ls_dbsql = righttrim(ls_dbsql)
		ls_dbsql = replace(ls_dbsql, len(ls_dbsql),1,' ')
		ls_dbsql = ls_dbsql + ')); ~r~n'
		ll_file = fileopen(ls_docname,LINEmode!,write!,lockwrite!,replace!)

		if ll_File <= 0 then 
			Messagebox("����","������ ������ �� �����ϴ�.") 
			return
		end if 
		filewrite(ll_file,ls_dbsql)
		fileclose(ll_file)
		
		//db�������� �÷��Ӽ� ���� �߰�
		ll_file = fileopen(ls_docname,LINEmode!,write!,lockwrite!,Append!)
		if ll_File <= 0 then 
			Messagebox("����","������ ������ �� �����ϴ�.") 
			return
		end if 
		//db��Ī �� �Ӽ������
		ls_dbdesc = 'insert into ~"PBCOMMON~".pbcattbl' + &
		'(pbt_tnam, pbt_ownr, pbd_fhgt, pbd_fwgt, pbd_fitl, pbd_funl, pbd_fchr, pbd_fptc, pbd_ffce, pbh_fhgt, pbh_fwgt, pbh_fitl, pbh_funl, pbh_fchr, pbh_fptc, pbh_ffce, pbl_fhgt, pbl_fwgt, pbl_fitl, pbl_funl, pbl_fchr, pbl_fptc, pbl_ffce, pbt_cmnt)' + & 
		'values ( ~'' + ls_dbid + '~', ~'' + ls_lib + '~', 0, 400, ~'N~', ~'N~', 0, 0, ~'                  ~', 0, 400, ~'N~', ~'N~', 0, 0, ~'                  ~', 0, 400 , ~'N~', ~'N~', 0, 0, ~'                  ~', ' + &
		'~'' + ls_dbname + '~') ; ~r~n'
		//�÷��Ӽ��� ���
		for ll_row = 1 to idw_11.rowcount()
			ls_name = upper(trim(idw_11.object.name[ll_row]))
			ls_type = upper(trim(idw_11.object.type[ll_row]))
			ls_xdesc = upper(trim(idw_11.object.xdesc[ll_row]))
			ls_dbdesc = ls_dbdesc + &
		   'insert into ~"PBCOMMON~".pbcatcol' + &
		   '(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt )' + &
		    ' values ( ~'' + ls_dbid + '~', ~'' + ls_lib + '~', ~'' + ls_name + '~', ~'' + ls_xdesc + &
			 '~', 23 , ~'' + ls_xdesc + '~', 25, ' 
			if ls_type = 'C' or ls_type = 'V' or ls_type = 'S' then
				ls_dbdesc = ls_dbdesc + '23 , 0 , 0 , 0 , ~'N~', ~'' + ls_xdesc + '~' ) ; ~r~n'
			else
				ls_dbdesc = ls_dbdesc + '24 , 0 , 0 , 0 , ~'N~', ~'' + ls_xdesc + '~' ) ; ~r~n'
			end if
			if len(ls_dbdesc) > 30000 then  //������ �Ѱ� 
				filewrite(ll_file,ls_dbdesc)
				ls_dbdesc = ''
			end if
		next
		filewrite(ll_file,ls_dbdesc)
      fileclose(ll_file)
		
//		ls_dropsql = 'DROP TABLE ' + ls_lib + '.' + ls_dbid 
//		
//		EXECUTE IMMEDIATE :ls_dropsql;
//		if sqlca.sqlcode <> 0 then
//			messagebox('Ȯ��','drop table����:' + ls_dropsql + ' sqlcode:' +string(sqlca.sqlcode))
//		end if
//		EXECUTE IMMEDIATE :ls_dbsql;
//      if sqlca.sqlcode <> 0 then
//			messagebox('Ȯ��','create table����:' + ' sqlcode:' +string(sqlca.sqlcode) + ls_dbsql)
//		end if

				
		
		
		
//		ll_tot = len(l_file)
//		do while true 
//			ll_writ = filewrite(ll_file,blobmid(l_file,ll_written+1) )
//			if ll_writ = 0 then exit
//			ll_written += ll_writ
//			if ll_Written >= ll_tot then exit
//		loop 
		
		
		uo_status.st_message.text = ls_docname + " ���ϻ����Ϸ�"
//		messagebox('Ȯ��',ls_docname + " ���ϻ����Ϸ�")	
		
//		IF ll_rcnt > 0 THEN
//			wf_icon_onoff(true,true,true,true,false,true,false,true,false)  //I,A,U,D,P
//			uo_status.st_message.text = "��ȸ�Ϸ�"
//		ELSE
//			//idw_11.InsertRow(0)
//			wf_icon_onoff(true,true,false,false,false,false,false,true,false)
//			uo_status.st_message.text = "�ش���������"
//		END IF
		
END CHOOSE	

SetPointer(arrow!)



end event

event ue_dprint;call super::ue_dprint;f_screen_print(this)
end event

event open;call super::open;this.event post ue_open_after()
end event

event ue_bcreate;call super::ue_bcreate;CHOOSE CASE ii_tabindex
	CASE 1
		MessageBox("Ȯ��","���Ϲޱ⸦ �� �� ���� ���Դϴ�.")
		Return
	CASE 2
		IF idw_21.rowcount() > 0 THEN
			uo_status.st_message.text	=	'�ڷ�������Դϴ�.��ø� ��ٸ�����'
			f_save_to_excel(idw_21)
			uo_status.st_message.text	=	' '
		ELSE
			uo_status.st_message.text	=	'������ �ڷᰡ �����ϴ�'
		END IF
	CASE 3
		IF idw_31.rowcount() > 0 THEN
			uo_status.st_message.text	=	'�ڷ�������Դϴ�.��ø� ��ٸ�����'
			f_save_to_excel(idw_31)
			uo_status.st_message.text	=	' '
		ELSE
			uo_status.st_message.text	=	'������ �ڷᰡ �����ϴ�'
		END IF
END CHOOSE
end event

event ue_delete;call super::ue_delete;SetPointer(hourglass!)

String   ls_stcd, ls_ivno
Long     ll_row, ll_rcnt
Integer  li_rtn, li_ok

CHOOSE CASE ii_tabindex
	
	CASE 1
		IF idw_11.rowcount() = 0  THEN
			MessageBox('Ȯ��','������ Invoice�� ��ȸ�ϼ���!',Exclamation!)
			Return
		END IF
		
		//�����ڵ�� �����Ҽ� �ִ� ������ ����.
		ls_stcd = trim(idw_11.GetItemString(1,"stcd"))
		ls_ivno = idw_11.GetItemString(1,"ivno")
		
		IF ls_stcd <> 'A' and ls_stcd <> 'X' THEN
			CHOOSE CASE ls_stcd
				CASE 'B'
					MessageBox("Ȯ��","�����Ұ�:������� ��û�� ���Դϴ�.",exclamation!)		
				CASE 'C'
					MessageBox("Ȯ��","�����Ұ�:������� �Ϸ�� ���Դϴ�.",exclamation!)		
				CASE 'D'
					MessageBox("Ȯ��","�����Ұ�:���ڰ��� Ȯ���� ���Դϴ�.",exclamation!)		
			END CHOOSE
			Return
		END IF
			
		li_ok = MessageBox("����Ȯ��", &
								 "�ش� Invoice(" + ls_ivno + ")�� ������ �����˴ϴ�.~r" + &
						  		 "Ȯ��Ű�� ��������!", &
								 Exclamation!, OKCancel!, 2)
		
		IF li_ok <> 1 THEN
		  	 // Process CANCEL.
			 rollback using sqlca;
			 uo_status.st_message.text = f_message("D030")	//������ ��ҵǾ����ϴ�.
			 Return
		END IF
				
		FOR ll_row = idw_12.RowCount() TO 1 step -1
			idw_12.Deleterow(ll_row)
		NEXT
		FOR ll_row = idw_13.RowCount() TO 1 step -1
			idw_13.Deleterow(ll_row)
		NEXT
		IF idw_12.Update(True,False) <> 1 THEN  // ã�� : DataWindow controls:DBError event
			messagebox('Ȯ��','Invoice�� ǰ������ ������ ����,�����ٶ��ϴ�!',Exclamation!)
			ROLLBACK USING sqlca;
			uo_status.st_message.text = 'Invoice�� ǰ������ ������ ����,�����ٶ��ϴ�!'
			return
		end if
		IF idw_13.Update(True,False) <> 1 THEN  // ã�� : DataWindow controls:DBError event
			messagebox('Ȯ��','Invoice BOX���� ������ ����,�����ٶ��ϴ�!',Exclamation!)
			ROLLBACK USING sqlca;
			uo_status.st_message.text = 'Invoice BOX���� ������ ����,�����ٶ��ϴ�!'
			return
		end if
		idw_11.Deleterow(0)
		IF idw_11.Update(True,False) <> 1 THEN  // ã�� : DataWindow controls:DBError event
			messagebox('Ȯ��','Invoice�⺻���� ������ ����,�����ٶ��ϴ�!',Exclamation!)
			ROLLBACK USING sqlca;
			uo_status.st_message.text = 'Invoice�⺻���� ������ ����,�����ٶ��ϴ�!'
			return
		end if	
		COMMIT USING sqlca;
		idw_11.ResetUpdate()
		idw_12.ResetUpdate()
		idw_13.ResetUpdate()
		//This.triggerevent('ue_retrieve')
		uo_status.st_message.text = f_message("D010") //����
	CASE 2,3
		MessageBox("Ȯ��","���� �� �� ���� ���Դϴ�.")
		Return
END CHOOSE		

end event

type uo_status from w_origin_sheet09`uo_status within w_purcrtdb
integer y = 2468
end type

type tab_1 from tab within w_purcrtdb
event create ( )
event destroy ( )
integer y = 4
integer width = 4617
integer height = 2464
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.Control[]={this.tabpage_1}
end on

on tab_1.destroy
destroy(this.tabpage_1)
end on

event selectionchanged;ii_tabindex = newindex
g_n_tabno = newindex
CHOOSE CASE newindex
	CASE 1
		IF idw_11.rowcount() > 0 THEN
			wf_icon_onoff(true,false,false,false,false,true,false,true,false) //I,A,U,D,P
		ELSE
			wf_icon_onoff(true,false,false,false,false,false,false,true,false) //I,A,U,D,P
		END IF
	CASE 2
		wf_icon_onoff(true,false,false,false,false,false,false,true,false) //I,A,U,D,P
	CASE 3
		IF idw_31.rowcount() > 0 THEN
			wf_icon_onoff(true,false,true,false,false,true,false,true,false) //I,A,U,D,P
		ELSE
			wf_icon_onoff(true,false,false,false,false,false,false,true,false) //I,A,U,D,P
		END IF
END CHOOSE

end event

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4581
integer height = 2348
long backcolor = 12632256
string text = "DB�����������"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_11 dw_11
dw_10 dw_10
end type

on tabpage_1.create
this.dw_11=create dw_11
this.dw_10=create dw_10
this.Control[]={this.dw_11,&
this.dw_10}
end on

on tabpage_1.destroy
destroy(this.dw_11)
destroy(this.dw_10)
end on

type dw_11 from datawindow within tabpage_1
integer x = 14
integer y = 124
integer width = 4549
integer height = 2204
integer taborder = 40
string title = "none"
string dataobject = "d_pur050_crtdb_11"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
idw_11 = this

//this.insertrow(0)
end event

event itemchanged;Dec     ld_width, ld_length, ld_height, ld_boxamt, ld_volume
Dec{5}  ld_cwet, ld_gwet, ld_scost2, ld_exch
String  ls_curr,  ls_xcode , ls_coitname

This.AcceptText()

CHOOSE CASE dwo.Name
	case 'nation'  //�߼۱�
		select coalesce(max(coitname),''),coalesce(max(coextend),'')
		into :ls_coitname, :ls_xcode
		from  pbcommon.dac002
		where comltd = '01'
		and   cogubun = 'RCD200'
		and   cocode  = :data ;
		if trim(ls_xcode) = '' then
			MessageBox("Ȯ��", &
						  "�߼۱����� ���������� ��ϵǾ����� �ʽ��ϴ�.~r" + &
						  "����ڿ��� ��� ��û �Ͻʽÿ�.", Exclamation!)
			return 1
		end if
		this.object.dstn[1]  = ls_coitname
		this.object.xarea[1] = ls_xcode
		if this.object.gwet[row] > 0 then //��������� ��ۺ� �ٽ� ����
			idw_11.event post itemchanged(1,idw_11.object.gwet,string(idw_11.object.gwet[1]))
		end if
	case 'chk'
		if isnull(data)  then
			data = '0'
		end if
		if data = '1' then  //�����üũ
			if this.object.volume[row] = 0 then
				MessageBox("Ȯ��", &
						  "�����ɼ��� �����ϱ����� ���Ǹ� ���� �Է��ϼ���!",  &
						  Exclamation!)
			   return 1
			end if
			ld_volume = this.object.volume[row]
			Select coalesce(min(scost2),0) into :ld_boxamt
			from pbrcd.rcd410
			where comltd = '01'
			and   gubun = 'B'
			and   volume >= :ld_volume ; 
			this.object.boxamt[row] = ld_boxamt 
			if this.object.xpay[row] ='C' then
			  This.SetItem(row,'tamt',ld_boxamt)
		   else
				this.object.tamt[row] = this.object.tamt[row] + ld_boxamt 
		   end if
		end if
	CASE 'gwet','width','length','height','curr','boxamt'
		
		//��������� �� ��������
		ld_boxamt = This.GetItemDecimal(row,'boxamt')
		
		//�����߷� ȯ�� cwet ���
//		ld_width  = This.GetItemDecimal(row,'width')
//		ld_length = This.GetItemDecimal(row,'length')
//		ld_height = This.GetItemDecimal(row,'height')
//		this.object.volume[1] = ld_width * ld_length * ld_height
		
		ld_cwet   = this.object.volume[1] / 6000
      this.object.cwet[1] = ld_cwet   //�ڸ��� ���� �Է� 		
		
	   ls_xcode = this.object.xarea[1] 
		
		if this.object.xpay[row] ='C' then  //�ݷ�Ʈ �ݾ׾���
			return
		end if
		// * ���� �ֱ��� ���Ӵܰ��� �����;� �Ѵ�.
		// 1.�߷����� ���Ӵܰ�(�޷�) �����;� �Ѵ�.
		// 2.�����߷�ȯ�� > �߷� �̸� �����߷�ȯ�깫�Է� ���Ӵܰ�(�޷�)�����;� �Ѵ�.
		// * ���ӵ�޺��� �߷��� ���������Ѵ�.=>���Ӵܰ� ��Ͻ� �̰� üũ ����.
		
		//// ���� �ܰ� ��������.////////////////////////////////////////////////////
		
		//���߷�
		ld_gwet = This.GetItemDecimal(1,'gwet')
		//This.SetItem(row,'cwet',ld_cwet)  //�����߷�
		
		IF ld_cwet > ld_gwet THEN
			ld_gwet = ld_cwet         
		END IF	
		
		SELECT VALUE(MIN(SCOST2),0) 
		INTO   :ld_scost2
		FROM PBRCD.RCD410
		WHERE COMLTD = '01'       AND
				gubun  = 'A'        and
				xcode  =  :ls_xcode and
				WEIGHT >= :ld_gwet ;
				
		IF SQLCA.SQLCode <> 0 THEN
			MessageBox("Ȯ��", &
						  "���Ӵܰ��� ���� �ü� �����ϴ�.~r" + &
						  "�߼۱��� ���߷� ���� �Է��ϼ���. �׷��� ������ ���� ����ڿ��� ���� �Ͻʽÿ�!")
			return 1
		END IF
//		messagebox('',string(ls_xcode))
//		messagebox('',string(ld_gwet))
		IF ld_scost2 = 0 THEN		
			MessageBox("Database Error", &
						  "�ش��߷��� ���Ӵܰ��� �����ϴ�.~r" + &
						  "���� ����ڿ��� ���� �Ͻʽÿ�!")
			return 1
		END IF
				
		////// Setting/////////////////////////////////////////////////////////////
		// 1.���Ӵܰ��� ��ȭ ��۱ݾ� Setting
		// 2.ȯ���� ��ȭ ��ۺ� ���.
		// 3.��۱ݾ��ձ��� ����ؼ� Setting �Ϸ�.
		
		ls_curr = This.GetItemString(row,'curr')
		
		//ȯ�� Setting
		SELECT EXCH1
		INTO   :ld_exch
		FROM PBRCD.RCD110
		WHERE COMLTD = '01'  AND
				GUBUN  = 'A'   AND
				CURR   = :ls_curr AND
				ADJDT  = ( SELECT MAX(ADJDT)
							  FROM PBRCD.RCD110
							  WHERE COMLTD = '01'     AND
									  GUBUN  = 'A'      AND
									  CURR   = :ls_curr AND
									  ADJDT  < '99999999' ) ;
									  
		IF SQLCA.SQLCode <> 0 THEN
			MessageBox("Ȯ��", &
						  "ȯ���� ��ϵǾ����� �ʽ��ϴ�.~r" + &
						  "����ڿ��� ȯ����� ��û �Ͻʽÿ�.", Exclamation!)
			return 1
		END IF
		
		This.SetItem(row,'exch',ld_exch)
		This.SetItem(row,'samt',ld_scost2)
		This.SetItem(row,'wamt',ld_scost2 * ld_exch)
		This.SetItem(row,'ddpc',0 )
		This.SetItem(row,'boxamt',ld_boxamt)
		This.SetItem(row,'etc', 0)
		This.SetItem(row,'tamt',(ld_scost2 * ld_exch) + ld_boxamt)
		if this.object.xpay[row] = 'P' and this.object.tamt[row] > 200000 then
			MessageBox("Ȯ��", &
						  "20�����̻��� ������ �ӿ����縦 ���ľ� �մϴ�.~r" + &
						  "Ȯ���Ͻʽÿ�.", Exclamation!)
		end if
	case 'sdate'  //�߼�����üũ
	   if isnull(data)  then
			data = ''
		end if
		if trim(f_dateedit(data))  = '' then
			MessageBox("Ȯ��", &
						  "�߼�����" + &
						  "Ȯ���Ͻʽÿ�.", Exclamation!)
			return 1			  
		end if
	case 'xpay'  //���ҹ��
	   if isnull(data)  then
			data = ''
		end if
		if trim(data)  = 'P' then
			this.object.courier[row] = ''
			this.object.account[row] = ''
			if this.object.gwet[row] > 0 then //�������Ǻ���� ��ۺ� �ٽ� ����
				idw_11.event post itemchanged(1,idw_11.object.gwet,string(idw_11.object.gwet[1]))
			end if
		end if	
		if trim(data)  = 'C' then
			if this.object.wamt[row] > 0 then
				MessageBox("����","COLLECT��������" + &
						  "��ۺ� 0�Դϴ�. �����ϼ���.", Exclamation!)
				this.object.samt[row] = 0		  
				this.object.wamt[row] = 0	
				this.object.tamt[row] = this.object.boxamt[row] 		  		  
			end if	
		end if	
END CHOOSE


end event

event itemerror;return 1
end event

event getfocus;f_pur040_toggle(handle(this),'ENG')
end event

type dw_10 from datawindow within tabpage_1
event ue_dwnkey pbm_dwnkey
integer x = 41
integer y = 16
integer width = 2560
integer height = 92
integer taborder = 170
boolean bringtotop = true
string title = "none"
string dataobject = "d_pur050_crtdb_10"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_dwnkey;if key = keyenter! then
	iw_sheet.triggerevent('ue_retrieve')
end if
end event

event constructor;this.settransobject(sqlca)
idw_10 = this

//this.GetChild("div",idwc_1)
//idwc_1.SetTransObject(Sqlca)
//idwc_1.Retrieve('D')
//
//this.GetChild("pdcd",idwc_1)
//idwc_1.SetTransObject(Sqlca)
//idwc_1.Retrieve('A')

this.insertrow(0)
if g_s_empno = '970077' then
	this.object.lib[1] = 'PBPUR'
	this.object.dbid[1] = 'OPM401'
end if
f_pur040_nullchk03(this)

//this.object.frdt[1] = f_pur040_relativedate(g_s_date,-180)
//this.object.todt[1] = g_s_date
end event

event itemerror;return 1
end event

event losefocus;f_pur040_toggle( handle(This), 'ENG' ) // Ű���� �������� ����...
end event

event itemfocuschanged;CHOOSE CASE DWO.NAME
	CASE 'dbname'
		f_pur040_toggle(handle(this),'KOR')
	case else
		f_pur040_toggle(handle(this),'ENG')
End choose
end event

event getfocus;f_pur040_toggle(handle(this),'ENG')
end event

