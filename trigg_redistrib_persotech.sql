SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER Redistribution_PersonnelTechnicien
   ON personnel_technicien
   INSTEAD OF INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	
	-- Redistribution des inserts de la vue dans les tables concernées
	INSERT INTO PERSONNEL
	(	idPersonnel, nomPersonnel, prenomPersonnel, adressePersonnel,
		matricule, dateEmb, uLogin, uPassword )
	SELECT
		I.idPersonnel, I.nomPersonnel, I.prenomPersonnel,
		I.adressePersonnel, I.matricule, I.dateEmb, I.uLogin, I.uPassword
	FROM inserted I
	
	-- @@identity correspond à l'id de l'insertion au dessus
	INSERT INTO TECHNICIEN ( idPersonnel, nivIntervention, formation )
	SELECT @@identity, I.nivIntervention, I.formation
	FROM inserted I
    
END
GO
