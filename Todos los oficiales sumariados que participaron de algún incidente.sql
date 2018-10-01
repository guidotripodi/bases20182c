SELECT 
    oficial.Datos AS Oficial
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