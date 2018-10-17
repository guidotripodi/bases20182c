delimiter $
create procedure oficialDadoDepartamento(in Nombre varchar(24))
begin
SELECT 
    oficial.Nombre AS NombreOficial,
    oficial.Apellido AS ApellidoOficial,
    oficial.Rango AS Rango
FROM
    mydb.Departamento AS departamento,
    mydb.Oficial AS oficial
WHERE
    departamento.Nombre = Nombre
        AND oficial.idDepartamento = departamento.idDepartamento;
end
$