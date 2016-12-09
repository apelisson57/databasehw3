-- SET PROFILING = 1;


CREATE INDEX batting_index ON batting (playerID(6));

CREATE INDEX player_index2 ON master (playerID(6));

DROP VIEW IF EXISTS special_master;
DROP VIEW IF EXISTS aggregateBatting;

CREATE VIEW special_master AS
SELECT playerID, nameFirst, nameLast
FROM master 
WHERE birthYear > 1970 AND nameLast < 'N';

CREATE VIEW aggregateBatting AS
SELECT
playerID,
sum(ab) totalAtBats,
sum(r) totalRuns,
sum(h) totalHits
FROM batting
GROUP BY playerID
HAVING totalRuns > 100;

SELECT nameFirst, nameLast, totalAtBats, totalRuns, totalHits
FROM special_master 
INNER JOIN aggregateBatting ON (special_master.playerID = aggregateBatting.playerID)
ORDER BY nameLast;

DROP INDEX batting_index ON batting;
DROP INDEX player_index2 ON master;

-- SHOW PROFILES;