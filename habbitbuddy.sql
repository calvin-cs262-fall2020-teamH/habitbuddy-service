DROP TABLE IF EXISTS Buddies;
DROP TABLE IF EXISTS Habit;
DROP TABLE IF EXISTS User;


-- category will be an integer that we have mapped with a certain habit category
-- 1: School
-- 2: Exercise
-- 3: Leisure
-- 4: Spiritual
-- 5: Health
CREATE TABLE Habit (
	ID integer PRIMARY KEY, 
	habit varchar(50) NOT NULL,
    category integer,
	);

CREATE TABLE User (
	ID integer PRIMARY KEY,
    firstName varchar(15),
    lastName varchar(15),
	emailAddress varchar(50),
    phone varchar(20),
	username varchar(50),
    password varchar(20),
    dob date,
    profileURL varchar(200),
    hobby varchar(120),

	);

--schema suggested in class, doesn't require buddy relationship to be two ways
CREATE TABLE Buddies (
    buddy1 integer REFERENCES User(ID),
    buddy2 integer REFERENCES User(ID),
    buddyHabitID integer REFERENCES Habit(ID),
    PRIMARY KEY (buddy1, buddy2, buddy1habitID)
    );

-- Allow users to select data from the tables.
GRANT SELECT ON Habit TO PUBLIC;
GRANT SELECT ON User TO PUBLIC;
GRANT SELECT ON Buddies TO PUBLIC;

INSERT INTO User VALUES (1, 'andrew@email.com', '(616)-123-1234', 'Andrew', '2020-08-22');
INSERT INTO User VALUES (2, 'Dawson@email.com', '(616)-123-1234', 'Dawson', '2020-08-22');
INSERT INTO User VALUES (3, 'Joe@email.com', '(616)-123-1234', 'Joe', '2020-08-22');
INSERT INTO User VALUES (4, 'Belina@email.com', '(616)-123-1234', 'Belina', '2020-08-22');
INSERT INTO User VALUES (5, 'Nathan@email.com', '(616)-123-1234', 'Nathan', '2020-08-22');
INSERT INTO User VALUES (6, 'Kelsey@email.com', '(616)-123-1234', 'Kelsey', '2020-08-22');

INSERT INTO Habit VALUES (1, 'Study', 'School');
INSERT INTO Habit VALUES (2, 'Work on Homework', 'School');
INSERT INTO Habit VALUES (3, 'Run', 'Exercise');
INSERT INTO Habit VALUES (4, 'Lift', 'Exercise');
INSERT INTO Habit VALUES (5, 'Read', 'Leisure');
INSERT INTO Habit VALUES (6, 'Spend time with friends', 'Leisure');

INSERT INTO Buddies VALUES (1, 2, 1);
INSERT INTO Buddies VALUES (3, 5, 4);
INSERT INTO Buddies VALUES (4, 6, 5);
INSERT INTO Buddies VALUES (2, 1, 1);
INSERT INTO Buddies VALUES (5, 3, 3);
INSERT INTO Buddies VALUES (6, 4, 6);




