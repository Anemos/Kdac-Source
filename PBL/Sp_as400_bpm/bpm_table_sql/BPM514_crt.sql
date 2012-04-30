CREATE TABLE "BPM514" ( 
 "ZCMCD" CHAR(2) NOT NULL  DEFAULT '', 
 "ZDATE" CHAR(4) NOT NULL  DEFAULT '', 
 "ZBREV" CHAR(2) NOT NULL  DEFAULT '', 
 "ZGUBUN" CHAR(1) NOT NULL  DEFAULT '', 
 "ZPLANT" CHAR(1) NOT NULL  DEFAULT '', 
 "ZDIV" CHAR(1) NOT NULL  DEFAULT '', 
 "ZMDCD" VARCHAR(4) NOT NULL  DEFAULT '', 
 "ZMDNO" VARCHAR(12) NOT NULL  DEFAULT '', 
 "ZSERIAL" NUMERIC(4,0) NOT NULL  DEFAULT 0, 
 "ZLEVEL" VARCHAR(10) NOT NULL  DEFAULT '', 
 "ZITNO" VARCHAR(12) NOT NULL  DEFAULT '', 
 "ZREV" CHAR(1) NOT NULL  DEFAULT '', 
 "ZDESC" VARCHAR(50) NOT NULL  DEFAULT '', 
 "ZSPEC" VARCHAR(50) NOT NULL  DEFAULT '', 
 "ZUNITQTY" NUMERIC(11,3) NOT NULL  DEFAULT 0, 
 "ZUNIT1" CHAR(2) NOT NULL  DEFAULT '', 
 "ZCONFACT" NUMERIC(13,5) NOT NULL  DEFAULT 0, 
 "ZUNIT2" CHAR(2) NOT NULL  DEFAULT '', 
 "ZSRCE" CHAR(2) NOT NULL  DEFAULT '', 
 "ZTYPE" CHAR(1) NOT NULL  DEFAULT '', 
 "ZCURD" CHAR(3) NOT NULL  DEFAULT '', 
 "ZCURE" CHAR(3) NOT NULL  DEFAULT '', 
 "ZFOB1" CHAR(1) NOT NULL  DEFAULT '', 
 "ZFOB2" CHAR(1) NOT NULL  DEFAULT '', 
 "ZCHK" CHAR(2) NOT NULL  DEFAULT '', 
 "ZCURDCST" NUMERIC(11,6) NOT NULL  DEFAULT 0, 
 "ZCURECST" NUMERIC(11,6) NOT NULL  DEFAULT 0, 
 "ZWONDCST" NUMERIC(11,6) NOT NULL  DEFAULT 0, 
 "ZWONECST" NUMERIC(11,6) NOT NULL  DEFAULT 0, 
 "ZWONEAMT" NUMERIC(13,6) NOT NULL  DEFAULT 0, 
 "ZWONDAMT" NUMERIC(13,6) NOT NULL  DEFAULT 0, 
 "ZWKCT" CHAR(4) NOT NULL  DEFAULT '', 
 "ZGRAD" CHAR(1) NOT NULL  DEFAULT '', 
 "ZALTNO" VARCHAR(12) NOT NULL  DEFAULT '', 
 "ZFMDT" CHAR(8) NOT NULL  DEFAULT '', 
 "ZTODT" CHAR(8) NOT NULL  DEFAULT '', 
 "ZCALC" CHAR(1) NOT NULL  DEFAULT '', 
PRIMARY KEY ( "ZCMCD",  "ZDATE",  "ZGUBUN",  "ZPLANT",  "ZDIV",  "ZMDCD",  "ZMDNO",  "ZSERIAL" )); 

