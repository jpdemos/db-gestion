-- reset l'indentité
DBCC CHECKIDENT (PERSONNEL, RESEED, 0);

-- Chacune des executions ci-dessous doivent créer un matricule, login et mot de passe grace aux triggers concernés
-- UpdateMatricule, GenPassword

--insertion multiple - plusieurs insert
INSERT INTO PERSONNEL
( nomPersonnel, prenomPersonnel, adressePersonnel, dateEmb )
VALUES
('Paris', 'Julien', '268 Av. Bir Hakeim', '01-01-2017');

INSERT INTO PERSONNEL
( nomPersonnel, prenomPersonnel, adressePersonnel, dateEmb )
VALUES
('Alatete', 'Jemal', 'Rue Jeuno', '11-06-2016');


-- Insertion multiple - un seul insert
INSERT INTO PERSONNEL
( nomPersonnel, prenomPersonnel, adressePersonnel, dateEmb )
VALUES
('Paris', 'Julien', '268 Av. Bir Hakeim', '01-01-2017'),
('Alatete', 'Jemal', 'Rue Jeuno', '11-06-2016'),
('Éussi', 'Gépar', 'Rue Marvel', '07-04-2015');


/*
---- VÉRIFICATIONS ----
*/

-- Vérification des matricules
SELECT P.idPersonnel, P.nomPersonnel, P.prenomPersonnel, P.matricule,
	 CASE
		WHEN UPPER( SUBSTRING( P.nomPersonnel, 1, 2 ) + SUBSTRING( P.prenomPersonnel, 1, 2 ) + CONVERT( varchar, P.idPersonnel ) ) = P.matricule
		THEN 'Valide'
		ELSE 'Invalide'
		END AS 'Conformité'
FROM PERSONNEL AS P;

-- Ou..
SELECT P.idPersonnel, P.nomPersonnel, P.prenomPersonnel, P.matricule
FROM PERSONNEL AS P
WHERE UPPER( SUBSTRING( P.nomPersonnel, 1, 2 ) + SUBSTRING( P.prenomPersonnel, 1, 2 ) + CONVERT( varchar, P.idPersonnel ) ) = P.matricule;

-- Vérification des login et mot de passe de chaque personnes
SELECT P.idPersonnel, P.nomPersonnel, P.prenomPersonnel, P.uLogin, P.uPassword,
	CASE
		WHEN P.uLogin IS NULL AND P.uPassword IS NULL
		THEN 'Login et mdp invalide'
		WHEN P.uLogin IS NULL
		THEN 'Login invalide - NULL'
		WHEN P.uPassword IS NULL
		THEN 'Mot de passe invalide - NULL'
		WHEN P.uLogin != P.matricule
		THEN 'Login invalide - Ne correspond pas au matricule'
		ELSE 'Valide'
		END AS 'Conformité login et mdp'
FROM PERSONNEL P;