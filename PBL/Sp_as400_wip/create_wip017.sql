--  Generate SQL 
--  Version:                   	V5R3M0 040528 
--  Generated on:              	09/05/20 16:19:41 
--  Relational Database:       	I520 
--  Standards Option:          	DB2 UDB iSeries 
--  �ǻ��ڷ� ����� ������� �������̺�

DROP TABLE PBWIP.WIP017;

CREATE TABLE PBWIP.WIP017 ( 
	COMLTD CHAR(2) CCSID 833 NOT NULL ,     --ȸ��
	XPLANT CHAR(1) CCSID 833 NOT NULL ,     --����
	DIV CHAR(1) CCSID 833 NOT NULL ,       --����
	ITNO VARCHAR(12) CCSID 933 NOT NULL ,     --��ǰ��
	ORCT VARCHAR(5) CCSID 833 NOT NULL ,  -- ��ü�ڵ�/�����ڵ�
	IOCD CHAR(1) CCSID 833 NOT NULL ,     --�������
	P00 NUMERIC(11, 1) NOT NULL ,     --����
	P30 NUMERIC(11, 1) NOT NULL ,     --����
	P60 NUMERIC(11, 1) NOT NULL ,     --����
	P90 NUMERIC(11, 1) NOT NULL ,     --����
	P120 NUMERIC(11, 1) NOT NULL ,     --����
	P150 NUMERIC(11, 1) NOT NULL ,     --����
	INPTID CHAR(6) CCSID 933 NOT NULL , 
	INPTDT CHAR(19) CCSID 933 NOT NULL , 
	PRIMARY KEY( COMLTD , XPLANT, DIV, ITNO, ORCT, IOCD ) ) ;
	
INSERT INTO PBWIP.WIP017
( COMLTD,XPLANT,DIV,ITNO,ORCT,IOCD,
P00,P30,P60,P90,P120,P150,INPTID,INPTDT )