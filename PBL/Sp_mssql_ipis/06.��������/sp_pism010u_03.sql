S E T   Q U O T E D _ I D E N T I F I E R   O F F  
 G O  
 S E T   A N S I _ N U L L S   O F F  
 G O  
  
 i f   e x i s t s   ( s e l e c t   *   f r o m   d b o . s y s o b j e c t s   w h e r e   i d   =   o b j e c t _ i d ( N ' [ d b o ] . [ s p _ p i s m 0 1 0 u _ 0 3 ] ' )   a n d   O B J E C T P R O P E R T Y ( i d ,   N ' I s P r o c e d u r e ' )   =   1 )  
 d r o p   p r o c e d u r e   [ d b o ] . [ s p _ p i s m 0 1 0 u _ 0 3 ]  
 G O  
  
  
  
  
 / * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * /  
 / *             ����|���  �����ɷ����        * /  
 / * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * /  
  
 C R E A T E   P R O C E D U R E   s p _ p i s m 0 1 0 u _ 0 3  
     @ p s _ a r e a         C h a r ( 1 ) ,         - -   ���� 
     @ p s _ d i v           C h a r ( 1 ) ,         - -   ���� 
     @ p s _ w c             V a r c h a r ( 5 ) ,       - -   p� 
     @ p s _ w d a y         C h a r ( 1 0 ) ,       - -   ����|ǐ� 
     @ p s _ w c I t e m r e t C h k     C h a r ( 1 )           - -   p�ļ����|�����  ������x�  �� ����ŀ� 
  
 A S  
 B E G I N  
  
   D e c l a r e   @ a c t I n M H   N u m e r i c ( 4 , 1 )  
  
 I f   @ p s _ w c I t e m r e t C h k   =   ' 1 '  
     B e g i n  
     - -   ' ������'   mթ�  ��� 
  
         S E L E C T   @ a c t I n M H   =   s u m ( I s N u l l ( A c t I n M H , 0 ) )  
             F R O M   T M H D A I L Y  
           W H E R E   (   A r e a C o d e   =   @ p s _ a r e a   )   A N D  
                       (   D i v i s i o n C o d e   =   @ p s _ d i v   )   A N D  
                       (   W o r k C e n t e r   =   @ p s _ w c   )   A N D  
                       (   W o r k D a y   =   @ p s _ w d a y   )  
  
         I f   I s N u l l ( @ a c t I n M H , 0 )   =   0  
               B e g i n  
         D E L E T E   T M H R E A L P R O D  
           W H E R E   (   A r e a C o d e   =   @ p s _ a r e a   )   A N D  
                       (   D i v i s i o n C o d e   =   @ p s _ d i v   )   A N D  
                       (   W o r k C e n t e r   =   @ p s _ w c   )   A N D  
                       (   W o r k D a y   =   @ p s _ w d a y   )  
         I f   @ @ E r r o r   < >   0   G o t o   E x i t _ p r  
               E n d  
         E l s e  
               B e g i n  
             D E L E T E   T M H R E A L P R O D  
                 F R O M   T M H R E A L P R O D   A  
               W H E R E   (   (   A . A r e a C o d e   =   @ p s _ a r e a   )   A N D  
                               (   A . D i v i s i o n C o d e   =   @ p s _ d i v   )   A N D  
                               (   A . W o r k C e n t e r   =   @ p s _ w c   )   A N D  
                               (   A . W o r k D a y   =   @ p s _ w d a y   )   A n d  
                   (   (   I s N u l l ( A . d a y p Q t y ,   0 )   +   I s N u l l ( A . n i g h t p Q t y ,   0 )   )   =   0   )   )  
             I f   @ @ E r r o r   < >   0   G o t o   E x i t _ p r  
  
  
             I N S E R T   I N T O   T M H R E A L P R O D  
                             (   A r e a C o d e ,   D i v i s i o n C o d e ,   W o r k C e n t e r ,   W o r k D a y ,   I t e m C o d e ,  
                     s u b L i n e C o d e ,   s u b L i n e N o ,   w c I t e m G r o u p ,   S e q   )  
             S E L E C T   A . A r e a C o d e ,  
               A . D i v i s i o n C o d e ,  
               A . W o r k C e n t e r ,  
               @ p s _ w d a y ,  
               A . I t e m C o d e ,  
                           A . s u b L i n e C o d e ,  
                           A . s u b L i n e N o ,  
               A . w c I t e m G r o u p ,  
               A . S e q  
                 F R O M   T M H W C I T E M   A ,   V R O U T B A S I C T I M E   B  
               W H E R E   (   A . A r e a C o d e   =   B . A r e a C o d e   )   a n d  
                           (   A . D i v i s i o n C o d e   =   B . D i v i s i o n C o d e   )   a n d  
               (   A . W o r k C e n t e r   =   B . W o r k C e n t e r   )   a n d  
               (   A . I t e m C o d e   =   B . I t e m C o d e   )   a n d  
               (   A . s u b L i n e C o d e   =   B . S u b L i n e C o d e   )   a n d  
               (   A . s u b L i n e N o   =   B . S u b L i n e N o   )   a n d  
 / *               (   (   B . A p p l y D a t e   =   (   S E L E C T   m a x ( A p p l y D a t e )   F R O M   V R O U T B A S I C T I M E  
                                 W H E R E   (   A r e a C o d e   =   A . A r e a C o d e   )   A N D  
                                 (   D i v i s i o n C o d e   =   A . D i v i s i o n C o d e   )   A N D  
                                 (   W o r k C e n t e r   =   A . W o r k C e n t e r   )   A N D  
                                 (   I t e m C o d e   =   A . I t e m C o d e   )   A n d  
                                 (   s u b L i n e C o d e   =   A . s u b L i n e C o d e   )   a n d  
                                 (   s u b L i n e N o   =   A . s u b L i n e N o   )   A n d  
                                 (   A p p l y D a t e   < =   @ p s _ w d a y   )   )   )   A n d   * /  
               (   (   A . A r e a C o d e   =   @ p s _ a r e a   )   A N D  
                   (   A . D i v i s i o n C o d e   =   @ p s _ d i v   )   A N D  
                   (   A . W o r k C e n t e r   =   @ p s _ w c   )   A N D  
                   (   I s N u l l ( A . U s e F l a g , ' 0 ' )   =   ' 1 '   )   A n d  
         N o t   E x i s t s   (   S e l e c t   I t e m C o d e   F r o m   T M H R E A L P R O D  
                         W h e r e   (   A r e a C o d e   =   A . A r e a C o d e   )   A n d   (   D i v i s i o n C o d e   =   A . D i v i s i o n C o d e   )   A n d  
                         (   W o r k C e n t e r   =   A . W o r k C e n t e r   )   A n d   (   W o r k D a y   =   @ p s _ w d a y   )   A n d  
                         (   I t e m C o d e   =   A . I t e m C o d e   )   A n d   (   s u b l i n e c o d e   =   A . s u b l i n e c o d e   )   A n d  
                         (   S u b L i n e n o   =   A . s u b L i n e N o   )   )   )  
             I f   @ @ E r r o r   < >   0   G o t o   E x i t _ p r  
  
         - -    Ǭ�p���m�  1��� 
           U P D A T E   T M H R E A L P R O D  
                   S E T   w c I t e m G r o u p   =   B . w c I t e m G r o u p ,  
               S e q   =   B . s e q  
                 F R O M   T M H R E A L P R O D   A ,  
                           T M H W C I T E M   B  
               W H E R E   (   A . A r e a C o d e   =   B . A r e a C o d e   )   a n d  
               (   A . D i v i s i o n C o d e   =   B . D i v i s i o n C o d e   )   A n d  
               (   A . W o r k C e n t e r   =   B . W o r k C e n t e r   )   A n d  
               (   A . I t e m C o d e   =   B . I t e m C o d e   )   A n d  
               (   A . s u b L i n e C o d e   =   B . s u b L i n e C o d e   )   A n d  
               (   A . s u b L i n e N o   =   B . s u b L i n e N o   )   A n d  
                           (   (   A . A r e a C o d e   =   @ p s _ a r e a   )   A N D  
                               (   A . D i v i s i o n C o d e   =   @ p s _ d i v   )   A N D  
                               (   A . W o r k C e n t e r   =   @ p s _ w c   )   A N D  
                               (   A . W o r k D a y   =   @ p s _ w d a y   )   A n d  
                   (   I s N u l l ( B . U s e F l a g , ' ' )   =   ' 1 '   )   )  
  
         - -   \� ����  1��� 
  
             U P D A T E   T M H R E A L P R O D  
                   S E T   B a s i c T i m e   =   B . B a s i c T i m e  
                 F R O M   T M H R E A L P R O D   A ,  
                           V R O U T B A S I C T I M E   B  
               W H E R E   (   A . A r e a C o d e   =   B . A r e a C o d e   )   a n d  
               (   A . D i v i s i o n C o d e   =   B . D i v i s i o n C o d e   )   A n d  
               (   A . W o r k C e n t e r   =   B . W o r k C e n t e r   )   A n d  
               (   A . I t e m C o d e   =   B . I t e m C o d e   )   A n d  
               (   A . s u b L i n e C o d e   =   B . s u b L i n e C o d e   )   A n d  
               (   A . s u b L i n e N o   =   B . s u b L i n e N o   )   A n d  
 / *                           (   B . A p p l y D a t e   =   (   S E L E C T   m a x ( A p p l y D a t e )   F R O M   V R O U T B A S I C T I M E  
                             W H E R E   (   A r e a C o d e   =   A . A r e a C o d e   )   A N D  
                             (   D i v i s i o n C o d e   =   A . D i v i s i o n C o d e   )   A N D  
                             (   W o r k C e n t e r   =   A . W o r k C e n t e r   )   A N D  
                             (   I t e m C o d e   =   A . I t e m C o d e   )   A n d  
                             (   s u b L i n e C o d e   =   A . s u b L i n e C o d e   )   A n d  
                             (   s u b L i n e N o   =   A . s u b L i n e N o   )   A n d  
                             (   A p p l y D a t e   < =   @ p s _ w d a y   )   )   )   A n d   * /  
                           (   (   A . A r e a C o d e   =   @ p s _ a r e a   )   A N D  
                               (   A . D i v i s i o n C o d e   =   @ p s _ d i v   )   A N D  
                               (   A . W o r k C e n t e r   =   @ p s _ w c   )   A N D  
                               (   A . W o r k D a y   =   @ p s _ w d a y   )   )  
             I f   @ @ E r r o r   < >   0   G o t o   E x i t _ p r  
  
         - -   \� ��������  ��Ĭ�� 
  
             U P D A T E   T M H R E A L P R O D  
                   S E T   B a s i c M H   =   R o u n d (   (   I s N u l l ( d a y p Q t y , 0 )   +   I s N u l l ( n i g h t p Q t y , 0 )   )   *   (   B a s i c T i m e   /   3 6 0 0   )   ,   1   )  
               W H E R E   (   A r e a C o d e   =   @ p s _ a r e a   )   A N D  
                           (   D i v i s i o n C o d e   =   @ p s _ d i v   )   A N D  
                           (   W o r k C e n t e r   =   @ p s _ w c   )   A N D  
                           (   W o r k D a y   =   @ p s _ w d a y   )   A n d  
               (   I s N u l l ( d a y p Q t y , 0 )   +   I s N u l l ( n i g h t p Q t y , 0 )   >   0   )  
             I f   @ @ E r r o r   < >   0   G o t o   E x i t _ p r  
  
         E n d  
     E n d  
  
     S E L E C T   A . D i v i s i o n C o d e ,  
           A . A r e a C o d e ,  
       A . W o r k C e n t e r ,  
       A . W o r k D a y ,  
           A . w c I t e m G r o u p ,  
       A . S e q ,  
       A . I t e m C o d e ,  
       A . s u b L i n e C o d e ,  
       A . s u b L i n e N o ,  
       A . d a y p Q t y ,  
       A . n i g h t p Q t y ,  
       A . U n u s e M H ,  
       A . A c t M H ,  
       A . A c t I n M H ,  
       A . B a s i c T i m e ,  
       A . B a s i c M H ,  
       B . I t e m N a m e ,  
           B . I t e m S p e c ,  
       ' 0 '   u n u s e _ i n p u t C h k ,  
       ' 0 '   a c t _ i n p u t C h k ,  
       A . L a s t E m p ,  
       A . L a s t D a t e  
           F R O M   T M H R E A L P R O D   A ,  
                     T M S T I T E M   B  
       W H E R E   (   A . I t e m C o d e   =   B . I t e m C o d e   )   a n d  
                   (   (   A . A r e a C o d e   =   @ p s _ a r e a   )   A N D  
                       (   A . D i v i s i o n C o d e   =   @ p s _ d i v   )   A N D  
                       (   A . W o r k C e n t e r   =   @ p s _ w c   )   A N D  
                       (   A . W o r k D a y   =   @ p s _ w d a y   )   )  
  
 E x i t _ p r :  
  
 E N D  
  
  
 G O  
 S E T   Q U O T E D _ I D E N T I F I E R   O F F  
 G O  
 S E T   A N S I _ N U L L S   O N  
 G O  
  
 