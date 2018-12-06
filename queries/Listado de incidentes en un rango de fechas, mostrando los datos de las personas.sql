delimiter $
create procedure listadoDeIncidentesPorFecha(in fechaDesde datetime, in fechaHasta datetime)
begin
SELECT 
    incidente.Numero AS NumeroIncidente,
    incidente.Descripcion AS Descripcion,
    oficial.num AS NumeroOficial,
    oficial.Nombre AS NombreOficial,
    oficial.Apellido AS ApellidoOficial,
    interviene.Rol AS RolOficial,
    persona.Nombre AS NombrePersona,
    persona.Apellido AS ApellidoPersona,
    involucra.Rol AS RolPersona
FROM
    mydb.Oficial oficial,
    mydb.Incidente incidente,
    mydb.Interviene interviene,
    mydb.Involucra involucra,
    mydb.Persona persona
WHERE
    incidente.Fecha >= fechaDesde
        AND incidente.Fecha <= fechaHasta
        AND incidente.idIncidente = involucra.idIncidente
        AND incidente.idIncidente = interviene.idIncidente
        AND oficial.num = interviene.num
        AND persona.idPersona = involucra.idPersona;
            end
$