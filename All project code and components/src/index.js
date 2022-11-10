const express = require('express');
const app = express();
const pgp = require('pg-promise')();
const bodyParser = require('body-parser');
const session = require('express-session');
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

 - <-> IMPORTANT!!! <> -
If you want to use this method instead, you MUST add the following line of code to the .env file:
SESSION_SECRET="super duper secret!"

*/

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

  app.get('/register', (req, res) => {
    res.render('pages/register');
  });


app.post("/login", (req, res) => {
  const email = req.body.email;
  const username = req.body.username;
  const query = "select * from user where user.email = $1";
  const values = [email];

  // get the student_id based on the emailid
  db.one(query, values)
    .then((data) => {
      user.user_id = data.user_id;
      user.username = username;
      user.email = data.email;

      req.session.user = user;
      req.session.save();

      res.redirect("/");
    })
    .catch((err) => {
      console.log(err);
      res.redirect("/login");
    });
});


app.post('/register', async (req, res) => {

  //insert into database
  let query ="INSERT INTO user (username, password) VALUES ($1,$2)";
  db.any(query, [req.body.username, req.body.email, req.body.password])
  .then(()=> {
  res.redirect('/login')
  })
  .catch(function (err) {
  console.log(err);
  res.redirect('/register')
  });
});



  // app.post('/register', async (req, res) => {
  //   //the logic goes here
  //   const hash = await bcrypt.hash(req.body.password, 10);
  
  //   //insert into database
  //   let query ="INSERT INTO users(username, email, password) VALUES($1,$2,$3)";
  //   db.any(query, [req.body.username, hash])
  //   .then(()=> {
  //   res.redirect('/login')
  //   })
  //   .catch(function (err) {
  //   console.log(err);
  //   res.redirect('/register')
  //   });
  // });
  



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
    