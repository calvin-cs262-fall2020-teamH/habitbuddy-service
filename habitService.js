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
router.get("/users", readUsers);
router.get("/buddies", readBuddies)
router.get("/user/:id", readUser);

router.put("/players/:id", updatePlayer);
router.post('/players', createPlayer);
router.delete('/players/:id', deletePlayer);

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
    res.send('Hello, CS 262 habitbudy service!');
}

function readUsers(req, res, next) {
    db.many("SELECT * FROM UserTable")
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        })
}

function readBuddies(req, res, next) {
    db.many("SELECT * FROM Buddies")
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        })
}

function readUser(req, res, next) {
    db.oneOrNone('SELECT firstName, lastName, emailAddress, phone, profileURL, hobby, habitGoal, habit, category FROM UserTable, Habit WHERE ID = ${id} AND UserTable.ID = userID', req.params)
        .then(data => {
            returnDataOr404(res, data);
        })
        .catch(err => {
            next(err);
        });
}
//////////////////Everything below this is unchanged from monopoly
function updatePlayer(req, res, next) {
    db.oneOrNone(`UPDATE Player SET email=$(email), name=$(name) WHERE id=${req.params.id} RETURNING id`, req.body)
        .then(data => {
            returnDataOr404(res, data);
        })
        .catch(err => {
            next(err);
        });
}

function createPlayer(req, res, next) {
    db.one(`INSERT INTO Player(email, name) VALUES ($(email), $(name)) RETURNING id`, req.body)
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        });
}

function deletePlayer(req, res, next) {
    db.oneOrNone(`DELETE FROM Player WHERE id=${req.params.id} RETURNING id`)
        .then(data => {
            returnDataOr404(res, data);
        })
        .catch(err => {
            next(err);
        });
}
