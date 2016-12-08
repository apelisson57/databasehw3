SET PROFILING = 1;



DROP VIEW IF EXISTS aggregateBatting;

-- DROP INDEX birth_year ON master;

-- CREATE INDEX birth_year ON master(birthYear);

CREATE VIEW aggregateBatting AS
SELECT
playerID,
sum(ab) totalAtBats,
sum(r) totalRuns,
sum(h) totalHits
FROM batting
GROUP BY playerID;



-- DROP INDEX total_runs ON aggregateBatting;

-- CREATE INDEX total_runs ON aggregateBatting(total_runs);

SELECT nameFirst, nameLast, totalAtBats, totalRuns, totalHits
FROM master
JOIN aggregateBatting ON (master.playerID = aggregateBatting.playerID)
WHERE birthYear > 1970 AND nameLast < 'N' AND totalRuns > 100
ORDER BY nameLast;

SHOW PROFILES;