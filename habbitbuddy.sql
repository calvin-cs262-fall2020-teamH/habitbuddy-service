DROP TABLE IF EXISTS Buddies;
DROP TABLE IF EXISTS Habit;
DROP TABLE IF EXISTS User;


-- category will be an integer that we have mapped with a certain habit category
-- Contains basic general habit goal and the specific goal/ category
-- 1: School
-- 2: Exercise
-- 3: Leisure
-- 4: Spiritual
-- 5: Health
CREATE TABLE Habit (
	ID integer PRIMARY KEY, 
    userID integer REFERENCES User(ID)
	habit varchar(50) NOT NULL,
    category integer,
	);

-- Contains all user data including hobbies and the general habit goal, but not the specific category.
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
    habitGoal varchar(120),
    notifications boolean,
    theme varchar(6),
	);

--schema suggested in class, doesn't require buddy relationship to be two ways
-- Builds table pairing up buddies and habits. Users can be in the table more than once, allowing for multiple buddies.
--      Also allows for users to be with different habits, which could allow for multiple habits at once, should we decide to implement that. 
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

INSERT INTO User VALUES (1, 'Andrew', 'Baker', 'andrew@email.com', '(616)-123-1234', 'andba', 'password', '2020-08-22', 'https://th.bing.com/th/id/OIP.suYiHgQnIAH_48Q64UHAQAHaHa?pid=Api&rs=1', 'Reading', 'studying');
INSERT INTO User VALUES (2, 'Dawson', 'Buist', 'Dawson@email.com', '(616)-123-1234', 'dawbu', 'password', '2020-08-22', 'https://th.bing.com/th/id/OIP.suYiHgQnIAH_48Q64UHAQAHaHa?pid=Api&rs=1', 'Reading', 'studying');
INSERT INTO User VALUES (3, 'Joe', 'Pastucha', 'Joe@email.com', '(616)-123-1234', 'joepa', 'password', '2020-08-22', 'https://th.bing.com/th/id/OIP.suYiHgQnIAH_48Q64UHAQAHaHa?pid=Api&rs=1', 'Reading', 'studying');
INSERT INTO User VALUES (4, 'Belina', 'Sainju', 'Belina@email.com', '(616)-123-1234', 'belsa', 'password', '2020-08-22', 'https://th.bing.com/th/id/OIP.suYiHgQnIAH_48Q64UHAQAHaHa?pid=Api&rs=1', 'Reading', 'studying');
INSERT INTO User VALUES (5, 'Nathan', 'Strain', 'Nathan@email.com', '(616)-123-1234', 'natst', 'password', '2020-08-22', 'https://th.bing.com/th/id/OIP.suYiHgQnIAH_48Q64UHAQAHaHa?pid=Api&rs=1', 'Reading', 'studying');
INSERT INTO User VALUES (6, 'Kelsey', 'Yen', 'Kelsey@email.com', '(616)-123-1234', 'kelye', 'password', '2020-08-22', 'https://th.bing.com/th/id/OIP.suYiHgQnIAH_48Q64UHAQAHaHa?pid=Api&rs=1', 'Reading', 'studying');

INSERT INTO Habit VALUES (1, 'Study', 1);
INSERT INTO Habit VALUES (2, 'Work on Homework', 1);
INSERT INTO Habit VALUES (3, 'Run', 2);
INSERT INTO Habit VALUES (4, 'Lift', 2);
INSERT INTO Habit VALUES (5, 'Read', 3);
INSERT INTO Habit VALUES (6, 'Spend time with friends', 3);

INSERT INTO Buddies VALUES (1, 2, 1);
INSERT INTO Buddies VALUES (3, 5, 4);
INSERT INTO Buddies VALUES (4, 6, 5);
INSERT INTO Buddies VALUES (2, 1, 1);
INSERT INTO Buddies VALUES (5, 3, 3);
INSERT INTO Buddies VALUES (6, 4, 6);




