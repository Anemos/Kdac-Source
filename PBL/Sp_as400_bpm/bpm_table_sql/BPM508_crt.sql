CREATE TABLE "BPM508" ( 
 "COMLTD" CHAR(2) NOT NULL  DEFAULT '', 
 "XYEAR" CHAR(4) NOT NULL  DEFAULT '', 
 "BREV" CHAR(2) NOT NULL  DEFAULT '', 
 "BGUBUN" CHAR(1) NOT NULL  DEFAULT '', 
 "BPLANT" CHAR(1) NOT NULL  DEFAULT '', 
 "BDIV" CHAR(1) NOT NULL  DEFAULT '', 
 "BMDCD" CHAR(4) NOT NULL  DEFAULT '', 
 "BMDNO" CHAR(12) NOT NULL  DEFAULT '', 
 "BSERNO" NUMERIC(4,0) NOT NULL  DEFAULT 0, 
 "BPRNO" CHAR(12) NOT NULL  DEFAULT '', 
 "BCHNO" CHAR(12) NOT NULL  DEFAULT '', 
 "BLEV" NUMERIC(2,0) NOT NULL  DEFAULT 0, 
 "BLOLE" NUMERIC(2,0) NOT NULL  DEFAULT 0, 
 "BUM" CHAR(2) NOT NULL  DEFAULT '', 
 "BWOCT" CHAR(4) NOT NULL  DEFAULT '', 
 "BPRQT" NUMERIC(9,3) NOT NULL  DEFAULT 0, 
 "BPRQT1" NUMERIC(9,3) NOT NULL  DEFAULT 0, 
 "BFMDT" CHAR(8) NOT NULL  DEFAULT '', 
 "BTODT" CHAR(8) NOT NULL  DEFAULT '', 
 "BALCD" CHAR(1) NOT NULL  DEFAULT '', 
 "BYOU" CHAR(1) NOT NULL  DEFAULT '', 
 "BGRAD" CHAR(1) NOT NULL  DEFAULT '', 
 "BALTNO" VARCHAR(12) NOT NULL  DEFAULT '', 
 "BCALC" CHAR(1) NOT NULL  DEFAULT '', 
 "EXTD" CHAR(10) NOT NULL  DEFAULT '', 
 "INPTID" CHAR(6) NOT NULL  DEFAULT '', 
 "INPTDT" CHAR(19) NOT NULL  DEFAULT '', 
 "UPDTID" CHAR(6) NOT NULL  DEFAULT '', 
 "UPDTDT" CHAR(19) NOT NULL  DEFAULT '', 
 "IPADDR" CHAR(30) NOT NULL  DEFAULT '', 
 "MACADDR" CHAR(30) NOT NULL  DEFAULT '', 
PRIMARY KEY ( "COMLTD",  "XYEAR",  "BREV",  "BGUBUN",  "BPLANT",  "BDIV",  "BMDCD",  "BMDNO",  "BSERNO" )); 

