S E T   Q U O T E D _ I D E N T I F I E R   O F F  
 G O  
 S E T   A N S I _ N U L L S   O F F  
 G O  
  
 i f   e x i s t s   ( s e l e c t   *   f r o m   d b o . s y s o b j e c t s   w h e r e   i d   =   o b j e c t _ i d ( N ' [ d b o ] . [ s p _ p i s m 0 8 0 i _ 0 2 ] ' )   a n d   O B J E C T P R O P E R T Y ( i d ,   N ' I s P r o c e d u r e ' )   =   1 )  
 d r o p   p r o c e d u r e   [ d b o ] . [ s p _ p i s m 0 8 0 i _ 0 2 ]  
 G O  
  
  
  
  
 / * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * /  
 / *           �Ԉ�ļ  L P I   �  ���Ũ�(�  pȌ�        * /  
 / * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * /  
  
 C R E A T E   P R O C E D U R E   s p _ p i s m 0 8 0 i _ 0 2  
     @ p s _ a r e a     C h a r ( 1 ) ,         - -   ���� 
     @ p s _ d i v       C h a r ( 1 ) ,         - -   ���� 
     @ p s _ w c         V a r C h a r ( 5 ) ,       - -   p� 
     @ p s _ s t M o n t h   C h a r ( 7 )           - -   0� �D��� 
 A S  
 B E G I N  
  
 D e c l a r e   @ l a s t Y e a r   C h a r ( 4 )  
 D e c l a r e   @ w o r k m o n t h     C h a r ( 8 )  
  
 S e t   @ l a s t Y e a r       =       C a s t   (   C a s t (   s u b s t r i n g ( @ p s _ s t M o n t h ,   1 ,   4 )   a s   N u m e r i c ( 4 )   )   -   1   a s   C h a r ( 4 )   )  
 S e t   @ w o r k m o n t h     =   @ p s _ s t M o n t h     +   ' % '  
  
 s e l e c t   a r e a c o d e , d i v i s i o n c o d e , w o r k c e n t e r , i t e m c o d e , s u b l i n e c o d e , s u b l i n e n o , s u m ( b a s i c t i m e ) / c o u n t ( w o r k d a y )   a s   b a s i c t i m e  
     i n t o   # t m p _ r e a l p r o d  
 f r o m   t m h r e a l p r o d  
 w h e r e         A r e a C o d e   =   @ p s _ a r e a     A n d  
       D i v i s i o n C o d e   =   @ p s _ d i v     A n d  
       W o r k C e n t e r   l i k e   @ p s _ w c     A n d  
       w o r k d a y   l i k e   @ w o r k m o n t h  
 g r o u p   b y   a r e a c o d e , d i v i s i o n c o d e , w o r k c e n t e r , i t e m c o d e , s u b l i n e c o d e , s u b l i n e n o  
  
  
     S E L E C T   A . s M o n t h ,  
       A . A r e a C o d e ,  
                   A . D i v i s i o n C o d e ,  
                   A . W o r k C e n t e r ,  
                   E . W o r k C e n t e r N a m e ,  
                   B . P r o d u c t G r o u p ,  
                   D . P r o d u c t G r o u p N a m e ,  
       A . s u b L i n e C o d e ,  
       A . s u b L i n e N o ,  
                   A . I t e m C o d e ,  
                   C . I t e m N a m e ,  
 - -               F . w c I t e m G r o u p ,  
       A . p Q t y ,  
       A . u n u s e M H ,  
       A . A c t M H ,  
       A . A c t I n M H ,  
       A . B a s i c M H ,  
       G . t a r M H ,  
       H . s t M H ,  
       I . t a r L P I ,  
       I . d i v t a r L P I ,  
       J . B a s i c T i m e   /   3 6 0 0  
         F R O M   T M H M O N T H P R O D L I N E _ S   A ,  
                   T M S T M O D E L   B ,  
                   T M S T I T E M   C ,  
                   T M S T P R O D U C T G R O U P   D ,  
                   T M S T W O R K C E N T E R   E ,  
 - -               T M H W C I T E M   F ,  
     (   S E L E C T   W o r k C e n t e r ,  
           I t e m C o d e ,  
           s u b L i n e C o d e ,  
           s u b L i n e N o ,  
                       t a r M H  
             F R O M   T M H M O N T H T A R G E T  
           W H E R E   (   A r e a C o d e   =   @ p s _ a r e a   )   A N D  
           (   D i v i s i o n C o d e   =   @ p s _ d i v   )   A N D  
           (   W o r k C e n t e r   l i k e   @ p s _ w c   )   A N D  
           (   t a r M o n t h   =   @ p s _ s t M o n t h   )   )   G ,  
     (   S E L E C T   W o r k C e n t e r ,  
           I t e m C o d e ,  
           s u b L i n e C o d e ,  
           s u b L i n e N o ,  
                       C A S E   S U B S T R I N G ( @ p s _ s t M o n t h , 6 , 2 )  
             W H E N   ' 0 1 '   T H E N   S T M H 0 1  
             W H E N   ' 0 2 '   T H E N   S T M H 0 2  
             W H E N   ' 0 3 '   T H E N   S T M H 0 3  
             W H E N   ' 0 4 '   T H E N   S T M H 0 4  
             W H E N   ' 0 5 '   T H E N   S T M H 0 5  
             W H E N   ' 0 6 '   T H E N   S T M H 0 6  
             W H E N   ' 0 7 '   T H E N   S T M H 0 7  
             W H E N   ' 0 8 '   T H E N   S T M H 0 8  
             W H E N   ' 0 9 '   T H E N   S T M H 0 9  
             W H E N   ' 1 0 '   T H E N   S T M H 1 0  
             W H E N   ' 1 1 '   T H E N   S T M H 1 1  
             W H E N   ' 1 2 '   T H E N   S T M H 1 2   E N D   A S   s t M H  
             F R O M   t m h s t a n d a r d  
           W H E R E   (   A r e a C o d e   =   @ p s _ a r e a   )   A N D  
           (   D i v i s i o n C o d e   =   @ p s _ d i v   )   A N D  
           (   W o r k C e n t e r   l i k e   @ p s _ w c   )   A N D  
           (   s t Y e a r   =   @ l a s t Y e a r   )   )   H ,  
       T M H V A L U E T A R G E T   I ,  
       # t m p _ r e a l p r o d   J  
       W H E R E   (   A . A r e a C o d e   =   B . A r e a C o d e   )   a n d  
                   (   A . D i v i s i o n C o d e   =   B . D i v i s i o n C o d e   )   a n d  
                   (   A . I t e m C o d e   =   C . I t e m C o d e   )   a n d  
                   (   A . I t e m C o d e   =   B . I t e m C o d e   )   a n d  
                   (   B . P r o d u c t G r o u p   =   D . P r o d u c t G r o u p   )   a n d  
                   (   A . A r e a C o d e   =   D . A r e a C o d e   )   a n d  
                   (   A . D i v i s i o n C o d e   =   D . D i v i s i o n C o d e   )   a n d  
                   (   A . A r e a C o d e   =   E . A r e a C o d e   )   a n d  
                   (   A . D i v i s i o n C o d e   =   E . D i v i s i o n C o d e   )   a n d  
                   (   A . W o r k C e n t e r   =   E . W o r k C e n t e r   )   a n d  
 - -               (   A . A r e a C o d e   * =   F . A r e a C o d e   )   a n d  
 - -               (   A . D i v i s i o n C o d e   * =   F . D i v i s i o n C o d e   )   a n d  
 - -               (   A . W o r k C e n t e r   * =   F . W o r k C e n t e r   )   a n d  
 - -               (   A . I t e m C o d e   * =   F . I t e m C o d e   )   A n d  
       (   A . A r e a C o d e   * =   I . A r e a C o d e   )   a n d  
                   (   A . D i v i s i o n C o d e   * =   I . D i v i s i o n C o d e   )   a n d  
                   (   A . W o r k C e n t e r   * =   I . W o r k C e n t e r   )   A n d  
       (   A . s M o n t h   * =   I . t a r M o n t h   )   A n d  
       (   A . W o r k C e n t e r   * =   G . W o r k C e n t e r   )   A n d  
       (   A . I t e m C o d e   * =   G . I t e m C o d e   )   A n d  
       (   A . s u b L i n e C o d e   * =   G . s u b L i n e C o d e   )   A n d  
       (   A . s u b L i n e N o   * =   G . s u b L i n e N o   )   A n d  
       (   A . W o r k C e n t e r   * =   H . W o r k C e n t e r   )   A n d  
       (   A . I t e m C o d e   * =   H . I t e m C o d e   )   A n d  
       (   A . s u b L i n e C o d e   * =   H . s u b L i n e C o d e   )   A n d  
       (   A . s u b L i n e N o   * =   H . s u b L i n e N o   )   A n d  
       (   A . A r e a C o d e   * =   J . A r e a C o d e   )   A n d  
       (   A . D i v i s i o n C o d e   * =   J . D i v i s i o n C o d e   )   A n d  
       (   A . W o r k C e n t e r   * =   J . W o r k C e n t e r   )   A n d  
       (   A . I t e m C o d e   * =   J . I t e m C o d e   )   a n d  
                   (   A . s u b L i n e C o d e   * =   J . s u b L i n e C o d e   )   a n d  
       (   A . s u b L i n e N o   * =   J . s u b L i n e N o   )   A n d  
       (   (   A . A r e a C o d e   =   @ p s _ a r e a   )   A n d  
           (   A . D i v i s i o n C o d e   =   @ p s _ d i v   )   A n d  
           (   A . W o r k C e n t e r   l i k e   @ p s _ w c   )   A n d  
           (   A . s M o n t h   =   @ p s _ s t M o n t h   )   )   / *   A n d  
           (   J . A p p l y D a t e   =   (   S E L E C T   m a x ( C . A p p l y D a t e )  
                               F R O M   V R O U T B A S I C T I M E   C  
                         W H E R E   (   C . A r e a C o d e   =   A . A r e a C o d e   )   A N D  
                         (   C . D i v i s i o n C o d e   =   A . D i v i s i o n C o d e   )   A N D  
                         (   C . W o r k C e n t e r   =   A . W o r k C e n t e r   )   A N D  
                         (   C . I t e m C o d e   =   A . I t e m C o d e   )   A n d  
                         (   C . s u b L i n e c o d e   =   A . s u b L i n e C o d e   )   A n d  
                         (   C . s u b L i n e N o   =   A . s u b L i n e N o   )   A n d  
                         (   s u b s t r i n g ( C . A p p l y D a t e ,   1 ,   6 )   < =   @ p s _ s t M o n t h   )   )   )   )   * /  
  
 d r o p   t a b l e   # t m p _ r e a l p r o d  
  
 E N D  
  
  
  
 G O  
 S E T   Q U O T E D _ I D E N T I F I E R   O F F  
 G O  
 S E T   A N S I _ N U L L S   O N  
 G O  
  
 