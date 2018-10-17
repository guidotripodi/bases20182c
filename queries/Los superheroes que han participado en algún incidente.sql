SELECT 
    superheroe.Nombre AS Superheroe
FROM
    mydb.Participa AS participa,
    mydb.Superheroe AS superheroe
WHERE
    participa.idSuperheroe = superheroe.idSuperheroe
GROUP BY superheroe.Nombre;