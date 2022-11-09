const express = require("express");
const app = express();
const pgp = require("pg-promise")();
const bodyParser = require("body-parser");
const session = require("express-session");
const bcrypt = require('bcrypt');
const { queryResult } = require("pg-promise");

// db config
const dbConfig = {
  host: "db",
  port: 5432,
  database: process.env.POSTGRES_DB,
  user: process.env.POSTGRES_USER,
  password: process.env.POSTGRES_PASSWORD,
};

const db = pgp(dbConfig);

// db test
db.connect()
  .then((obj) => {
    // Can check the server version here (pg-promise v10.1.0+):
    console.log("Database connection successful");
    obj.done(); // success, release the connection;
  })
  .catch((error) => {
    console.log("ERROR:", error.message || error);
  });
  
// set the view engine to ejs
app.set("view engine", "ejs");
app.use(bodyParser.json());

// set session
app.use(
  session({
    secret: "XASDASDA",
    saveUninitialized: true,
    resave: true,
  })
);
/* This was the other version used on the labs; I am not sure about the difference, other than this might be more secure.

app.use(
    session({
      secret: process.env.SESSION_SECRET,
      saveUninitialized: false,
      resave: false,
    })
  );

 - <-> IMPORTANT!!! <> -
If you want to use this method instead, you MUST add the following line of code to the .env file:
SESSION_SECRET="super duper secret!"

*/

  app.use(
    bodyParser.urlencoded({
      extended: true,
    })
  );
  
//We will use this to store the user's information in a session variable.
const user = {
  user_id: undefined,
  username: undefined,
  email: undefined,
};


  //Redirect from / to /login - once we have a home page, can change to home
app.get('/', (req, res) =>{
    res.redirect('/login'); 
});

//GET login
app.get("/login", (req, res) => {
    res.render("pages/login");
});


//POST login - Ready to test when Database is done
  // Note: Need to rectify the fact that we need a password yet the pages are only sending username and email
  app.post("/login", (req, res) => {
    const username = req.body.username;
    const password = req.body.password;
    const query = 'SELECT * FROM users WHERE username = $1;';
  
    db.one(query, [username]) //query the database using the username provided at login
      .then(async (queryResult) => {

        //compare the hashed password in the database with the hashed version of the password the user provided
        const match = await bcrypt.compare(req.body.password, queryResult.password);
  
        if(!match){   //if the hashed passwords didn't match, return error and redirect
          console.log("Incorrect username or password");
          res.redirect("/login");
        }
        else{   //If user was found, save the results of the query (except password) in a session variable

          //updating the data of user
          user.user_id = queryResult.user_id;
          user.username = queryResult.username;
          user.email = queryResult.email;

          //make this user into a session variable
          req.session.user = user;
            req.session.save();
            res.redirect("/profile");
        }
      })
      //if error, return the error and render login with this error message so it can be displayed to user
      .catch((err) => {
        console.log(err);
        res.render("pages/login", {
          message: err,
        });
      });
  });

  // Authentication Middleware.
const auth = (req, res, next) => {
  //if no session variable, that means user is not logged in, so shouldn't be able to view profile, for example
  if (!req.session.user) {
    //if the path is /register or /login, thats fine, do nothing. Otherwise, redirect to login
      if(req.path == "/register" || req.path == "/login"){
          return;
      }
    // Default to login page.
    return res.redirect('/login');
  }
  next();
};

// Authentication Required
app.use(auth);

  app.listen(3000);
  console.log("Server is listening on port 3000");
    