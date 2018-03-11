SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER UpdateMatricule
   ON  PERSONNEL
   AFTER INSERT, UPDATE
AS
	
BEGIN
	SET NOCOUNT ON;
	
	-- DECLARE @ID int = @@IDENTITY;
	-- On utilise I.idPersonnel à la place de @@IDENTITY car celui-ci ne correspond qu'au dernier ID inséré et donc ne modifira que la derniere ligne.
	
	UPDATE PERSONNEL
	SET matricule = UPPER( SUBSTRING( I.nomPersonnel, 1,2 ) + SUBSTRING( I.prenomPersonnel, 1, 2 ) ) + CONVERT( varchar, I.idPersonnel )
	FROM PERSONNEL AS P, inserted AS I
	WHERE P.idPersonnel = I.idPersonnel;

END
GO
