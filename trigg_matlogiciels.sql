SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER Redistribution_MaterielLogiciels
   ON  materiel_logiciels
   INSTEAD OF INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @MatID int;
	
    INSERT INTO MATERIEL ( idMat, idPersonnel, processeur, mem, disque )
    SELECT I.idMat, I.idPersonnel, I.processeur, I.mem, I.disque
    FROM inserted I;
    
    SET @MatID = @@identity
    
    INSERT INTO LOGICIEL ( idLogiciel, nomLogiciel, dateInstallation )
    SELECT I.idLogiciel, I.nomLogiciel, I.dateInstallation
    FROM inserted I;
    
    -- Liaison entre le materiel et le logiciel
    INSERT INTO DISPOSER ( idMat, idLogiciel )
    SELECT @MatID, @@identity;
    
    

END
GO
