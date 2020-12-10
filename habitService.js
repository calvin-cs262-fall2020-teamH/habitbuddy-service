/**
 * The database is hosted on ElephantSQL.
 *
 *
 * @author: Andrew Baker, Nathan Strain
 * @date: Fall, 2020
 */

// Set up the database connection.

const pgp = require('pg-promise')();
const db = pgp({
    host: "lallah.db.elephantsql.com",
    port: 5432,
    database: process.env.USER,
    user: process.env.USER,
    password: process.env.PASSWORD
});

const {PreparedStatement: PS} = pgp;

// Configure the server and its routes.

const express = require('express');
const app = express();
const port = process.env.PORT || 3000;
const router = express.Router();
router.use(express.json());

router.get("/", readHelloMessage);
router.get("/users/:category", readUsers);
router.get("/buddies/:id", readBuddies)
router.get("/user/:id", readUser);
router.get("/home/:id", readHome);
router.get("/login/:username/:pass", login);
router.get("/streak/:id", readStreaks);

router.put("/user/:id", updateUser);
router.put("/habit/:id", updateHabit);
router.put("/streak/:id", updateStreak);
router.post('/user', createUser);
router.post('/buddies', createBuddies);
router.delete('/user/:id', deleteUser);
router.delete('/user/:userID/:notFriendID', deleteBuddy);

app.use(router);
app.use(errorHandler);
app.listen(port, () => console.log(`Listening on port ${port}`));

// Implement the CRUD operations.

function errorHandler(err, req, res) {
    if (app.get('env') === "development") {
        console.log(err);
    }
    res.sendStatus(err.status || 500);
}

function returnDataOr404(res, data) {
    if (data == null) {
        res.sendStatus(404);
    } else {
        res.send(data);
    }
}

function readHelloMessage(req, res) {
    res.send('Hello, CS 262 HabitBuddy Service!');
}

function readUsers(req, res, next) {
    db.many("SELECT UserTable.ID FROM UserTable, Habit WHERE Habit.category=$(category) AND Habit.userID = UserTable.ID", req.params)
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        })
}

function readBuddies(req, res, next) {
    db.many("SELECT Usertable.ID, firstName, lastName, emailAddress, phone, profileURL, hobby, habit, streak, Habit.category FROM UserTable, Buddies, Habit WHERE buddy1=${id} AND buddy2 = UserTable.ID AND buddy2HabitID = Habit.ID"
    + " UNION SELECT Usertable.ID, firstName, lastName, emailAddress, phone, profileURL, hobby, habit, streak, Habit.category FROM UserTable, Buddies, Habit WHERE buddy2=${id} AND buddy1 = UserTable.ID AND buddy1HabitID = Habit.ID ORDER BY lastName ASC"
    , req.params)
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        })
}

function readUser(req, res, next) {
    db.oneOrNone('SELECT UserTable.firstName, lastName, emailAddress, phone, profileURL, hobby, habit, category, streak FROM UserTable, Habit WHERE UserTable.ID=${id} AND Habit.userID = UserTable.ID', req.params)
        .then(data => {
            returnDataOr404(res, data);
        })
        .catch(err => {
            next(err);
        });
}

function readHome(req, res, next) {
    db.oneOrNone('SELECT habit, firstName, lastName, streak FROM UserTable, Habit WHERE UserTable.ID=${id} AND Habit.userID = UserTable.ID', req.params)
        .then(data => {
            db.many("SELECT buddy2 FROM Buddies WHERE buddy1=${id} UNION SELECT buddy1 FROM Buddies WHERE buddy2=${id}", req.params)
            .then(data2 => {
                data.totalbuddies = data2.length;
                returnDataOr404(res, data);
            })
            .catch(err => {
                next(err);
            })
        })
        .catch(err => {
            next(err);
        });
}

function readStreaks(req, res, next) {
    db.many("SELECT Usertable.ID, firstName, lastName, streak FROM UserTable, Buddies WHERE buddy1=${id} AND buddy2 = UserTable.ID"
    + " UNION SELECT Usertable.ID, firstName, lastName, streak FROM UserTable, Buddies WHERE buddy2=${id} AND buddy1 = UserTable.ID ORDER BY lastName ASC"
    , req.params)
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        })
}

function login(req, res, next) {
    db.oneOrNone('SELECT ID FROM UserTable WHERE username = ${username} AND password = ${pass}', req.params)
        .then(data => {
            returnDataOr404(res, data);
        })
        .catch(err => {
            next(err);
        });
}

