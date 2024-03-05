-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it

-- Represent active ingredients
CREATE TABLE "active_ingredient" (
    "id" INTEGER,
    "IngredientName" TEXT NOT NULL,
    "ChemicalFormula" TEXT NOT NULL,
    "PharmacologyClassID" INT,
    "DiseaseID" INT,
    "DosageFormID" INT,
    PRIMARY KEY("id")
    FOREIGN KEY("PharmacologyClassID") REFERENCES "pharmacology"("id"),
    FOREIGN KEY("DiseaseID") REFERENCES "disease"("id"),
    FOREIGN KEY("DosageFormID") REFERENCES "dosage"("id")
);

-- Represent pharmacology classes
CREATE TABLE "pharmacology" (
    "id" INTEGER,
    "ClassName" TEXT NOT NULL,
    PRIMARY KEY("id")
);

-- Represent diseases
CREATE TABLE "disease" (
    "id" INTEGER,
    "DiseaseName" TEXT NOT NULL UNIQUE,
    "Class" TEXT,
    PRIMARY KEY("id")
    FOREIGN KEY("Class") REFERENCES "DiseaseClassification"("id")
);

-- Represent Dosage forms
CREATE TABLE "dosage" (
    "id" INTEGER,
    "DosageFormula" TEXT NOT NULL,
    PRIMARY KEY("id")
);

-- Represent Diseases Classification
CREATE TABLE "DiseaseClassification" (
    "id" INTEGER,
    "class" TEXT NOT NULL,
    "type" TEXT CHECK(type IN ('infectious','non-infectious')),
     PRIMARY KEY("id")
);

-- Create indexes to speed common searches
CREATE INDEX "ai_search" ON "active_ingredient" ("IngredientName", "ChemicalFormula");
CREATE INDEX "disease_search" ON "disease" ("DiseaseName");
CREATE INDEX "pharma_search" ON "pharmacology" ("ClassName");

-- Create some views
CREATE VIEW ActiveIngredientDetails AS
SELECT active_ingredient.IngredientName, active_ingredient.ChemicalFormula, pharmacology.ClassName, disease.DiseaseName
FROM active_ingredient
INNER JOIN pharmacology ON active_ingredient.PharmacologyClassID = pharmacology.id
INNER JOIN disease ON active_ingredient.DiseaseID = disease.id;

CREATE VIEW DiseaseClassificationWithDiseases AS
SELECT DiseaseClassification.class, DiseaseClassification.type, disease.DiseaseName
FROM DiseaseClassification
INNER JOIN disease ON DiseaseClassification.id = disease.Class;


