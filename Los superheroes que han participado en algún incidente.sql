SELECT 
    Superheroe.Nombre AS Superheroe
FROM
    mydb.Participa AS participa,
    mydb.Superheroe AS superheroe
WHERE
    participa.idSuperheroe = Superheroe.idSuperheroe
GROUP BY Superheroe.Nombre;