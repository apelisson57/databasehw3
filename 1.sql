-- SET PROFILING = 1;

-- CREATE INDEX team_index ON teams (yearID,teamID(6));
-- CREATE INDEX salary_index ON salaries (yearID,teamID(6));

DROP VIEW IF EXISTS teamSalaries;
DROP VIEW IF EXISTS total;

CREATE VIEW teamSalaries AS
SELECT
yearID,
teamID,
sum(salary) teamSalary
FROM salaries
GROUP BY yearId, teamID;

create view total AS
SELECT
teams.yearID AS yearID,
teamSalary , WSWin
FROM teams, teamSalaries
WHERE
teams.yearID = teamSalaries.yearID AND
teams.teamID = teamSalaries.teamID;




SELECT winningSalaries.yearID as yearID, winningSalaries.teamSalary AS "Winning Team
Salary", nonWinningSalaries.nonWinningSalary AS "Average Team Salary"
FROM (
SELECT total.yearID, teamSalary
FROM total
WHERE total.WSWin = 'Y'
) winningSalaries, (
SELECT total.yearID, AVG(teamSalary) AS nonWinningSalary
FROM total
GROUP BY total.yearID
) nonWinningSalaries
WHERE winningSalaries.yearID = nonWinningSalaries.yearID
;

-- DROP INDEX team_index ON teams;
-- DROP INDEX salary_index ON salaries;

-- SHOW PROFILES;