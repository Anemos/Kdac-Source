--  Generate SQL
--  Version:                    V5R3M0 040528
--  Generated on:               09/08/19 11:01:38
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries
--  BOM ������ȸ : ��޿ϼ�ǰ�ܰ� ��������

DROP TABLE PBBPM.BPM514A;

CREATE TABLE PBBPM.BPM514A (
  ZCMCD CHAR(2) CCSID 833 NOT NULL ,      -- ȸ��
  ZDATE CHAR(4) CCSID 933 NOT NULL ,      -- �⵵
  ZBREV CHAR(2) CCSID 833 NOT NULL ,      -- �����ȹ����
  ZGUBUN CHAR(1) CCSID 833 NOT NULL ,     -- ��б���
  ZPLANT CHAR(1) CCSID 833 NOT NULL ,     -- ����
  ZDIV CHAR(1) CCSID 833 NOT NULL ,       -- ����
  ZMDCD VARCHAR(4) CCSID 933 NOT NULL ,      -- ��ǰ��
  ZMDNO VARCHAR(12) CCSID 933 NOT NULL ,     -- ��ǰ
  ZSERIAL NUMERIC(4, 0) NOT NULL ,          -- ����
  ZLEVEL NUMERIC(2, 0) NOT NULL ,           -- ����
  ZPITNO VARCHAR(12) CCSID 933 NOT NULL ,   -- ����ǰ��
  ZITNO VARCHAR(12) CCSID 933 NOT NULL ,    -- ����ǰ��
  ZREV CHAR(1) CCSID 833 NOT NULL ,         -- REV
  ZDESC VARCHAR(50) CCSID 933 NOT NULL ,    -- ǰ��
  ZSPEC VARCHAR(50) CCSID 933 NOT NULL ,    -- �԰�
  ZUNITQTY DECIMAL(11, 3) NOT NULL ,        -- ������
  ZUNIT1 CHAR(2) CCSID 833 NOT NULL ,       -- BOM����
  ZCONFACT DECIMAL(13, 5) NOT NULL ,        -- ��ȯ���
  ZUNIT2 CHAR(2) CCSID 833 NOT NULL ,       -- ���Ŵ���
  ZSRCE CHAR(2) CCSID 833 NOT NULL ,        -- ���Լ�
  ZTYPE CHAR(1) CCSID 833 NOT NULL ,        -- Ÿ��
  ZCURD CHAR(3) CCSID 833 NOT NULL ,        -- ������ȭ
  ZCURE CHAR(3) CCSID 833 NOT NULL ,        -- ������ȭ
  ZFOB1 CHAR(1) CCSID 833 NOT NULL ,        -- FOB 1
  ZFOB2 CHAR(1) CCSID 833 NOT NULL ,        -- FOB 2
  ZCHK CHAR(2) CCSID 833 NOT NULL ,         -- üũ
  ZCURDCST DECIMAL(14, 6) NOT NULL ,    -- �����ܰ�
  ZCURECST DECIMAL(14, 6) NOT NULL ,    -- ����ܰ�
  ZWONDCST DECIMAL(14, 6) NOT NULL ,    -- ������ȭ�ܰ�
  ZWONECST DECIMAL(14, 6) NOT NULL ,    -- �����ȭ�ܰ�
  ZWONEAMT DECIMAL(15, 6) NOT NULL ,    -- ����ݾ�
  ZWONDAMT DECIMAL(15, 6) NOT NULL ,    -- �����ݾ�
  ZWKCT CHAR(4) CCSID 933 NOT NULL ,        -- �۾���
  ZGRAD CHAR(1) CCSID 833 NOT NULL ,        -- ���
  ZALTNO VARCHAR(12) CCSID 933 NOT NULL ,      -- ȣȯ
  ZFMDT CHAR(8) CCSID 933 NOT NULL ,        -- ������
  ZTODT CHAR(8) CCSID 933 NOT NULL ,        -- �Ϸ���
  ZCALC CHAR(1) CCSID 833 NOT NULL ,        -- ���񿩺�
  ZCURSCST DECIMAL(14, 6) NOT NULL,         -- �������(ǰ��)�ܰ� (2010.09 �߰�)
  ZWONSCST DECIMAL(14, 6) NOT NULL,         -- ����ȯ�ܰ� (2010.09 �߰�)
  ZWONSAMT DECIMAL(14, 6) NOT NULL,         -- ����ݾ� (2010.09 �߰�)
  ZCUMDAMT DECIMAL(14, 6) NOT NULL,         -- ����ݾ�(����) (2010.09 �߰�)
  ZCUMEAMT DECIMAL(14, 6) NOT NULL,         -- ����ݾ�(����) (2010.09 �߰�)
  PRIMARY KEY( ZCMCD , ZDATE, ZBREV, ZGUBUN , ZPLANT , ZDIV , ZMDCD , ZMDNO , ZSERIAL ) ) ;

CREATE INDEX PBBPM.BPM514ALX01
  ON PBBPM.BPM514A ( ZCMCD ASC , ZDATE DESC, ZBREV ASC, ZGUBUN ASC , ZPLANT ASC , ZDIV ASC , ZMDNO ASC , ZSERIAL ASC ) ;

CREATE INDEX PBBPM.BPM514ALX02
  ON PBBPM.BPM514A ( ZCMCD ASC , ZDATE DESC, ZBREV ASC, ZGUBUN ASC , ZPLANT ASC , ZDIV ASC , ZMDNO ASC , ZPITNO ASC , ZWKCT ASC , ZLEVEL ASC) ;