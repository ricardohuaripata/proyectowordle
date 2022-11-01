
USE wordle_db

GO

INSERT INTO Palabras(palabra,fecha)
VALUES('PERRO',FORMAT(GETDATE(), 'yyyy-MM-dd'))

INSERT INTO Palabras(palabra,fecha)
VALUES('AMIGO',FORMAT(GETDATE(), 'yyyy-MM-dd'))

INSERT INTO Palabras(palabra,fecha)
VALUES('PONER',FORMAT(GETDATE(), 'yyyy-MM-dd'))

INSERT INTO Palabras(palabra,fecha)
VALUES('MUJER',FORMAT(GETDATE(), 'yyyy-MM-dd'))

INSERT INTO Palabras(palabra,fecha)
VALUES('ARMAR',FORMAT(GETDATE(), 'yyyy-MM-dd'))

INSERT INTO Palabras(palabra,fecha)
VALUES('PARTE',FORMAT(GETDATE(), 'yyyy-MM-dd'))

INSERT INTO Palabras(palabra,fecha)
VALUES('MUNDO',FORMAT(GETDATE(), 'yyyy-MM-dd'))

INSERT INTO Palabras(palabra,fecha)
VALUES('NIVEL',FORMAT(GETDATE(), 'yyyy-MM-dd'))

INSERT INTO Palabras(palabra,fecha)
VALUES('MEJOR',FORMAT(GETDATE(), 'yyyy-MM-dd'))

INSERT INTO Palabras(palabra,fecha)
VALUES('GRUPO',FORMAT(GETDATE(), 'yyyy-MM-dd'))

INSERT INTO Palabras(palabra,fecha)
VALUES('FELIZ',FORMAT(GETDATE(), 'yyyy-MM-dd'))

INSERT INTO Palabras(palabra,fecha)
VALUES('FELIZ',FORMAT(GETDATE(), 'yyyy-MM-dd'))

INSERT INTO Palabras(palabra,fecha)
VALUES('LARGO',FORMAT(GETDATE(), 'yyyy-MM-dd'))

INSERT INTO Palabras(palabra,fecha)
VALUES('SABER',FORMAT(GETDATE(), 'yyyy-MM-dd'))

INSERT INTO Palabras(palabra,fecha)
VALUES('MIEDO',FORMAT(GETDATE(), 'yyyy-MM-dd'))

INSERT INTO Palabras(palabra,fecha)
VALUES('FINAL',FORMAT(GETDATE(), 'yyyy-MM-dd'))

INSERT INTO Palabras(palabra,fecha)
VALUES('BELLA',FORMAT(GETDATE(), 'yyyy-MM-dd'))

INSERT INTO Palabras(palabra,fecha)
VALUES('SNACK',FORMAT(GETDATE(), 'yyyy-MM-dd'))

INSERT INTO Palabras(palabra,fecha)
VALUES('SABIO',FORMAT(GETDATE(), 'yyyy-MM-dd'))

INSERT INTO Palabras(palabra,fecha)
VALUES('ETAPA',FORMAT(GETDATE(), 'yyyy-MM-dd'))

INSERT INTO Palabras(palabra,fecha)
VALUES('VIEJO',FORMAT(GETDATE(), 'yyyy-MM-dd'))

INSERT INTO Palabras(palabra,fecha)
VALUES('VIAJE',FORMAT(GETDATE(), 'yyyy-MM-dd'))

INSERT INTO Palabras(palabra,fecha)
VALUES('IDEAL',FORMAT(GETDATE(), 'yyyy-MM-dd'))

INSERT INTO Palabras(palabra,fecha)
VALUES('LLENO',FORMAT(GETDATE(), 'yyyy-MM-dd'))

INSERT INTO Palabras(palabra,fecha)
VALUES('CERCA',FORMAT(GETDATE(), 'yyyy-MM-dd'))

INSERT INTO Palabras(palabra,fecha)
VALUES('PAPEL',FORMAT(GETDATE(), 'yyyy-MM-dd'))

INSERT INTO Palabras(palabra,fecha)
VALUES('GIRAR',FORMAT(GETDATE(), 'yyyy-MM-dd'))

INSERT INTO Palabras(palabra,fecha)
VALUES('NUNCA',FORMAT(GETDATE(), 'yyyy-MM-dd'))

INSERT INTO Palabras(palabra,fecha)
VALUES('UNION',FORMAT(GETDATE(), 'yyyy-MM-dd'))

INSERT INTO Palabras(palabra,fecha)
VALUES('BREVE',FORMAT(GETDATE(), 'yyyy-MM-dd'))


UPDATE Palabras SET fecha = DATEADD(DAY,idPalabra-1,FORMAT(GETDATE(), 'yyyy-MM-dd'))
