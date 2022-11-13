const express = require('express');
const app = express();
const pgp = require("pg-promise")();
const bodyParser = require("body-parser");
const session = require("express-session");
const bcrypt = require('bcrypt');
const { query } = require('express');
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
/*POST upload - called from a form probably, needs info from form, does not return anything (updates database)
  //(like POST register, except bigger and to recipes table, not users)
  
  //Need from HTML:
  //HTML needs to send values for every column in the recipes table EXCEPT for recipe_id, author_id, under_30_minutes, m30_minutes_1_hour, h1_hour_2_hours, h2_hours_3_hours, h3_hours_or_more
  //the items sent can be empty, except for recipe name, but they should still be sent.
  //for example, in the login POST, it sends an email, but if the user provided no email, it would be empty. This is ok.

  //To be explicit, I need recipe_name, prep_time, cook_time, recipe_image(link), recipe_ingredients, instructions, cuisine_type, rating, date_published(format?), 
  //and all the booleans for: vegan, vegetarian, keto, paleo, grain_free, gluten_free, contains_dairy, contains_eggs, contains_nuts, contains_soy, contains_wheat, contains_beef, contains_pork, contains_fish, 
  //and the booleans (only one should be true) for s1_star, s2_stars, s3_stars, s4_stars, s5_stars
    //Note: if it is too hard to ensure only one of these is TRUE, then please send star_rating instead of these 5 booleans, s1_star, s2_stars, s3_stars, s4_stars, and s5_stars.
    //star_rating should be an integer
    //I can then use this star_rating integer to assign the correct booleans in the table.

  //Return to HTML:
  //I will not return anything for the website to use, instead I will redirect to home.
*/

/*GET logout - called when clicked on logout button from other pages, renders login page with message, EXACTLY like labs
  Need: nothing
  Return to HTML: an object called message - it says "Logged out successfully"
  //Tested the error message functionality as well as session destroy functionality and it all worked.
*/
    //DONE - TESTED
app.get("/logout", (req, res) => {
  req.session.destroy();
  res.render("pages/login", {
    message: `Logged out Successfully`,
  });
});

/*GET profile - called from menu bar or redirected from login, renders /profile page with a results object
  Need from HTML:
  Does not need anything from HTML.

  Return to HTML:
  Will return a JSON object called results (for use on the profile.ejs page)
  results will contain MULTIPLE (an array of) recipes, and for each one, 
  you will be able to access ALL of its information just like the recipes table 
  (except as a JSON object of course), 
  also the JSON object will be printed to console for your reference
  
    Notes: if you want to display all of the information for each recipe, you will need to use ALL of these except recipe_id
    if you don't need to display all of the information for each recipe, you can simply use whatever you need.
    if you wanted to, you could try to find a way to display a bunch of recipes as cards, and then when you click on one, it gives you a popup which shows all of the information. I don't know how difficult this would be.
*/
    //DONE - TESTED
app.get("/profile", (req, res) => {
  query = 'SELECT recipes.recipe_id, recipes.recipe_name, recipes.prep_time, recipes.cook_time, recipes.recipe_image, recipes.recipe_ingredients, recipes.instructions, recipes.author_id, recipes.cuisine_type, recipes.rating, recipes.date_published, recipes.vegan, recipes.vegetarian, recipes.keto, recipes.paleo, recipes.grain_free, recipes.gluten_free, recipes.contains_dairy, recipes.contains_eggs, recipes.contains_nuts, recipes.contains_soy, recipes.contains_wheat, recipes.contains_beef, recipes.contains_pork, recipes.contains_fish, recipes.under_30_minutes, recipes.m30_minutes_1_hour, recipes.h1_hour_2_hours, recipes.h2_hours_3_hours, recipes.h3_hours_or_more, recipes.s1_star, recipes.s2_stars, recipes.s3_stars, recipes.s4_stars, recipes.s5_stars FROM users FULL JOIN favorites ON users.user_id = favorites.user_id FULL JOIN recipes ON favorites.recipe_id = recipes.recipe_id WHERE users.user_id = $1;'; //need to do a join on recipes, users, over favorites, so that we can select all recipes that are the favorite of the current user.
  db.any(query, [req.session.user.user_id]) //note: MUST be db.any to return multipe query rows /recipes!
    .then(queryResult => {
      
      //little edge case: if the user hasn't favorited any recipes, then send EMPTY results, and error message
      if(queryResult[0].recipe_id == null){
        res.render("pages/profile", {
          results: [],
          message: 'No Favorited Recipes',
        });
        return;
      }

      // show the object on console for reference, then render it to the page. On page, reference like results[0].recipe_name 
      console.log(queryResult);
      
      res.render("pages/profile", {
      results: queryResult, //you will access in the EJS/HTML by calling results, not queryResult
    });
    })
    .catch(err => {
    // Handle errors, send no results and an error message to HTML
      console.log(err);
      res.render("pages/profile", {
        results: [],
        message: err,
      });
    });
}); 

