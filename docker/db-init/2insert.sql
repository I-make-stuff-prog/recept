INSERT INTO units (unit_name, unit_symbol) VALUES
('Gram', 'g'),
('Kilogram', 'kg'),
('Milliliter', 'ml'),
('Liter', 'l'),
('Piece', 'pc'),
('Teaspoon', 'tsp'),
('Tablespoon', 'tbsp'),
('Cup', 'cup');

INSERT INTO ingredients (ingredient_name, default_unit_id) VALUES
('Flour', 1),
('Sugar', 1),
('Salt', 6),
('Egg', 5),
('Milk', 3),
('Butter', 1),
('Baking Powder', 6),
('Chicken Breast', 2),
('Olive Oil', 7),
('Garlic', 5),
('Onion', 5),
('Tomato', 5),
('Black Pepper', 6),
('Rice', 2);

INSERT INTO recipes (recipe_name) VALUES
('Pancakes'),
('Grilled Chicken'),
('Tomato Rice');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity) VALUES
(1, 1, 200),   -- Flour (200g)
(1, 2, 50),    -- Sugar (50g)
(1, 3, 1),     -- Salt (1 tsp)
(1, 4, 2),     -- Egg (2 pcs)
(1, 5, 300),   -- Milk (300ml)
(1, 6, 50),    -- Butter (50g)
(1, 7, 2);     -- Baking Powder (2 tsp)

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity) VALUES
(2, 8, 1),     -- Chicken Breast (1 kg)
(2, 9, 2),     -- Olive Oil (2 tbsp)
(2, 10, 3),    -- Garlic (3 pcs)
(2, 13, 1),    -- Black Pepper (1 tsp)
(2, 3, 1);     -- Salt (1 tsp)

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity) VALUES
(3, 14, 1),    -- Rice (1 kg)
(3, 12, 3),    -- Tomato (3 pcs)
(3, 11, 1),    -- Onion (1 pc)
(3, 10, 2),    -- Garlic (2 pcs)
(3, 9, 2),     -- Olive Oil (2 tbsp)
(3, 3, 1),     -- Salt (1 tsp)
(3, 13, 1);    -- Black Pepper (1 tsp)
