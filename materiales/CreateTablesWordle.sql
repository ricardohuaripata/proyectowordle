
DROP DATABASE IF EXISTS wordle_db

CREATE DATABASE wordle_db

USE wordle_db

GO

CREATE TABLE Palabras (

idPalabra INT PRIMARY KEY IDENTITY(1,1),
palabra VARCHAR(5) NOT NULL,
fecha DATE NOT NULL
)

CREATE TABLE Jugadores (

idJugador INT PRIMARY KEY IDENTITY(1,1),
nick NVARCHAR(250) NOT NULL,
numPartidas INT NULL,
mediaIntentos DECIMAL(18,2) NULL,
aciertos INT NULL,
porcentajeAciertos DECIMAL(18,2) NULL

)

CREATE TABLE Intentos (

idIntento INT PRIMARY KEY IDENTITY(1,1),
idJugador INT NOT NULL,
palabraIntento VARCHAR(5) NOT NULL,
fecha DATE NOT NULL,
resultado VARCHAR(5) NULL --5 LETRAS, ejemplo: ('VVVAG') V=VERDE, A=AMARILLO, G=GRIS
CONSTRAINT fkJugadorIntentos FOREIGN KEY(idJugador) REFERENCES Jugadores(idJugador),

)