--Written By: Andrew Baker
--Date: 10.27.20

--Queries to be used for various screens in the habbit buddy application
--NOT UP TO DATE WITH THE CURRENT SCHEMA. 

--Buddies
---NEED TO READ: list of buddies, details including firstName, lastName, habitGoal, habitCategory, hobby, email, profile url
---NEED TO WRITE: none
SELECT *
    FROM UserBuddy, Username, Habit, 

    ORDER BY username ASC

--Buddy Details
---NEED TO READ: At the moment this screen takes in data given to it from the buddies screen, so none for now
---NEED TO WRITE: None, possible delete?

-- SELECT 
--     FROM

--     ORDER BY 

--Edit Profile
---NEED TO READ: Current user data, firstName, lastName, habitGoal, habitCategory, hobby, email, profile url
---NEED TO WRITE: Everything from above
SELECT *
    FROM Username

    -- ORDER BY 

--Empty Habits 
---NEED TO READ: None
---NEED TO WRITE: habits, written specifically to the userprofile

SELECT 
    FROM

    ORDER BY 

--Empty Profile
---NEED TO READ: None
---NEED TO WRITE: Writing all user profile data. Similar to the edit profile. Current user data, firstName, lastName, habitGoal, habitCategory, hobby, email, profile url

SELECT 
    FROM

    ORDER BY 

--Habit Selector
---NEED TO READ: user data: HabitCategory
---NEED TO WRITE: None
SELECT 
    FROM 

    ORDER BY 

--Habit Tracker
---NEED TO READ: N/A
---NEED TO WRITE: N/A
SELECT *
    FROM Habit, UserHabit, HabitCategory, Username
    WHERE userID = Username.ID
        AND habitID = Habit.ID

--Home
---NEED TO READ: List of buddies, days of habits tracked, user's habit
---NEED TO WRITE: habit stacker information
SELECT habit, username, buddy1, buddy2
    FROM UserBuddy, Username, Habit, HabitCategory, UserHabit
    WHERE userID = Username.ID
        AND habitID = Habit.ID
        AND buddy1 != Username.ID
        AND buddy2 != Username.ID

--Login
---NEED TO READ: user data: username, password
---NEED TO WRITE: None
SELECT 
    FROM
    ORDER BY 

--Profile
---NEED TO READ: user data: firstName, lastName, habitGoal, habitCategory, hobby, email, profile url
---NEED TO WRITE: None
SELECT *
    FROM Username, Habit, UserHabit, HabitCategory
    WHERE userID = Username.ID
        AND habitID = Habit.ID
        AND username = ''   --Username of user
    

--Settings
---NEED TO READ: Current settings information? May be stored locally
---NEED TO WRITE: Same as above. 
SELECT 
    FROM

    ORDER BY 
