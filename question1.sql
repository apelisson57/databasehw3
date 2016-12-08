SET PROFILING = 1;

DROP VIEW IF EXISTS teamSalaries;
DROP VIEW IF EXISTS winningSalaries;
DROP VIEW IF EXISTS nonWinningSalaries;

CREATE VIEW teamSalaries AS
SELECT
yearID,
teamID,
sum(salary) teamSalary
FROM salaries
GROUP BY yearId, teamID;

SELECT winningSalaries.yearID as yearID, winningSalaries.winningSalary AS "Winning Team
Salary", nonWinningSalaries.nonWinningSalary AS "Average Team Salary"
FROM (
SELECT
teams.yearID,
teamSalary AS winningSalary
FROM teams, teamSalaries
WHERE
teams.yearID = teamSalaries.yearID AND
teams.teamID = teamSalaries.teamID AND
teams.WSWin = 'Y'
) winningSalaries, (
SELECT teams.yearID, AVG(teamSalary) AS nonWinningSalary
FROM teams, teamSalaries
WHERE
teams.yearID = teamSalaries.yearID AND
teams.teamID = teamSalaries.teamID
GROUP BY teams.yearID
) nonWinningSalaries
WHERE winningSalaries.yearID = nonWinningSalaries.yearID
;

SHOW PROFILES;