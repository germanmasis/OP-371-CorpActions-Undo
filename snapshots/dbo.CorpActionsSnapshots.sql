USE [DownloadDB]
GO
/****** Object:  StoredProcedure [dbo].[CorpActionsSnapshots]    Script Date: 4/14/2021 5:11:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	OP-371
	Create a snapshot of the position tables over DownLoadDB
	before beginning corpActons - AUTO 4 job.
	Tables:
    - dbo.Position
    - ox.Position
    - ox.PositionSummary

*/
Create PROCEDURE [dbo].[CorpActionsSnapshots]
As
-- [ox] schema creation
if not exists (select * from DownloadDB.sys.schemas where name=N'ox')	
		exec ('Create Schema [ox] ')
-- dbo.Position
If Object_id ('DownloadDB.dbo.Position_CorpActions_snapshot', 'U') is not null
	Drop table [DownloadDB].[dbo].[Position_CorpActions_snapshot]
Select *
	into [DownloadDB].[dbo].[Position_CorpActions_snapshot]
from [Wowtrader].[dbo].[Position]

-- ox.Position
If Object_id ('DownloadDB.ox.Position_CorpActions_snapshot', 'U') is not null
	Drop table [DownloadDB].[ox].[Position_CorpActions_snapshot]
Select *
	into [DownloadDB].[ox].[Position_CorpActions_snapshot]
from [Wowtrader].[ox].[Position]

-- ox.PositionSummary
If Object_id ('DownloadDB.ox.PositionSummary_CorpActions_snapshot', 'U') is not null
	Drop table [DownloadDB].[ox].[PositionSummary_CorpActions_snapshot]
Select *
	into [DownloadDB].[ox].[PositionSummary_CorpActions_snapshot]
from [Wowtrader].[ox].[PositionSummary]

