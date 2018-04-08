USE LogRhythmEMDB
Create table SysMonToMedAssignment (
	[SysmonID] int
	,[SysmonName] varchar (128)
	,[MediatorID] int
	,[MediatorName] varchar (128)
	,[Priority] int
);

Insert into SysMonToMedAssignment (
	[SysmonID]
	,[MediatorID]
	,[Priority]
)
		Select
		LogRhythmEMDB.dbo.SystemMonitorToMediator.SystemMonitorID as SysMonID
		,LogRhythmEMDB.dbo.SystemMonitorToMediator.MediatorID as MediatorID
		,LogRhythmEMDB.dbo.SystemMonitorToMediator.Priority as Priority
		from dbo.SystemMonitorToMediator
		
Select 	dbo.SysMonToMedAssignment.SysmonID, dbo.SystemMonitor.Name, dbo.SysMonToMedAssignment.MediatorID, dbo.Mediator.Name, dbo.SysMonToMedAssignment.Priority
From dbo.SysMonToMedAssignment
Join dbo.systemmonitor
on dbo.SysmontomedAssignment.SysMonID=SystemMonitor.SystemMonitorID
Join dbo.Mediator
on dbo.sysmontomedAssignment.MediatorID=dbo.Mediator.MediatorID
where dbo.SystemMonitor.Status=1

drop table SysMonToMedAssignment
GO