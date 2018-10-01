delimiter $
create procedure oficialDadoDepartamento(in Nombre varchar(24))
begin
SELECT 
	oficial.Datos as DatosOficial,
    oficial.Rango as Rango 
FROM 
	mydb.Departamento AS departamento,
    mydb.Oficial as oficial
where 
departamento.Nombre = Nombre and
oficial.idDepartamento = departamento.idDepartamento;
end
$