SELECT 
    oficial.Nombre AS NombreOficial,
    oficial.Apellido As ApellidoOficial
FROM
    mydb.Interviene AS interviene,
    mydb.Sumario AS sumario,
    mydb.Oficial AS oficial,
    mydb.Designacion AS designacion
WHERE
    interviene.num = oficial.num
        AND designacion.num = oficial.num
        AND designacion.idDesignacion = sumario.idDesignacion
GROUP BY oficial.Datos;