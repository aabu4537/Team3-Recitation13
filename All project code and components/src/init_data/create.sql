CREATE TABLE IF NOT EXISTS users (
  user_id SERIAL PRIMARY KEY,
  username VARCHAR(50) NOT NULL,
  email VARCHAR(50),
  password VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS recipes (
  recipe_id SERIAL PRIMARY KEY NOT NULL,
  recipe_name VARCHAR(100) NOT NULL,
  prep_time INT,
  cook_time INT,
  recipe_image VARCHAR(1000),
  recipe_description VARCHAR (200),
  recipe_ingredients VARCHAR(10000),
  instructions VARCHAR(10000),
  author_id INTEGER NOT NULL REFERENCES users(user_id),/* might be a problem later */
  cuisine_type VARCHAR(50),
  rating INT, 
  date_published DATE,

  /* filters */
  vegan BOOLEAN, /* common diets */
  vegetarian BOOLEAN,
  keto BOOLEAN,
  paleo BOOLEAN,
  grain_free BOOLEAN,
  gluten_free BOOLEAN,
  contains_dairy BOOLEAN, /* common allergens/restrictions/sensitivities */
  contains_eggs BOOLEAN,
  contains_nuts BOOLEAN,
  contains_soy BOOLEAN,
  contains_wheat BOOLEAN,
  contains_beef BOOLEAN,
  contains_pork BOOLEAN,
  contains_fish BOOLEAN,
  /* different checklists, only one option for each */
  under_30_minutes BOOLEAN, /* total cook time */
  m30_minutes_1_hour BOOLEAN,
  h1_hour_2_hours BOOLEAN,
  h2_hours_3_hours BOOLEAN,
  h3_hours_or_more BOOLEAN,
  s1_star BOOLEAN, /* rating */
  s2_stars BOOLEAN,
  s3_stars BOOLEAN,
  s4_stars BOOLEAN,
  s5_stars BOOLEAN
);

CREATE TABLE IF NOT EXISTS favorites ( /* since this is a many-to-many relationship between users and recipes (unlike the author_id in recipes table) we need a bridge table */
  user_id INTEGER NOT NULL REFERENCES users(user_id),
  recipe_id INTEGER NOT NULL REFERENCES recipes(recipe_id),
  PRIMARY KEY(user_id, recipe_id) /* this defines a composite primary key consisting of two halves: the user_id foreign key and the recipe_id foreign key*/
);