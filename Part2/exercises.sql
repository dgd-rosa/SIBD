CREATE TABLE member
(
    number   INTEGER,
    name     VARCHAR(80),
    birthday DATE,
    PRIMARY KEY (number)
);

CREATE TABLE employee
(
    name        VARCHAR(80),
    description VARCHAR(80),
    birthday    DATE,
    PRIMARY KEY (name)
);

CREATE TABLE class
(
    time     INTEGER,
    activity VARCHAR(80),
    name     VARCHAR(80),
    PRIMARY KEY (time, activity),
    FOREIGN KEY (name) REFERENCES employee (name)
);

CREATE TABLE participant
(
    number   INTEGER,
    time     INTEGER,
    activity VARCHAR(80),
    PRIMARY KEY (number, time, activity),
    FOREIGN KEY (time, activity) REFERENCES class (time, activity),
    FOREIGN KEY (number) REFERENCES member (number)
);

INSERT INTO employee
VALUES ('In 1', 'YAY', '1999-01-22');

INSERT INTO member
VALUES (55, 'Mem 1', '1999-01-22');
INSERT INTO member
VALUES (75, 'Mem 2', '1999-01-22');

INSERT INTO class
VALUES (10, 'cycling', 'In 1');
INSERT INTO class
VALUES (20, 'cycling', 'In 1');

INSERT INTO class
VALUES (10, 'aerobics', 'In 1');
INSERT INTO class
VALUES (20, 'aerobics', 'In 1');

INSERT INTO participant
VALUES (55, 10, 'cycling');
INSERT INTO participant
VALUES (55, 20, 'cycling');

INSERT INTO participant
VALUES (75, 10, 'aerobics');

SELECT p1.number
FROM participant p1
WHERE EXISTS(
              SELECT p2.number
              FROM participant p2
              WHERE p1.number = p2.number
                AND p2.activity = 'aerobics'
                AND p1.number IN (
                  SELECT p3.number
                  FROM participant p3
                  WHERE p1.number = p3.number
                    AND p3.activity = 'cycling'
              )
          );

SELECT number
FROM participant
WHERE number IN (SELECT number
                 FROM participant
                 WHERE activity = 'cycling')
  AND number IN (SELECT number
                 FROM participant
                 WHERE activity = 'aerobics');


INSERT INTO class
VALUES (10, 'yoga', 'In 1');
INSERT INTO class
VALUES (20, 'yoga', 'In 1');

INSERT INTO participant
VALUES (55, 10, 'yoga');
INSERT INTO participant
VALUES (55, 20, 'yoga');
INSERT INTO participant
VALUES (75, 20, 'yoga');


SELECT number
FROM participant
WHERE activity = 'yoga'
GROUP BY number
HAVING COUNT(activity) = (
    SELECT COUNT(*)
    FROM class
    WHERE class.activity = 'yoga'
);

select number
from member as m
where not exists(
        select *
        from class as c
        where activity = 'yoga'
          and not exists(
                select *
                from participant as p
                where p.number = m.number
                  and p.time = c.time
                  and p.activity = c.activity));



CREATE TABLE posse_livro
(
    pessoa     VARCHAR(80),
    nome_livro VARCHAR(80),
    PRIMARY KEY (pessoa, nome_livro)
);


CREATE TABLE personagens
(
    nome_livro  VARCHAR(80),
    super_heroi VARCHAR(80),
    PRIMARY KEY (nome_livro, super_heroi)
);


CREATE TABLE gostos
(
    pessoa  VARCHAR(80),
    super_heroi VARCHAR(80),
    PRIMARY KEY (pessoa, super_heroi)
);


INSERT INTO personagens VALUES ('xx Swamp Thing', 'Super');
INSERT INTO personagens VALUES ('xx Swamp Thing xx', 'Super');
INSERT INTO personagens VALUES ('xxass Swamp Thing', 'Super');

INSERT INTO personagens VALUES ('xxass Swamp Thing', 'Superw');
INSERT INTO personagens VALUES ('xxasdasdass Swamp Thing', 'Superw');


INSERT INTO personagens VALUES ('xxasdasdass Swamp Thing', 'Shitty');


SELECT super_heroi
FROM personagens
WHERE nome_livro LIKE '%Swamp Thing%'
GROUP BY super_heroi
HAVING count(distinct nome_livro) >= 2;



SELECT distinct p1.super_heroi
FROM personagens p1, personagens p2
WHERE p1.nome_livro <> p2.nome_livro AND p1.super_heroi = p2.super_heroi
AND p1.nome_livro LIKE '%Swamp Thing%' AND p2.nome_livro LIKE '%Swamp Thing%'





