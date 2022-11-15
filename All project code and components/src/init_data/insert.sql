insert into users (username, email, password) values ('Player1', 'player1@gmail.com', '12345');
insert into users (username, email, password) values ('Player2', 'player2@gmail.com', '12345');
insert into users (username, email, password) values ('Robert', 'rob@gmail.com', 'ert');
insert into users (username, email, password) values ('OldPerson', 'grandpa@gmail.com', 'cooking');
insert into users (username, email, password) values ('Light', 'deathnote@gmail.com', 'illtakeapotatochipandeatit');



insert into recipes (recipe_name, prep_time, cook_time, recipe_image, recipe_ingredients, instructions, author_id, cuisine_type, rating, 
    date_published, vegan, vegetarian, keto, paleo, grain_free, gluten_free, contains_dairy, contains_eggs, contains_nuts, contains_soy, 
    contains_wheat, contains_beef, contains_pork, contains_fish, under_30_minutes, m30_minutes_1_hour, h1_hour_2_hours, h2_hours_3_hours, 
    h3_hours_or_more, s1_star, s2_stars, s3_stars, s4_stars, s5_stars) values ('Poutine', 30, 30, 'https://www.seasonsandsuppers.ca/wp-content/uploads/2014/01/new-poutine-1.jpg', 
    '1 quart vegetable oil for frying, 1 (10.25 ounce) can beef gravy, 5 medium potatoes, cut into fries, 2 cups cheese curds', 'Heat oil in a deep fryer or deep heavy skillet to 365 degrees F (185 degrees C). While the oil is heating, begin to warm gravy. Place fries into the hot oil, and cook until light brown, 8 to 10 minutes. Cook fries in batches if necessary to allow them room to move a little in the oil. Remove to a paper towel-lined plate to drain. Place fries on a serving platter, and sprinkle cheese over them. Ladle warmed gravy over the fries and cheese, and serve immediately.', 1, 'Canadian', 5, '2022-05-24',
   false, false, false, false, false, true, false, true, 
    false, false, false, true, false, false, false, true, false, false, false, false, false, false ,false, true);   

insert into recipes (recipe_name, prep_time, cook_time, recipe_image, recipe_ingredients, instructions, author_id, cuisine_type, rating, 
    date_published, vegan, vegetarian, keto, paleo, grain_free, gluten_free, contains_dairy, contains_eggs, contains_nuts, contains_soy, 
    contains_wheat, contains_beef, contains_pork, contains_fish, under_30_minutes, m30_minutes_1_hour, h1_hour_2_hours, h2_hours_3_hours, 
    h3_hours_or_more, s1_star, s2_stars, s3_stars, s4_stars, s5_stars)   values ('Chicken Stir-Fry', 30, 30, 'https://www.allrecipes.com/thmb/MrARb3JSqldom4E30bLGK2mGQxM=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/223382_chicken-stir-fry_Rita-1x1-1-b6b835ccfc714bb6a8391a7c47a06a84.jpg',
    '4 cups water, 2 cups white rice, ⅔ cup soy sauce, ¼ cup brown sugar, 1 tablespoon cornstarch, 1 tablespoon minced fresh ginger, 1 tablespoon minced garlic, ¼ teaspoon red pepper flakes, 3 skinless, boneless chicken breast halves thinly sliced, 2 tablespoons sesame oil, divided, 1 head broccoli, broken into florets, 1 onion, cut into large chunks, 1 cup sliced carrots, 1 (8 ounce) can sliced water chestnuts, 1 green bell pepper, cut into matchsticks', '1. Stir the soy sauce, sugar, cornstarch, and spices together.2. Add the chicken and toss. Cover and marinate.
3. Cook the vegetables and water chestnuts in sesame oil.
4. Cook the marinated chicken, then stir in the veggies and reserved marinade.
5. Boil until the chicken is fully cooked. Serve over rice.',2, 'Asian', 3, '2020-05-05',
   false, false, true, false, false, true, false, true, 
    false, false, false, true, false, false, false, false, true, false, false, false, false, true ,false, false); 

insert into recipes (recipe_name, prep_time, cook_time, recipe_image, recipe_ingredients, instructions, author_id, cuisine_type, rating, 
    date_published, vegan, vegetarian, keto, paleo, grain_free, gluten_free, contains_dairy, contains_eggs, contains_nuts, contains_soy, 
    contains_wheat, contains_beef, contains_pork, contains_fish, under_30_minutes, m30_minutes_1_hour, h1_hour_2_hours, h2_hours_3_hours, 
    h3_hours_or_more, s1_star, s2_stars, s3_stars, s4_stars, s5_stars)   
     values ('Banana Pancakes', 20, 60, 'https://www.allrecipes.com/thmb/cBHbBMQ6pd1GaSEh6LKtuxZOT6s=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/20334-Banana-Pancakes-mfs__2x3-21fe4c9bcb35452dacd21d2f76639e13.jpg', 
     '1 cup all-purpose flour, 1 tablespoon white sugar, 2 teaspoons baking powder, ¼ teaspoon salt, 1 egg, beaten, 1 cup milk, 2 tablespoons vegetable oil, 2 ripe bananas mashed', 'Combine flour, white sugar, baking powder, and salt in a bowl. Mix together egg, milk, vegetable oil, and bananas in a second bowl.

Stir flour mixture into banana mixture; batter will be slightly lumpy.

Heat a lightly oiled griddle or frying pan over medium high heat. Pour or scoop the batter onto the griddle, using approximately 1/4 cup for each pancake. Cook until pancakes are golden brown, 3 to 5 minutes per side. Serve hot.', 1, 'American', 5, '1234-12-21',
   false, false, true, false, false, true, false, true, 
    false, true, false, true, false, false, false, false, true, false, false, false, false, true ,false, false); 


