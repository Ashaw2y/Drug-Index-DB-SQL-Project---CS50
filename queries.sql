-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database

-- Retrieve all active ingredients and their chemical formulas
SELECT IngredientName, ChemicalFormula
FROM active_ingredient;

-- Find all diseases classified as "infectious"
SELECT DiseaseName
FROM disease
WHERE Class = (SELECT id FROM DiseaseClassification WHERE type = 'infectious');

-- Get details of an active ingredient by its name
SELECT *
FROM active_ingredient
WHERE IngredientName = 'Aspirin';

-- Add a new disease record
INSERT INTO disease (DiseaseName, Class)
VALUES ('Diabetes', (SELECT id FROM DiseaseClassification WHERE class = 'non-infectious'));

-- Create a new entry for an active ingredient
-- INSERT INTO active_ingredient (IngredientName, ChemicalFormula, PharmacologyClassID, DiseaseID, DosageFormID)
-- VALUES ('Paracetamol', 'C8H9NO2', 1, 2, 3);

-- Update the class of a disease
UPDATE disease
SET Class = (SELECT id FROM DiseaseClassification WHERE class = 'infectious')
WHERE DiseaseName = 'Influenza';

-- Change the name of an active ingredient
UPDATE active_ingredient
SET IngredientName = 'Acetaminophen'
WHERE IngredientName = 'Paracetamol';

-- Delete a specific disease record
DELETE FROM disease
WHERE DiseaseName = 'Common Cold';

-- Remove an active ingredient entry
DELETE FROM active_ingredient
WHERE ChemicalFormula = 'C8H9NO2';
