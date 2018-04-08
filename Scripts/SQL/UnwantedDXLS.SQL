USE LogRhythmEMDB

UPDATE MsgSource
	SET RecordStatus = 0
where MsgSourceID IN(Select MsgSourceID from MsgSource where MsgSourceTypeID = 1000648)
AND MsgSourceID Not IN(Select MsgSourceID from MsgSource where HostID IN(
Select hi.HostID from NGPNode n 
inner join HostIdentifier hi
on n.SearchRequestIP = hi.Value)
AND MsgSourceID IN(Select MsgSourceID from MsgSource where MsgSourceTypeID = 1000648))

DECLARE @hName Varchar(100) = HOST_NAME()

IF EXISTS (Select 1 FROM NGPNode WHERE SearchRequestIP = '127.0.0.1')
BEGIN
	UPDATE MsgSource 
		SET RecordStatus = 1
	where HostID IN(Select mS.HostID from MsgSource mS, HostIdentifier hI where ms.HostID = hI.HostID AND hI.Value = @hName) AND MsgSourceTypeID = 1000648
END