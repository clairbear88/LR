USE LogRhythmEMDB
Create table KBtoObjectMap (
	[KBModuleID] int
	,[KBName] varchar (128)
	,[ObjectID] int
	,[ObjectName] varchar (128)
	,[ObjectType] int
);

Insert into KBtoObjectMap (
	[KBModuleID]
	,[ObjectID]
)
		Select
		dbo.KBModuleToKBModuleObject.KBModuleID as KBModuleID
		,dbo.KBModuleToKBModuleObject.KBModuleObjectID as ObjectID
		from LogRhythmEMDB.dbo.KBModuleToKBModuleObject
;
Select 	dbo.KBtoObjectMap.KBModuleID, dbo.KBModule.Name, dbo.KBtoObjectMap.ObjectID, dbo.KBModuleObject.Name, dbo.KBModuleObject.ObjectType
From dbo.KBtoObjectMap
Join dbo.KBModule
on dbo.KBtoObjectMap.KBModuleID=dbo.KBModule.KBModuleID
Join dbo.KBModuleObject
on dbo.KBtoObjectMap.ObjectID=dbo.KBModuleObject.ObjectID
;
drop table KBtoObjectMap
GO