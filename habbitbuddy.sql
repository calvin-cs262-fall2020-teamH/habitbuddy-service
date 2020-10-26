DROP TABLE IF EXISTS UserBuddy;
DROP TABLE IF EXISTS UserHabit;
DROP TABLE IF EXISTS Habit;
DROP TABLE IF EXISTS HabitCategory;
DROP TABLE IF EXISTS Username;


CREATE TABLE HabitCategory (
    category varchar(50) NOT NULL PRIMARY KEY
    );

CREATE TABLE Habit (
	ID integer PRIMARY KEY, 
	habit varchar(50) NOT NULL,
    category varchar(50) REFERENCES HabitCategory(category)
	);

CREATE TABLE Username (
	ID integer PRIMARY KEY, 
	emailAddress varchar(50),
    phone varchar(20),
	username varchar(50),
    dob date
	);

CREATE TABLE UserHabit (
    userID integer REFERENCES Username(ID),
    habitID integer REFERENCES Habit(ID),
    PRIMARY KEY (userID, habitID)
    );

--schema suggested in class, doesn't require buddy relationship to be two ways
CREATE TABLE UserBuddy (
    buddy1 integer REFERENCES Username(ID),
    buddy2 integer REFERENCES Username(ID),
    buddy1habitID integer REFERENCES Habit(ID),
    PRIMARY KEY (buddy1, buddy2, buddy1habitID)
    );

-- Allow users to select data from the tables.
GRANT SELECT ON HabitCategory TO PUBLIC;
GRANT SELECT ON Habit TO PUBLIC;
GRANT SELECT ON Username TO PUBLIC;
GRANT SELECT ON UserHabit TO PUBLIC;
GRANT SELECT ON UserBuddy TO PUBLIC;

INSERT INTO HabitCategory VALUES ('School');
INSERT INTO HabitCategory VALUES ('Exercise');
INSERT INTO HabitCategory VALUES ('Leisure');

INSERT INTO Username VALUES (1, 'andrew@email.com', '(616)-123-1234', 'Andrew', '2020-08-22');
INSERT INTO Username VALUES (2, 'Dawson@email.com', '(616)-123-1234', 'Dawson', '2020-08-22');
INSERT INTO Username VALUES (3, 'Joe@email.com', '(616)-123-1234', 'Joe', '2020-08-22');
INSERT INTO Username VALUES (4, 'Belina@email.com', '(616)-123-1234', 'Belina', '2020-08-22');
INSERT INTO Username VALUES (5, 'Nathan@email.com', '(616)-123-1234', 'Nathan', '2020-08-22');
INSERT INTO Username VALUES (6, 'Kelsey@email.com', '(616)-123-1234', 'Kelsey', '2020-08-22');

INSERT INTO Habit VALUES (1, 'Study', 'School');
INSERT INTO Habit VALUES (2, 'Work on Homework', 'School');
INSERT INTO Habit VALUES (3, 'Run', 'Exercise');
INSERT INTO Habit VALUES (4, 'Lift', 'Exercise');
INSERT INTO Habit VALUES (5, 'Read', 'Leisure');
INSERT INTO Habit VALUES (6, 'Spend time with friends', 'Leisure');

INSERT INTO UserHabit VALUES (1, 1);
INSERT INTO UserHabit VALUES (2, 1);
INSERT INTO UserHabit VALUES (3, 4);
INSERT INTO UserHabit VALUES (4, 5);
INSERT INTO UserHabit VALUES (5, 3);
INSERT INTO UserHabit VALUES (6, 6);

INSERT INTO UserBuddy VALUES (1, 2, 1);
INSERT INTO UserBuddy VALUES (3, 5, 4);
INSERT INTO UserBuddy VALUES (4, 6, 5);
INSERT INTO UserBuddy VALUES (2, 1, 1);
INSERT INTO UserBuddy VALUES (5, 3, 3);
INSERT INTO UserBuddy VALUES (6, 4, 6);




