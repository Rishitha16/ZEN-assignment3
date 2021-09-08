CREATE DATABASE imdb;
USE imdb;

CREATE TABLE movies (movie_id int NOT NULL, movie_name varchar(30) NOT NULL);
ALTER TABLE movies ADD CONSTRAINT movies_movie_id_pk PRIMARY KEY(movie_id);

CREATE TABLE reviews (review_id int NOT NULL, movie_id int, user_id int, description varchar(100));
ALTER TABLE reviews ADD CONSTRAINT reviews_rid_mid_pk PRIMARY KEY(review_id, movie_id);

CREATE TABLE genres (genre_id int NOT NULL, genre_name varchar(50));
ALTER TABLE genres ADD CONSTRAINT genre_gid_pk PRIMARY KEY(genre_id);

CREATE TABLE movie_genre_bridge (movie_id int NOT NULL, genre_id int NOT NULL);
ALTER TABLE movie_genre_bridge ADD CONSTRAINT mgb_mid_gid_pk PRIMARY KEY(movie_id, genre_id);

CREATE TABLE actors (actor_id int NOT NULL, actor_name varchar(30), gender char(1));
ALTER TABLE actors ADD CONSTRAINT actors_aid_pk PRIMARY KEY(actor_id);

CREATE TABLE roles (role_id int NOT NULL, role_name varchar(50));
ALTER TABLE roles ADD CONSTRAINT roles_rid_pk PRIMARY KEY(role_id);

CREATE TABLE movie_actor_bridge (movie_id int NOT NULL, actor_id int NOT NULL);
ALTER TABLE movie_actor_bridge ADD CONSTRAINT mab_mid_aid_pk PRIMARY KEY(movie_id, actor_id);

CREATE TABLE actor_role_bridge (actor_id int NOT NULL, role_id int NOT NULL);
ALTER TABLE actor_role_bridge ADD CONSTRAINT arb_aid_rid_pk PRIMARY KEY(actor_id, role_id);

CREATE TABLE media (media_id int NOT NULL, image blob(100), video blob(100), movie_id int);
ALTER TABLE media ADD CONSTRAINT media_mid_pk PRIMARY KEY(media_id);

CREATE TABLE skills (skill_id int NOT NULL, skill_name varchar(50));
ALTER TABLE skills ADD CONSTRAINT skills_sid_pk PRIMARY KEY(skill_id);

CREATE TABLE actor_skills_bridge (actor_id int NOT NULL, skill_id int NOT NULL);
ALTER TABLE actor_skills_bridge ADD CONSTRAINT asb_aid_sid_pk PRIMARY KEY(actor_id, skill_id);

CREATE TABLE users (user_id int NOT NULL, user_name varchar(30));
ALTER TABLE users ADD CONSTRAINT users_uid_pk PRIMARY KEY(user_id);

ALTER TABLE movie_genre_bridge ADD CONSTRAINT mgb_mid_fk FOREIGN KEY (movie_id) REFERENCES movies(movie_id);
ALTER TABLE movie_genre_bridge ADD CONSTRAINT mgb_gid_fk FOREIGN KEY (genre_id) REFERENCES genres(genre_id);
ALTER TABLE movie_actor_bridge ADD CONSTRAINT mab_mid_fk FOREIGN KEY (movie_id) REFERENCES movies(movie_id);
ALTER TABLE movie_actor_bridge ADD CONSTRAINT mab_aid_fk FOREIGN KEY (actor_id) REFERENCES actors(actor_id);
ALTER TABLE actor_role_bridge ADD CONSTRAINT arb_aid_fk FOREIGN KEY (actor_id) REFERENCES actors(actor_id);
ALTER TABLE actor_role_bridge ADD CONSTRAINT arb_rid_fk FOREIGN KEY (role_id) REFERENCES roles(role_id);
ALTER TABLE media ADD CONSTRAINT media_mid_fk FOREIGN KEY (movie_id) REFERENCES movies(movie_id);
ALTER TABLE reviews ADD CONSTRAINT reviews_mid_fk FOREIGN KEY (movie_id) REFERENCES movies(movie_id);
ALTER TABLE reviews ADD CONSTRAINT reviews_uid_fk FOREIGN KEY (user_id) REFERENCES users(user_id);

INSERT INTO movies (movie_id, movie_name) VALUES (1, 'The Intern'), (2, '2 States'), (3, 'Love, Rosie');
INSERT INTO users (user_id, user_name) VALUES (1, 'Rishitha'), (2, '2 Harshitha'), (3, 'Aamukta');
INSERT INTO reviews (review_id, movie_id, user_id, description) VALUES (1, 2, 3, 'Outstanding'), (2, 3, 2, 'Heart touching'), (3, 1, 1, 'Inspiring');
INSERT INTO media (media_id, movie_id) VALUES (1, 2), (2, 3), (3, 1);
INSERT INTO genres (genre_id, genre_name) VALUES (1, 'Rom-com'), (2, 'Comedy'), (3, 'Romance');
INSERT INTO actors (actor_id, actor_name) VALUES (1, 'Lily Collins'), (2, 'Anne Hathaway'), (3, 'Alia Bhatt');
INSERT INTO roles (role_id, role_name) VALUES (1, 'Rosie'), (2, 'Jules'), (3, 'Ananya');
INSERT INTO skills (skill_id, skill_name) VALUES (1, 'Acting'), (2, 'Dancing'), (3, 'Singing');
INSERT INTO movie_genre_bridge (movie_id, genre_id) VALUES (1, 2), (2, 3), (3, 1);
INSERT INTO movie_actor_bridge (movie_id, actor_id) VALUES (1, 2), (2, 3), (3, 1);
INSERT INTO actor_role_bridge (actor_id, role_id) VALUES (1, 1), (2, 2), (3, 3);
INSERT INTO actor_skills_bridge (actor_id, skill_id) VALUES (1, 1), (2, 1), (3, 1);

SELECT *FROM media INNER JOIN movies ON media.movie_id = movies.movie_id;
SELECT *FROM media, reviews, movies WHERE media.movie_id = movies.movie_id AND reviews.movie_id = movies.movie_id;
SELECT reviews.user_id, user_name, description FROM reviews, users WHERE reviews.user_id = users.user_id;
SELECT *FROM actors a LEFT OUTER JOIN actor_skills_bridge b ON a.actor_id = b.actor_id LEFT OUTER JOIN skills c ON b.skill_id = c.skill_id;
SELECT *FROM actors a LEFT OUTER JOIN actor_role_bridge b ON a.actor_id = b.actor_id LEFT OUTER JOIN roles c ON b.role_id = c.role_id;
