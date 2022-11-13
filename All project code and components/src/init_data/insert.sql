
/* Initialize Users Table*/
insert into users (username, email, password) values ('Player1', 'player1@gmail.com', '12345');
insert into users (username, email, password) values ('Player2', 'player2@gmail.com', '12345');
insert into users (username, email, password) values ('Robert', 'rob@gmail.com', 'ert');
insert into users (username, email, password) values ('OldPerson', 'grandpa@gmail.com', 'cooking');
insert into users (username, email, password) values ('Light', 'deathnote@gmail.com', 'illtakeapotatochipandeatit');

/* mock recipes */
insert into recipes (recipe_name, prep_time, cook_time, recipe_image, recipe_description, recipe_indredients, instructions, author_id, cuisine_type, rating, date_published, vegan, vegetarian, keto, paleo, grain_free, gluten_free, contains_dairy, contains_eggs, contains_nuts, contains_soy, contains_wheat, contains_beef, contains_pork, contains_fish, under_30_minutes, h1_hour_2_hours, h2_hours_3_hours, h3_hours_or_more, s1_star, s2_stars, s3_stars, s4_stars, s5_stars)
    values ('Recipe A', 30, 30, 'https://healthyrecipesblogs.com/wp-content/uploads/2013/02/steak-and-eggs-featured-2021.jpg', 
    'Recipe A Description', 'Recipe A Ingredients', 'Recipe A Instructions', 1, 'American', 2, 0001-01-01,
    1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0);

insert into recipes (recipe_name, prep_time, cook_time, recipe_image, recipe_description, recipe_indredients, instructions, author_id, cuisine_type, rating, date_published, vegan, vegetarian, keto, paleo, grain_free, gluten_free, contains_dairy, contains_eggs, contains_nuts, contains_soy, contains_wheat, contains_beef, contains_pork, contains_fish, under_30_minutes, h1_hour_2_hours, h2_hours_3_hours, h3_hours_or_more, s1_star, s2_stars, s3_stars, s4_stars, s5_stars)
    values ('Recipe B', 20, 60, 'https://healthyrecipesblogs.com/wp-content/uploads/2013/02/steak-and-eggs-featured-2021.jpg', 
    'Recipe B Description', 'Recipe B Ingredients', 'Recipe B Instructions', 1, 'European', 5, 1234-12-21,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1);

insert into recipes (recipe_name, prep_time, cook_time, recipe_image, recipe_description, recipe_indredients, instructions, author_id, cuisine_type, rating, date_published, vegan, vegetarian, keto, paleo, grain_free, gluten_free, contains_dairy, contains_eggs, contains_nuts, contains_soy, contains_wheat, contains_beef, contains_pork, contains_fish, under_30_minutes, h1_hour_2_hours, h2_hours_3_hours, h3_hours_or_more, s1_star, s2_stars, s3_stars, s4_stars, s5_stars)
    values ('Recipe C', 30, 30, 'https://healthyrecipesblogs.com/wp-content/uploads/2013/02/steak-and-eggs-featured-2021.jpg', 
    'Recipe C Description', 'Recipe C Ingredients', 'Recipe C Instructions', 2, 'Asian', 2, 0055-05-05,
    1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0);