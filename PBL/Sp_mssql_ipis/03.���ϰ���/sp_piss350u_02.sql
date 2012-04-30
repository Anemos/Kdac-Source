drop procedure sp_piss350u_02
go
/*
exec sp_piss350u_02 
*/

Create Procedure sp_piss350u_02
As
Begin
  SELECT kbno = a.kbno,   
         currentqty = a.currentqty,   
         readingqty  = 0,
         invgubunflag = a.invgubunflag
    FROM Tkb  a
  where a.kbno = 'z'
end


GO
