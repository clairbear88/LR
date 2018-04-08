create table #tempFreeSpace2 (
	 [hostname] varchar (128)
	,[databasename] varchar(128)
	,[version] varchar(512)
  );

exec sp_msforeachdb 'use [?]

  if exists (select * from sys.objects where object_id = OBJECT_ID(N''dbo.SCDBVersion'') and type in (N''U''))
  begin
			
  insert into #tempFreeSpace2 (
	 [hostname]
    ,[databasename]
    ,[version]
  )
  
	select 
	 @@servername as hostname
	,DB_Name() as DatabaseName
			,convert(varchar(10), db1.Major) + ''.'' + 
			convert(varchar(10), db1.Minor) + ''.'' + 
			convert(varchar(10), db1.Patch) + ''.'' + 
			convert(varchar(10), db1.Revision) as Version
  from dbo.SCDBVersion db1
  end
'
GO

create table #tempFreeSpace (
	 [hostname] varchar (128)
    ,[databasename] varchar(128)
    ,[fileid] integer
    ,[file_total_mb] decimal(10,2)
    ,[file_used_mb] decimal(10,2) 
    ,[file_free_mb] decimal(10,2)
    ,[name] varchar(128)
    ,[filename] varchar(512)
  );

Exec sp_msforeachdb '
  use [?]

  if exists (select * from sys.objects where object_id = OBJECT_ID(N''dbo.SCDBVersion'') and type in (N''U''))
  begin
  
  insert into #tempFreeSpace (
	 [hostname]
    ,[databasename] 
    ,[fileid] 
    ,[file_total_mb] 
    ,[file_used_mb] 
    ,[file_free_mb] 
    ,[name] 
    ,[filename] 
  )

  select
	 @@servername as hostname
	,db_name() as DatabaseName
	,a.FILEID
	,[FILE_TOTAL_MB] = 
		convert(decimal(12,2),round(a.size/128.000,2))
	,[FILE_USED_MB] = 
		convert(decimal(12,2),round(fileproperty(a.name,''SpaceUsed'')/128.000,2))
	,[FILE_FREE_MB] = 
		convert(decimal(12,2),round((a.size-fileproperty(a.name,''SpaceUsed''))
		/128.000,2)) 
	,NAME = left(a.NAME,15)
	,FILENAME = left(a.FILENAME,256)

  from dbo.sysfiles a
  end
'
GO

select 
	 #tempFreeSpace2.hostname
	,#tempFreeSpace.databasename
	,#tempFreeSpace2.version
	,#tempFreeSpace.fileid
	,#tempFreeSpace.file_total_mb
	,#tempFreeSpace.file_used_mb
	,#tempFreeSpace.file_free_mb
	,#tempFreeSpace.name
	,#tempFreeSpace.filename
from #tempFreeSpace2
join #tempFreeSpace
on #tempFreeSpace2.databasename=#tempFreeSpace.databasename
order by databasename;

drop table #tempFreeSpace2
drop table #tempFreeSpace
GO

