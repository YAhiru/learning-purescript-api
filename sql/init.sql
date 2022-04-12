CREATE TABLE users
(
    id        INTEGER      NOT NULL CONSTRAINT users_pk PRIMARY KEY,
    firstName VARCHAR(255) NOT NULL,
    lastName  VARCHAR(255) NOT NULL
);

INSERT INTO users (id, firstName, lastName)
VALUES (1, 'Patricia', 'Smith'),
       (2, 'Linda', 'Johnson'),
       (3, 'Mary', 'William'),
       (4, 'Robert', 'Jones'),
       (5, 'James', 'Brown'),
       (6, 'Susan', 'Taylor');