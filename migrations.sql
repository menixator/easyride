DROP TABLE notifs;
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
    UNIQUE(email)
);

CREATE TABLE rides(
    id              INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY ( START WITH 1, INCREMENT BY 1 ),
    userId          INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    driverId        INTEGER REFERENCES users(id) ON DELETE CASCADE,
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

-- ride status change
CREATE TABLE notifs(
    id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY( START WITH 1, INCREMENT BY 1),
    type VARCHAR(255) NOT NULL,
    rideId INTEGER NOT NULL REFERENCES rides(id) ON DELETE CASCADE,
    createdTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id)
);
INSERT INTO USERS(NAME, EMAIL, CONTACTNUMBER, TYPE, HASH, VEHICALREGISTRATIONNUMBER, LICENSENUMBER, DRIVERSTATUS)
VALUES('admin', 'admin@easycab', '', 'Admin', '21232f297a57a5a743894a0e4a801fc3', NULL, NULL, NULL),
('driver', 'driver@easycab', '', 'Driver', 'e2d45d57c7e2941b65c6ccd64af4223e', '000', '000', 'Offline'),
('customer', 'customer@easycab', '', 'Customer', '91ec1f9324753048c0096d036a694f86', NULL, NULL, NULL);