/* ************************** part_out_temp table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[part_out_temp]')
              and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[part_out_temp]
GO

CREATE TABLE [dbo].[part_out_temp] (
  [scandate]        [varchar]   (50)    NOT NULL,
  [area_code]       [char]      (1)     NOT NULL,
  [factory_code]    [char]      (1)     NOT NULL,
  [part_code]       [varchar]   (15)    NOT NULL,
  [flag]            [char]      (1)     NULL,
  [stscd]           [char]      (1)     NULL,
  [inptid]          [char]      (6)     NULL,
  [inptdt]          [datetime]          NULL,
  [updtid]          [char]      (6)     NULL,
  [updtdt]          [datetime]          NULL,
  [ipaddr]          [varchar]   (30)    NULL,
  [macaddr]         [varchar]   (30)    NULL,
  CONSTRAINT [PK_part_out_temp] PRIMARY KEY  CLUSTERED
  (
    [ScanDate]
  )  ON [PRIMARY]
) ON [PRIMARY]
GO

setuser
GO
