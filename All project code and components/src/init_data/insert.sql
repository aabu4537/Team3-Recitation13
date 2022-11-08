
/* Initialize Users Table*/
insert into users (username, email, password) values ('Player1', 'player1@gmail.com', '12345');
insert into users (username, email, password) values ('Player2', 'player2@gmail.com', '12345');
insert into users (username, email, password) values ('Robert', 'rob@gmail.com', 'ert');
insert into users (username, email, password) values ('OldPerson', 'grandpa@gmail.com', 'cooking');
insert into users (username, email, password) values ('Light', 'deathnote@gmail.com', 'illtakeapotatochipandeatit');

/* Initialize Ingredients Table*/
insert into ingredients (ingredient_name, dietary_warning) values (, );

/* Initialize Recipes Table*/
insert into recipes (recipe_name, prep_time, cook_time, recipe_image, instructions, author_id, cuisine_type, rating) values ('Steak and Eggs', 5, 20, 'https://healthyrecipesblogs.com/wp-content/uploads/2013/02/steak-and-eggs-featured-2021.jpg', 'Couldnt be bothered to add an actual instructions, so take a lorem ipsum: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut sagittis commodo ullamcorper. Quisque tincidunt ac orci eget facilisis. Morbi porttitor eros nec imperdiet vehicula. Donec a massa et erat ullamcorper cursus. Nulla efficitur eu tellus sed venenatis. Aenean rutrum, dui in rutrum ullamcorper, ipsum orci fringilla tellus, vel luctus eros sapien quis eros. Donec eu enim condimentum, bibendum magna at, condimentum mauris. Nunc dictum ante quis nibh pellentesque, et tempor diam porta. In mollis ex sed massa euismod tincidunt. Nullam faucibus tristique massa eget egestas. Integer id ultricies eros. Pellentesque malesuada tempus congue.

Phasellus at est orci. Donec iaculis ultricies urna sit amet dictum. Sed ultricies, lorem at auctor bibendum, enim sapien fringilla lorem, eget dictum massa nunc ac nisi. Etiam commodo non purus ac viverra. Duis aliquam felis id condimentum tristique. Donec interdum blandit auctor. Aliquam ac massa a lectus vulputate cursus. Proin consectetur ut tellus quis posuere. Pellentesque felis dolor, congue quis ipsum et, tempus scelerisque nulla. Maecenas nec interdum mauris, et pharetra nunc. Donec ut enim malesuada, volutpat erat eget, pulvinar urna. Aenean orci mauris, fringilla id dolor non, malesuada tincidunt nibh.', 1, 'American', 7.5);

/* Initialize Favorites Table - FOR TESTING ONLY - should be added to only dynamically in production*/
insert into favorites (user_id, recipe_id) values (, );

/* Initialize Recipes to Ingredients Table*/
insert into recipes_to_ingredients (user_id, username, email, password) values (, );