insert into "PBCOMMON".pbcattbl(pbt_tnam, pbt_ownr, pbd_fhgt, pbd_fwgt, pbd_fitl, pbd_funl, pbd_fchr, pbd_fptc, pbd_ffce, pbh_fhgt, pbh_fwgt, pbh_fitl, pbh_funl, pbh_fchr, pbh_fptc, pbh_ffce, pbl_fhgt, pbl_fwgt, pbl_fitl, pbl_funl, pbl_fchr, pbl_fptc, pbl_ffce, pbt_cmnt)values ( 'BPM514', 'PBBPM', 0, 400, 'N', 'N', 0, 0, '                  ', 0, 400, 'N', 'N', 0, 0, '                  ', 0, 400 , 'N', 'N', 0, 0, '                  ', '�����ȹBOM������ȸ') ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZCMCD', 'ȸ��', 23 , 'ȸ��', 25, 23 , 0 , 0 , 0 , 'N', 'ȸ��' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZDATE', '�����ȹ�⵵', 23 , '�����ȹ�⵵', 25, 23 , 0 , 0 , 0 , 'N', '�����ȹ�⵵' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZBREV', '����', 23 , '����', 25, 23 , 0 , 0 , 0 , 'N', '����' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZGUBUN', '��α���', 23 , '��α���', 25, 23 , 0 , 0 , 0 , 'N', '��α���' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZPLANT', '����', 23 , '����', 25, 23 , 0 , 0 , 0 , 'N', '����' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZDIV', '����', 23 , '����', 25, 23 , 0 , 0 , 0 , 'N', '����' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZMDCD', '�𵨱�', 23 , '�𵨱�', 25, 23 , 0 , 0 , 0 , 'N', '�𵨱�' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZMDNO', '��ǰ��', 23 , '��ǰ��', 25, 23 , 0 , 0 , 0 , 'N', '��ǰ��' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZSERIAL', '����', 23 , '����', 25, 24 , 0 , 0 , 0 , 'N', '����' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZLEVEL', '����', 23 , '����', 25, 23 , 0 , 0 , 0 , 'N', '����' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZITNO', '��ǰ��', 23 , '��ǰ��', 25, 23 , 0 , 0 , 0 , 'N', '��ǰ��' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZREV', 'REV', 23 , 'REV', 25, 23 , 0 , 0 , 0 , 'N', 'REV' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZDESC', 'ǰ��', 23 , 'ǰ��', 25, 23 , 0 , 0 , 0 , 'N', 'ǰ��' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZSPEC', '�԰�', 23 , '�԰�', 25, 23 , 0 , 0 , 0 , 'N', '�԰�' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZUNITQTY', '������', 23 , '������', 25, 24 , 0 , 0 , 0 , 'N', '������' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZUNIT1', 'BOM������', 23 , 'BOM������', 25, 23 , 0 , 0 , 0 , 'N', 'BOM������' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZCONFACT', '��ȯ���', 23 , '��ȯ���', 25, 24 , 0 , 0 , 0 , 'N', '��ȯ���' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZUNIT2', '���ſ�����', 23 , '���ſ�����', 25, 23 , 0 , 0 , 0 , 'N', '���ſ�����' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZSRCE', '���Լ�', 23 , '���Լ�', 25, 23 , 0 , 0 , 0 , 'N', '���Լ�' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZTYPE', 'Ÿ��', 23 , 'Ÿ��', 25, 23 , 0 , 0 , 0 , 'N', 'Ÿ��' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZCURD', '������ȭ', 23 , '������ȭ', 25, 23 , 0 , 0 , 0 , 'N', '������ȭ' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZCURE', '������ȭ', 23 , '������ȭ', 25, 23 , 0 , 0 , 0 , 'N', '������ȭ' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZFOB1', 'FOB1', 23 , 'FOB1', 25, 23 , 0 , 0 , 0 , 'N', 'FOB1' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZFOB2', 'FOB2', 23 , 'FOB2', 25, 23 , 0 , 0 , 0 , 'N', 'FOB2' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZCHK', '����', 23 , '����', 25, 23 , 0 , 0 , 0 , 'N', '����' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZCURDCST', '���ڴܰ�', 23 , '���ڴܰ�', 25, 24 , 0 , 0 , 0 , 'N', '���ڴܰ�' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZCURECST', '���ڴܰ�', 23 , '���ڴܰ�', 25, 24 , 0 , 0 , 0 , 'N', '���ڴܰ�' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZWONDCST', '���ڴܰ�(��ȯ)', 23 , '���ڴܰ�(��ȯ)', 25, 24 , 0 , 0 , 0 , 'N', '���ڴܰ�(��ȯ)' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZWONECST', '���ڴܰ�(��ȭ)', 23 , '���ڴܰ�(��ȭ)', 25, 24 , 0 , 0 , 0 , 'N', '���ڴܰ�(��ȭ)' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZWONEAMT', '���ڱݾ�', 23 , '���ڱݾ�', 25, 24 , 0 , 0 , 0 , 'N', '���ڱݾ�' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZWONDAMT', '���ڱݾ�', 23 , '���ڱݾ�', 25, 24 , 0 , 0 , 0 , 'N', '���ڱݾ�' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZWKCT', '�����', 23 , '�����', 25, 23 , 0 , 0 , 0 , 'N', '�����' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZGRAD', '���', 23 , '���', 25, 23 , 0 , 0 , 0 , 'N', '���' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZALTNO', '��ü', 23 , '��ü', 25, 23 , 0 , 0 , 0 , 'N', '��ü' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZFMDT', '��������', 23 , '��������', 25, 23 , 0 , 0 , 0 , 'N', '��������' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZTODT', '�Ϸ�����', 23 , '�Ϸ�����', 25, 23 , 0 , 0 , 0 , 'N', '�Ϸ�����' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZCALC', '������', 23 , '������', 25, 23 , 0 , 0 , 0 , 'N', '������' ) ; 