insert into recipes (recipe_name, prep_time, cook_time, recipe_image, recipe_ingredients, instructions, author_id, cuisine_type, rating, 
    date_published, vegan, vegetarian, keto, paleo, grain_free, gluten_free, contains_dairy, contains_eggs, contains_nuts, contains_soy, 
    contains_wheat, contains_beef, contains_pork, contains_fish, under_30_minutes, m30_minutes_1_hour, h1_hour_2_hours, h2_hours_3_hours, 
    h3_hours_or_more, s1_star, s2_stars, s3_stars, s4_stars, s5_stars)    values ('Pesto Pasta', 30, 30, 'https://www.allrecipes.com/thmb/9yM-87rBbN3qbr7QYf_5q4dJQpk=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/11887_pesto-pasta_Rita-1x1-1-501c953b29074ab193e2b5ad36e64648.jpg', 
    '1 (16 ounce) package pasta,

, 2 tablespoons olive oil

, ½ cup chopped onion

, 2 ½ tablespoons pesto

, salt to taste

, ground black pepper to taste

, 2 tablespoons grated Parmesan cheese', 'Fill a large pot with lightly salted water and bring to a rolling boil. Stir in pasta and return to a boil. Cook pasta uncovered, stirring occasionally, until tender yet firm to the bite, about 8 to 10 minutes. Drain and transfer into a large bowl.

Meanwhile, heat oil in a frying pan over medium-low heat. Add onion; cook and stir until softened, about 3 minutes. Stir in pesto, salt, and pepper until warmed through.

Add pesto mixture to hot pasta; stir in grated cheese and toss well to coat.', 1, 'Italian', 2, '2019-01-01',
   false, true, true, false, false, true, false, true, 
    false, true, false, true, false, true, false, false, true, false, false, false, false, false ,true, false); 

insert into recipes (recipe_name, prep_time, cook_time, recipe_image, recipe_ingredients, instructions, author_id, cuisine_type, rating, 
    date_published, vegan, vegetarian, keto, paleo, grain_free, gluten_free, contains_dairy, contains_eggs, contains_nuts, contains_soy, 
    contains_wheat, contains_beef, contains_pork, contains_fish, under_30_minutes, m30_minutes_1_hour, h1_hour_2_hours, h2_hours_3_hours, 
    h3_hours_or_more, s1_star, s2_stars, s3_stars, s4_stars, s5_stars)    values ('Mexican Rice and Beans', 20, 60, 'https://www.allrecipes.com/thmb/9v5OCep86fOd8EO3eFN3X5f2DDQ=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/7989559-4b139ba34ab34cbb926073511f30d88f.jpg', 
 '2 tablespoons olive oil,

1 small onion diced,

1 small poblano pepper diced, 

1 clove garlic chopped, 

1 cup basmati rice, 

2 teaspoons paprika,

1 teaspoon ground cumin, 

1 teaspoon dried oregano, 

salt and ground black pepper to taste,  

2 tablespoons tomato paste,  

2 cups vegetable broth, 

1 (14 ounce) can pinto beans, rinsed and drained', 'Recipe B Instructions', 1, 'Mexican', 1, '2020-12-21',
   true, true, true, false, false, true, false, true, 
    false, true, false, true, false, true, false, false, true, false, false, true, false, false ,false, false); 