function updateUser(req, res, next) {
    db.oneOrNone(`UPDATE UserTable SET emailAddress=$(body.emailAddress), phone=$(body.phone), hobby=$(body.hobby) WHERE ID=$(params.id)`, req)
    .then(function () {
        res.status(200)
        .json({
            status: 'success',
            message: 'Updated user'
        });
    })
    .catch(err => {
        next(err);
    });

    db.oneOrNone(`UPDATE Habit SET habit=$(body.habit) WHERE userID=$(params.id)`, req)
    .then(function () {
        res.status(200)
        .json({
            status: 'success',
            message: 'Updated user'
        });
    })
    .catch(err => {
        next(err);
    });
}

function updateHabit(req, res, next) {
    db.none('UPDATE Habit SET habit=$(body.habit) WHERE userID=$(params.id)', req)
    .then(function () {
      res.status(200)
        .json({
          status: 'success',
          message: 'Updated habit'
        });
    })
    .catch(function (err) {
      return next(err);
    });
}

function updateStreak(req, res, next) {
    db.oneOrNone(`UPDATE UserTable SET streak=$(body.streak) WHERE ID=$(params.id)`, req)
        .then(function () {
            res.status(200)
            .json({
                status: 'success',
                message: 'Updated streak'
            });
        })
        .catch(err => {
            next(err);
        });
}

function createUser(req, res, next) {
    let values = [req.body.firstName, req.body.lastName, req.body.emailAddress, req.body.phone,
        req.body.username, req.body.password, req.body.profileURL, req.body.hobby];
    console.log(req.body);
    //creates the user
    let stmt = new PS({name: 'create-user', 
        text: "INSERT INTO UserTable (firstName, lastName, emailAddress, phone, username, password, profileURL, hobby, totalBuddies, streak )"
        + " VALUES ( $1, $2, $3, $4, $5, $6, $7, $8, 0, 0 ) RETURNING id",
        values: values
    });
    db.one(stmt)
        .then(data => {
            let values = [data.id, req.body.habit, req.body.category]

            //creates the user's habits
            let stmt = new PS({name: 'create-habit', 
            text: "INSERT INTO Habit (userID, habit, category) VALUES ( $1, $2, $3 ) RETURNING id",
            values: values
            });
            db.one(stmt)
                .then(data2 => {
                    //finds all the users who have a habit of the same category
                    let stmt = new PS({name: 'find-users', 
                        text: "SELECT ID, userID FROM Habit WHERE category = $1 AND userID != $2",
                        values: [req.body.category, data.id]
                        });

                        db.many(stmt)
                            .then(data3 => {
                                //makes all users with the same category buddies
                                console.log(data3);
                                data3.forEach(habit => {
                                    let stmt = new PS({name: 'create-buddies', 
                                    text: "INSERT INTO Buddies (buddy1, buddy2, buddy1HabitID, buddy2HabitID) VALUES ( $1, $2, $3, $4 )",
                                    values: [data.id, habit.userid, data2.id, habit.id]
                                    });

                                    db.none(stmt)
                                        .catch(err => {
                                            next(err);
                                        });
                                });

                                returnDataOr404(res, {id: data.id, habitid: data2.id});
                            })
                            .catch(err => {
                                next(err);
                            });
                })
                .catch(err => {
                    next(err);
                });
        })
        .catch(err => {
            next(err);
        });
}

function createBuddies(req, res, next) {
    db.one(`INSERT INTO Buddies (buddy1, buddy2, buddy1HabitID, buddy2HabitID) VALUES ($(userID), $(buddyID), $(userHabitID), $(buddyHabitID)) RETURNING id`, req.body)
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        });
}

function deleteUser(req, res, next) {
    db.oneOrNone(`DELETE FROM UserTable WHERE id=${req.params.id} RETURNING id`)
        .then(data => {
            returnDataOr404(res, data);
        })
        .catch(err => {
            next(err);
        });
}

function deleteBuddy(req, res, next) {
    db.oneOrNone(`DELETE FROM Buddies WHERE (buddy1=$(userID) AND buddy2=$(notFriendID)) OR (buddy1=$(notFriendID) AND buddy2=$(userID))`, req.params)
    .then(function () {
        res.status(200)
        .json({
            status: 'success',
            message: 'Deleted buddy'
        });
    })    
    .catch(err => {
            next(err);
        });
}
