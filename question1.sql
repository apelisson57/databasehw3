SET PROFILING = 1;

SELECT winningSalaries.yearID as yearID, winningSalaries.winningSalary AS "Winning Team
Salary", nonWinningSalaries.nonWinningSalary AS "Average Team Salary"
FROM (
SELECT
teams.yearID,
teamSalary AS winningSalary
FROM teams, (
SELECT
yearID,
teamID,
sum(salary) teamSalary
FROM salaries
GROUP BY yearId, teamID
) teamSalaries
WHERE
teams.yearID = teamSalaries.yearID AND
teams.teamID = teamSalaries.teamID AND
teams.WSWin = 'Y'
) winningSalaries, (
SELECT teams.yearID, AVG(teamSalary) AS nonWinningSalary
FROM teams, (
SELECT yearID, teamID, sum(salary) teamSalary
FROM salaries
GROUP BY yearId, teamID
) teamSalaries
WHERE
teams.yearID = teamSalaries.yearID AND
teams.teamID = teamSalaries.teamID
GROUP BY teams.yearID
) nonWinningSalaries
WHERE winningSalaries.yearID = nonWinningSalaries.yearID
;

SHOW PROFILES;