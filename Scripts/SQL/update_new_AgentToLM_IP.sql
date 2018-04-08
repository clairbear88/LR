USE LogRhythmEMDB
GO
update a
set a.ClientAddress = b.ClientAddress
from [LogRhythmEMDB].[dbo].[SystemMonitorToMediator] a, [LogRhythmEMDB].[dbo].[SystemMonitorToMediator] b
where a.ClientAddress like 0 and b.ClientAddress not like 0 and a.SystemMonitorID = b.SystemMonitorID
