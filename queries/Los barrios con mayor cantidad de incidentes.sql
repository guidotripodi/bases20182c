SELECT 
    barrio.Nombre AS NombreBarrio,
    COUNT(*) AS CantidadDeIncidentes
FROM
    mydb.Barrio barrio,
    mydb.Direccion direccion,
    mydb.Incidente incidente
WHERE
    incidente.idDireccion = direccion.idDireccion
        AND direccion.Barrio_idBarrio = barrio.idBarrio
GROUP BY barrio.idBarrio
HAVING COUNT(*) >= ALL (SELECT 
        COUNT(*)
    FROM
        mydb.Barrio barrio1,
        mydb.Direccion direccion1,
        mydb.Incidente incidente1
    WHERE
        incidente1.idDireccion = direccion1.idDireccion
            AND direccion1.Barrio_idBarrio = barrio1.idBarrio
            AND barrio.idBarrio != barrio1.idBarrio
    GROUP BY barrio1.idBarrio);