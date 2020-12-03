DROP TABLE IF EXISTS Buddies;
DROP TABLE IF EXISTS Habit;
DROP TABLE IF EXISTS HabitCategory;
DROP TABLE IF EXISTS UserTable;

--create a category so that we don't have to update app to
-- change the categories
CREATE TABLE HabitCategory (
    category varchar(50) NOT NULL PRIMARY KEY
    );

-- Contains all user data including hobbies and the general habit goal, but not the specific category.
CREATE TABLE UserTable (
	ID SERIAL PRIMARY KEY,
    firstName varchar(15),
    lastName varchar(15),
	emailAddress varchar(50) NOT NULL,
    phone varchar(20) NOT NULL,
	username varchar(50) NOT NULL,
    password varchar(20) NOT NULL,
    profileURL varchar(300) NOT NULL,
    hobby varchar(120),
    totalBuddies integer,
    streak integer,
	);

CREATE TABLE Habit (
	ID SERIAL PRIMARY KEY,
	userID integer REFERENCES UserTable(ID),
	habit varchar(50) NOT NULL,
    category varchar(50) REFERENCES HabitCategory(category)
	);

--schema suggested in class, doesn't require buddy relationship to be two ways
-- Builds table pairing up buddies and habits. Users can be in the table more than once, allowing for multiple buddies.
--      Also allows for users to be with different habits, which could allow for multiple habits at once, should we decide to implement that.
CREATE TABLE Buddies (
    buddy1 integer REFERENCES UserTable(ID),
    buddy2 integer REFERENCES UserTable(ID),
    buddy1HabitID integer REFERENCES Habit(ID),
    buddy2HabitID integer REFERENCES Habit(ID),
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
INSERT INTO HabitCategory VALUES ('Health');
INSERT INTO HabitCategory VALUES ('Spiritual');

INSERT INTO UserTable(firstName, lastName, emailAddress, phone, username, password, profileURL, hobby, totalBuddies, streak) VALUES ('Andrew', 'Baker', 'andrew@email.com', '(616)-123-1234', 'andba', 'password', '2020-08-22', 'https://scontent-ort2-2.xx.fbcdn.net/v/t1.0-9/59745462_102655627622924_4862557033871704064_o.jpg?_nc_cat=109&ccb=2&_nc_sid=09cbfe&_nc_ohc=ET9UNrS141EAX_2jGtR&_nc_ht=scontent-ort2-2.xx&oh=994cc5b7cf569e9e9791c019efabc7c6&oe=5FCAC2E0', 'Reading', 'studying', 3, 0, false, 'light');
INSERT INTO UserTable(firstName, lastName, emailAddress, phone, username, password, profileURL, hobby, totalBuddies, streak) VALUES ('Dawson', 'Buist', 'Dawson@email.com', '(616)-123-1234', 'dawbu', 'password', '2020-08-22', 'https://scontent-ort2-2.xx.fbcdn.net/v/t1.0-9/104948192_4184601054913338_953146845638702540_n.jpg?_nc_cat=104&ccb=2&_nc_sid=09cbfe&_nc_ohc=7hwMelyT4SUAX9Bp9C0&_nc_ht=scontent-ort2-2.xx&oh=d51a7304d76517e63252d30b02fdb9e4&oe=5FC86C3A', 'Playing Video Games', 'studying', 1, 0, false, 'light');
INSERT INTO UserTable(firstName, lastName, emailAddress, phone, username, password, profileURL, hobby, totalBuddies, streak) VALUES ('Joe', 'Pastucha', 'Joe@email.com', '(616)-123-1234', 'joepa', 'password', '2020-08-22', 'https://scontent-ort2-2.xx.fbcdn.net/v/t1.0-9/49411157_2482634981749821_1257420489870016512_o.jpg?_nc_cat=108&ccb=2&_nc_sid=09cbfe&_nc_ohc=VpIkl5ZG6WwAX-oBa9c&_nc_ht=scontent-ort2-2.xx&oh=89e58d115252bffe32dc7fa71a09a703&oe=5FC99EE5', 'Snow Boarding', 'Reading', 1, 0, false, 'light');
INSERT INTO UserTable(firstName, lastName, emailAddress, phone, username, password, profileURL, hobby, totalBuddies, streak) VALUES ('Belina', 'Sainju', 'Belina@email.com', '(616)-123-1234', 'belsa', 'password', '2020-08-22', 'https://scontent-ort2-2.xx.fbcdn.net/v/t1.0-9/94386001_3052697268125747_8543896262028558336_o.jpg?_nc_cat=108&ccb=2&_nc_sid=09cbfe&_nc_ohc=HB2iMgmeyiMAX-xH8b0&_nc_ht=scontent-ort2-2.xx&oh=80085c34f488d26877a9d5e5cebc7074&oe=5FC74D3E', 'Reading', 'studying', 1, 0, false, 'light');
INSERT INTO UserTable(firstName, lastName, emailAddress, phone, username, password, profileURL, hobby, totalBuddies, streak) VALUES ('Nathan', 'Strain', 'Nathan@email.com', '(616)-123-1234', 'natst', 'password', '2020-08-22', 'https://moodle.calvin.edu/pluginfile.php/1229007/user/icon/fordson/f1?rev=42095108', 'Reading', 'studying', 1, 0, false, 'light');
INSERT INTO UserTable(firstName, lastName, emailAddress, phone, username, password, profileURL, hobby, totalBuddies, streak) VALUES ('Kelsey', 'Yen', 'Kelsey@email.com', '(616)-123-1234', 'kelye', 'password', '2020-08-22', 'https://scontent-ort2-2.xx.fbcdn.net/v/t1.0-9/48361196_2323280584559505_806143671874355200_n.jpg?_nc_cat=109&ccb=2&_nc_sid=09cbfe&_nc_ohc=Vsd6KMQHRwoAX8Jwzit&_nc_ht=scontent-ort2-2.xx&oh=b0df354626d6db23c6e2d011ca9c7171&oe=5FC87E95', 'Reading', 'studying', 1, 0, false, 'light');


INSERT INTO Habit(userID, habit, category) VALUES (1, 'Study', 'School');
INSERT INTO Habit(userID, habit, category) VALUES (2, 'Work on Homework', 'School');
INSERT INTO Habit(userID, habit, category) VALUES (3, 'Run', 'Exercise');
INSERT INTO Habit(userID, habit, category) VALUES (4, 'Lift', 'Exercise');
INSERT INTO Habit(userID, habit, category) VALUES (5, 'Read', 'Leisure');
INSERT INTO Habit(userID, habit, category) VALUES (6, 'Spend time with friends', 'Leisure');

INSERT INTO Buddies VALUES (1, 2, 1, 2);
INSERT INTO Buddies VALUES (3, 5, 3, 5);
INSERT INTO Buddies VALUES (4, 6, 4, 6);
INSERT INTO Buddies VALUES (2, 1, 2, 1);
INSERT INTO Buddies VALUES (5, 3, 5, 3);
INSERT INTO Buddies VALUES (6, 4, 6, 4);
INSERT INTO Buddies VALUES (1, 3, 1, 3);
INSERT INTO Buddies VALUES (1, 6, 1, 6);


INSERT INTO UserTable(firstName, lastName, emailAddress, phone, username, password, profileURL, hobby, totalBuddies, streak) VALUES ('Sample', 'user', 'sample@email.com', '(616)-123-1234', 'sample', 'password', '2020-08-22', 'https://th.bing.com/th/id/OIP.K6XYBPwgLPhvWH9BxDYfXAHaEN?pid=Api&rs=1', 'Reading', 'Study for 1 hour', 3, 0, false, 'light');
INSERT INTO Habit(userID, habit, category) VALUES (7, 'Study', 'School');
INSERT INTO Buddies VALUES (7, 1, 7, 1);
INSERT INTO Buddies VALUES (7, 2, 7, 2);
INSERT INTO Buddies VALUES (7, 3, 7, 3);
