-- Get the Entity ID for the Entity name
select * from dbo.Entity where Name = 'Primary Site'

-- Get the Host ID's for the Entity
select * from dbo.Host where EntityID = 1

-- The following must be done for each host returned from dbo.Host
select * from dbo.MsgSource where HostID = -1000002

-- MsgSourceID from previous query
select * from dbo.UserProfileLSPerm where MsgSourceID = -1000002

-- Same HostID as above
select * from dbo.SystemMonitor where HostID = -1000002

-- SystemMonitorID from previous query
select * from dbo.SMSNMPV3Credential where SystemMonitorID = -1000002

-- Replace MsgSourceID, HostID, SystemMonitorID, and EntityID with values from previous queries & execute the following:
delete dbo.UserProfileLSPerm where MsgSourceID = -1000002
delete dbo.AIEEngineToMsgSource where MsgSourceID = -1000002
delete dbo.MsgSource where HostID = -1000002
delete dbo.SMSNMPV3Credential where SystemMonitorID = -1000002
delete dbo.SystemMonitor where HostID = -1000002
delete dbo.Host where EntityID = 1



