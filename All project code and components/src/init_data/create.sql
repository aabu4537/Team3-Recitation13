CREATE TABLE IF NOT EXISTS users (
  user_id SERIAL PRIMARY KEY NOT NULL,
  username VARCHAR(50),
  email VARCHAR(50),
  password VARCHAR(100)
);

/* CREATE TABLE IF NOT EXISTS ingredients (
  ingredient_id SERIAL PRIMARY KEY NOT NULL,  
  ingredient_name varchar(50) NOT NULL,
); */

CREATE TABLE IF NOT EXISTS recipes (
  recipe_id SERIAL PRIMARY KEY NOT NULL,
  recipe_name VARCHAR(100) NOT NULL,
  prep_time INT,
  cook_time INT,
  recipe_image VARCHAR(1000), 
  recipe_ingredients VARCHAR(10000),
  instructions VARCHAR(10000),
  author_id INTEGER NOT NULL REFERENCES users(user_id), /* might be a problem later */
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
  30_minutes_1_hour BOOLEAN,
  1_hour_2_hours BOOLEAN,
  2_hours_3_hours BOOLEAN,
  3_hours_or_more BOOLEAN,
  1_star BOOLEAN, /* rating */
  2_stars BOOLEAN,
  3_stars BOOLEAN,
  4_stars BOOLEAN,
  5_stars BOOLEAN
);

/* CREATE TABLE IF NOT EXISTS filters (
  /* filter_id SERIAL PRIMARY KEY NOT NULL, /* create separate tables or leave as is? */
  /* recipe_id INTEGER NOT NULL REFERENCES recipes(recipe_id),
  vegan BOOLEAN, /* common diets */
  /*vegetarian BOOLEAN,
  keto BOOLEAN,
  paleo BOOLEAN,
  grain_free BOOLEAN,
  gluten_free BOOLEAN,
  /*low_carb BOOLEAN,
  high_carb BOOLEAN,
  low_calorie BOOLEAN,
  high_calorie BOOLEAN,*/
  /* contains_dairy BOOLEAN, /* common allergens/restrictions/sensitivities */
  /*contains_eggs BOOLEAN,
  contains_nuts BOOLEAN,
  contains_soy BOOLEAN,
  contains_wheat BOOLEAN,
  contains_meat BOOLEAN, /* or just beef if meat is too complicated */
  /*contains_pork BOOLEAN,
  contains_fish BOOLEAN,
  under_30_minutes BOOLEAN, /* total cook time */
  /*30_minutes_1_hour BOOLEAN,
  1_hour_2_hours BOOLEAN,
  2_hours_3_hours BOOLEAN,
  3_hours_or_more BOOLEAN,
  /* this_week BOOLEAN, /* published */
  /* this_month BOOLEAN,
  this_year BOOLEAN,
  today BOOLEAN */
  /*1_star BOOLEAN, /* rating */
  /*2_stars BOOLEAN,
  3_stars BOOLEAN,
  4_stars BOOLEAN,
  5_stars BOOLEAN
);*/

CREATE TABLE IF NOT EXISTS favorites ( /* since this is a many-to-many relationship between users and recipes (unlike the author_id in recipes table) we need a bridge table */
  user_id INTEGER NOT NULL REFERENCES users(user_id),
  recipe_id INTEGER NOT NULL REFERENCES recipes(recipe_id),
  PRIMARY KEY(user_id, recipe_id) /* this defines a composite primary key consisting of two halves: the user_id foreign key and the recipe_id foreign key*/
);

/* CREATE TABLE IF NOT EXISTS recipes_to_ingredients (
  recipe_id INTEGER NOT NULL REFERENCES recipes(recipe_id),
  ingredient_id INTEGER NOT NULL REFERENCES ingredients(ingredient_id),
  PRIMARY KEY(recipe_id,ingredient_id) /* this defines a composite primary key consisting of two halves: the recipe_id foreign key and the ingredient_id foreign key*/
/* ); */

/*CREATE TABLE IF NOT EXISTS recipes_to_filters (
  user_id INTEGER NOT NULL REFERENCES recipes(recipe_id),
  filter_id INTEGER NOT NULL REFERENCES filters(filter_id),
  PRIMARY KEY(recipe_id, filter_id)
);*/