USE stats;
SET PROFILING = 1;

SELECT nameFirst, nameLast, pos, games
FROM master join (
SELECT
playerID,
POS,
AVG(G) as games
FROM fielding
WHERE G > 5
GROUP BY playerID, POS
HAVING avg(g) > 15
) positions ON (master.playerID = positions.playerID)
WHERE height > 71;

SHOW PROFILES;