-- GET the IP Address of current Host
Declare @NodeTable TABLE(ClusterId INT, SearchRequestIP NVARCHAR(2000))
INSERT INTO @NodeTable
	Select ClusterID, 
	SearchRequestIP = (Case SearchRequestIP when '127.0.0.1' THEN HOST_NAME()
	ELSE SearchRequestIP
	END)
from NGPNode

UPDATE MsgSource
	SET RecordStatus = 0
where MsgSourceID IN(Select MsgSourceID from MsgSource where MsgSourceTypeID = 1000648)
AND MsgSourceID Not IN(Select MsgSourceID from MsgSource where HostID IN(
	Select hi.HostID from @NodeTable n 
	inner join HostIdentifier hi
	on n.SearchRequestIP = hi.Value) 
AND MsgSourceID IN(Select MsgSourceID from MsgSource where MsgSourceTypeID = 1000648))