/*GET home - will render the HTML page home.ejs with a results object containing recipes. If called from its own page, this means it needs to filter the database before returning this. If called from somewhere else (i.e. menu bar), renders with all recipes.
  
  //ok so this one is a bit confusing. When we render it without any input, it should render /home with results as all columns for all recipes (like profile except no fancy query)
  //but when the user has selected filters, it should build a query that returns to the HTML a result object with only what the user was looking for.
  //so in the code, I think we need to be able to decide which of these things to do.

  //Need from HTML:
  Nothing

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

<->
On second thought, it probably makes sense to split this into two different calls, 
even if it has to use two more or less identical HTML pages. Therefore I suggest a 
home.ejs which loads all of the recipes, and something like a filter.ejs, 
which can look basically identical, but on which we will load the filtered recipes. 
We will then have a GET /home, which will require a very easy query, and 
a GET /filter, which will be more complicated.
<->

    */
//DONE - NOT TESTED
app.get("/home", (req, res) => {
  query = 'SELECT * FROM recipes;'; //getting all recipes and all their info
  db.any(query, [req.session.user.user_id]) //note: MUST be db.any to return multipe query rows /recipes!
    .then(queryResult => {
      //Render home page using a JSON object called results that contains all recipes for the webpage to use however it wants to.
     res.render("pages/home", {
      results: queryResult, //you will access in the EJS/HTML by calling results, not queryResult
    });
    })
    .catch(err => {
    // Handle errors, send no results and an error message to HTML
      console.log(err);
      res.render("pages/home", {
        results: [],
        message: err,
      });
    });
}); 


/*GET /filter
  //HTML needs to send values for cuisine_type and all of the columns under "filters"
  //the items sent can be empty, (in fact most of the time there will be some empty) but they should still be sent.
  //for example, in the login POST, it sends an email, but if the user provided no email, it would be empty. This is ok.

  //To be explicit, I need 
  //cuisine_type, and all the booleans for: vegan, vegetarian, keto, paleo, grain_free, gluten_free, contains_dairy, contains_eggs, contains_nuts, contains_soy, contains_wheat, contains_beef, contains_pork, contains_fish, 
  //and the booleans (any amount of them can be true) for under_30_minutes, m30_minutes_1_hour, h1_hour_2_hours, h2_hours_3_hours, h3_hours_or_more
  //and the booleans (any amount of them can be true) for s1_star, s2_stars, s3_stars, s4_stars, s5_stars
    //Note: This time, sending one star_rating instead of the 5 different star booleans will not suffice, because the user should be able to filter for all recipes that are 3 or 4 stars, for example, and sending one value cannot convey this

  Return to HTML:
  Same as GET home, except will have fewer recipes
    */
    //IN PROGRESS
app.get("/filter", (req, res) => {

  var i = 0; //we use this because the first filter added to the query shouldn't have AND, but the rest should
  query = 'SELECT * FROM recipes WHERE (';
  //here we will start building the query based off of the filters the user has sent.
  //this will basically be a lot of if statements that concatenate the query string, for example:

  //recipe_name
  if((req.body.recipe_name != '') && (req.body.recipe_name != null)){ //NOTE: the user passing a recipe_name is kind of an edge case
    if(i == 0){
      query = query + ` recipe_name = ${req.body.recipe_name}`;
    }
    else {
      query = query + ` AND recipe_name = ${req.body.recipe_name}`;
    }
    i++;
  }
  
  //cuisine_type
  if((req.body.cuisine_type != null) && (req.body.cuisine_type != "")){ //Not null and not empty
    if(i == 0){
      query = query + ` cuisine_type = ${req.body.cuisine_type}`;
    }
    else {
      query = query + ` AND cuisine_type = ${req.body.cuisine_type}`;
    }
    i++;
  }



  //after all the filters have been checked, finish the query
  query = query + ');'

  db.any(query, [req.session.user.user_id]) //note: MUST be db.any to return multipe query rows /recipes!
    .then(queryResult => {

      //Render HOME or different page?
    res.render("pages/home", {
      results: queryResult, //you will access in the EJS/HTML by calling results, not queryResult
    });
    })
    .catch(err => {
    // Handle errors, send no results and an error message to HTML
      console.log(err);
      res.render("pages/home", {
        results: [],
        message: err,
      });
    });
}); 


/*POST favorite - will be called by some kind of form that you use to favorite a recipe. It does not need to be its own page. Updates the database favorites table.
  //Need from HTML: only one thing, recipe_name

  //Return to HTML: Nothing

  //Explanation: POST favorite will take req.body.recipe_name and use this along with req.session.user.user_id to add an entry to the favorites table. 
  //the sent recipe will then be included in the JSON object returned by GET profile next time its called.
  //redirects to home.
  */
  //WORKING - But handles edge cases and errors badly
  app.post("/favorite", (req, res) => {
  query = 'INSERT INTO favorites (user_id, recipe_id) VALUES ($1, (SELECT recipe_id FROM recipes WHERE recipe_name = $2));'; //insert a new row in favorites which is the user's id and the recipe_id of the recipe the user typed
  db.any(query, [req.session.user.user_id, req.body.recipe_name])
    .then(queryResult => {
      //don't need to do anything
    })
    .catch(err => {
    // Handle errors, send no results and an error message to HTML
      console.log(err);
      res.render("pages/home", {
        message: err,
      });
    });
}); 


// Authentication Required
//app.use(auth);


  app.listen(3000);
  console.log("Server is listening on port 3000");
    