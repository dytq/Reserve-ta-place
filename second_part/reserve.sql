/* Table */
CREATE TABLE Clients(
    num_client INT,
    nom VARCHAR(30) NOT NULL,
    prenom VARCHAR(30) NOT NULL,
    email VARCHAR(30) NOT NULL UNIQUE,
    mot_de_passe VARCHAR(30) NOT NULL,
    type_de_reduction VARCHAR(30) NOT NULL,
    PRIMARY KEY(num_client)
);
CREATE TABLE Film(
    num_film INT(3),
    nom VARCHAR(30) NOT NULL,
    genre VARCHAR(30) NOT NULL,
    duree INT NOT NULL,
    origine VARCHAR(30) NOT NULL,
    PRIMARY KEY(num_film)
);
CREATE TABLE Cinema(
    nom VARCHAR(30),
    companie VARCHAR(30) NOT NULL,
    PRIMARY KEY(nom)
);
CREATE TABLE Salle(
    num_salle INT,
    nom_du_cinema VARCHAR(30),
    nombre_de_place INT(3) NOT NULL,
    ville VARCHAR(30) NOT NULL,
    PRIMARY KEY(num_salle, nom_du_cinema),
    FOREIGN KEY(nom_du_cinema) REFERENCES Cinema(nom)
);
CREATE TABLE Veut_voir(
    num_client INT,
    num_film INT,
    prix INT NOT NULL,
    PRIMARY KEY(num_client, num_film),
    FOREIGN KEY(num_client) REFERENCES Clients(num_client),
    FOREIGN KEY(num_film) REFERENCES Film(num_film)
);
CREATE TABLE Note(
    num_client INT,
    num_film INT,
    note INT NOT NULL,
    PRIMARY KEY(num_client, num_film),
    FOREIGN KEY(num_client) REFERENCES Clients(num_client),
    FOREIGN KEY(num_film) REFERENCES Film(num_film)
);
CREATE TABLE Suit(
    num_film_prec INT,
    num_film_suiv INT,
    PRIMARY KEY(
        num_film_prec,
        num_film_suiv
    ),
    FOREIGN KEY(num_film_prec) REFERENCES Film(num_film),
    FOREIGN KEY(num_film_suiv) REFERENCES Film(num_film)
);
CREATE TABLE Se_joue_dans(
    jour VARCHAR(30),
    heure VARCHAR(30),
    version VARCHAR(30) NOT NULL,
    num_film INT,
    num_salle INT,
    PRIMARY KEY(
        num_film,
        num_salle,
        jour,
        heure
    ),
    FOREIGN KEY(num_film) REFERENCES Film(num_film),
    FOREIGN KEY(num_salle) REFERENCES Salle(num_salle)
);
CREATE TABLE Personne(
    num_personne INT,
    nom VARCHAR(30) NOT NULL,
    prenom VARCHAR(30) NOT NULL,
    age INT NOT NULL,
    metier VARCHAR(30) NOT NULL,
    PRIMARY KEY(num_personne)
);
CREATE TABLE Participe_au_film(
    num_personne INT,
    num_film INT,
    PRIMARY KEY(num_personne, num_film),
    FOREIGN KEY(num_personne) REFERENCES Personne(num_personne),
    FOREIGN KEY(num_film) REFERENCES Film(num_film)
);

/* Vue */
create view film_vf
from film f, se_joue_dans j
where f.num_film = j.num_film
and j.version like "vf";

create view film_vo
from film f, se_joue_dans j
where f.num_film = j.num_film
and j.version like "vo";

create view personne_majeur
from personne p
where p.age >= 18;

create view client_avec_reduction
from clients c
where c.type_de_reduction <> "none";

/* Database */
create database Projet;

create user 'Client'@'localhost' identified by 'client';
create user 'Admin'@'localhost' identified by 'admin';
create user 'Anonyme'@'localhost' identified by 'anonyme';

grant all on Projet.* to 'Admin'@'localhost';

