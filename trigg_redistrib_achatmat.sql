SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER Redistribution_AchatMateriel
   ON achat_materiel
   INSTEAD OF INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	
	-- Redistribution des inserts de la vue dans les tables concernées
	INSERT INTO MATERIEL ( idMat, idPersonnel, processeur, mem, disque )
	SELECT I.idMat, I.idPersonnel, I.processeur, I.mem, I.disque
	FROM inserted I
	
	-- @@identity correspond à l'id de l'insertion au dessus
	INSERT INTO ACHAT ( idMat, dateObtention, fournisseur )
	SELECT @@identity, I.dateObtention, I.fournisseur
	FROM inserted I
    
END
GO
