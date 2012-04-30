CREATE TABLE "BPM505" ( 
 "OCMCD" CHAR(2) NOT NULL  DEFAULT '', 
 "XYEAR" CHAR(4) NOT NULL  DEFAULT '', 
 "REVNO" CHAR(2) NOT NULL  DEFAULT '', 
 "OPLANT" CHAR(1) NOT NULL  DEFAULT '', 
 "ODVSN" CHAR(1) NOT NULL  DEFAULT '', 
 "OPITN" VARCHAR(15) NOT NULL  DEFAULT '', 
 "OFITN" VARCHAR(15) NOT NULL  DEFAULT '', 
 "OCHDT" CHAR(8) NOT NULL  DEFAULT '', 
 "OEDTM" CHAR(8) NOT NULL  DEFAULT '', 
 "OEDTE" CHAR(8) NOT NULL  DEFAULT '', 
 "ORATE" NUMERIC(5,2) NOT NULL  DEFAULT 0, 
 "OCHCD" CHAR(1) NOT NULL  DEFAULT '', 
 "OFOCD" CHAR(2) NOT NULL  DEFAULT '', 
 "OMACADDR" VARCHAR(30) NOT NULL  DEFAULT '', 
 "OIPADDR" VARCHAR(30) NOT NULL  DEFAULT '', 
 "OEMNO" CHAR(6) NOT NULL  DEFAULT '', 
PRIMARY KEY ( "OCMCD",  "XYEAR",  "REVNO",  "OPLANT",  "ODVSN",  "OPITN",  "OFITN",  "OCHDT" )); 

insert into "PBCOMMON".pbcattbl(pbt_tnam, pbt_ownr, pbd_fhgt, pbd_fwgt, pbd_fitl, pbd_funl, pbd_fchr, pbd_fptc, pbd_ffce, pbh_fhgt, pbh_fwgt, pbh_fitl, pbh_funl, pbh_fchr, pbh_fptc, pbh_ffce, pbl_fhgt, pbl_fwgt, pbl_fitl, pbl_funl, pbl_fchr, pbl_fptc, pbl_ffce, pbt_cmnt)values ( 'BPM505', 'PBBPM', 0, 400, 'N', 'N', 0, 0, '                  ', 0, 400, 'N', 'N', 0, 0, '                  ', 0, 400 , 'N', 'N', 0, 0, '                  ', '�����ȹBOMȣȯ���') ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM505', 'PBBPM', 'OCMCD', 'ȸ��', 23 , 'ȸ��', 25, 23 , 0 , 0 , 0 , 'N', 'ȸ��' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM505', 'PBBPM', 'XYEAR', '�����ȹ�⵵', 23 , '�����ȹ�⵵', 25, 23 , 0 , 0 , 0 , 'N', '�����ȹ�⵵' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM505', 'PBBPM', 'REVNO', '����', 23 , '����', 25, 23 , 0 , 0 , 0 , 'N', '����' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM505', 'PBBPM', 'OPLANT', '����', 23 , '����', 25, 23 , 0 , 0 , 0 , 'N', '����' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM505', 'PBBPM', 'ODVSN', '����', 23 , '����', 25, 23 , 0 , 0 , 0 , 'N', '����' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM505', 'PBBPM', 'OPITN', '��ǰ��', 23 , '��ǰ��', 25, 23 , 0 , 0 , 0 , 'N', '��ǰ��' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM505', 'PBBPM', 'OFITN', '��ǰ��', 23 , '��ǰ��', 25, 23 , 0 , 0 , 0 , 'N', '��ǰ��' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM505', 'PBBPM', 'OCHDT', '��������', 23 , '��������', 25, 23 , 0 , 0 , 0 , 'N', '��������' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM505', 'PBBPM', 'OEDTM', '��������', 23 , '��������', 25, 23 , 0 , 0 , 0 , 'N', '��������' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM505', 'PBBPM', 'OEDTE', '�Ϸ�����', 23 , '�Ϸ�����', 25, 23 , 0 , 0 , 0 , 'N', '�Ϸ�����' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM505', 'PBBPM', 'ORATE', 'ȣȯ��', 23 , 'ȣȯ��', 25, 24 , 0 , 0 , 0 , 'N', 'ȣȯ��' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM505', 'PBBPM', 'OCHCD', '���汸��', 23 , '���汸��', 25, 23 , 0 , 0 , 0 , 'N', '���汸��' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM505', 'PBBPM', 'OFOCD', '�ɼ�', 23 , '�ɼ�', 25, 23 , 0 , 0 , 0 , 'N', '�ɼ�' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM505', 'PBBPM', 'OMACADDR', 'MAC ADDRESS', 23 , 'MAC ADDRESS', 25, 23 , 0 , 0 , 0 , 'N', 'MAC ADDRESS' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM505', 'PBBPM', 'OIPADDR', 'IP ADDRESS', 23 , 'IP ADDRESS', 25, 23 , 0 , 0 , 0 , 'N', 'IP ADDRESS' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM505', 'PBBPM', 'OEMNO', '������', 23 , '������', 25, 23 , 0 , 0 , 0 , 'N', '������' ) ; 

