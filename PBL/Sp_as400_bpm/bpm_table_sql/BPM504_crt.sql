CREATE TABLE "BPM504" ( 
 "PCMCD" CHAR(2) NOT NULL  DEFAULT '', 
 "XYEAR" CHAR(4) NOT NULL  DEFAULT '', 
 "REVNO" CHAR(2) NOT NULL  DEFAULT '', 
 "PLANT" CHAR(1) NOT NULL  DEFAULT '', 
 "PDVSN" CHAR(1) NOT NULL  DEFAULT '', 
 "PPITN" VARCHAR(15) NOT NULL  DEFAULT '', 
 "PROUT" CHAR(4) NOT NULL  DEFAULT '', 
 "PCITN" VARCHAR(15) NOT NULL  DEFAULT '', 
 "PCHDT" CHAR(8) NOT NULL  DEFAULT '', 
 "PQTYM" NUMERIC(8,3) NOT NULL  DEFAULT 0, 
 "PQTYE" NUMERIC(8,3) NOT NULL  DEFAULT 0, 
 "PWKCT" CHAR(4) NOT NULL  DEFAULT '', 
 "PEDTM" CHAR(8) NOT NULL  DEFAULT '', 
 "PEDTE" CHAR(8) NOT NULL  DEFAULT '', 
 "POPCD" CHAR(1) NOT NULL  DEFAULT '', 
 "PEXPLANT" CHAR(1) NOT NULL  DEFAULT '', 
 "PEXDV" CHAR(1) NOT NULL  DEFAULT '', 
 "PCHCD" CHAR(1) NOT NULL  DEFAULT '', 
 "POSCD" CHAR(1) NOT NULL  DEFAULT '', 
 "PEBST" CHAR(1) NOT NULL  DEFAULT '', 
 "PMACADDR" VARCHAR(30) NOT NULL  DEFAULT '', 
 "PIPADDR" VARCHAR(30) NOT NULL  DEFAULT '', 
 "PINDT" CHAR(8) NOT NULL  DEFAULT '', 
 "PEMNO" CHAR(6) NOT NULL  DEFAULT '', 
 "PREMK" CHAR(20) NOT NULL  DEFAULT '', 
PRIMARY KEY ( "PCMCD",  "XYEAR",  "REVNO",  "PLANT",  "PDVSN",  "PPITN",  "PROUT",  "PCITN",  "PCHDT" )); 

insert into "PBCOMMON".pbcattbl(pbt_tnam, pbt_ownr, pbd_fhgt, pbd_fwgt, pbd_fitl, pbd_funl, pbd_fchr, pbd_fptc, pbd_ffce, pbh_fhgt, pbh_fwgt, pbh_fitl, pbh_funl, pbh_fchr, pbh_fptc, pbh_ffce, pbl_fhgt, pbl_fwgt, pbl_fitl, pbl_funl, pbl_fchr, pbl_fptc, pbl_ffce, pbt_cmnt)values ( 'BPM504', 'PBBPM', 0, 400, 'N', 'N', 0, 0, '                  ', 0, 400, 'N', 'N', 0, 0, '                  ', 0, 400 , 'N', 'N', 0, 0, '                  ', '�����ȹBOM���') ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PCMCD', 'ȸ��', 23 , 'ȸ��', 25, 23 , 0 , 0 , 0 , 'N', 'ȸ��' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'XYEAR', '�����ȹ�⵵', 23 , '�����ȹ�⵵', 25, 23 , 0 , 0 , 0 , 'N', '�����ȹ�⵵' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'REVNO', '����', 23 , '����', 25, 23 , 0 , 0 , 0 , 'N', '����' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PLANT', '����', 23 , '����', 25, 23 , 0 , 0 , 0 , 'N', '����' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PDVSN', '����', 23 , '����', 25, 23 , 0 , 0 , 0 , 'N', '����' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PPITN', '����ǰ��', 23 , '����ǰ��', 25, 23 , 0 , 0 , 0 , 'N', '����ǰ��' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PROUT', '�����', 23 , '�����', 25, 23 , 0 , 0 , 0 , 'N', '�����' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PCITN', '����ǰ��', 23 , '����ǰ��', 25, 23 , 0 , 0 , 0 , 'N', '����ǰ��' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PCHDT', '��������', 23 , '��������', 25, 23 , 0 , 0 , 0 , 'N', '��������' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PQTYM', '������(����)', 23 , '������(����)', 25, 24 , 0 , 0 , 0 , 'N', '������(����)' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PQTYE', '������(����)', 23 , '������(����)', 25, 24 , 0 , 0 , 0 , 'N', '������(����)' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PWKCT', '�۾���', 23 , '�۾���', 25, 23 , 0 , 0 , 0 , 'N', '�۾���' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PEDTM', '��������', 23 , '��������', 25, 23 , 0 , 0 , 0 , 'N', '��������' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PEDTE', '�Ϸ�����', 23 , '�Ϸ�����', 25, 23 , 0 , 0 , 0 , 'N', '�Ϸ�����' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'POPCD', 'ȣȯ����', 23 , 'ȣȯ����', 25, 23 , 0 , 0 , 0 , 'N', 'ȣȯ����' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PEXPLANT', '��ü����', 23 , '��ü����', 25, 23 , 0 , 0 , 0 , 'N', '��ü����' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PEXDV', '��ü����', 23 , '��ü����', 25, 23 , 0 , 0 , 0 , 'N', '��ü����' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PCHCD', '���汸��', 23 , '���汸��', 25, 23 , 0 , 0 , 0 , 'N', '���汸��' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'POSCD', '��ޱ���', 23 , '��ޱ���', 25, 23 , 0 , 0 , 0 , 'N', '��ޱ���' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PEBST', '�����ڵ�', 23 , '�����ڵ�', 25, 23 , 0 , 0 , 0 , 'N', '�����ڵ�' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PMACADDR', 'MAC ADDRESS', 23 , 'MAC ADDRESS', 25, 23 , 0 , 0 , 0 , 'N', 'MAC ADDRESS' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PIPADDR', 'IP ADDRESS', 23 , 'IP ADDRESS', 25, 23 , 0 , 0 , 0 , 'N', 'IP ADDRESS' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PINDT', '��������', 23 , '��������', 25, 23 , 0 , 0 , 0 , 'N', '��������' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PEMNO', '������', 23 , '������', 25, 23 , 0 , 0 , 0 , 'N', '������' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PREMK', '���', 23 , '���', 25, 23 , 0 , 0 , 0 , 'N', '���' ) ; 

