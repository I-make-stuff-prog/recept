-- =========================
-- Units Table
-- =========================
CREATE TABLE units (
    id INT AUTO_INCREMENT PRIMARY KEY,
    unit_name VARCHAR(50) NOT NULL UNIQUE,
    unit_symbol VARCHAR(10) NOT NULL
);

-- =========================
-- Ingredients Table
-- =========================
CREATE TABLE ingredients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ingredient_name VARCHAR(100) NOT NULL UNIQUE,
    default_unit_id INT NOT NULL,
    FOREIGN KEY (default_unit_id) REFERENCES units(id)
);

-- =========================
-- Recipes Table
-- =========================
CREATE TABLE recipes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    recipe_name VARCHAR(150) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- Junction Table (Many-to-Many)
-- =========================
CREATE TABLE recipe_ingredients (
    recipe_id INT NOT NULL,
    ingredient_id INT NOT NULL,
    quantity DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (recipe_id, ingredient_id),

    FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(id)
);
