--Written By: Andrew Baker
--Date: 10.27.20

--Queries to be used for various screens in the habbit buddy application
--NOT UP TO DATE WITH THE CURRENT SCHEMA. 

--Buddies: This functions completely YESSSSSS!
---NEED TO READ: list of buddies, details including firstName, lastName, habitGoal, habitCategory, hobby, email, profile url
---NEED TO WRITE: none
SELECT firstName, lastName, emailAddress, phone, profileURL, hobby, habitGoal, streak
    FROM UserTable, Buddies, Habit
    WHERE buddy1=${id}
        AND buddy2 = UserTable.ID
        AND buddy1HabitID = Habit.ID
    ORDER BY lastName ASC

--Edit Profile
---NEED TO READ: Current user data, firstName, lastName, habitGoal, habitCategory, hobby, email, profile url
---NEED TO WRITE: Everything from above
SELECT firstName, lastName, emailAddress, phone, profileURL, hobby, habitGoal, 
    FROM UserTable
    WHERE ID = ${req.params.ID}

UPDATE UserTable
    SET firstName=$(),                      --UPDATE
        lastName=$(),                       --UPDATE
        emailAddress=$(),                   --UPDATE
        phone=$(),                          --UPDATE
        username=$(username),
        password=$(password),
        dob=$(),                            --UPDATE
        profileURL=$(),                     --UPDATE
        hobby=$(),                          --UPDATE
        habitGoal=$(),                      --UPDATE
        notifications=$(notifications),
        theme=$(theme)

    WHERE ID = ${req.params.ID}

--Empty Habits 
---NEED TO READ: None
---NEED TO WRITE: habits, written specifically to the userprofile

UPDATE UserTable
    SET firstName=$(firstName),
        lastName=$(lastName),
        emailAddress=$(emailAddress),
        phone=$(phone),
        username=$(username),
        password=$(password),
        dob=$(dob),
        profileURL=$(profileURL),
        hobby=$(hobby),
        habitGoal=$(),                      --UPDATE
        notifications=$(notifications),
        theme=$(theme)

    WHERE ID = ${req.params.ID}


--Empty Profile
---NEED TO READ: None
---NEED TO WRITE: Writing all user profile data. Similar to the edit profile. Current user data, firstName, lastName, habitGoal, habitCategory, hobby, email, profile url

UPDATE UserTable
    SET firstName=$(),                      --UPDATE
        lastName=$(),                       --UPDATE
        emailAddress=$(),                   --UPDATE
        phone=$(),                          --UPDATE
        username=$(username),
        password=$(password),
        dob=$(),                            --UPDATE
        profileURL=$(),                     --UPDATE
        hobby=$(),                          --UPDATE
        habitGoal=$(),                      --UPDATE
        notifications=$(notifications),
        theme=$(theme)

    WHERE ID = ${req.params.ID}

--Habit Tracker
---NEED TO READ: N/A
---NEED TO WRITE: N/A
SELECT *
    FROM 
    WHERE 

-- Home
---NEED TO READ: List of buddies, days of habits tracked, user's habit
---NEED TO WRITE: habit stacker information
SELECT habit, firstName, lastName, totalBuddies, streak
    FROM UserTable, Habit
    WHERE UserTable.ID=${id}
        AND Habit.ID = UserTable.ID

--Login
---NEED TO READ: user data: username, password
---NEED TO WRITE: None, maybe create user upon sign up 
SELECT username, password
    FROM UserTable
    WHERE ID = ${req.params.ID}

INSERT INTO UserTable VALUES ($(ID), $(firstName), $(lastName), $(emailAddress), $(phone), $(username), $(password), $(dob), $(profileURL), $(hobby), $(habitGoal), true, 'light')


--Profile
---NEED TO READ: user data: firstName, lastName, habitGoal, habitCategory, hobby, email, profile url
---NEED TO WRITE: None
SELECT UserTable.firstName, lastName, emailAddress, phone, profileURL, hobby, habitGoal, habit, category, totalBuddies, streak
    FROM UserTable, Habit
    WHERE UserTable.ID=${id}
        AND Habit.userID = UserTable.ID
        
--Settings: NOT FINISHED, NEED PARAM STUFF
---NEED TO READ: Current settings information? May be stored locally
---NEED TO WRITE: Same as above. 
SELECT password, notifications, theme
    FROM UserTable
    WHERE ID = ${req.params.ID}