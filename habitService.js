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

router.put("/user/:id", updateUser);
router.put("/habit/:id", updateHabit);
router.post('/user', createUser);
router.post('/habit', createHabit);
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
    db.many("SELECT UserTable.ID FROM UserTable, Habit WHERE Habit.category=$(category)", req.params)
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        })
}

function readBuddies(req, res, next) {
    db.many("SELECT Usertable.ID, firstName, lastName, emailAddress, phone, profileURL, hobby, habitGoal, streak, Habit.category FROM UserTable, Buddies, Habit WHERE buddy1=${id} AND buddy2 = UserTable.ID AND buddy1HabitID = Habit.ID ORDER BY lastName ASC", req.params)
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        })
}

function readUser(req, res, next) {
    db.oneOrNone('SELECT UserTable.firstName, lastName, emailAddress, phone, profileURL, hobby, habitGoal, habit, category, totalBuddies, streak FROM UserTable, Habit WHERE UserTable.ID=${id} AND Habit.userID = UserTable.ID', req.params)
        .then(data => {
            returnDataOr404(res, data);
        })
        .catch(err => {
            next(err);
        });
}

function readHome(req, res, next) {
    db.oneOrNone('SELECT habit, firstName, lastName, totalBuddies, streak FROM UserTable, Habit WHERE UserTable.ID=${id} AND Habit.ID = UserTable.ID', req.params)
        .then(data => {
            returnDataOr404(res, data);
        })
        .catch(err => {
            next(err);
        });
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
    db.oneOrNone(`UPDATE UserTable SET emailAddress=$(body.email), phone=$(body.phone), profileURL=$(body.URL), hobby=$(body.hobby), habitGoal=$(body.habitGoal) WHERE id=${params.id} RETURNING id`, req)
        .then(data => {
            returnDataOr404(res, data);
        })
        .catch(err => {
            next(err);
        });
}

function updateHabit(req, res, next) {
    db.none('UPDATE Habit SET habit=$1 WHERE ID=$2',
    [req.body.habit, parseInt(req.params.id)])
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

// function createUser(req, res, next) {
//     const {firstName, lastName, emailAddress, phone, username, password, dob, profileURL, hobby,
//          habitGoal } = req.body
//     db.one(`INSERT INTO UserTable(firstName, lastName, emailAddress, phone, username, password, dob, profileURL, hobby, habitGoal, totalBuddies, streak, notifications, theme) VALUES ($1, $2, $3, $4, $5, $6, TO_DATE($7, 'YYYY-MM-DD'), $8, $9, $10, $11, $12, $13, $14) RETURNING id`, 
//     [firstName, lastName, emailAddress, phone, username, password, dob, profileURL, hobby, habitGoal, 
//         0, 0, false, 'light'])
//         .then(data => {
//             res.send(data);
//         })
//         .catch(err => {
//             next(err);
//         });
// }

// function createUser(req, res, next) {
//     db.one(`INSERT INTO UserTable(firstName, lastName, emailAddress, phone, username, password, dob, profileURL, hobby, habitGoal, totalBuddies, streak, notifications, theme)
//      VALUES (${firstName}, ${lastName}, ${emailAddress}, ${phone}, ${username}, ${password}, TO_DATE(${dob}, 'YYYY-MM-DD'), ${profileURL}, ${hobby}, ${habitGoal}, 0, 0, false, 'light') RETURNING id`, req.body)
//     .then(function () {
//         res.status(200)
//           .json({
//             status: 'success',
//             message: 'Inserted one user'
//           });
//       })
//       .catch(function (err) {
//         return next(err);
//       });
// }

function createUser(req, res, next) {
    let values = [req.body.firstName, req.body.lastName, req.body.emailAddress, req.body.phone,
        req.body.username, req.body.password, req.body.dob, req.body.profileURL, req.body.hobby,
        req.body.habitGoal];
    let stmt = new PS({name: 'create-user', 
        text: "INSERT INTO UserTable(firstName, lastName, emailAddress, phone, username, password, dob, profileURL, hobby, habitGoal, totalBuddies, streak, notifications, theme)"
        + " VALUES ( $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, 0, 0, to_boolean('false'), 'light' ) RETURNING id",
        values: values
    });
    db.one(stmt)
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        });
}

function createHabit(req, res, next) {
    req.body.userID = parseInt(req.body.userID);
    db.one(`INSERT INTO Habit (userID, habit, category) VALUES ($(ID), $(habit), $(category)) RETURNING ID`, req.body)
        .then(data => {
            res.send(data);
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
    db.oneOrNone(`DELETE FROM Buddies WHERE buddy1=${userID} AND buddy2=${notFriendID} RETURNING buddy1`, req.params)
        .then(data => {
            returnDataOr404(res, data);
        })
        .catch(err => {
            next(err);
        });
}
