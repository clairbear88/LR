--Last Updated : 2011-06-21

use [master]
go

set nocount on

--declare @versiontable table
--(
--	DatabaseName sysname,
--	DatabaseVersion varchar(40)
--)
declare @majorversion int
declare @sql varchar(max)

if exists (select database_id from sys.databases where name = N'LogRhythm_Alarms')
begin

	set @majorversion = (select Major from LogRhythm_Alarms.dbo.SCDBVersion)

	if(@majorversion=6)
	begin
		set @sql = '
			select ''LogRhythm_Alarms'' as DatabaseName,
			convert(varchar(10), db1.Major) + ''.'' + 
			convert(varchar(10), db1.Minor) + ''.'' + 
			convert(varchar(10), db1.Patch) + ''.'' + 
			convert(varchar(10), db1.Revision) as Version
			from LogRhythm_Alarms.dbo.SCDBVersion db1'
			
		exec(@sql)
	end
	else
	begin
		set @sql = '
			select ''LogRhythm_Alarms'' as DatabaseName,
			convert(varchar(10), db1.Major) + ''.'' + 
			convert(varchar(10), db1.Minor) + ''.'' + 
			convert(varchar(10), db1.Revision) as Version
			from LogRhythm_Alarms.dbo.SCDBVersion db1'
		
		exec(@sql)
	end
end
else
begin
	select 'LogRhythm_Alarms' as DatabaseName,
	'Not present' as Version
end

if exists (select database_id from sys.databases where name = N'LogRhythm_Events')
begin

	set @majorversion = (select Major from LogRhythm_Events.dbo.SCDBVersion)

	if(@majorversion=6)
	begin
		set @sql = '
			select ''LogRhythm_Events'' as DatabaseName,
			convert(varchar(10), db1.Major) + ''.'' + 
			convert(varchar(10), db1.Minor) + ''.'' + 
			convert(varchar(10), db1.Patch) + ''.'' + 
			convert(varchar(10), db1.Revision) as Version
			from LogRhythm_Events.dbo.SCDBVersion db1'
			
		exec(@sql)
	end
	else
	begin
		set @sql = '
			select ''LogRhythm_Events'' as DatabaseName,
			convert(varchar(10), db1.Major) + ''.'' + 
			convert(varchar(10), db1.Minor) + ''.'' + 
			convert(varchar(10), db1.Revision) as Version
			from LogRhythm_Events.dbo.SCDBVersion db1'
		
		exec(@sql)
	end
end
else
begin
	select 'LogRhythm_Events' as DatabaseName,
	'Not present' as Version
end

if exists (select database_id from sys.databases where name = N'LogRhythm_LogMart')
begin

	set @majorversion = (select Major from LogRhythm_LogMart.dbo.SCDBVersion)

	if(@majorversion=6)
	begin
		set @sql = '
			select ''LogRhythm_LogMart'' as DatabaseName,
			convert(varchar(10), db1.Major) + ''.'' + 
			convert(varchar(10), db1.Minor) + ''.'' + 
			convert(varchar(10), db1.Patch) + ''.'' + 
			convert(varchar(10), db1.Revision) as Version
			from LogRhythm_LogMart.dbo.SCDBVersion db1'
			
		exec(@sql)
	end
	else
	begin
		set @sql = '
			select ''LogRhythm_LogMart'' as DatabaseName,
			convert(varchar(10), db1.Major) + ''.'' + 
			convert(varchar(10), db1.Minor) + ''.'' + 
			convert(varchar(10), db1.Revision) as Version
			from LogRhythm_LogMart.dbo.SCDBVersion db1'
		
		exec(@sql)
	end
end
else
begin
	select 'LogRhythm_LogMart' as DatabaseName,
	'Not present' as Version
end

if exists (select database_id from sys.databases where name = N'LogRhythmEMDB')
begin

	set @majorversion = (select Major from LogRhythmEMDB.dbo.SCDBVersion)

	if(@majorversion=6)
	begin
		set @sql = '
			select ''LogRhythmEMDB'' as DatabaseName,
			convert(varchar(10), db1.Major) + ''.'' + 
			convert(varchar(10), db1.Minor) + ''.'' + 
			convert(varchar(10), db1.Patch) + ''.'' + 
			convert(varchar(10), db1.Revision) as Version
			from LogRhythmEMDB.dbo.SCDBVersion db1'
			
		exec(@sql)
	end
	else
	begin
		set @sql = '
			select ''LogRhythmEMDB'' as DatabaseName,
			convert(varchar(10), db1.Major) + ''.'' + 
			convert(varchar(10), db1.Minor) + ''.'' + 
			convert(varchar(10), db1.Revision) as Version
			from LogRhythmEMDB.dbo.SCDBVersion db1'
		
		exec(@sql)
	end
end
else
begin
	select 'LogRhythmEMDB' as DatabaseName,
	'Not present' as Version
end

if exists (select database_id from sys.databases where name = N'LogRhythmLMDB')
begin

	set @majorversion = (select Major from LogRhythmLMDB.dbo.SCDBVersion)

	if(@majorversion=6)
	begin
		set @sql = '
			select ''LogRhythmLMDB'' as DatabaseName,
			convert(varchar(10), db1.Major) + ''.'' + 
			convert(varchar(10), db1.Minor) + ''.'' + 
			convert(varchar(10), db1.Patch) + ''.'' + 
			convert(varchar(10), db1.Revision) as Version
			from LogRhythmLMDB.dbo.SCDBVersion db1'
			
		exec(@sql)
	end
	else
	begin
		set @sql = '
			select ''LogRhythmLMDB'' as DatabaseName,
			convert(varchar(10), db1.Major) + ''.'' + 
			convert(varchar(10), db1.Minor) + ''.'' + 
			convert(varchar(10), db1.Revision) as Version
			from LogRhythmLMDB.dbo.SCDBVersion db1'
		
		exec(@sql)
	end
end
else
begin
	select 'LogRhythmLMDB' as DatabaseName,
	'Not present' as Version
end

if exists (select database_id from sys.databases where name = N'LogRhythmRADB')
begin

	set @majorversion = (select Major from LogRhythmRADB.dbo.SCDBVersion)

	if(@majorversion=6)
	begin
		set @sql = '
			select ''LogRhythmRADB'' as DatabaseName,
			convert(varchar(10), db1.Major) + ''.'' + 
			convert(varchar(10), db1.Minor) + ''.'' + 
			convert(varchar(10), db1.Patch) + ''.'' + 
			convert(varchar(10), db1.Revision) as Version
			from LogRhythmRADB.dbo.SCDBVersion db1'
			
		exec(@sql)
	end
	else
	begin
		set @sql = '
			select ''LogRhythmRADB'' as DatabaseName,
			convert(varchar(10), db1.Major) + ''.'' + 
			convert(varchar(10), db1.Minor) + ''.'' + 
			convert(varchar(10), db1.Revision) as Version
			from LogRhythmRADB.dbo.SCDBVersion db1'
		
		exec(@sql)
	end
end
else
begin
	select 'LogRhythmRADB' as DatabaseName,
	'Not present' as Version
end

--select * from @versiontable