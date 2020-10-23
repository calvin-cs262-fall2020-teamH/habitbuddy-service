DROP TABLE IF EXISTS UserBuddy;
DROP TABLE IF EXISTS UserHabbit;
DROP TABLE IF EXISTS Habbit;
DROP TABLE IF EXISTS HabbitCategory;
DROP TABLE IF EXISTS Username;


CREATE TABLE HabbitCategory (
    ID integer PRIMARY KEY,
    category varchar(50) NOT NULL
    );

CREATE TABLE Habbit (
	ID integer PRIMARY KEY, 
	habbit varchar(50) NOT NULL,
    category integer REFERENCES HabbitCategory(id)
	);

CREATE TABLE Username (
	ID integer PRIMARY KEY, 
	emailAddress varchar(50),
    phone varchar(20),
	username varchar(50),
    dob date
	);

CREATE TABLE UserHabbit (
    userID integer REFERENCES Username(ID),
    habbitID integer REFERENCES Habbit(ID),
    PRIMARY KEY (userID, habbitID)
    );

-- I don't like this table, feels akward but I think it works, will think about how to do it better
-- problems:
--      want to only have one entry for a pair of buddies
--      want user to be able to have multiple buddies for same habbit?
--      want to be able to find specific user and habit to show buddies
--          with this table this requires two queries I think (one to search buddy1 + habit1 and one to search buddy2 + habbit2)
CREATE TABLE UserBuddy (
    buddy1 integer REFERENCES Username(ID),
    buddy2 integer REFERENCES Username(ID),
    buddy1habbitID integer REFERENCES Habbit(ID),
    buddy2habbitID integer REFERENCES Habbit(ID),
    PRIMARY KEY (buddy1, buddy2, buddy1habbitID, buddy2habbitID)
    );

-- Allow users to select data from the tables.
GRANT SELECT ON HabbitCategory TO PUBLIC;
GRANT SELECT ON Habbit TO PUBLIC;
GRANT SELECT ON Username TO PUBLIC;
GRANT SELECT ON UserHabbit TO PUBLIC;
GRANT SELECT ON UserBuddy TO PUBLIC;

INSERT INTO HabbitCategory VALUES (1, 'School');
INSERT INTO HabbitCategory VALUES (2, 'Exercise');
INSERT INTO HabbitCategory VALUES (3, 'Leisure');

INSERT INTO Habbit VALUES (1, 'Study', 1);
INSERT INTO Habbit VALUES (2, 'Work on Homework', 1);
INSERT INTO Habbit VALUES (3, 'Run', 2);
INSERT INTO Habbit VALUES (4, 'Lift', 2);
INSERT INTO Habbit VALUES (5, 'Read', 3);
INSERT INTO Habbit VALUES (6, 'Spend time with friends', 3);

INSERT INTO Username VALUES (1, 'andrew@email.com', '(616)-123-1234', 'Andrew', '2020-08-22');
INSERT INTO Username VALUES (2, 'Dawson@email.com', '(616)-123-1234', 'Dawson', '2020-08-22');
INSERT INTO Username VALUES (3, 'Joe@email.com', '(616)-123-1234', 'Joe', '2020-08-22');
INSERT INTO Username VALUES (4, 'Belina@email.com', '(616)-123-1234', 'Belina', '2020-08-22');
INSERT INTO Username VALUES (5, 'Nathan@email.com', '(616)-123-1234', 'Nathan', '2020-08-22');
INSERT INTO Username VALUES (6, 'Kelsey@email.com', '(616)-123-1234', 'Kelsey', '2020-08-22');

INSERT INTO UserHabbit VALUES (1, 1);
INSERT INTO UserHabbit VALUES (2, 1);
INSERT INTO UserHabbit VALUES (3, 4);
INSERT INTO UserHabbit VALUES (4, 5);
INSERT INTO UserHabbit VALUES (5, 3);
INSERT INTO UserHabbit VALUES (6, 6);

INSERT INTO UserBuddy VALUES (1, 2, 1, 1);
INSERT INTO UserBuddy VALUES (3, 5, 4, 3);
INSERT INTO UserBuddy VALUES (4, 6, 5, 6);




