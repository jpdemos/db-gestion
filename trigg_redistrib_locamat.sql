SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER Redistribution_LocationMateriel
   ON location_materiel
   INSTEAD OF INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	
	-- Redistribution des inserts de la vue dans les tables concernées
	INSERT INTO MATERIEL ( idMat, idPersonnel, processeur, mem, disque )
	SELECT I.idMat, I.idPersonnel, I.processeur, I.mem, I.disque
	FROM inserted I
	
	-- @@identity correspond à l'id de l'insertion au dessus
	INSERT INTO LOCATION ( idMat, dateDebLoc, dateFinLoc, ticketsDispo )
	SELECT @@identity, I.dateDebLoc, I.dateFinLoc, I.ticketsDispo
	FROM inserted I
    
END
GO