grant select on Projet.* to 'Anonyme'@'localhost';
revoke select from Projet.Clients from 'Anonyme'@'localhost';
revoke select from Projet.VeutVoir from 'Anonyme'@'localhost';
revoke select from Projet.Note from 'Anonyme'@'localhost';

grant select on Projet.* to 'Client'@'localhost';
grant all from Projet.Clients from 'Client'@'localhost';
grant all from Projet.VeutVoir from 'Client'@'localhost';
grant all from Projet.Note from 'Client'@'localhost';

/* Requête d'insertion */

/* Clients */
insert into Clients values (1, "Marley", "Bob", "bob.marley@email.com", "bob", "none");
insert into Clients values (2, "Queen", "Alice", "alice.queen@email.com", "alice", "have");
insert into Clients values (3, "Dubreuil", "Clément", "clement.dubreuil@email.com", "clement", "none");
insert into Clients values (4, "Abral", "Mohamed", "mohamed.abral@email.com", "mohamed", "have");
insert into Clients values (5, "Dupont", "Clément", "clement.dupont@email.com", "clement", "none");
insert into Clients values (6, "Zuckerberg", "Mark", "mark.zuckerberg@email.com", "mark", "have");
insert into Clients values (7, "Dupond", "Charles", "charles.dupond@email.com", "charles", "none");
insert into Clients values (8, "Daf", "Max", "max.daf@email.com", "max", "none");
insert into Clients values (9, "Lemond", "Max", "max.lemond@email.com", "max", "none");
insert into Clients values (10, "Valgrin", "Brad", "brad.valgrin@email.com", "brad", "none");

/* Cinema */
insert into Cinema values ("Pathé Boulogne", "Pathé Gaumont");
insert into Cinema values ("Ciné-Sel", "Sel");
insert into Cinema values ("UGC Versailles", "UGC");
insert into Cinema values ("UGC Vélizy", "UGC");

/* Salle */
insert into Salle values (1, "Pathé Boulogne", 60, "Boulogne");
insert into Salle values (2, "Pathé Boulogne", 60, "Boulogne");
insert into Salle values (3, "Pathé Boulogne", 40, "Boulogne");
insert into Salle values (4, "Pathé Boulogne", 30, "Boulogne");
insert into Salle values (1, "Ciné-Sel", 60, "Sèvres");
insert into Salle values (2, "Ciné-Sel", 60, "Sèvres");
insert into Salle values (3, "Ciné-Sel", 30, "Sèvres");
insert into Salle values (1, "UGC Versailles", 60, "Versailles");
insert into Salle values (2, "UGC Versailles", 30, "Versailles");
insert into Salle values (1, "UGC Vélizy", 60, "Vélizy");
insert into Salle values (2, "UGC Vélizy", 60, "Vélizy");
insert into Salle values (3, "UGC Vélizy", 60, "Vélizy");
insert into Salle values (4, "UGC Vélizy", 30, "Vélizy");

/* Film */
insert into Film values (1, "The Matrix", "SF", 120, "USA");
insert into Film values (2, "The Matrix reloaded", "SF", 120, "USA");
insert into Film values (3, "The Matrix revolution", "SF", 120, "USA");
insert into Film values (4, "The social network", "Biographie", 120, "USA");
insert into Film values (5, "V for Vendetta", "Action", 120, "USA");
insert into Film values (6, "Die hard", "Action", 120, "USA");
insert into Film values (7, "Toy Story", "Animation", 120, "USA");
insert into Film values (8, "Toy Story 2", "Animation", 120, "USA");
insert into Film values (9, "Toy Story 3", "Animation", 120, "USA");
insert into Film values (10, "Toy Story 4", "Animation", 120, "USA");

/* Personne */
/* Matrix (vérifié age) */
insert into Personne values (1, "Reeves", "Keanu", 55, "Acteur");
insert into Personne values (2, "Fishburne", "Laurence", 58, "Acteur");
insert into Personne values (3, "Wachowski", "Lilly", 62, "Directrice");
insert into Personne values (4, "Wachowski", "Lana", 60, "Directrice");
insert into Personne values (5, "Moss", "Carrie-Anne", 62, "Actrice");

