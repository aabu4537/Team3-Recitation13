CREATE TABLE recipes (
  recipe_id SERIAL PRIMARY KEY NOT NULL,
  recipe_name VARCHAR(100) NOT NULL,
  prep_time INT,
  cook_time INT,
  recipe_image VARCHAR(1000), 
  instructions VARCHAR(10000), /* is formatting multi-paragraph instructions going to be a problem?*/
  author_id INTEGER NOT NULL REFERENCES users(user_id),
  cuisine_type VARCHAR(50),/* do I need a table for this?*/
  rating REAL /* maybe too extra*/
);

CREATE TABLE users (
  user_id SERIAL PRIMARY KEY NOT NULL,
  username VARCHAR(50),
  email VARCHAR(50),
  password VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS ingredients(
  ingredient_id SERIAL PRIMARY KEY NOT NULL,  
  ingredient_name varchar(50) NOT NULL,
  dietary_warning BOOLEAN /* too extra? // put this here or in a different table?*/
  );

CREATE TABLE IF NOT EXISTS favorites( /* since this is a many-to-many relationship between users and recipes (unlike the author_id in recipes table) we need a bridge table, it will also e nice to keep it seperate*/
  user_id INTEGER NOT NULL REFERENCES users(user_id),
  recipe_id INTEGER NOT NULL REFERENCES recipes(recipe_id),
  PRIMARY KEY(user_id, recipe_id) /* this defines a composite primary key consisting of two halves: the user_id foreign key and the recipe_id foreign key*/
);

CREATE TABLE IF NOT EXISTS recipes_to_ingredients(
  recipe_id INTEGER NOT NULL REFERENCES recipes(recipe_id),
  ingredient_id INTEGER NOT NULL REFERENCES ingredients(ingredient_id),
  PRIMARY KEY(recipe_id,) /* this defines a composite primary key consisting of two halves: the user_id foreign key and the recipe_id foreign key*/
);