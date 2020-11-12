DROP TABLE IF EXISTS Buddies;
DROP TABLE IF EXISTS Habit;
DROP TABLE IF EXISTS HabitCategory;
DROP TABLE IF EXISTS UserTable;

--create a category so that we don't have to update app to
-- change the categories
CREATE TABLE HabitCategory (
    category varchar(50) NOT NULL PRIMARY KEY
    );

CREATE TABLE Habit (
	ID integer PRIMARY KEY, 
	habit varchar(50) NOT NULL,
    category varchar(50) REFERENCES HabitCategory(category)
	);

-- Contains all user data including hobbies and the general habit goal, but not the specific category.
CREATE TABLE UserTable (
	ID integer PRIMARY KEY,
    firstName varchar(15),
    lastName varchar(15),
	emailAddress varchar(50) NOT NULL,
    phone varchar(20) NOT NULL,
	username varchar(50) NOT NULL,
    password varchar(20) NOT NULL,
    dob date,
    profileURL varchar(200) NOT NULL,
    hobby varchar(120),
    habitGoal varchar(120),
    notifications boolean,
    theme varchar(6)
	);

--schema suggested in class, doesn't require buddy relationship to be two ways
-- Builds table pairing up buddies and habits. Users can be in the table more than once, allowing for multiple buddies.
--      Also allows for users to be with different habits, which could allow for multiple habits at once, should we decide to implement that. 
CREATE TABLE Buddies (
    buddy1 integer REFERENCES UserTable(ID),
    buddy2 integer REFERENCES UserTable(ID),
    buddy1HabitID integer REFERENCES Habit(ID),
    PRIMARY KEY (buddy1, buddy2, buddy1HabitID)
    );

-- Allow users to select data from the tables.
GRANT SELECT ON Habit TO PUBLIC;
GRANT SELECT ON UserTable TO PUBLIC;
GRANT SELECT ON Buddies TO PUBLIC;
GRANT SELECT ON HabitCategory TO PUBLIC;

INSERT INTO HabitCategory VALUES ('School');
INSERT INTO HabitCategory VALUES ('Exercise');
INSERT INTO HabitCategory VALUES ('Leisure');

INSERT INTO UserTable VALUES (1, 'Andrew', 'Baker', 'andrew@email.com', '(616)-123-1234', 'andba', 'password', '2020-08-22', 'https://th.bing.com/th/id/OIP.suYiHgQnIAH_48Q64UHAQAHaHa?pid=Api&rs=1', 'Reading', 'studying', false, 'light');
INSERT INTO UserTable VALUES (2, 'Dawson', 'Buist', 'Dawson@email.com', '(616)-123-1234', 'dawbu', 'password', '2020-08-22', 'https://th.bing.com/th/id/OIP.suYiHgQnIAH_48Q64UHAQAHaHa?pid=Api&rs=1', 'Reading', 'studying', false, 'light');
INSERT INTO UserTable VALUES (3, 'Joe', 'Pastucha', 'Joe@email.com', '(616)-123-1234', 'joepa', 'password', '2020-08-22', 'https://th.bing.com/th/id/OIP.suYiHgQnIAH_48Q64UHAQAHaHa?pid=Api&rs=1', 'Reading', 'studying', false, 'light');
INSERT INTO UserTable VALUES (4, 'Belina', 'Sainju', 'Belina@email.com', '(616)-123-1234', 'belsa', 'password', '2020-08-22', 'https://th.bing.com/th/id/OIP.suYiHgQnIAH_48Q64UHAQAHaHa?pid=Api&rs=1', 'Reading', 'studying', false, 'light');
INSERT INTO UserTable VALUES (5, 'Nathan', 'Strain', 'Nathan@email.com', '(616)-123-1234', 'natst', 'password', '2020-08-22', 'https://th.bing.com/th/id/OIP.suYiHgQnIAH_48Q64UHAQAHaHa?pid=Api&rs=1', 'Reading', 'studying', false, 'light');
INSERT INTO UserTable VALUES (6, 'Kelsey', 'Yen', 'Kelsey@email.com', '(616)-123-1234', 'kelye', 'password', '2020-08-22', 'https://th.bing.com/th/id/OIP.suYiHgQnIAH_48Q64UHAQAHaHa?pid=Api&rs=1', 'Reading', 'studying', false, 'light');

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