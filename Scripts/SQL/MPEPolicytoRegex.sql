/** 
Author: James Clair
Date: 3/23/18
Description: This script can be used to understand what MPE Rules and their associated Regex are 
assigned to which policy, tech, and source types.
**/

USE LogRhythmEMDB
GO

SELECT A.MPEPolicyID, A.[Name] AS PolicyName, A.MsgSourceTypeID, C.[Name] AS SourceTypeName, F.TechID, B.MPERuleID, D.MPERuleRegexID, D.[Name] AS MPERuleName, E.RegexTagged  FROM MPEPolicy A
	JOIN MPERuleToPolicy B ON A.MPEPolicyID = B.MPEPolicyID
	JOIN MsgSourceType C ON A.MsgSourceTypeID = C.MsgSourceTypeID
	JOIN MPERule D ON B.MPERuleID = D.MPERuleID
	JOIN MPERuleRegex E ON D.MPERuleRegexID = E.MPERuleRegexID
	JOIN MPERuleToTech F ON B.MPERuleID = F.MPERuleID
	--Remove comments on WHERE clause and enter your policy ID.
	--WHERE A.MPEPolicyID = 