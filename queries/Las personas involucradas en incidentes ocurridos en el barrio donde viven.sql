SELECT 
    persona.Nombre AS Nombre,
    persona.Apellido AS Apellido,
    barrio.Nombre AS Barrio
FROM
    mydb.Persona persona,
    mydb.Barrio barrio,
    mydb.Involucra involucra,
    mydb.Incidente incidente,
    mydb.Direccion direccion
WHERE
    persona.idBarrio = barrio.idBarrio
        AND persona.idPersona = involucra.idPersona
        AND incidente.idIncidente = involucra.idIncidente
        AND incidente.idDireccion = direccion.idDireccion
        AND direccion.Barrio_idBarrio = barrio.idBarrio
GROUP BY persona.Nombre , persona.Apellido , barrio.Nombre
;