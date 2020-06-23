
DROP TABLE users;
CREATE TABLE users(
    id              INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    name            VARCHAR(255) NOT NULL,
    email           VARCHAR(255) NOT NULL,
    contactNumber   VARCHAR(255) NOT NULL,
    type            VARCHAR(255) NOT NULL,
    hash            VARCHAR(255) NOT NULL,
    vehicalRegistrationNumber VARCHAR(255) DEFAULT NULL,
    licenseNumber VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (id),
    UNIQUE(email),
    UNIQUE(contactNumber)
);