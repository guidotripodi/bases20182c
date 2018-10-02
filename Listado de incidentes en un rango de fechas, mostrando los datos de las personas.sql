delimiter $
create procedure listadoDeIncidentesPorFecha(in fechaDesde datetime, in fechaHasta datetime)
begin
SELECT 
    incidente.Numero as NumeroIncidente,
    incidente.Descripcion as Descripcion,
    oficial.num as NumeroOficial,
    oficial.Datos as DatosOficial,
    persona.Nombre as NombrePersona,
    persona.Apellido as ApellidoPersona,
    involucra.Rol as RolPersona
    
FROM
    mydb.Oficial oficial,
    mydb.Incidente incidente,
    mydb.Interviene interviene,
    mydb.Involucra involucra,
    mydb.Persona persona
WHERE
	incidente.Fecha >= fechaDesde and
    incidente.Fecha <= fechaHasta and
    incidente.idIncidente =  involucra.idIncidente and
    incidente.idIncidente =  interviene.idIncidente and
    oficial.num = interviene.num and
    persona.idPersona = involucra.idPersona
    group by incidente.Numero, incidente.Descripcion, oficial.num, oficial.Datos, persona.Nombre, persona.Apellido, involucra.Rol
    ;
            end
$