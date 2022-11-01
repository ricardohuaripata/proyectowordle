USE wordle_db

GO

--metodo que devuelve 0 si el jugador no existe o 1 si el jugador existe
CREATE OR ALTER FUNCTION dbo.existeJugador(@nick AS NVARCHAR(250))
RETURNS BIT

BEGIN

	DECLARE @existe AS BIT

	IF (SELECT 1 FROM Jugadores WHERE nick=@nick)=1
		SET @existe=1
	ELSE
		SET @existe=0

	RETURN @existe

END

GO

--metodo para que me devuelva la palabra del dia

CREATE OR ALTER FUNCTION dbo.palabraDelDia()
RETURNS VARCHAR(5)

BEGIN

	DECLARE @palabraDelDia AS VARCHAR(5)

	SET @palabraDelDia=(SELECT palabra FROM Palabras WHERE fecha=FORMAT(GETDATE(), 'yyyy-MM-dd'))

	RETURN @palabraDelDia

END

GO

--metodo para que, dado un jugador, me diga cuantos intentos lleva en el dia de hoy.

CREATE OR ALTER FUNCTION dbo.intentosDeHoy(@idJugador AS INT)
RETURNS INT

BEGIN

	DECLARE @intentos AS INT

	SET @intentos=(SELECT COUNT(1) FROM Intentos WHERE fecha=FORMAT(GETDATE(), 'yyyy-MM-dd'))

	RETURN @intentos

END

GO

--metodo que calcule el resultado AVG (Amarillo Verde Gris) 

CREATE OR ALTER FUNCTION dbo.calcularResultado(@palabraBuena AS VARCHAR(5), @palabraIntento AS VARCHAR(5))
RETURNS VARCHAR(5)

AS

BEGIN

	DECLARE @resultado AS VARCHAR(5) = ''
	DECLARE @contador AS INT = 1
	DECLARE @letraIntento AS VARCHAR(1)
	DECLARE @letraBuena AS VARCHAR(1)

	WHILE @contador <= 5
	BEGIN

		SET @letraIntento = SUBSTRING(@palabraIntento, @contador, 1)
		SET @letraBuena = SUBSTRING(@palabraBuena, @contador, 1)

		IF @letraIntento = @letraBuena
		BEGIN
			SET @resultado += 'V'
		END

		ELSE IF CHARINDEX(@letraIntento,@palabraBuena) > 0
		BEGIN
			SET @resultado += 'A'
		END

		ELSE IF CHARINDEX(@letraIntento,@palabraBuena) = 0
		BEGIN
			SET @resultado += 'G'
		END

		SET @contador += 1

	END

	RETURN @resultado

END

GO

--trigger para que cuando se inserte algo en la tabla intentos, 
--recoga la palabra intentada y calcule el resultado segun la palabra del jugador y luego la guarde en la tabla intentos

CREATE OR ALTER TRIGGER TR_guardarResultado 
ON Intentos
FOR INSERT

AS

BEGIN

	DECLARE @palabraBuena AS VARCHAR(5) = (SELECT palabra FROM Palabras WHERE fecha=(SELECT fecha FROM inserted))
	DECLARE @palabraIntento AS VARCHAR(5) = (SELECT palabraIntento FROM inserted)
	DECLARE @idIntento AS INT = (SELECT idIntento FROM inserted)


	UPDATE Intentos SET resultado = dbo.calcularResultado(@palabraBuena, @palabraIntento)
	WHERE idIntento = @idIntento
	
END

GO

CREATE OR ALTER TRIGGER TR_guardarEstadisticas
ON Intentos
FOR INSERT

AS

BEGIN

	DECLARE @idJugador AS INT = (SELECT idJugador FROM inserted)

	DECLARE @numPartidas AS INT = (SELECT COUNT(DISTINCT(fecha)) FROM Intentos WHERE idJugador=@idJugador)

	DECLARE @mediaIntentos AS DECIMAL(18,2) = ( (SELECT COUNT(1) FROM Intentos WHERE idJugador=@idJugador) / @numPartidas )

	DECLARE @aciertos AS INT = (SELECT COUNT(1) FROM Intentos WHERE resultado='VVVVV' AND idJugador=@idJugador)

	DECLARE @porcentajeAciertos AS DECIMAL(18,2) = (100/@numPartidas)*@aciertos

	UPDATE Jugadores SET numPartidas=@numPartidas,
	mediaIntentos=@mediaIntentos,
	aciertos=@aciertos,
	porcentajeAciertos=@porcentajeAciertos
	WHERE idJugador=@idJugador
	
END

GO

CREATE OR ALTER PROCEDURE jugarPartida @nick AS NVARCHAR(250), @palabraIntentada AS VARCHAR(5)
AS

BEGIN

	IF dbo.existeJugador(@nick)=0
		INSERT INTO Jugadores(nick) VALUES(@nick)

	DECLARE @idJugador AS INT = (SELECT idJugador FROM Jugadores WHERE nick=@nick)

	INSERT INTO Intentos (idJugador, palabraIntento, fecha)
	VALUES (@idJugador, @palabraIntentada, FORMAT(GETDATE(), 'yyyy-MM-dd'))
	
END

GO
-- trigger mejorado con cursor
CREATE OR ALTER TRIGGER TR_guardarResultado 
ON Intentos
FOR INSERT

AS

BEGIN

	DECLARE @palabraBuena AS VARCHAR(5)
	DECLARE @palabraIntento AS VARCHAR(5)
	DECLARE @idIntento AS INT
	DECLARE @fechaIntento AS DATE

	DECLARE intento CURSOR FOR SELECT idIntento FROM inserted
	OPEN intento
	FETCH NEXT FROM intento INTO @idIntento

	WHILE @@FETCH_STATUS = 0
		BEGIN

		SET @fechaIntento = (SELECT fecha FROM Intentos WHERE idIntento=@idIntento)
		SET @palabraBuena = (SELECT palabra FROM Palabras WHERE fecha=@fechaIntento)
		SET @palabraIntento = (SELECT palabraIntento FROM Intentos WHERE idIntento=@idIntento)
		UPDATE Intentos SET resultado = dbo.calcularResultado(@palabraBuena, @palabraIntento)
		WHERE idIntento = @idIntento

		FETCH NEXT FROM intento INTO @idIntento

		END

	CLOSE intento
	DEALLOCATE intento
	
END
