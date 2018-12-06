SELECT 
    persona.Nombre AS Nombre,
    persona.Apellido AS Apellido,
    barrio.Nombre AS Barrio
FROM
    mydb.Persona persona,
    mydb.Barrio barrio,
    mydb.Involucra involucra,
    mydb.Incidente incidente,
    mydb.Direccion direccion,
    mydb.Direccion direccion2
WHERE
    persona.Direccion_idDireccion = direccion.idDireccion
    AND direccion.Barrio_idBarrio = barrio.idBarrio
        AND persona.idPersona = involucra.idPersona
        AND incidente.idIncidente = involucra.idIncidente
        AND incidente.idDireccion = direccion2.idDireccion
        AND direccion2.Barrio_idBarrio = barrio.idBarrio

;