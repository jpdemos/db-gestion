SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER GenPassword
   ON PERSONNEL
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON;

	DECLARE @password varchar( 6 ) = '';
	DECLARE @cat float = 0;
	DECLARE @rand int;

	WHILE LEN( @password ) < 6
	BEGIN
		SET @cat = RAND();
		SET @rand = CONVERT( int, RAND() * 100 );

		-- Une chance sur trois de tomber dans une des catégories de caractères à ajouter. [A-Z], [a-z] ou [0-9]
		IF @cat <= 0.33 -- [A-Z]
		BEGIN
			SET @password = CONCAT( @password, CHAR( 65 + @rand % 25 ) );
		END
		ELSE IF @cat BETWEEN 0.33 AND 0.66 -- [a-z]
		BEGIN
			SET @password = CONCAT( @password, CHAR( 97 + @rand % 25 ) );
		END
		ELSE -- [0-9] plus grand que 0.66
		BEGIN
			SET @password = CONCAT( @password, CHAR( 48 + @rand % 9 ) );
		END

	END;

	--SELECT @password AS 'Mot de passe généré'

	UPDATE PERSONNEL
    SET uLogin = P.MATRICULE, uPassword = @password
	FROM PERSONNEL AS P, inserted AS I
	WHERE P.idPersonnel = I.idPersonnel;

END
GO