/* The social Network */
insert into Personne values (6, "Fincher", "David", 57, "Directeur");
insert into Personne values (7, "Sorkin", "Aaron", 58, "Scenariste");
insert into Personne values (8, "Eisenberg", "Jesse", 36, "Acteur");
insert into Personne values (9, "Garfield", "Andrew", 36, "Acteur");
insert into Personne values (10, "Timberlake", "Justin", 38, "Acteur");

/* V for Vendetta */
insert into Personne values (11, "McTeigue", "James", 52, "Directeur");
insert into Personne values (12, "Weaving", "Hugo", 59, "Acteur");
insert into Personne values (13, "Portman", "Natalie", 38, "Actrice");
insert into Personne values (14, "Graves", "Rupert", 56, "Acteur");

/* Die hard */
insert into Personne values (15, "McTierman", "John", 68, "Directeur");
insert into Personne values (16, "Willis", "Bruce", 62, "Acteur");
insert into Personne values (17, "Stuart", "James", 63, "Scenariste");
insert into Personne values (18, "Rickman", "Alan", 69, "Acteur");

/* Toy Story 1 */
insert into Personne values (19, "Lasseter", "John", 62, "Directeur");
insert into Personne values (20, "Docter", "Pete", 51, "Scenariste");
insert into Personne values (21, "Hanks", "Tom", 63, "Doubleur");
insert into Personne values (22, "Allen", "Tim", 66, "Doubleur");
insert into Personne values (23, "Rickles", "Don", 90, "Doubleur");

/* Suit */
insert into Suit values (1, 2);
insert into Suit values (2, 3);
insert into Suit values (7, 8);
insert into Suit values (8, 9);
insert into Suit values (9, 10);

/* Participe au film */
insert into Participe_au_film values (1, 1);
insert into Participe_au_film values (2, 1);
insert into Participe_au_film values (3, 1);
insert into Participe_au_film values (4, 1);
insert into Participe_au_film values (5, 1);

insert into Participe_au_film values (1, 2);
insert into Participe_au_film values (2, 2);
insert into Participe_au_film values (3, 2);
insert into Participe_au_film values (4, 2);
insert into Participe_au_film values (5, 2);

insert into Participe_au_film values (1, 3);
insert into Participe_au_film values (2, 3);
insert into Participe_au_film values (3, 3);
insert into Participe_au_film values (4, 3);
insert into Participe_au_film values (5, 3);

insert into Participe_au_film values (6, 4);
insert into Participe_au_film values (7, 4);
insert into Participe_au_film values (8, 4);
insert into Participe_au_film values (9, 4);
insert into Participe_au_film values (10, 4);

insert into Participe_au_film values (3, 5);
insert into Participe_au_film values (4, 5);
insert into Participe_au_film values (11, 5);
insert into Participe_au_film values (12, 5);
insert into Participe_au_film values (13, 5);
insert into Participe_au_film values (14, 5);

insert into Participe_au_film values (15, 6);
insert into Participe_au_film values (16, 6);
insert into Participe_au_film values (17, 6);
insert into Participe_au_film values (18, 6);

insert into Participe_au_film values (19, 7);
insert into Participe_au_film values (20, 7);
insert into Participe_au_film values (21, 7);
insert into Participe_au_film values (22, 7);
insert into Participe_au_film values (23, 7);

/* Se_joue_dans */

/* Veut_voir */

/* Note */

/* Requète select */

/* Note Moyenne des film */
select f.nom, moy(n.note)
from Film f, Note n
where f.num_film = n.num_film
group by f.nom

/* nom, prenom des acteurs / actices jouant dans des film en vf */
select p.nom, p.prenom
from Personne p, film_vf vf, Participe_au_film pf
where p.num_personne = pf.num_personne
and vf.num_film = pf.num_film

/* nom des film ayant une suite et le nom du film */
select f_prec.nom, f_suiv.nom
from Film f_prec, Film f_suiv, Suit s
where f_prec.num_film = s.num_film_prec
or f_suiv.num_film = s.num_film_suiv
