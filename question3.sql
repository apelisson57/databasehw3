SET PROFILING = 1;


SELECT nameFirst, nameLast, totalAtBats, totalRuns, totalHits
FROM master JOIN (
SELECT
playerID,
sum(ab) totalAtBats,
sum(r) totalRuns,
sum(h) totalHits
FROM batting
GROUP BY playerID
) aggregateBatting ON (master.playerID = aggregateBatting.playerID)
WHERE birthYear > 1970 AND nameLast < 'N' AND totalRuns > 100
ORDER BY nameLast;

SHOW PROFILES;