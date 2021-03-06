USE [PARIS]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER TRIGGER [dbo].[GenPassword]
   ON [dbo].[PERSONNEL]
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	
	-- Login = matricule
	-- Mot de passe = généré
	UPDATE PERSONNEL
    SET uLogin = P.MATRICULE, uPassword = dbo.GeneratePassword( 6 )
	FROM PERSONNEL P, inserted I
	WHERE P.idPersonnel = I.idPersonnel;
	
END
