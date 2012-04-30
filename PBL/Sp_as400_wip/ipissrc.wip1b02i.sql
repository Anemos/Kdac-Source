       IDENTIFICATION DIVISION.
       PROGRAM-ID.  WIP1B02I.
       AUTHOR.     CHO TAE SEOB.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. IBM-AS400.
       OBJECT-COMPUTER. IBM-AS400.
       SPECIAL-NAMES.   LOCAL-DATA  IS LDA
                        SYSTEM-CONSOLE IS SYS-CON.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INV002-FILE  ASSIGN TO DATABASE-INV002
                  ORGANIZATION         IS INDEXED
                  ACCESS  MODE         IS RANDOM
                  RECORD  KEY          IS EXTERNALLY-DESCRIBED-KEY
                  FILE    STATUS       IS INV002-STSCD.
           SELECT BOM001L03-FILE ASSIGN TO DATABASE-BOM001L03
                  ORGANIZATION         IS INDEXED
                  ACCESS  MODE         IS DYNAMIC
                  RECORD  KEY          IS EXTERNALLY-DESCRIBED-KEY
                  FILE     STATUS      IS BOM001L03-STSCD.
           SELECT BOM001L03-FILE1 ASSIGN TO DATABASE-BOM001L03
                  ORGANIZATION         IS INDEXED
                  ACCESS  MODE         IS DYNAMIC
                  RECORD  KEY          IS EXTERNALLY-DESCRIBED-KEY
                  FILE     STATUS      IS BOM001L03-STSCD1.
           SELECT WIP001-FILE   ASSIGN TO DATABASE-WIP001
                  ORGANIZATION         IS INDEXED
                  ACCESS  MODE         IS RANDOM
                  RECORD  KEY          IS EXTERNALLY-DESCRIBED-KEY
                  FILE    STATUS       IS WIP001-STSCD.
           SELECT BOM003-FILE   ASSIGN TO DATABASE-BOM003
                  ORGANIZATION         IS INDEXED
                  ACCESS  MODE         IS DYNAMIC
                  RECORD  KEY          IS EXTERNALLY-DESCRIBED-KEY
                  FILE    STATUS       IS BOM003-STSCD.
           SELECT BOM003LA-FILE   ASSIGN TO DATABASE-BOM003LA
                  ORGANIZATION         IS INDEXED
                  ACCESS  MODE         IS DYNAMIC
                  RECORD  KEY          IS EXTERNALLY-DESCRIBED-KEY
                  FILE    STATUS       IS BOM003LA-STSCD.
           SELECT INV101-FILE   ASSIGN TO DATABASE-INV101
                  ORGANIZATION         IS INDEXED
                  ACCESS  MODE         IS RANDOM
                  RECORD  KEY          IS EXTERNALLY-DESCRIBED-KEY
                  FILE    STATUS       IS INV101-STSCD.
           SELECT INV401-FILE   ASSIGN TO DATABASE-INV401
                  ORGANIZATION         IS INDEXED
                  ACCESS  MODE         IS RANDOM
                  RECORD  KEY          IS EXTERNALLY-DESCRIBED-KEY
                  FILE    STATUS       IS INV401-STSCD.
           SELECT WIP004-FILE   ASSIGN TO DATABASE-WIP004
                  ORGANIZATION         IS INDEXED
                  ACCESS  MODE         IS RANDOM
                  RECORD  KEY          IS EXTERNALLY-DESCRIBED-KEY
                  FILE    STATUS       IS WIP004-STSCD.
           SELECT WIP041-FILE   ASSIGN TO DATABASE-WIP041
                  ORGANIZATION         IS INDEXED
                  ACCESS  MODE         IS RANDOM
                  RECORD  KEY          IS EXTERNALLY-DESCRIBED-KEY
                  FILE    STATUS       IS WIP041-STSCD.
           SELECT WIP090-FILE    ASSIGN TO DATABASE-WIP090
                  ORGANIZATION         IS INDEXED
                  ACCESS  MODE         IS RANDOM
                  RECORD  KEY          IS EXTERNALLY-DESCRIBED-KEY
                  FILE    STATUS       IS WIP090-STSCD.
       DATA                DIVISION.
       FILE                SECTION.
       FD  INV002-FILE LABEL RECORD ARE STANDARD.
       01  INV002-REC.
           COPY DDS-ALL-FORMATS OF PBINV-INV002.
       FD  BOM001L03-FILE  LABEL RECORD ARE STANDARD.
       01  BOM001L03-REC.
           COPY DDS-ALL-FORMATS OF PBPDM-BOM001L03.
       FD  BOM001L03-FILE1 LABEL RECORD ARE STANDARD.
       01  BOM001L03-REC1.
           COPY DDS-ALL-FORMATS OF PBPDM-BOM001L03.
       FD  WIP001-FILE LABEL RECORD ARE STANDARD.
       01  WIP001-REC.
           COPY DDS-ALL-FORMATS OF PBWIP-WIP001.
       FD  BOM003-FILE LABEL RECORD ARE STANDARD.
       01  BOM003-REC.
           COPY DDS-ALL-FORMATS OF PBPDM-BOM003.
       FD  BOM003LA-FILE LABEL RECORD ARE STANDARD.
       01  BOM003LA-REC.
           COPY DDS-ALL-FORMATS OF PBPDM-BOM003LA.
       FD  INV101-FILE LABEL RECORD ARE STANDARD.
       01  INV101-REC.
           COPY DDS-ALL-FORMATS OF PBINV-INV101.
       FD  INV401-FILE LABEL RECORD ARE STANDARD.
       01  INV401-REC.
           COPY DDS-ALL-FORMATS  OF  PBINV-INV401.
       FD  WIP004-FILE LABEL RECORD ARE STANDARD.
       01  WIP004-REC.
           COPY DDS-ALL-FORMATS  OF  PBWIP-WIP004.
       FD  WIP041-FILE LABEL RECORD ARE STANDARD.
       01  WIP041-REC.
           COPY DDS-ALL-FORMATS  OF  PBWIP-WIP041.
       FD  WIP090-FILE LABEL RECORD ARE STANDARD.
       01  WIP090-REC.
           COPY DDS-ALL-FORMATS OF PBWIP-WIP090.
       WORKING-STORAGE SECTION.
       77  I-IDX           PIC  9(3)  VALUE ZEROS.
       77  J-IDX           PIC  9(3)  VALUE ZEROS.
       77  K-IDX           PIC  9(3)  VALUE ZEROS.
       77  ERR-SW          PIC  9(1)  VALUE ZEROS.
       77  SW              PIC  9(1)  VALUE ZEROS.
       77  WERCD           PIC  X(1)  VALUE SPACE.
       77  WK-FOUND        PIC  X(1)  VALUE SPACE.
       77  WK-ERRITNO      PIC  X(12) VALUE SPACE.
       77  WK-QTY      PIC S9(12)V9(4).
       77  WK-IUMCV    PIC S9(12)V9(3) VALUE ZEROS.
       77  WK-DVSN     PIC X(1)  VALUE SPACE.
       77  WK-CHILD    PIC X(1)   VALUE SPACE.
       77  WK-BCMCD        PIC X(02)  VALUE SPACE.
       77  WK-BPLANT       PIC X(01)  VALUE SPACE.
       77  WK-BDVSN        PIC X(01)  VALUE SPACE.
       77  WK-BITNO        PIC X(12)  VALUE SPACE.
       77  WK-GRAD         PIC X(01)  VALUE SPACES.
       77  SYS-DATE        PIC X(8)        VALUE SPACE.
       77  WC-SRNO         PIC X(10)       VALUE SPACE.
       01  SYSTEM-TIME.
           03 SYS-TIME     PIC X(6)        VALUE SPACE.
           03 FILLER       PIC X(2)        VALUE SPACE.
       01  SAVE-AREA.
           03 SA-DATA OCCURS 100 TIMES.
              05 SA-ITNO   PIC X(15).
              05 SA-QTY    PIC S9(13)V9(4).
       01  SAVE-AREA1.
           03 SA-QTYA    PIC S9(11)V9(4) OCCURS 100 TIMES.
           03 SA-TWCMCD  PIC X(01)       OCCURS 100 TIMES.
           03 SA-TWPLANT PIC X(01)       OCCURS 100 TIMES.
           03 SA-TWDVSN  PIC X(01)       OCCURS 100 TIMES.
           03 SA-TWPITN  PIC X(12)       OCCURS 100 TIMES.
           03 SA-TWCITN  PIC X(12)       OCCURS 100 TIMES.
           03 SA-TWCHDT  PIC X(08)       OCCURS 100 TIMES.
           03 SA-TWROUT  PIC X(04)       OCCURS 100 TIMES.
       01  FILE-STATUS.
           03 WIP090-STSCD       PIC X(2).
           03 INV002-STSCD      PIC X(2).
           03 INV101-STSCD       PIC X(2).
           03 INV401-STSCD       PIC X(2).
           03 WIP004-STSCD       PIC X(2).
           03 WIP041-STSCD       PIC X(2).
           03 BOM001L03-STSCD    PIC X(2).
           03 BOM001L03-STSCD1   PIC X(2).
           03 WIP001-STSCD       PIC X(2).
           03 BOM003-STSCD       PIC X(2).
           03 BOM003LA-STSCD     PIC X(2).
       LINKAGE SECTION.
       01  ACC-PARM.
           03 AC-SLIPTYPE PIC X(2).
           03 AC-SRNO     PIC X(8).
           03 AC-SRNO1    PIC X(2).
           03 AC-SRNO2    PIC X(2).
       PROCEDURE               DIVISION USING ACC-PARM.
       START-RTN.
           OPEN INPUT INV002-FILE INV101-FILE INV401-FILE
                      BOM001L03-FILE BOM001L03-FILE1 BOM003-FILE
                      BOM003LA-FILE
                I-O   WIP001-FILE WIP004-FILE WIP090-FILE WIP041-FILE.
           MOVE   SPACE       TO   SYS-DATE.
           MOVE ZEROS TO I-IDX, J-IDX, K-IDX.
           CALL   "DATEACPT" USING SYS-DATE.
           CANCEL "DATEACPT".
           ACCEPT SYSTEM-TIME FROM TIME.
           MOVE "01"        TO COMLTD   OF INV401-REC.
           MOVE AC-SLIPTYPE TO SLIPTYPE OF INV401-REC.
           MOVE AC-SRNO     TO SRNO     OF INV401-REC.
           MOVE AC-SRNO1    TO SRNO1    OF INV401-REC.
           MOVE AC-SRNO2    TO SRNO2    OF INV401-REC.
           READ INV401-FILE.
           IF INV401-STSCD NOT = "00"
              MOVE "A" TO WERCD
              MOVE ITNO OF INV401-REC TO WK-ERRITNO
              PERFORM ERROR-WRITE-RTN THRU ERROR-WRITE-EXIT
               GO TO END-RTN.
           MOVE COMLTD OF INV401-REC TO COMLTD OF INV101-REC.
           MOVE XPLANT OF INV401-REC TO XPLANT OF INV101-REC.
           MOVE DIV    OF INV401-REC TO DIV    OF INV101-REC.
           MOVE ITNO   OF INV401-REC TO ITNO   OF INV101-REC.
           READ INV101-FILE INVALID KEY
              MOVE "B" TO WERCD
              MOVE ITNO OF INV401-REC TO WK-ERRITNO
              PERFORM ERROR-WRITE-RTN THRU ERROR-WRITE-EXIT
              GO TO END-RTN.
           IF SRCE OF INV101-REC NOT = "04"
              GO TO END-RTN.
           IF CONVQTY OF INV101-REC = ZEROS
              MOVE 1 TO WK-IUMCV
           ELSE
              MOVE CONVQTY OF INV101-REC TO WK-IUMCV.
           IF XPLANT OF INV101-REC = "D" AND DIV OF INV101-REC = "A"
              NEXT SENTENCE
           ELSE
              IF CLS OF INV101-REC = "50"
                 PERFORM WIP-OUT-RTN THRU WIP-OUT-EXIT.
           MOVE ZEROS TO ERR-SW
           PERFORM BOM-INIT-RTN THRU BOM-INIT-EXIT
                   VARYING I-IDX FROM 1 BY 1 UNTIL I-IDX > 100.
           PERFORM BOM-CHK-RTN THRU BOM-CHK-EXIT
           IF ERR-SW = 1 OR K-IDX = ZEROS
              MOVE "C" TO WERCD
              MOVE ITNO OF INV401-REC TO WK-ERRITNO
              PERFORM ERROR-WRITE-RTN THRU ERROR-WRITE-EXIT
              GO TO END-RTN.
           PERFORM WIP-UPDATE-RTN THRU WIP-UPDATE-EXIT
                   VARYING I-IDX FROM 1 BY 1 UNTIL I-IDX > K-IDX.
           GO TO END-RTN.
       BOM-INIT-RTN.
           MOVE SPACE TO SA-ITNO(I-IDX) SA-TWCMCD(I-IDX)
                         SA-TWPLANT(I-IDX)
                         SA-TWDVSN(I-IDX) SA-TWPITN(I-IDX)
                         SA-TWCITN(I-IDX) SA-TWCHDT(I-IDX)
                         SA-TWROUT(I-IDX).
           MOVE ZEROS TO SA-QTY(I-IDX) SA-QTYA(I-IDX).
       BOM-INIT-EXIT.
           EXIT.
      *
       BOM-CHK-RTN.
           MOVE ZEROS TO K-IDX J-IDX.
       BOM-CHK-RTN1.
           MOVE COMLTD OF INV401-REC TO PCMCD OF BOM001L03-REC WK-BCMCD.
           MOVE XPLANT OF INV401-REC TO PLANT OF BOM001L03-REC
                                        WK-BPLANT
           MOVE DIV    OF INV401-REC TO PDVSN OF BOM001L03-REC WK-BDVSN.
           MOVE ITNO   OF INV401-REC TO PPITN OF BOM001L03-REC WK-BITNO.
           MOVE SPACES               TO PCITN OF BOM001L03-REC
                                        PCHDT OF BOM001L03-REC
                                        PROUT OF BOM001L03-REC.
           START BOM001L03-FILE KEY IS NOT < EXTERNALLY-DESCRIBED-KEY
                 INVALID KEY
                 MOVE 1 TO ERR-SW
                 GO TO BOM-CHK-EXIT.
           READ BOM001L03-FILE NEXT RECORD AT END
                 MOVE 1 TO ERR-SW
                 GO TO BOM-CHK-EXIT.
           IF WK-BCMCD  = PCMCD OF BOM001L03-REC AND
              WK-BPLANT = PLANT OF BOM001L03-REC AND
              WK-BDVSN  = PDVSN OF BOM001L03-REC AND
              WK-BITNO  = PPITN OF BOM001L03-REC
              NEXT SENTENCE
           ELSE
              MOVE 1 TO ERR-SW
              GO TO BOM-CHK-EXIT.
       EXPRO-RTN.
           IF PEDTM OF BOM001L03-REC NOT = SPACE AND
              PEDTM OF BOM001L03-REC > TDTE4 OF INV401-REC
              GO TO NEXT-COMPONENT-RTN.
           IF PEDTE OF BOM001L03-REC NOT = SPACE AND
              PEDTE OF BOM001L03-REC < TDTE4 OF INV401-REC
              GO TO NEXT-COMPONENT-RTN.
           MOVE PCMCD OF BOM001L03-REC TO COMLTD OF INV002-REC
                                          COMLTD OF INV101-REC.
           MOVE PLANT OF BOM001L03-REC TO XPLANT OF INV101-REC.
           MOVE PDVSN OF BOM001L03-REC TO DIV    OF INV101-REC.
           MOVE PCITN OF BOM001L03-REC TO ITNO   OF INV002-REC
                                          ITNO   OF INV101-REC.
           READ INV002-FILE INVALID KEY
                MOVE 1 TO ERR-SW
                GO TO BOM-CHK-EXIT.
           READ INV101-FILE INVALID KEY
                MOVE 1 TO ERR-SW
                GO TO BOM-CHK-EXIT.
           MOVE SPACE TO WK-GRAD.
           PERFORM BOM003-GRAD2-RTN THRU BOM003-GRAD2-EXIT.
           IF WK-GRAD = "2"
              GO TO NEXT-COMPONENT-RTN.
           PERFORM COM-QTY-1 THRU COM-QTY-1-EXIT.
           IF (CLS    OF INV101-REC = "30") AND
              (CLS    OF INV101-REC = "10" OR
               SRCE   OF INV101-REC = "03") AND
               XTYPE  OF INV002-REC = "0"
               NEXT SENTENCE
           ELSE
              PERFORM MOVE-RTN THRU MOVE-EXIT
              IF ERR-SW = 1
                 GO TO BOM-CHK-EXIT
              ELSE
                 GO TO NEXT-COMPONENT-RTN.
           MOVE "N" TO WK-CHILD.
           PERFORM CHILD-FOUND-RTN THRU CHILD-FOUND-EXIT.
           IF WK-CHILD NOT = "Y"
              GO TO NEXT-COMPONENT-RTN.
           PERFORM SAVE-QTY THRU SAVE-QTY-EXIT.
           MOVE PCMCD OF BOM001L03-REC TO SA-TWCMCD(J-IDX) WK-BCMCD.
           MOVE PLANT OF BOM001L03-REC TO SA-TWPLANT(J-IDX) WK-BPLANT.
           MOVE PDVSN OF BOM001L03-REC TO SA-TWDVSN(J-IDX) WK-BDVSN.
           MOVE PPITN OF BOM001L03-REC TO SA-TWPITN(J-IDX).
           MOVE PCITN OF BOM001L03-REC TO PPITN OF BOM001L03-REC
                                          WK-BITNO SA-TWCITN(J-IDX).
           MOVE PCHDT OF BOM001L03-REC TO SA-TWCHDT(J-IDX).
           MOVE PROUT OF BOM001L03-REC TO SA-TWROUT(J-IDX).
           MOVE SPACE                 TO PCITN OF BOM001L03-REC
                                         PCHDT OF BOM001L03-REC
                                         PROUT OF BOM001L03-REC.
       CHILD-START-RTN.
           START BOM001L03-FILE KEY IS > EXTERNALLY-DESCRIBED-KEY
                 INVALID KEY GO TO SAVE-CHECK-RTN.
       NEXT-COMPONENT-RTN.
           READ BOM001L03-FILE NEXT RECORD AT END GO TO SAVE-CHECK-RTN.
           IF WK-BCMCD  = PCMCD OF BOM001L03-REC AND
              WK-BPLANT = PLANT OF BOM001L03-REC AND
              WK-BDVSN  = PDVSN OF BOM001L03-REC AND
              WK-BITNO  = PPITN OF BOM001L03-REC
              GO TO EXPRO-RTN.
       SAVE-CHECK-RTN.
           IF J-IDX = ZEROS
              GO TO BOM-CHK-EXIT.
           MOVE SA-TWCMCD(J-IDX)  TO PCMCD OF BOM001L03-REC WK-BCMCD.
           MOVE SA-TWPLANT(J-IDX) TO PLANT OF BOM001L03-REC WK-BPLANT.
           MOVE SA-TWDVSN(J-IDX)  TO PDVSN OF BOM001L03-REC WK-BDVSN.
           MOVE SA-TWPITN(J-IDX)  TO PPITN OF BOM001L03-REC WK-BITNO.
           MOVE SA-TWCITN(J-IDX)  TO PCITN OF BOM001L03-REC.
           MOVE SA-TWCHDT(J-IDX)  TO PCHDT OF BOM001L03-REC.
           MOVE SA-TWROUT(J-IDX)  TO PROUT OF BOM001L03-REC.
           COMPUTE  J-IDX = J-IDX - 1.
           GO TO CHILD-START-RTN.
       BOM-CHK-EXIT.
           EXIT.
      *
       MOVE-RTN.
           IF PWKCT OF BOM001L03-REC = "8888"
              GO TO MOVE-EXIT.
           IF PWKCT OF BOM001L03-REC NOT = "9999"
              MOVE 1 TO ERR-SW
              GO TO MOVE-EXIT.
           ADD  1       TO K-IDX
           MOVE COMLTD OF INV101-REC TO WACMCD.
           MOVE XPLANT OF INV101-REC TO WAPLANT.
           MOVE DIV    OF INV101-REC TO WADVSN.
           MOVE ITNO   OF INV101-REC TO SA-ITNO(K-IDX) WAITNO.
           READ WIP001-FILE INVALID KEY
             MOVE "2"   TO WAIOCD  OF WIP001-REC
             MOVE ZEROS TO WAAVRG1 OF WIP001-REC
                           WAAVRG2 OF WIP001-REC
                           WABGQT  OF WIP001-REC
                           WABGAT1 OF WIP001-REC
                           WABGAT2 OF WIP001-REC
                           WAINQT  OF WIP001-REC
                           WAINAT1 OF WIP001-REC
                           WAINAT2 OF WIP001-REC
                           WAINAT3 OF WIP001-REC
                           WAINAT4 OF WIP001-REC
                           WAUSQT1 OF WIP001-REC
                           WAUSAT1 OF WIP001-REC
                           WAUSQT2 OF WIP001-REC
                           WAUSAT2 OF WIP001-REC
                           WAUSQT3 OF WIP001-REC
                           WAUSAT3 OF WIP001-REC
                           WAUSQT4 OF WIP001-REC
                           WAUSAT4 OF WIP001-REC
                           WAUSQT5 OF WIP001-REC
                           WAUSAT5 OF WIP001-REC
                           WAUSQT6 OF WIP001-REC
                           WAUSAT6 OF WIP001-REC
                           WAUSQT7 OF WIP001-REC
                           WAUSAT7 OF WIP001-REC
                           WAUSQT8 OF WIP001-REC
                           WAUSAT8 OF WIP001-REC
                           WAUSAT9 OF WIP001-REC
                           WAOHQT  OF WIP001-REC
                           WAOHAT1 OF WIP001-REC
                           WAOHAT2 OF WIP001-REC
                           WASCRP  OF WIP001-REC
                           WARETN  OF WIP001-REC
             MOVE SPACE TO WAPLAN OF WIP001-REC
                           WAIPADDR  OF WIP001-REC
                           WAMACADDR OF WIP001-REC
             MOVE SYS-DATE TO WAINPTDT OF WIP001-REC
                              WAUPDTDT OF WIP001-REC.
           MOVE WK-QTY  TO SA-QTY(K-IDX).
           MOVE SPACE TO WK-GRAD.
           PERFORM BOM003-GRAD1-RTN THRU BOM003-GRAD1-EXIT.
           IF WK-GRAD = "1"
              MOVE WK-QTY TO SA-QTY(K-IDX)
           ELSE
              IF WK-QTY > WAOHQT OF WIP001-REC
                 MOVE WAOHQT OF WIP001-REC TO SA-QTY(K-IDX)
                 COMPUTE WK-QTY = WK-QTY - SA-QTY(K-IDX)
                 PERFORM ALTER-ONHAND-RTN THRU ALTER-ONHAND-EXIT
                 ADD WK-QTY TO SA-QTY(K-IDX)
              ELSE
                 MOVE WK-QTY  TO SA-QTY(K-IDX).
       MOVE-EXIT.
           EXIT.
      *
       ALTER-ONHAND-RTN.
           MOVE PCMCD  OF BOM001L03-REC TO OCMCD  OF BOM003-REC.
           MOVE PLANT  OF BOM001L03-REC TO OPLANT OF BOM003-REC.
           MOVE PDVSN  OF BOM001L03-REC TO ODVSN  OF BOM003-REC.
           MOVE PCITN  OF BOM001L03-REC TO OPITN  OF BOM003-REC.
           MOVE SPACE                   TO OFITN  OF BOM003-REC
                                           OCHDT  OF BOM003-REC.
           START BOM003-FILE KEY IS NOT < EXTERNALLY-DESCRIBED-KEY
                 INVALID KEY
                 GO ALTER-ONHAND-EXIT.
       ALTER-READ-RTN.
           READ BOM003-FILE NEXT RECORD AT END
                GO ALTER-ONHAND-EXIT.
           IF OCMCD  OF BOM003-REC = PCMCD OF BOM001L03-REC AND
              OPLANT OF BOM003-REC = PLANT OF BOM001L03-REC AND
              ODVSN  OF BOM003-REC = PDVSN OF BOM001L03-REC AND
              OPITN  OF BOM003-REC = PCITN OF BOM001L03-REC
              NEXT SENTENCE
           ELSE
              GO TO ALTER-ONHAND-EXIT.
           IF OEDTM OF BOM003-REC > TDTE4 OF INV401-REC AND
              OEDTM OF BOM003-REC NOT = SPACE
              GO TO ALTER-READ-RTN.
           IF OEDTE OF BOM003-REC < TDTE4 OF INV401-REC AND
              OEDTE OF BOM003-REC NOT = SPACE
              GO TO ALTER-READ-RTN.
           ADD 1 TO K-IDX.
           MOVE PCMCD OF BOM001L03-REC TO WACMCD  COMLTD OF INV101-REC.
           MOVE PLANT OF BOM001L03-REC TO WAPLANT XPLANT OF INV101-REC.
           MOVE PDVSN OF BOM001L03-REC TO WADVSN  DIV OF INV101-REC.
           MOVE VSRNO OF INV401-REC    TO WAORCT.
           MOVE OFITN OF BOM003-REC    TO WAITNO SA-ITNO(K-IDX)
                                          ITNO   OF INV101-REC.
           READ INV101-FILE INVALID KEY
                MOVE 1 TO ERR-SW.
           READ WIP001-FILE INVALID KEY
             MOVE "2"   TO WAIOCD  OF WIP001-REC
             MOVE ZEROS TO WAAVRG1 OF WIP001-REC
                           WAAVRG2 OF WIP001-REC
                           WABGQT  OF WIP001-REC
                           WABGAT1 OF WIP001-REC
                           WABGAT2 OF WIP001-REC
                           WAINQT  OF WIP001-REC
                           WAINAT1 OF WIP001-REC
                           WAINAT2 OF WIP001-REC
                           WAINAT3 OF WIP001-REC
                           WAINAT4 OF WIP001-REC
                           WAUSQT1 OF WIP001-REC
                           WAUSAT1 OF WIP001-REC
                           WAUSQT2 OF WIP001-REC
                           WAUSAT2 OF WIP001-REC
                           WAUSQT3 OF WIP001-REC
                           WAUSAT3 OF WIP001-REC
                           WAUSQT4 OF WIP001-REC
                           WAUSAT4 OF WIP001-REC
                           WAUSQT5 OF WIP001-REC
                           WAUSAT5 OF WIP001-REC
                           WAUSQT6 OF WIP001-REC
                           WAUSAT6 OF WIP001-REC
                           WAUSQT7 OF WIP001-REC
                           WAUSAT7 OF WIP001-REC
                           WAUSQT8 OF WIP001-REC
                           WAUSAT8 OF WIP001-REC
                           WAUSAT9 OF WIP001-REC
                           WAOHQT  OF WIP001-REC
                           WAOHAT1 OF WIP001-REC
                           WAOHAT2 OF WIP001-REC
                           WASCRP  OF WIP001-REC
                           WARETN  OF WIP001-REC
             MOVE SPACE TO WAPLAN OF WIP001-REC
                           WAIPADDR  OF WIP001-REC
                           WAMACADDR OF WIP001-REC
             MOVE SYS-DATE TO WAINPTDT OF WIP001-REC
                              WAUPDTDT OF WIP001-REC.
           IF WK-QTY > WAOHQT OF WIP001-REC
              MOVE WAOHQT OF WIP001-REC  TO SA-QTY(K-IDX)
              COMPUTE WK-QTY = WK-QTY - SA-QTY(K-IDX)
              GO TO ALTER-READ-RTN.
           MOVE WK-QTY  TO SA-QTY(K-IDX).
           MOVE ZEROS   TO WK-QTY.
       ALTER-ONHAND-EXIT.
           EXIT.
      *
       CHILD-FOUND-RTN.
           MOVE PCMCD OF BOM001L03-REC TO PCMCD OF BOM001L03-REC1.
           MOVE PLANT OF BOM001L03-REC TO PLANT OF BOM001L03-REC1.
           MOVE PDVSN OF BOM001L03-REC TO PDVSN OF BOM001L03-REC1.
           MOVE PCITN OF BOM001L03-REC TO PPITN OF BOM001L03-REC1.
           MOVE SPACE                  TO PCITN OF BOM001L03-REC1
                                          PROUT OF BOM001L03-REC1
                                          PCHDT OF BOM001L03-REC1.
           START BOM001L03-FILE1 KEY IS NOT < EXTERNALLY-DESCRIBED-KEY
                 INVALID KEY GO TO CHILD-FOUND-EXIT.
       CHILD-FOUND-RTN1.
           READ BOM001L03-FILE1 NEXT RECORD AT END
                GO TO CHILD-FOUND-EXIT.
           IF PCMCD OF BOM001L03-REC = PCMCD OF BOM001L03-REC1 AND
              PLANT OF BOM001L03-REC = PLANT OF BOM001L03-REC1 AND
              PDVSN OF BOM001L03-REC = PDVSN OF BOM001L03-REC1 AND
              PCITN OF BOM001L03-REC = PPITN OF BOM001L03-REC1
              NEXT SENTENCE
           ELSE
              GO TO CHILD-FOUND-EXIT.
           IF (PEDTM OF BOM001L03-REC1 > TDTE4 OF INV401-REC) AND
              (PEDTM OF BOM001L03-REC1 NOT = SPACE)
              GO TO CHILD-FOUND-RTN1.
           IF (PEDTE OF BOM001L03-REC1 < TDTE4 OF INV401-REC) AND
              (PEDTE OF BOM001L03-REC1 NOT = SPACE)
              GO TO CHILD-FOUND-RTN1.
           MOVE "Y" TO WK-CHILD.
       CHILD-FOUND-EXIT.
           EXIT.
      *
       WIP-OUT-RTN.
           MOVE COMLTD OF INV401-REC TO WACMCD.
           MOVE XPLANT OF INV401-REC TO WAPLANT.
           MOVE DIV    OF INV401-REC TO WADVSN.
           MOVE "9999"               TO WAORCT.
           MOVE ITNO   OF INV401-REC TO WAITNO.
           READ WIP001-FILE INVALID KEY
                MOVE ZEROS TO WAAVRG1.
           IF WIP001-STSCD NOT = "00"
             MOVE "1"   TO WAIOCD  OF WIP001-REC
             MOVE ZEROS TO WAAVRG1 OF WIP001-REC
                           WAAVRG2 OF WIP001-REC
                           WABGQT  OF WIP001-REC
                           WABGAT1 OF WIP001-REC
                           WABGAT2 OF WIP001-REC
                           WAINQT  OF WIP001-REC
                           WAINAT1 OF WIP001-REC
                           WAINAT2 OF WIP001-REC
                           WAINAT3 OF WIP001-REC
                           WAINAT4 OF WIP001-REC
                           WAUSQT1 OF WIP001-REC
                           WAUSAT1 OF WIP001-REC
                           WAUSQT2 OF WIP001-REC
                           WAUSAT2 OF WIP001-REC
                           WAUSQT3 OF WIP001-REC
                           WAUSAT3 OF WIP001-REC
                           WAUSQT4 OF WIP001-REC
                           WAUSAT4 OF WIP001-REC
                           WAUSQT5 OF WIP001-REC
                           WAUSAT5 OF WIP001-REC
                           WAUSQT6 OF WIP001-REC
                           WAUSAT6 OF WIP001-REC
                           WAUSQT7 OF WIP001-REC
                           WAUSAT7 OF WIP001-REC
                           WAUSQT8 OF WIP001-REC
                           WAUSAT8 OF WIP001-REC
                           WAUSAT9 OF WIP001-REC
                           WAOHQT  OF WIP001-REC
                           WAOHAT1 OF WIP001-REC
                           WAOHAT2 OF WIP001-REC
                           WASCRP  OF WIP001-REC
                           WARETN  OF WIP001-REC
             MOVE SPACE TO WAPLAN OF WIP001-REC
                           WAIPADDR  OF WIP001-REC
                           WAMACADDR OF WIP001-REC
             MOVE SYS-DATE TO WAINPTDT OF WIP001-REC
                              WAUPDTDT OF WIP001-REC.
           IF CONVQTY OF INV101-REC = ZEROS
              ADD TQTY4 OF INV401-REC TO WAINQT
              ADD TQTY4 OF INV401-REC TO WAOHQT
           ELSE
              COMPUTE WAINQT = WAINQT +
                               (TQTY4 OF INV401-REC *
                                CONVQTY OF INV101-REC)
              COMPUTE WAOHQT = WAOHQT +
                               (TQTY4 OF INV401-REC *
                                CONVQTY OF INV101-REC).
           IF WIP001-STSCD = "00"
              REWRITE WIP001-REC.
           IF WIP001-STSCD NOT = "00"
              WRITE WIP001-REC.
       WIP-OUT-EXIT.
           EXIT.
      *
       WIP-UPDATE-RTN.
           IF SA-QTY(I-IDX) = ZEROS
              GO TO WIP-UPDATE-EXIT.
           MOVE COMLTD OF INV401-REC TO WACMCD COMLTD OF INV002-REC
                                               COMLTD OF INV101-REC.
           MOVE XPLANT OF INV401-REC TO WAPLANT XPLANT OF INV101-REC.
           MOVE DIV    OF INV401-REC TO WADVSN DIV OF INV101-REC.
           MOVE VSRNO  OF INV401-REC TO WAORCT.
           MOVE SA-ITNO(I-IDX)       TO WAITNO ITNO OF INV002-REC
                                               ITNO OF INV101-REC.
           READ INV002-FILE INVALID KEY
                MOVE "D" TO WERCD
                MOVE ITNO OF INV002-REC TO WK-ERRITNO
                PERFORM ERROR-WRITE-RTN THRU ERROR-WRITE-EXIT
                GO TO WIP-UPDATE-EXIT.
           READ INV101-FILE INVALID KEY
                MOVE "E" TO WERCD
                MOVE ITNO OF INV101-REC TO WK-ERRITNO
                PERFORM ERROR-WRITE-RTN THRU ERROR-WRITE-EXIT
                GO TO WIP-UPDATE-EXIT.
           READ WIP001-FILE INVALID KEY
                MOVE ZEROS TO WAAVRG1.
           IF WIP001-STSCD NOT = "00"
             MOVE "2"   TO WAIOCD  OF WIP001-REC
             MOVE ZEROS TO WAAVRG1 OF WIP001-REC
                           WAAVRG2 OF WIP001-REC
                           WABGQT  OF WIP001-REC
                           WABGAT1 OF WIP001-REC
                           WABGAT2 OF WIP001-REC
                           WAINQT  OF WIP001-REC
                           WAINAT1 OF WIP001-REC
                           WAINAT2 OF WIP001-REC
                           WAINAT3 OF WIP001-REC
                           WAINAT4 OF WIP001-REC
                           WAUSQT1 OF WIP001-REC
                           WAUSAT1 OF WIP001-REC
                           WAUSQT2 OF WIP001-REC
                           WAUSAT2 OF WIP001-REC
                           WAUSQT3 OF WIP001-REC
                           WAUSAT3 OF WIP001-REC
                           WAUSQT4 OF WIP001-REC
                           WAUSAT4 OF WIP001-REC
                           WAUSQT5 OF WIP001-REC
                           WAUSAT5 OF WIP001-REC
                           WAUSQT6 OF WIP001-REC
                           WAUSAT6 OF WIP001-REC
                           WAUSQT7 OF WIP001-REC
                           WAUSAT7 OF WIP001-REC
                           WAUSQT8 OF WIP001-REC
                           WAUSAT8 OF WIP001-REC
                           WAUSAT9 OF WIP001-REC
                           WAOHQT  OF WIP001-REC
                           WAOHAT1 OF WIP001-REC
                           WAOHAT2 OF WIP001-REC
                           WASCRP  OF WIP001-REC
                           WARETN  OF WIP001-REC
             MOVE SPACE TO WAPLAN OF WIP001-REC
                           WAIPADDR  OF WIP001-REC
                           WAMACADDR OF WIP001-REC
             MOVE SYS-DATE TO WAINPTDT OF WIP001-REC
                              WAUPDTDT OF WIP001-REC.
           COMPUTE WAUSQT2 = WAUSQT2 + SA-QTY(I-IDX).
           COMPUTE WAOHQT  = WAOHQT  - SA-QTY(I-IDX).
           MOVE    SYS-DATE TO  WAUPDTDT.
           PERFORM WIP-TRANS-RTN THRU WIP-TRANS-EXIT.
           IF WIP001-STSCD = "00"
              REWRITE WIP001-REC INVALID KEY
                   GO TO WIP-UPDATE-EXIT.
           IF WIP001-STSCD NOT = "00"
              WRITE WIP001-REC INVALID KEY
                MOVE "F" TO WERCD
                MOVE WAITNO TO WK-ERRITNO
                PERFORM ERROR-WRITE-RTN THRU ERROR-WRITE-EXIT
                   GO TO WIP-UPDATE-EXIT.
       WIP-UPDATE-EXIT.
           EXIT.
      *
       WIP-TRANS-RTN.
           MOVE SPACE TO WDCMCD   OF WIP004-REC WDSLTY    OF WIP004-REC
                         WDSRNO   OF WIP004-REC WDPLANT   OF WIP004-REC
                         WDDVSN   OF WIP004-REC WDIOCD    OF WIP004-REC
                         WDITNO   OF WIP004-REC WDRVNO    OF WIP004-REC
                         WDDESC   OF WIP004-REC WDSPEC    OF WIP004-REC
                         WDUNIT   OF WIP004-REC WDITCL    OF WIP004-REC
                         WDSRCE   OF WIP004-REC WDUSGE    OF WIP004-REC
                         WDPDCD   OF WIP004-REC WDSLNO    OF WIP004-REC
                         WDPRSRTY OF WIP004-REC WDPRSRNO  OF WIP004-REC
                         WDPRSRNO1 OF WIP004-REC
                         WDPRSRNO2 OF WIP004-REC
                         WDPRNO   OF WIP004-REC WDPRDPT   OF WIP004-REC
                         WDCHDPT  OF WIP004-REC WDDATE    OF WIP004-REC
                         WDIPADDR OF WIP004-REC WDMACADDR OF WIP004-REC
                         WDINPTID OF WIP004-REC WDUPDTID  OF WIP004-REC
                         WDINPTDT OF WIP004-REC WDUPDTDT  OF WIP004-REC
                         WDINPTTM OF WIP004-REC.
           MOVE ZEROS TO WDPRQT OF WIP004-REC WDCHQT OF WIP004-REC.
           MOVE COMLTD OF INV401-REC    TO  WDCMCD  OF WIP004-REC.
           MOVE "WC"                    TO  WDSLTY  OF WIP004-REC.
           MOVE XPLANT OF INV401-REC    TO  WDPLANT OF WIP004-REC.
           MOVE DIV    OF INV401-REC    TO  WDDVSN  OF WIP004-REC.
           MOVE "2"                     TO  WDIOCD  OF WIP004-REC.
           MOVE ITNO   OF INV101-REC    TO  WDITNO  OF WIP004-REC.
           MOVE RVNO   OF INV002-REC    TO  WDRVNO  OF WIP004-REC.
           MOVE ITNM   OF INV002-REC    TO  WDDESC  OF WIP004-REC.
           MOVE SPEC   OF INV002-REC    TO  WDSPEC  OF WIP004-REC.
           MOVE UNIT1  OF INV101-REC    TO  WDUNIT  OF WIP004-REC.
           MOVE CLS    OF INV101-REC    TO  WDITCL  OF WIP004-REC.
           MOVE SRCE   OF INV101-REC    TO  WDSRCE  OF WIP004-REC.
           MOVE "02"                    TO  WDUSGE  OF WIP004-REC.
           MOVE  PDCD OF INV101-REC     TO  WDPDCD  OF WIP004-REC.
           MOVE  SLNO OF INV401-REC     TO  WDSLNO  OF WIP004-REC.
           MOVE  SLIPTYPE OF INV401-REC TO  WDPRSRTY  OF WIP004-REC.
           MOVE  SRNO     OF INV401-REC TO  WDPRSRNO  OF WIP004-REC.
           MOVE  SRNO1    OF INV401-REC TO  WDPRSRNO1 OF WIP004-REC.
           MOVE  SRNO2    OF INV401-REC TO  WDPRSRNO2 OF WIP004-REC.
           MOVE  ITNO     OF INV401-REC TO  WDPRNO    OF WIP004-REC.
           MOVE  SPACE                  TO  WDPRDPT   OF WIP004-REC.
           MOVE  VSRNO    OF INV401-REC TO  WDCHDPT   OF WIP004-REC.
           MOVE  TDTE4    OF INV401-REC TO  WDDATE    OF WIP004-REC.
           MOVE  TQTY4    OF INV401-REC TO  WDPRQT    OF WIP004-REC.
           MOVE  SPACE                  TO  WDIPADDR  OF WIP004-REC.
           MOVE  SPACE                  TO  WDMACADDR OF WIP004-REC.
           MOVE  SPACE                  TO  WDINPTID  OF WIP004-REC.
           MOVE  SPACE                  TO  WDUPDTID  OF WIP004-REC.
           MOVE  SYS-DATE               TO  WDINPTDT  OF WIP004-REC.
           MOVE  SYS-TIME               TO  WDINPTTM  OF WIP004-REC.
           MOVE  SPACE                  TO  WDUPDTDT  OF WIP004-REC.
       WIP-TRANS-RTN1.
           IF SA-QTY(I-IDX) > 99999999999
              MOVE 99999999999 TO WDCHQT OF WIP004-REC
           ELSE
              MOVE SA-QTY(I-IDX) TO WDCHQT OF WIP004-REC.
           SUBTRACT WDCHQT OF WIP004-REC FROM SA-QTY(I-IDX).
           MOVE COMLTD OF INV401-REC TO WZCMCD.
           MOVE " "                  TO WZPLANT.
           MOVE "SERIAL"             TO WZCTTP.
           READ WIP090-FILE INVALID KEY
                MOVE WAITNO TO WK-ERRITNO
                MOVE "G" TO WERCD
                PERFORM ERROR-WRITE-RTN THRU ERROR-WRITE-EXIT
                GO TO END-RTN.
           ADD 1 TO WZSERNO.
           REWRITE WIP090-REC INVALID
                   MOVE WAITNO TO WK-ERRITNO
                   MOVE "H" TO WERCD
                   PERFORM ERROR-WRITE-RTN THRU ERROR-WRITE-EXIT
                   GO TO END-RTN.
           MOVE WZSERNO     TO   WC-SRNO.
           MOVE WC-SRNO     TO   WDSRNO   OF WIP004-REC.
           WRITE WIP004-REC INVALID KEY
                   MOVE WAITNO TO WK-ERRITNO
                   MOVE "I" TO WERCD
                   PERFORM ERROR-WRITE-RTN THRU ERROR-WRITE-EXIT
                   GO TO END-RTN.
           IF SA-QTY(I-IDX) = ZEROS
              NEXT SENTENCE
           ELSE
              GO TO WIP-TRANS-RTN1.
       WIP-TRANS-EXIT.
           EXIT.
      *
       BOM003-GRAD1-RTN.
           MOVE COMLTD OF INV101-REC TO OCMCD  OF BOM003-REC.
           MOVE XPLANT OF INV101-REC TO OPLANT OF BOM003-REC.
           MOVE DIV    OF INV101-REC TO ODVSN  OF BOM003-REC.
           MOVE ITNO   OF INV101-REC TO OPITN  OF BOM003-REC.
           START BOM003-FILE KEY IS NOT < EXTERNALLY-DESCRIBED-KEY
                 INVALID KEY
                 GO TO BOM003-GRAD1-EXIT.
       BOM003-GRAD1-RTN1.
           READ BOM003-FILE NEXT RECORD AT END
                GO TO BOM003-GRAD1-EXIT.
           IF OCMCD  OF BOM003-REC = COMLTD OF INV101-REC AND
              OPLANT OF BOM003-REC = XPLANT OF INV101-REC AND
              ODVSN  OF BOM003-REC = DIV    OF INV101-REC AND
              OPITN  OF BOM003-REC = ITNO   OF INV101-REC
              NEXT SENTENCE
           ELSE
              GO TO BOM003-GRAD1-EXIT.
           IF OEDTM OF BOM003-REC > TDTE4 OF INV401-REC AND
              OEDTM OF BOM003-REC NOT = SPACE
              GO TO BOM003-GRAD1-RTN1.
           IF OEDTE OF BOM003LA-REC < TDTE4 OF INV401-REC AND
              OEDTE OF BOM003LA-REC NOT = SPACE
              GO TO BOM003-GRAD1-RTN1.
           MOVE "1" TO WK-GRAD.
       BOM003-GRAD1-EXIT. EXIT.
      *
       BOM003-GRAD2-RTN.
           MOVE COMLTD OF INV101-REC  TO OCMCD  OF BOM003LA-REC.
           MOVE XPLANT OF INV101-REC  TO OPLANT OF BOM003LA-REC.
           MOVE DIV    OF INV101-REC  TO ODVSN  OF BOM003LA-REC.
           MOVE ITNO   OF INV101-REC  TO OFITN  OF BOM003LA-REC.
           MOVE SPACE                 TO OPITN  OF BOM003LA-REC.
           MOVE SPACE                 TO OCHDT  OF BOM003LA-REC.
           START BOM003LA-FILE KEY IS NOT < EXTERNALLY-DESCRIBED-KEY
                 INVALID KEY
                 GO TO BOM003-GRAD2-EXIT.
       BOM003-GRAD2-RTN1.
           READ BOM003LA-FILE NEXT RECORD AT END
                GO TO BOM003-GRAD2-EXIT.
           IF COMLTD OF INV101-REC = OCMCD  OF BOM003LA-REC AND
              XPLANT OF INV101-REC = OPLANT OF BOM003LA-REC AND
              DIV    OF INV101-REC = ODVSN  OF BOM003LA-REC AND
              ITNO   OF INV101-REC = OFITN  OF BOM003LA-REC
              NEXT SENTENCE
           ELSE
              GO TO BOM003-GRAD2-EXIT.
           IF OEDTM OF BOM003LA-REC > TDTE4 OF INV401-REC AND
              OEDTM OF BOM003LA-REC NOT = SPACE
              GO TO BOM003-GRAD2-RTN1.
           IF OEDTE OF BOM003LA-REC < TDTE4 OF INV401-REC AND
              OEDTE OF BOM003LA-REC NOT = SPACE
              GO TO BOM003-GRAD2-RTN1.
           MOVE "2" TO WK-GRAD.
       BOM003-GRAD2-EXIT.
           EXIT.
       SAVE-QTY.
           ADD 1 TO J-IDX.
           MOVE WK-QTY  TO SA-QTYA(J-IDX).
       SAVE-QTY-EXIT. EXIT.
      *
       COM-QTY-1.
           IF J-IDX = 0
              COMPUTE WK-QTY  ROUNDED = TQTY4 OF INV401-REC *
                                        PQTYM OF BOM001L03-REC *
                                        WK-IUMCV
           ELSE
              COMPUTE WK-QTY ROUNDED  = SA-QTYA(J-IDX) *
                                        PQTYM OF BOM001L03-REC.
       COM-QTY-1-EXIT.
           EXIT.
       ERROR-WRITE-RTN.
           MOVE COMLTD   OF INV401-REC TO COMLTD   OF WIP041-REC.
           MOVE SLIPTYPE OF INV401-REC TO SLIPTYPE OF WIP041-REC.
           MOVE SRNO     OF INV401-REC TO SRNO     OF WIP041-REC.
           MOVE SRNO1    OF INV401-REC TO SRNO1    OF WIP041-REC.
           MOVE SRNO2    OF INV401-REC TO SRNO2    OF WIP041-REC.
           MOVE XPLANT   OF INV401-REC TO XPLANT   OF WIP041-REC.
           MOVE DIV      OF INV401-REC TO DIV      OF WIP041-REC.
           MOVE SLNO     OF INV401-REC TO SLNO     OF WIP041-REC.
           MOVE ITNO     OF INV401-REC TO ITNO     OF WIP041-REC.
           MOVE CLS      OF INV401-REC TO CLS      OF WIP041-REC.
           MOVE SRCE     OF INV401-REC TO SRCE     OF WIP041-REC.
           MOVE VSRNO    OF INV401-REC TO VSRNO    OF WIP041-REC.
           MOVE DEPT     OF INV401-REC TO DEPT     OF WIP041-REC.
           MOVE RTNGUB   OF INV401-REC TO RTNGUB   OF WIP041-REC.
           MOVE XUSE     OF INV401-REC TO XUSE     OF WIP041-REC.
           MOVE RSVSRNO  OF INV401-REC TO RSVSRNO  OF WIP041-REC.
           MOVE EXFR     OF INV401-REC TO EXFR     OF WIP041-REC.
           MOVE EXTO     OF INV401-REC TO EXTO     OF WIP041-REC.
           MOVE RQDIV    OF INV401-REC TO RQDIV    OF WIP041-REC.
           MOVE TDTE4    OF INV401-REC TO TDTE4    OF WIP041-REC.
           MOVE TQTY1    OF INV401-REC TO TQTY1    OF WIP041-REC.
           MOVE TQTY2    OF INV401-REC TO TQTY2    OF WIP041-REC.
           MOVE TQTY3    OF INV401-REC TO TQTY3    OF WIP041-REC.
           MOVE TQTY4    OF INV401-REC TO TQTY4    OF WIP041-REC.
           MOVE RTQTY    OF INV401-REC TO RTQTY    OF WIP041-REC.
           MOVE WERCD                  TO ERRCD    OF WIP041-REC.
           MOVE WK-ERRITNO             TO ERRITNO  OF WIP041-REC.
           WRITE WIP041-REC.
       ERROR-WRITE-EXIT.
           EXIT.
       END-RTN.
           CLOSE INV002-FILE INV101-FILE INV401-FILE
                 BOM001L03-FILE BOM001L03-FILE1 BOM003-FILE
                 BOM003LA-FILE  WIP041-FILE
                 WIP001-FILE WIP004-FILE WIP090-FILE.
           GOBACK.

