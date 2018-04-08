SELECT DISTINCT t1.MPEPolicyID, t1.TotalRules, t2.EnabledRules, (t1.TotalRules - t2.EnabledRules) AS DisabledRules
FROM (Select DISTINCT P.MPEPolicyID, COUNT(R.MPERuleID) AS TotalRules FROM MPERuleToMsgSourceType MST 
JOIN MPERule R on MST.MPERuleRegexID = R.MPERuleRegexID JOIN MPEPolicy P on MST.MsgSourceTypeID = P.MsgSourceTypeID 
Group by P.MPEPolicyID) t1 JOIN 
(Select distinct RtP.MPEPolicyID, COUNT(RtP.MPERuleID) AS EnabledRules FROM [MPERuleToPolicy] RtP Group by RtP.MPEPolicyID) t2 ON t1.MPEPolicyID = t2.MPEPolicyID
