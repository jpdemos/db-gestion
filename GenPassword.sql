USE [PARIS]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[GeneratePassword]( @len int = 6 )
RETURNS varchar(32)
AS
BEGIN
	
	DECLARE @password varchar(32) = '';
	DECLARE @cat float = 0;
	DECLARE @rand int;
	
	WHILE LEN( @password ) < @len
	BEGIN
		
		-- @cat: nombre entre 0 et 1 (vient d'une vue qui genere un RAND() (RAND() est inutilisable dans une fonction))
		-- Ce nombre sert à définire la catégorie de caractère à ajouter: caractère minuscule, majuscule ou chiffre entre 0 et 9
		SELECT @cat = _RAND FROM RAND_GEN;
		
		-- @rand: nombre entre 0 et 100 (sera modulé par 25 ou 9 selon besoins)
		-- Ce nombre est entre 0 et 100 afin d'avoir plus de chance d'avoir 25 ou 9 (RAND() atteint rarement 1.0 ou 0.0)
		SELECT @rand = CONVERT( int, ( SELECT _RAND FROM RAND_GEN ) * 100 );
		
		-- Une chance sur trois de tomber dans une des catégories de caractères à ajouter. [A-Z], [a-z] ou [0-9]
		IF @cat < 0.33 -- [A-Z]
		BEGIN
			SET @password = @password + CHAR( 65 + @rand % 25 );
		END
		ELSE IF @cat BETWEEN 0.33 AND 0.66 -- [a-z]
		BEGIN
			SET @password = @password + CHAR( 97 + @rand % 25 );
		END
		ELSE -- [0-9] plus grand que 0.66
		BEGIN
			SET @password = @password + CHAR( 48 + @rand % 9 );
		END
		
	END
	
	RETURN @password;
END
