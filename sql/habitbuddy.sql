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
	username varchar(50) NOT NULL UNIQUE,
    password varchar(20) NOT NULL,
    profileURL varchar(300) NOT NULL,
    hobby varchar(120),
    totalBuddies integer,
    streak integer
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

INSERT INTO UserTable(firstName, lastName, emailAddress, phone, username, password, profileURL, hobby, totalBuddies, streak) VALUES ('Andrew', 'Baker', 'andbaker99@gmail.com', '(765)-667-5640', 'andba', 'password', 'https://i.imgur.com/SKHwTiF.jpg', 'Reading Science Fiction', 3, 4);
INSERT INTO UserTable(firstName, lastName, emailAddress, phone, username, password, profileURL, hobby, totalBuddies, streak) VALUES ('Dawson', 'Buist', 'Dawson@email.com', '(616)-123-1234', 'dawbu', 'password', 'https://i.imgur.com/SxGCXta.png', 'Playing Video Games', 1, 0);
INSERT INTO UserTable(firstName, lastName, emailAddress, phone, username, password, profileURL, hobby, totalBuddies, streak) VALUES ('Joe', 'Pastucha', 'Joe@email.com', '(616)-123-1234', 'joepa', 'password', 'https://i.imgur.com/NORjyKE.png', 'Snow Boarding', 1, 0);
INSERT INTO UserTable(firstName, lastName, emailAddress, phone, username, password, profileURL, hobby, totalBuddies, streak) VALUES ('Belina', 'Sainju', 'Belina@email.com', '(616)-123-1234', 'belsa', 'password', 'https://i.imgur.com/hWfU2ej.jpg', 'Reading', 1, 0);
INSERT INTO UserTable(firstName, lastName, emailAddress, phone, username, password, profileURL, hobby, totalBuddies, streak) VALUES ('Nathan', 'Strain', 'Nathan@email.com', '(616)-123-1234', 'natst', 'password', 'https://moodle.calvin.edu/pluginfile.php/1229007/user/icon/fordson/f1?rev=42095108', 'Reading', 1, 0);
INSERT INTO UserTable(firstName, lastName, emailAddress, phone, username, password, profileURL, hobby, totalBuddies, streak) VALUES ('Kelsey', 'Yen', 'Kelsey@email.com', '(616)-123-1234', 'kelye', 'password', 'https://i.imgur.com/go0Wgd9.png', 'Reading', 1, 0);


INSERT INTO Habit(userID, habit, category) VALUES (1, 'Run a mile each day', 'Exercise');
INSERT INTO Habit(userID, habit, category) VALUES (2, 'Doing 100 pushups a day', 'Exercise');
INSERT INTO Habit(userID, habit, category) VALUES (3, 'Running a mile every two days', 'Exercise');
INSERT INTO Habit(userID, habit, category) VALUES (4, 'Taking a 30 minute nap each day', 'Leisure');
INSERT INTO Habit(userID, habit, category) VALUES (5, 'Watching movies from the AFI 100', 'Leisure');
INSERT INTO Habit(userID, habit, category) VALUES (6, 'Studying for CS262', 'Leisure');

INSERT INTO Buddies VALUES (1, 2, 1, 2);
INSERT INTO Buddies VALUES (1, 3, 1, 3);
INSERT INTO Buddies VALUES (1, 6, 1, 6);
-- INSERT INTO Buddies VALUES (2, 1, 2, 1);
INSERT INTO Buddies VALUES (2, 3, 2, 3);
-- INSERT INTO Buddies VALUES (3, 1, 3, 1);
-- INSERT INTO Buddies VALUES (3, 2, 3, 1);
INSERT INTO Buddies VALUES (4, 5, 4, 5);
-- INSERT INTO Buddies VALUES (5, 4, 5, 4);
-- INSERT INTO Buddies VALUES (5, 6, 5, 6);
-- INSERT INTO Buddies VALUES (6, 4, 6, 4);
INSERT INTO Buddies VALUES (6, 5, 6, 5);
