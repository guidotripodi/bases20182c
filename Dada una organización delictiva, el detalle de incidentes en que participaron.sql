delimiter $
create procedure incidentesPorOrganizacion(in organizacion varchar(24))
begin
SELECT 
    incidente.Numero AS numeroIncidente,
    incidente.Descripcion AS DescripcionIncidente
FROM
    mydb.OrganizacionDelictiva orgaDelictiva,
    mydb.Persona persona,
    mydb.Involucra involucra,
    mydb.Incidente incidente
WHERE
    orgaDelictiva.Nombre = organizacion
        AND persona.idOrganizacionDelictiva = orgaDelictiva.idOrganizacionDelictiva
        AND involucra.idPersona = persona.idPersona
        AND incidente.idIncidente = involucra.idIncidente
GROUP BY incidente.Numero , incidente.Descripcion;
end
$