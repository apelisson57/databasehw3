create index index_name1 on teams (yearID,teamID(6));
create index index_name2 on salaries (yearID,teamID(6));

create view teamSalaries
 AS
	SELECT
	yearID,
	teamID,
	sum(salary) teamSalary
	FROM salaries
	GROUP BY yearId, teamID;

create view total as
	SELECT
	teams.yearID as yearID,
	teamSalary , WSWin
	FROM teams, teamSalaries
	WHERE
	teams.yearID = teamSalaries.yearID AND
	teams.teamID = teamSalaries.teamID;




SELECT winningSalaries.yearID as yearID, winningSalaries.teamSalary AS "Winning Team
Salary", nonWinningSalaries.nonWinningSalary AS "Average Team Salary"
FROM (
SELECT
total.yearID,
teamSalary FROM
total where
total.WSWin = 'Y'
) winningSalaries, (
SELECT total.yearID, AVG(teamSalary) AS nonWinningSalary
FROM total
GROUP BY total.yearID
) nonWinningSalaries
WHERE winningSalaries.yearID = nonWinningSalaries.yearID
;