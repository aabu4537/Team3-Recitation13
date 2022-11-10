CREATE TABLE users (
  user_id SERIAL PRIMARY KEY NOT NULL,
  username VARCHAR(50),
  email VARCHAR(50),
  password VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS ingredients(
  ingredient_id SERIAL PRIMARY KEY NOT NULL,  
  ingredient_name varchar(50) NOT NULL,
  );

CREATE TABLE recipes (
  recipe_id SERIAL PRIMARY KEY NOT NULL,
  recipe_name VARCHAR(100) NOT NULL,
  prep_time INT,
  cook_time INT,
  recipe_image VARCHAR(1000), 
  instructions VARCHAR(10000), /* is formatting multi-paragraph instructions going to be a problem?*/
  author_id INTEGER NOT NULL REFERENCES users(user_id),
  cuisine_type VARCHAR(50), /* might move this to filters */
  rating REAL /* maybe too extra, feel free to remove*/
);

CREATE TABLE filters (
  filter_id SERIAL PRIMARY KEY NOT NULL, /* create separate tables or leave as is? */
  vegan BOOLEAN, /* common diets */
  vegetarian BOOLEAN,
  keto BOOLEAN,
  paleo BOOLEAN,
  low_carb BOOLEAN,
  high_carb BOOLEAN,
  low_calorie BOOLEAN,
  high_calorie BOOLEAN,
  contains_dairy BOOLEAN, /* common allergens/restrictions/sensitivities */
  contains_eggs BOOLEAN,
  contains_nuts BOOLEAN,
  contains_soy BOOLEAN,
  contains_wheat BOOLEAN,
  contains_meat BOOLEAN,
  contains_pork BOOLEAN,
  contains_fish BOOLEAN,
  grain_free BOOLEAN,
  gluten_free BOOLEAN,
  under_30_minutes BOOLEAN, /* cook time */
  30_minutes_1_hour BOOLEAN,
  1_hour_2_hours BOOLEAN,
  2_hours_3_hours BOOLEAN,
  3_hours_or_more BOOLEAN,
  this_week BOOLEAN, /* published */
  this_month BOOLEAN,
  this_year BOOLEAN,
  today BOOLEAN
);

CREATE TABLE IF NOT EXISTS favorites( /* since this is a many-to-many relationship between users and recipes (unlike the author_id in recipes table) we need a bridge table */
  user_id INTEGER NOT NULL REFERENCES users(user_id),
  recipe_id INTEGER NOT NULL REFERENCES recipes(recipe_id),
  PRIMARY KEY(user_id, recipe_id) /* this defines a composite primary key consisting of two halves: the user_id foreign key and the recipe_id foreign key*/
);

CREATE TABLE IF NOT EXISTS recipes_to_ingredients(
  recipe_id INTEGER NOT NULL REFERENCES recipes(recipe_id),
  ingredient_id INTEGER NOT NULL REFERENCES ingredients(ingredient_id),
  PRIMARY KEY(recipe_id,ingredient_id) /* this defines a composite primary key consisting of two halves: the recipe_id foreign key and the ingredient_id foreign key*/
);