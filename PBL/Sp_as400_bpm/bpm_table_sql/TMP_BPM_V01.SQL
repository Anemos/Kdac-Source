--  Generate SQL 
--  Version:                   	V5R3M0 040528 
--  Generated on:              	11/10/20 16:19:41 
--  Relational Database:       	I520 
--  Standards Option:          	DB2 UDB iSeries 
--  �����ȹ ����������( ȣȯ��, ����ȣȯ���߰� )

DROP TABLE QTEMP.TMP_BPM;

CREATE TABLE QTEMP.TMP_BPM ( 
	TCMCD CHAR(2) CCSID 833 NOT NULL ,     --ȸ��
	TPLNT CHAR(1) CCSID 833 NOT NULL ,  -- ����
	TDVSN CHAR(2) CCSID 833 NOT NULL ,       --����
	TMODL CHAR(15) CCSID 933 NOT NULL ,     --��ǰ
	TOPTION CHAR(15) CCSID 933 NOT NULL ,     --ȣȯ��ǰ��
	TLEVEL NUMERIC(2, 0) CCSID 833 NOT NULL ,       --����
	TPITN CHAR(15) CCSID 933 NOT NULL ,      --����ǰ��
	TCITN CHAR(15) CCSID 933 NOT NULL ,     --����ǰ��
	TQTYM NUMERIC(8, 3) NOT NULL ,         --������
	TQTY1 NUMERIC(8, 3) NOT NULL ,         --���������
	TWKCT CHAR(4) CCSID 933 NOT NULL ,     --�۾���
	TEDTM CHAR(8) CCSID 933 NOT NULL ,           --��������
	TEDTE CHAR(8) CCSID 933 NOT NULL ,          --�Ϸ�����
	TOPCD CHAR(1) CCSID 833 NOT NULL ,        --ȣȯ���� ' ','1','2'
	TEXPLANT CHAR(1) CCSID 833 NOT NULL ,      --��ü����
	TEXDV CHAR(1) CCSID 833 NOT NULL ,          --��ü����
	TOSCD CHAR(1) CCSID 833 NOT NULL ,         --���������� '*'
	TCALCULATE CHAR(1) CCSID 933 NOT NULL ,    --������
	TCOMCD CHAR(1) CCSID 933 NOT NULL ,      --����������
	TSERL VARCHAR(600) CCSID 833 NOT NULL ,      --�����ø���
	TOPCHK CHAR(1) CCSID 833 NOT NULL ,       --ȣȯ�ٱ� ' ','1','2'
	TYGCHK CHAR(1) CCSID 833 NOT NULL ,       --�����������󿩺�
	TORATE NUMERIC(5, 2) NOT NULL ,           --ȣȯ��
	TCUMORATE NUMERIC(7, 4) NOT NULL           --����ȣȯ��(����)
	) ;
	
create table qtemp.tmp_bpm (tcmcd char(2) not null,
 tplnt char(1) not null, tdvsn char(1) not null,
 tmodl char(15) not null, toption char(15) not null,
 tlevel numeric(2,0) not null, tpitn char(15) not null,
 tcitn char(15) not null, tqtym numeric(8,3) not null,
 tqty1 numeric(8,3) not null, twkct char(4) not null,
 tedtm char(8) not null, tedte char(8) not null,
 topcd char(1) not null, texplant char(1) not null,
 texdv char(1) not null, toscd char(1) not null,
 tcalculate char(1) not null,tcomcd char(1) not null,
 tserl varchar(600) not null,topchk char(1) not null,
 tygchk char(1) not null,torate numeric(5, 2) not null,
 tcumorate numeric(7, 4) not null);