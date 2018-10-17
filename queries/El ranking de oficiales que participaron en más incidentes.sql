SELECT 
    oficial.num AS NumeroOficial,
    oficial.Nombre AS NombreOficial,
    oficial.Apellido As ApellidoOficial,
    COUNT(*) AS CantidadDeIncidentes
FROM
    mydb.Oficial oficial,
    mydb.Interviene interviene
WHERE
    oficial.num = interviene.num
GROUP BY oficial.num
HAVING COUNT(*) >= ALL (SELECT 
        COUNT(*)
    FROM
        mydb.Oficial oficial1,
        mydb.Interviene interviene1
    WHERE
        oficial1.num = interviene1.num
    GROUP BY oficial1.num);