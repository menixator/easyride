DROP TABLE rides;
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
    driverStatus VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (id),
    UNIQUE(email),
    UNIQUE(contactNumber)
);

CREATE TABLE rides(
    id              INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY ( START WITH 1, INCREMENT BY 1 ),
    userId          INTEGER NOT NULL REFERENCES users(id),
    driverId        INTEGER REFERENCES users(id),
    status          VARCHAR(255) NOT NULL,
    pickupLocationLongitude DOUBLE NOT NULL,
    pickupLocationLatitude DOUBLE NOT NULL,
    destinationLongitude DOUBLE NOT NULL,
    destinationLatitude DOUBLE NOT NULL,
    fare DOUBLE NOT NULL,
    requestedTimestamp TIMESTAMP NOT NULL,
    endTimestamp TIMESTAMP,
    distance DOUBLE NOT NULL,
    PRIMARY KEY(id)
);