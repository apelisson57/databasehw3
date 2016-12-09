CREATE INDEX index_name3
ON batting (playerID(6));

CREATE INDEX index_name4
ON master (playerID(6));

create view special_master
	as select playerID, nameFirst, nameLast
	from master 
	where birthYear > 1970 and nameLast < 'N';


SELECT nameFirst, nameLast, totalAtBats, totalRuns, totalHits
FROM special_master JOIN (
SELECT
playerID,
sum(ab) totalAtBats,
sum(r) totalRuns,
sum(h) totalHits
FROM batting
GROUP BY playerID
) aggregateBatting ON (special_master.playerID = aggregateBatting.playerID)
WHERE totalRuns > 100
ORDER BY nameLast;