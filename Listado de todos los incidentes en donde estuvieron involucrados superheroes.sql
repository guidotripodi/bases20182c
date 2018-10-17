SELECT 
    incidente.Numero AS NumeroIncidente,
    superheroe.Nombre AS Participa,
    persona.Nombre AS CausadoPor
FROM
    mydb.Superheroe superheroe,
    mydb.Archienemigo archienemigo,
    mydb.Involucra involucra,
    mydb.Participa participa,
    mydb.Incidente incidente,
    mydb.Persona persona
WHERE
    superheroe.idSuperheroe = participa.idSuperheroe
        AND incidente.idIncidente = participa.idIncidente
        AND archienemigo.idSuperheroe = superheroe.idSuperheroe
        AND archienemigo.idPersona = persona.idPersona
        AND involucra.idPersona = persona.idPersona
        AND involucra.idIncidente = incidente.idIncidente
        AND involucra.Rol LIKE 'Sospechoso'
GROUP BY incidente.Numero , superheroe.Nombre , persona.Nombre
;
