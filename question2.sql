
SET PROFILING = 1;



DROP VIEW IF EXISTS tallPlayers;
DROP VIEW IF EXISTS moreThanFiveGames;

CREATE VIEW tallPlayers AS
SELECT playerID, nameFirst, nameLast
FROM master
WHERE height > 71;

CREATE VIEW moreThanFiveGames AS
SELECT playerID, POS, G
FROM fielding
WHERE G > 5;

-- CREATE INDEX player_key ON master(playerID);


SELECT nameFirst, nameLast, pos, games
FROM tallPlayers
INNER JOIN (
SELECT
playerID,
POS,
AVG(G) as games
FROM moreThanFiveGames
GROUP BY playerID, POS
HAVING avg(g) > 15
) positions ON (tallPlayers.playerID = positions.playerID);

-- DROP INDEX player_key ON master;

SHOW PROFILES;