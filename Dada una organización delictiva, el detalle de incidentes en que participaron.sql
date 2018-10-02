delimiter $
create procedure incidentesPorOrganizacion(in organizacion varchar(24))
begin
SELECT incidente.Numero as numeroIncidente, incidente.Descripcion as DescripcionIncidente FROM mydb.OrganizacionDelictiva orgaDelictiva, mydb.Persona persona,
mydb.Involucra involucra, mydb.Incidente incidente
where orgaDelictiva.Nombre Like organizacion and 
persona.idOrganizacionDelictiva =  OrganizacionDelictiva.idOrganizacionDelictiva and
involucra.idPersona = persona.idPersona and
incidente.idIncidente = involucra.idIncidente
group by incidente.Numero, incidente.Descripcion;
end
$