insert into recipes (recipe_name, prep_time, cook_time, recipe_image, recipe_ingredients, instructions, author_id, cuisine_type, rating, 
    date_published, vegan, vegetarian, keto, paleo, grain_free, gluten_free, contains_dairy, contains_eggs, contains_nuts, contains_soy, 
    contains_wheat, contains_beef, contains_pork, contains_fish, under_30_minutes, m30_minutes_1_hour, h1_hour_2_hours, h2_hours_3_hours, 
    h3_hours_or_more, s1_star, s2_stars, s3_stars, s4_stars, s5_stars)    values ('Kimbop (Korean Sushi)', 30, 30, 'https://www.allrecipes.com/thmb/LS184SM-OapzhwjNZHPOeHetxXk=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/3987640-f11078a582654cb5b3a32bf9aad3ff27.jpg', 
 '1 cup uncooked glutinous white rice (sushi rice),

1 ½ cups water,

1 tablespoon sesame oil,

salt, to taste,

2 eggs, beaten,

4 sheets sushi nori (dry seaweed),

1 cucumber, cut into thin strips,

1 carrot, cut into thin strips,

4 slices American processed cheese, cut into thin strips,

4 slices cooked ham, cut into thin strips,

2 teaspoons sesame oil', 'Rinse the rice in a strainer or colander until the water runs clear. Combine the rice with water in a saucepan. Bring to a boil, then reduce the heat to low; cover and simmer until rice is tender, 12 to 14 minutes. Spread cooked rice onto a baking sheet to cool. Season with 1 tablespoon of sesame oil and salt.

While the rice is simmering, pour the eggs into a skillet over medium-high heat and allow to cook without stirring or turning to get a flat layer of cooked egg. When egg is completely cooked, remove from skillet and set aside on a cutting board to cool.

Separate the nori sheets onto a flat surface and divide the cooled rice between them, leaving only a half-inch strip of seaweed visible at the top of each sheet. Arrange strips of egg, cucumber, carrot, cheese, and ham in thin layers on top of the rice. Beginning with the bottom of each sheet of nori, use a bamboo sushi mat to firmly roll each piece into a cylindrical shape. Brush each roll with 1/2 teaspoon of sesame oil and cut into six even pieces.', 2, 'Korean', 2, '2015-05-05',
   false, true, true, false, false, true, false, true, 
    false, true, false, true, false, true, false, true, false, false, false, false, false, false ,false, true); 

insert into recipes (recipe_name, prep_time, cook_time, recipe_image, recipe_ingredients, instructions, author_id, cuisine_type, rating, 
    date_published, vegan, vegetarian, keto, paleo, grain_free, gluten_free, contains_dairy, contains_eggs, contains_nuts, contains_soy, 
    contains_wheat, contains_beef, contains_pork, contains_fish, under_30_minutes, m30_minutes_1_hour, h1_hour_2_hours, h2_hours_3_hours, 
    h3_hours_or_more, s1_star, s2_stars, s3_stars, s4_stars, s5_stars)       values ('Pancit', 20, 60, 'https://www.allrecipes.com/thmb/sklE4NaTIVejm0U9DyFmyPjVlmo=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/2201480-quick-and-easy-pancit-Paula-Goleta-1x1-1-f03b70c77f094dee901e72007dfe1a22.jpg', 
'1 (12 ounce) package dried rice noodles,

1 teaspoon vegetable oil,

1 onion, finely diced,

3 cloves garlic, minced,

2 cups diced cooked chicken breast meat,

1 small head cabbage thinly sliced,

4 carrot, thinly sliced,

¼ cup soy sauce,

2 lemons - cut into wedges, for garnish', 'Place rice noodles in a large bowl; cover with warm water and let soften for 8 to 10 minutes. Drain and set aside.

Meanwhile, heat oil in a wok or large skillet over medium-low heat. Add onion and garlic; cook and stir until onion is tender, about 3 to 5 minutes. Stir in chicken, cabbage, carrots, and soy sauce. Cook until cabbage begins to soften. Toss in noodles and cook, stirring constantly, until heated through.

Transfer pancit to a serving dish and garnish with lemon wedges.', 1, 'Filipino', 4, '2021-12-21',
   false, false, true, false, false, true, true, true, 
    false, true, false, true, false, true, false, true, false, false, false, false, false, false ,true, false); 

insert into recipes (recipe_name, prep_time, cook_time, recipe_image, recipe_ingredients, instructions, author_id, cuisine_type, rating, 
    date_published, vegan, vegetarian, keto, paleo, grain_free, gluten_free, contains_dairy, contains_eggs, contains_nuts, contains_soy, 
    contains_wheat, contains_beef, contains_pork, contains_fish, under_30_minutes, m30_minutes_1_hour, h1_hour_2_hours, h2_hours_3_hours, 
    h3_hours_or_more, s1_star, s2_stars, s3_stars, s4_stars, s5_stars)       values ('Stuffed Green Peppers', 30, 30, 'https://thesouthernladycooks.com/wp-content/uploads/2013/09/StuffedpeppersNewPhotosWebsite1.png', 
'6 green bell peppers,

salt to taste,

1 pound ground beef,

⅓ cup chopped onion,

salt and pepper to taste,

1 (14.5 ounce) can whole peeled tomatoes, chopped,

½ cup water,

½ cup uncooked rice,

1 teaspoon Worcestershire sauce,

1 cup shredded Cheddar cheese,

2 (10.75 ounce) cans condensed tomato soup,

water as needed', 'Stir in tomatoes, 1/2 cup water, rice, and Worcestershire sauce; reduce heat to low, cover, and simmer until rice is tender, about 15 minutes. Remove from heat and stir in cheese.

Preheat the oven to 350 degrees F (175 degrees C).

Stuff each bell pepper with beef and rice mixture; arrange open-side up in a baking dish.

Combine tomato soup with just enough water in a medium bowl to make the soup a gravy consistency; pour over the bell peppers and cover with aluminum foil.

Bake in the preheated oven until heated through and cheese is melted and bubbly, about 25 to 30 minutes.', 2, 'Mexican', 2, '2012-05-05',
   false, false, true, false, false, true, false, false, 
    true, true, false, true, false, true, false, true, false, false, false, false, true, false ,false, false); 