insert into "PBCOMMON".pbcattbl(pbt_tnam, pbt_ownr, pbd_fhgt, pbd_fwgt, pbd_fitl, pbd_funl, pbd_fchr, pbd_fptc, pbd_ffce, pbh_fhgt, pbh_fwgt, pbh_fitl, pbh_funl, pbh_fchr, pbh_fptc, pbh_ffce, pbl_fhgt, pbl_fwgt, pbl_fitl, pbl_funl, pbl_fchr, pbl_fptc, pbl_ffce, pbt_cmnt)values ( 'BPM508', 'PBBPM', 0, 400, 'N', 'N', 0, 0, '                  ', 0, 400, 'N', 'N', 0, 0, '                  ', 0, 400 , 'N', 'N', 0, 0, '                  ', '�����ȹBOM����������') ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'COMLTD', 'ȸ��', 23 , 'ȸ��', 25, 23 , 0 , 0 , 0 , 'N', 'ȸ��' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'XYEAR', '�����ȹ�⵵', 23 , '�����ȹ�⵵', 25, 23 , 0 , 0 , 0 , 'N', '�����ȹ�⵵' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BREV', '����', 23 , '����', 25, 23 , 0 , 0 , 0 , 'N', '����' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BGUBUN', '��α���', 23 , '��α���', 25, 23 , 0 , 0 , 0 , 'N', '��α���' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BPLANT', '����', 23 , '����', 25, 23 , 0 , 0 , 0 , 'N', '����' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BDIV', '����', 23 , '����', 25, 23 , 0 , 0 , 0 , 'N', '����' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BMDCD', '��ǰ��', 23 , '��ǰ��', 25, 23 , 0 , 0 , 0 , 'N', '��ǰ��' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BMDNO', '��ǰ��', 23 , '��ǰ��', 25, 23 , 0 , 0 , 0 , 'N', '��ǰ��' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BSERNO', '����', 23 , '����', 25, 24 , 0 , 0 , 0 , 'N', '����' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BPRNO', '��ǰ��', 23 , '��ǰ��', 25, 23 , 0 , 0 , 0 , 'N', '��ǰ��' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BCHNO', '��ǰ��', 23 , '��ǰ��', 25, 23 , 0 , 0 , 0 , 'N', '��ǰ��' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BLEV', '����', 23 , '����', 25, 24 , 0 , 0 , 0 , 'N', '����' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BLOLE', '���Ϸ���', 23 , '���Ϸ���', 25, 24 , 0 , 0 , 0 , 'N', '���Ϸ���' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BUM', 'BOM����', 23 , 'BOM����', 25, 23 , 0 , 0 , 0 , 'N', 'BOM����' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BWOCT', '���ڵ�', 23 , '���ڵ�', 25, 23 , 0 , 0 , 0 , 'N', '���ڵ�' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BPRQT', '�𵨿�����', 23 , '�𵨿�����', 25, 24 , 0 , 0 , 0 , 'N', '�𵨿�����' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BPRQT1', '����������', 23 , '����������', 25, 24 , 0 , 0 , 0 , 'N', '����������' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BFMDT', '��������', 23 , '��������', 25, 23 , 0 , 0 , 0 , 'N', '��������' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BTODT', '�Ϸ�����', 23 , '�Ϸ�����', 25, 23 , 0 , 0 , 0 , 'N', '�Ϸ�����' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BALCD', '��ü����', 23 , '��ü����', 25, 23 , 0 , 0 , 0 , 'N', '��ü����' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BYOU', '�����󱸺�', 23 , '�����󱸺�', 25, 23 , 0 , 0 , 0 , 'N', '�����󱸺�' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BGRAD', 'ȣȯ���', 23 , 'ȣȯ���', 25, 23 , 0 , 0 , 0 , 'N', 'ȣȯ���' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BALTNO', 'ȣȯ��ǰ��', 23 , 'ȣȯ��ǰ��', 25, 23 , 0 , 0 , 0 , 'N', 'ȣȯ��ǰ��' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BCALC', '��������', 23 , '��������', 25, 23 , 0 , 0 , 0 , 'N', '��������' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'EXTD', '���', 23 , '���', 25, 23 , 0 , 0 , 0 , 'N', '���' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'INPTID', '�Է��� ���', 23 , '�Է��� ���', 25, 23 , 0 , 0 , 0 , 'N', '�Է��� ���' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'INPTDT', '�Է���', 23 , '�Է���', 25, 23 , 0 , 0 , 0 , 'N', '�Է���' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'UPDTID', '������ ���', 23 , '������ ���', 25, 23 , 0 , 0 , 0 , 'N', '������ ���' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'UPDTDT', '������', 23 , '������', 25, 23 , 0 , 0 , 0 , 'N', '������' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'IPADDR', 'IP ADDRESS', 23 , 'IP ADDRESS', 25, 23 , 0 , 0 , 0 , 'N', 'IP ADDRESS' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'MACADDR', 'MAC ADDRESS', 23 , 'MAC ADDRESS', 25, 23 , 0 , 0 , 0 , 'N', 'MAC ADDRESS' ) ; 

