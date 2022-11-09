const express = require("express");
const app = express();
const pgp = require("pg-promise")();
const bodyParser = require("body-parser");
const session = require("express-session");

// db config
const dbConfig = {
  host: "db",
  port: 5432,
  database: process.env.POSTGRES_DB,
  user: process.env.POSTGRES_USER,
  password: process.env.POSTGRES_PASSWORD,
};

const db = pgp(dbConfig);

app.use(
    session({
      secret: process.env.SESSION_SECRET,
      saveUninitialized: false,
      resave: false,
    })
  );
  
  app.use(
    bodyParser.urlencoded({
      extended: true,
    })
  );
  
  app.get('/', (req, res) =>{
    res.redirect('/login'); 
  });

  app.get("/login", (req, res) => {
    res.render("pages/login");
  });



  // Authentication Middleware.
const auth = (req, res, next) => {
  if (!req.session.user) {
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
    