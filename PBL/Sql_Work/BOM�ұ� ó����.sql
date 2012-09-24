SELECT * FROM PBWIP.WIP004 BB
WHERE BB.WDCMCD = '01' AND BB.WDPLANT = 'D' AND BB.WDDVSN = 'M' AND BB.WDDATE >= '20120910' AND
BB.WDPRSRTY||BB.WDPRSRNO||BB.WDPRSRNO1||BB.WDPRSRNO2 IN
( SELECT DISTINCT WDPRSRTY||WDPRSRNO||WDPRSRNO1||WDPRSRNO2 FROM PBWIP.WIP004
WHERE WDCMCD = '01' AND WDPLANT = 'D' AND WDDVSN = 'M' AND WDITNO IN ('432716P','432716E') AND
WDDATE >= '20120910' );

//SELECT * FROM PBPDM.BOM001 WHERE
//PCMCD = '01' AND PCITN IN ('432713P','432713E') ;

//SELECT * FROM PBPDM.BOM001 WHERE
//PCMCD = '01' AND PCITN IN ('432714P','432714E') ;

//SELECT * FROM PBPDM.BOM001 WHERE
//PCMCD = '01' AND PCITN IN ('432715P','432715E') ;

//SELECT * FROM PBPDM.BOM001 WHERE
//PCMCD = '01' AND PCITN IN ('432716P','432716E') ;