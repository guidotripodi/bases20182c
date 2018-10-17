delimiter $
create procedure superheroeConHabilidad(in Habilidad varchar(24))
begin
SELECT superheroe.Nombre FROM mydb.Habilidad AS habilidad, mydb.Superheroe as superheroe
where habilidad.Nombre = Habilidad and superheroe.idSuperheroe = habilidad.Superheroe_idSuperheroe;
end
$