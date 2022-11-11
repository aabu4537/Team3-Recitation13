const express = require('express');
const app = express();
const pgp = require("pg-promise")();
const bodyParser = require("body-parser");
const session = require("express-session");
const bcrypt = require('bcrypt');
//const { queryResult } = require("pg-promise");
// db config
const dbConfig = {
  host: "db",
  port: 5432,
  database: process.env.POSTGRES_DB,
  user: process.env.POSTGRES_USER,
  email: process.env.POSTGRES_USER,
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

 - <-> IMPORTANT!!! <-> -
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

//GET register - Done
app.get('/register', (req, res) => {
  res.render('pages/register');
});


//GET login - Done
app.get("/login", (req, res) => {
    res.render("pages/login");
});


//POST register - Tested - Done
app.post('/register', async (req, res) => { //Input: username and password as JSON
  //hashes the user's password for safety. The password that goes into the database will be the hashed one, not what the user provided.
  const hash = await bcrypt.hash(req.body.password, 10);
  
  //Insert username and hash into users
  const query = 'insert into users (username, email, password) values ($1, $2, $3);';
  
  db.any(query, [req.body.username, req.body.email, hash])
    .then(function (queryResult) {
        res.render("pages/login"); //kind of inefficient to have them login right after registering, but its not a problem
    })
    .catch(function (err) { // if there's an error, send them back to register page, rendered with the error as a JSON object accessible by EJS/JS to show to the user 
        console.log(err);
        res.render("pages/register", {
          message: err,
        });

    });
});



//POST login - Tested - Done
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


/*
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
*/

//Remaining routes to implement:
//POST upload - like POST register, except bigger and to recipes table, not users
  
  //Need from HTML:
  //HTML needs to send values for every column in the recipes table except recipe_id and author_id
  //the items sent can be empty, except for recipe name, but they should still be sent.
  //for example, in the login POST, it sends an email, but if the user provided no email, it would be empty. This is ok.

  //To be explicit, I need recipe_name, prep_time, cook_time, recipe_image(link), recipe_ingredients, instructions, cuisine_type, rating, date_published(format?), 
  //and all the booleans for: vegan, vegetarian, keto, paleo, grain_free, gluten_free, contains_dairy, contains_eggs, contains_nuts, contains_soy, contains_wheat, contains_beef, contains_pork, contains_fish, 
  //and the booleans (only one should be true) for under_30_minutes, m30_minutes_1_hour, h1_hour_2_hours, h2_hours_3_hours, h3_hours_or_more
  //and the booleans (only one should be true) for s1_star, s2_stars, s3_stars, s4_stars, s5_stars

  //Return to HTML:
  //I will not return anything for the website to use, instead I will redirect to home.

//GET logout - called when clicked on logout button from other pages, renders login page, EXACTLY like labs
  //Need: nothing
  //Return to HTML: an object called message - it says "Logged out successfully"

//GET profile - dynamic page rendering, like GET discover from lab9
  //Need from HTML:
  //Does not need anything from HTML.

  //Return to HTML:
  //Will return a JSON object called results (for use on the profile.ejs page)
  //results will contain MULTIPLE  (an array of) recipes, and for each one, you will be able to access ALL of its information just like the recipes table (except as a JSON object of course)
  
  // To be explicit, for each recipe in the JSON object, it will have:
  // recipe_id, recipe_name, prep_time, cook_time, recipe_image(a link), recipe_ingredients, instructions, cuisine_type, rating, date_published(format?), 
  //and the booleans for vegan, vegetarian, keto, paleo, grain_free, gluten_free, contains_dairy, contains_eggs, contains_nuts, contains_soy, contains_wheat, contains_beef, contains_pork, contains_fish, 
  //and the booleans for under_30_minutes, m30_minutes_1_hour, h1_hour_2_hours, h2_hours_3_hours, h3_hours_or_more
  //and the booleans for s1_star, s2_stars, s3_stars, s4_stars, s5_stars
  
    //if you want to display all of the information for each recipe, you will need to use ALL of these except recipe_id
    //if you don't need to display all of the information for each recipe, you can simply use whatever you need.
    //if you wanted to, you could try to find a way to display a bunch of recipes as cards, and then when you click on one, it gives you a popup which shows all of the information. I don't know how difficult this would be.

app.get("/profile", (req, res) => {
  query = 'SELECT ... ;'; //need to do a join on recipes, users, over favorites, so that we can select all recipes that are the favorite of the current user. Quite a mouthful
  db.one(query, [req.session.user.username]) 
    .then(queryResult => {
     // Send some parameters
     res.render("pages/profile", {
      results: queryResult, //you will access in the EJS/HTML by calling results, not queryResult
    });
    })
    .catch(err => {
    // Handle errors
      console.log(err);
      res.render("pages/profile", {
        results: [],
        message: err,
      });
    });
}); 

//GET home - render like profile except no fancy query: we're returning all columns for all recipes.

  //Need from HTML:
  //Does not need anything from HTML.

  //Return to HTML:
  //Will return a JSON object called results (for use on the home.ejs page)
  //results will contain MULTIPLE  (an array of) recipes, and for each one, you will be able to access ALL of its information just like the recipes table (except as a JSON object of course)
  
  // To be explicit, for each recipe in the JSON object, it will have:
  // recipe_id, recipe_name, prep_time, cook_time, recipe_image(a link), recipe_ingredients, instructions, cuisine_type, rating, date_published(format?), 
  //and the booleans for vegan, vegetarian, keto, paleo, grain_free, gluten_free, contains_dairy, contains_eggs, contains_nuts, contains_soy, contains_wheat, contains_beef, contains_pork, contains_fish, 
  //and the booleans for under_30_minutes, m30_minutes_1_hour, h1_hour_2_hours, h2_hours_3_hours, h3_hours_or_more
  //and the booleans for s1_star, s2_stars, s3_stars, s4_stars, s5_stars
  
    //if you want to display all of the information for each recipe, you will need to use ALL of these except recipe_id
    //if you don't need to display all of the information for each recipe, you can simply use whatever you need.
    //if you wanted to, you could try to find a way to display a bunch of recipes as cards, and then when you click on one, it gives you a popup which shows all of the information. I don't know how difficult this would be.

app.get("/home", (req, res) => {
  query = 'SELECT * FROM recipes;'; //need to do a join on recipes, users, over favorites, so that we can select all recipes that are the favorite of the current user. Quite a mouthful
  db.one(query, [req.session.user.username]) 
    .then(queryResult => {
     // Send some parameters
     res.render("pages/home", {
      results: queryResult, //you will access in the EJS/HTML by calling results, not queryResult
    });
    })
    .catch(err => {
    // Handle errors
      console.log(err);
      res.render("pages/home", {
        results: [],
        message: err,
      });
    });
}); 

//POST home - the beefy boi. Render like profile except beforehand, choose a lot of options through the HTML form (not automatic.)


//POST favorite - this is a route that will be called by some kind of form or something that you use to favorite a recipe. It does not need to be its own page.
  //Need from HTML: recipe_name

  //Return to HTML: Nothing

  //Explanation: POST favorite will take req.body.recipe_name and use this along with req.session.user.user_id to add an entry to the favorites table. 
  //the sent recipe will then be included in the JSON object returned by GET profile next time its called.


// Authentication Required
//app.use(auth);

app.get("/logout", (req, res) => {
  req.session.destroy();
  res.render("pages/login", {
    message: `Logged out Successfully`,
  });
});

  app.listen(3000);
  console.log("Server is listening on port 3000");
    